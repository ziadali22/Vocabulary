//
//  DashboardView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 09/07/2025.
//

import SwiftUI

// MARK: - DashboardView Protocol (Clean Architecture - Presentation Layer Interface)
protocol DashboardViewProtocol {
    var viewModel: DashboardViewModel { get }
    func handleVocabularyAction(_ action: VocabularyAction)
}

// MARK: - Vocabulary Actions (Domain Layer)
enum VocabularyAction {
    case playPronunciation
    case markAsLearned
    case navigateToNext
    case navigateToPrevious
}

// MARK: - DashboardView Implementation
struct DashboardView2: View, DashboardViewProtocol {
    // MARK: - Properties
    @StateObject internal var viewModel: DashboardViewModel
    
    // MARK: - UI State
    @State private var isVisible: Bool = false
    @State private var showSuccessPopup: Bool = false
    @State private var isProcessingAction: Bool = false
    
    // MARK: - Animation Constants
    private let defaultAnimationDuration: Double = 0.6
    private let staggerDelay: Double = 0.2
    private let successPopupDelay: Double = 0.5
    
    // MARK: - Initialization (Dependency Injection)
    init() {
        let repository = VocabularyRepository()
        let useCase = VocabularyLearningUseCase(repository: repository)
        _viewModel = StateObject(wrappedValue: DashboardViewModel(useCase: useCase))
    }
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundView
                
                if !viewModel.vocabularies.isEmpty {
                    mainContentView(geometry: geometry)
                } else {
                    emptyStateView
                }
                
                overlayViews
            }
        }
        .task {
            await loadInitialData()
        }
        .onAppear {
            animateAppearance()
        }
        .onDisappear {
            handleDisappearance()
        }
        .onChange(of: viewModel.allVocabulariesLearned) { _, isCompleted in
            handleLearningCompletion(isCompleted)
        }
    }
    
    // MARK: - View Components (Single Responsibility Principle)
    private var backgroundView: some View {
        LinearGradient(
            colors: [AppColors.background, Color.gray.opacity(0.8)],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
    
    private func mainContentView(geometry: GeometryProxy) -> some View {
        PagingScrollView(
            items: viewModel.vocabularies,
            currentIndex: $viewModel.currentIndex,
            geometry: geometry
        ) { index, vocabulary in
            VocabularyPageView(
                vocabulary: vocabulary,
                index: index,
                currentIndex: viewModel.currentIndex,
                progress: viewModel.progress,
                progressText: viewModel.progressText,
                isLearned: viewModel.learnedVocabularyIds.contains(vocabulary.id),
                isVisible: isVisible,
                isProcessingAction: isProcessingAction,
                onAction: handleVocabularyAction
            )
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "book.closed")
                .font(.system(size: 64))
                .foregroundColor(.gray)
            
            Text("No vocabularies available")
                .font(.title2)
                .foregroundColor(.gray)
            
            Button("Reload") {
                Task { await loadInitialData() }
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    private var overlayViews: some View {
        SuccessAlertView(isPresented: $showSuccessPopup)
    }
    
    // MARK: - Business Logic Methods
    func handleVocabularyAction(_ action: VocabularyAction) {
        guard !isProcessingAction else { return }
        
        isProcessingAction = true
        
        Task { @MainActor in
            defer { isProcessingAction = false }
            
            switch action {
            case .playPronunciation:
                await handlePronunciation()
            case .markAsLearned:
                await handleMarkAsLearned()
            case .navigateToNext:
                handleNavigation(.next)
            case .navigateToPrevious:
                handleNavigation(.previous)
            }
        }
    }
    
    // MARK: - Private Action Handlers
    private func handlePronunciation() async {
        // Add haptic feedback for better UX
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
        
        viewModel.playPronunciation()
    }
    
    private func handleMarkAsLearned() async {
        // Add haptic feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
        
        await viewModel.markCurrentAsLearned()
    }
    
    private func handleNavigation(_ direction: NavigationDirection) {
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
        
        withAnimation(.spring(response: defaultAnimationDuration, dampingFraction: 0.8)) {
            switch direction {
            case .next:
                if viewModel.currentIndex < viewModel.vocabularies.count - 1 {
                    viewModel.currentIndex += 1
                }
            case .previous:
                if viewModel.currentIndex > 0 {
                    viewModel.currentIndex -= 1
                }
            }
        }
    }
    
    // MARK: - Lifecycle Methods
    private func loadInitialData() async {
        await viewModel.loadVocabularies()
    }
    
    private func animateAppearance() {
        withAnimation(.easeOut(duration: defaultAnimationDuration)) {
            isVisible = true
        }
    }
    
    private func handleDisappearance() {
        isVisible = false
        isProcessingAction = false
    }
    
    private func handleLearningCompletion(_ isCompleted: Bool) {
        guard isCompleted else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + successPopupDelay) {
            withAnimation(.spring(response: defaultAnimationDuration, dampingFraction: 0.8)) {
                showSuccessPopup = true
            }
        }
    }
}

// MARK: - Supporting Types
private enum NavigationDirection {
    case next, previous
}

// MARK: - VocabularyPageView (Extracted for better separation of concerns)
private struct VocabularyPageView: View {
    let vocabulary: Vocabulary
    let index: Int
    let currentIndex: Int
    let progress: Double
    let progressText: String
    let isLearned: Bool
    let isVisible: Bool
    let isProcessingAction: Bool
    let onAction: (VocabularyAction) -> Void
    
    var body: some View {
        GeometryReader { pageGeometry in
            VStack(spacing: 0) {
                headerSection(pageGeometry: pageGeometry)
                cardSection(pageGeometry: pageGeometry)
            }
            .frame(width: pageGeometry.size.width, height: pageGeometry.size.height)
        }
    }
    
    private func headerSection(pageGeometry: GeometryProxy) -> some View {
        VStack(spacing: 16) {
            Spacer()
            SessionTitleViewModern()
            
            ProgressBarView(
                progress: progress,
                text: progressText
            )
            .padding(.horizontal, 32)
            .opacity(isVisible ? 1 : 0)
            .offset(y: isVisible ? 0 : -20)
            .animation(.easeOut(duration: 0.6).delay(0.2), value: isVisible)
        }
        .padding(.bottom, 24)
        .frame(height: pageGeometry.size.height * 0.25)
        .frame(maxWidth: .infinity)
    }
    
    private func cardSection(pageGeometry: GeometryProxy) -> some View {
        VStack {
            Spacer()
            
            VocabularyCardView(
                vocabulary: vocabulary,
                isLearned: isLearned,
                onPronunciationTap: {
                    onAction(.playPronunciation)
                },
                onMarkLearned: {
                    onAction(.markAsLearned)
                }
            )
            .opacity(index == currentIndex ? 1 : 0.3)
            .scaleEffect(index == currentIndex ? 1.0 : 0.8)
            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: currentIndex)
            .disabled(isProcessingAction) // Prevent multiple taps during processing
            
            Spacer()
        }
        .frame(height: pageGeometry.size.height * 0.50)
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Preview Provider
#Preview {
    DashboardView()
}
