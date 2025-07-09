//
//  SuccessAlertView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 10/07/2025.
//

import SwiftUI
import Lottie
import Combine

// MARK: - SuccessAlertView
struct SuccessAlertView: View {
    @Binding var isPresented: Bool
    @StateObject private var viewModel = SuccessAlertViewModel()
    
    // Optional parameters for customization
    let wordsLearned: Int
    let timeSpent: String
    let streakCount: Int
    
    @State private var cardVisible = false
    @State private var confettiVisible = false
    
    init(
        isPresented: Binding<Bool>,
        wordsLearned: Int = 5,
        timeSpent: String = "2m",
        streakCount: Int = 1
    ) {
        self._isPresented = isPresented
        self.wordsLearned = wordsLearned
        self.timeSpent = timeSpent
        self.streakCount = streakCount
    }
    
    var body: some View {
        if isPresented {
            ZStack {
                Color.clear
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            dismissPopup()
                        }
                    }
                
                VStack(spacing: 16) {
                    LottieView(animation: .named("good"))
                        .configure { lottie in
                            lottie.contentMode = .scaleAspectFit
                        }
                        .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
                        .frame(width: 200, height: 200)
                        .padding(.vertical, 16)
                    
                    HStack(spacing: 20) {
                        StatBadge(icon: "book.fill", value: "\(viewModel.wordsLearned)", label: "Words")
                        StatBadge(icon: "clock.fill", value: viewModel.timeSpent, label: "Time")
                        StatBadge(icon: "", value: "🔥", label: "Streak")
                    }
                    .opacity(cardVisible ? 1 : 0)
                    .offset(y: cardVisible ? 0 : 15)
                    .padding(.bottom, 20)
                    
                    VStack(spacing: 8) {
                        Text(successMessage)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(AppColors.primaryText)
                            .multilineTextAlignment(.center)
                        
                        if !viewModel.userName.isEmpty {
                            Text(viewModel.userName)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(AppColors.accent)
                        }
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 28)
                        .fill(AppColors.background)
                }
                .cornerRadius(20)
                .padding(40)
                .shadow(radius: 20)
                .scaleEffect(cardVisible ? 1.0 : 0.8)
                .opacity(cardVisible ? 1 : 0)
                .offset(y: cardVisible ? 0 : -50)
                
                if confettiVisible {
                    TopConfettiView()
                        .allowsHitTesting(false)
                }
            }
            .onAppear {
                // Load user name and update stats
                Task {
                    await viewModel.loadUserName()
                    viewModel.updateStats(
                        wordsLearned: wordsLearned,
                        timeSpent: timeSpent,
                        streakCount: streakCount
                    )
                }
                
                // Start animations
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    cardVisible = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                    confettiVisible = true
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    dismissPopup()
                }
            }
        }
    }
    
    private var successMessage: String {
        if !viewModel.userName.isEmpty {
            return "Well Done, \(viewModel.userName)! 🎉"
        } else {
            return "Well Done! 🎉"
        }
    }
    
    private func dismissPopup() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            cardVisible = false
            confettiVisible = false
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isPresented = false
        }
    }
}

// MARK: - StatBadge (Helper View)
struct StatBadge: View {
    let icon: String
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            if !icon.isEmpty {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(AppColors.accent)
                
                Text(value)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(AppColors.primaryText)
            } else {
                Text(value)
                    .font(.system(size: 18, weight: .bold))
            }
            
            Text(label)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(AppColors.primaryText)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(AppColors.accent.opacity(0.1))
        )
    }
}

class SuccessAlertViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var wordsLearned: Int = 5
    @Published var timeSpent: String = "2m"
    @Published var streakCount: Int = 1
    
    private let onboardingRepository: OnboardingRepositoryProtocol
    
    init(onboardingRepository: OnboardingRepositoryProtocol)) {
        self.onboardingRepository = onboardingRepository
    }
    
    @MainActor
    func loadUserName() async {
        do {
            let onboardingData = try await onboardingRepository.get().async()
            if let name = onboardingData?.name, !name.isEmpty {
                self.userName = name
            }
        } catch {
            print("Failed to load user name: \(error)")
        }
    }
    
    func updateStats(wordsLearned: Int, timeSpent: String, streakCount: Int = 1) {
        self.wordsLearned = wordsLearned
        self.timeSpent = timeSpent
        self.streakCount = streakCount
    }
}

extension Publisher {
    func async() async throws -> Output {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?
            cancellable = first()
                .sink(
                    receiveCompletion: { completion in
                        switch completion {
                        case .failure(let error):
                            continuation.resume(throwing: error)
                        case .finished:
                            break
                        }
                        cancellable?.cancel()
                    },
                    receiveValue: { value in
                        continuation.resume(returning: value)
                        cancellable?.cancel()
                    }
                )
        }
    }
}
