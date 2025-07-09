//
//  DashboardView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 09/07/2025.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel: DashboardViewModel
    @State private var dragOffset: CGSize = .zero
    @State private var isVisible: Bool = false
    @State private var showSuccessPopup: Bool = false
    
    init() {
        let repository = VocabularyRepository()
        let useCase = VocabularyLearningUseCase(repository: repository)
        _viewModel = StateObject(wrappedValue: DashboardViewModel(useCase: useCase))
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(
                    colors: [AppColors.background, Color.gray.opacity(0.8)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                if !viewModel.vocabularies.isEmpty {
                    PagingScrollView(
                        items: viewModel.vocabularies,
                        currentIndex: $viewModel.currentIndex,
                        geometry: geometry
                    ) { index, vocabulary in
                        
                        GeometryReader { pageGeometry in
                            VStack(spacing: 0) {
                                
                                VStack(spacing: 16) {
                                    Spacer()
                                    SessionTitleViewModern()
                                    
                                    ProgressBarView(
                                        progress: viewModel.progress,
                                        text: viewModel.progressText
                                    )
                                    .padding(.horizontal, 32)
                                    .opacity(isVisible ? 1 : 0)
                                    .offset(y: isVisible ? 0 : -20)
                                    .animation(.easeOut(duration: 0.6).delay(0.2), value: isVisible)
                                }
                                .padding(.bottom, 24)
                                .frame(height: pageGeometry.size.height * 0.25)
                                .frame(maxWidth: .infinity)
                                
                                VStack {
                                    Spacer()
                                    
                                    VocabularyCardView(
                                        vocabulary: vocabulary,
                                        isLearned: viewModel.learnedVocabularyIds.contains(vocabulary.id),
                                        onPronunciationTap: { viewModel.playPronunciation() },
                                        onMarkLearned: {
                                            Task { await viewModel.markCurrentAsLearned() }
                                        }
                                    )
                                    .opacity(index == viewModel.currentIndex ? 1 : 0.3)
                                    .scaleEffect(index == viewModel.currentIndex ? 1.0 : 0.8)
                                    .animation(.spring(response: 0.6, dampingFraction: 0.8), value: viewModel.currentIndex)
                                    
                                    Spacer()
                                }
                                .frame(height: pageGeometry.size.height * 0.50)
                                .frame(maxWidth: .infinity)
                            }
                            .frame(width: pageGeometry.size.width, height: pageGeometry.size.height)
                        }
                    }
                }
            }
        }
        .overlay(content: {
            SuccessAlertView(isPresented: $showSuccessPopup)
        })
        .task {
            await viewModel.loadVocabularies()
        }
        .onAppear {
            withAnimation {
                isVisible = true
            }
        }
        .onDisappear {
            isVisible = false
        }
        .onChange(of: viewModel.allVocabulariesLearned) { isCompleted in
            if isCompleted {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        showSuccessPopup = true
                    }
                }
            }
        }
    }
}
