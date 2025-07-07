//
//  GoalsSelectionView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 07/07/2025.
//

import SwiftUI

struct GoalsSelectionView: View {
    let title: String
    let options: [String]
    @Binding var selectedGoals: Set<String>
    let onContinue: () -> Void
    let onSkip: () -> Void

    @State private var hasAppeared = false

    var body: some View {
        VStack(spacing: 0) {
            GoalsSelectionHeader(title: title, onSkip: onSkip, hasAppeared: hasAppeared)

            GoalOptionsList(
                options: options,
                selectedGoals: $selectedGoals,
                hasAppeared: hasAppeared
            )

            Spacer()

            ContinueButton(
                isEnabled: !selectedGoals.isEmpty,
                hasAppeared: hasAppeared,
                delay: Double(options.count) * 0.1 + 0.5,
                onTap: onContinue
            )
        }
        .onAppear {
            withAnimation { hasAppeared = true }
        }
        .onDisappear {
            hasAppeared = false
        }
    }
}

struct GoalsSelectionHeader: View {
    let title: String
    let onSkip: () -> Void
    let hasAppeared: Bool

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                SkipButton(hasAppeared: hasAppeared, onSkip: onSkip)
            }
            .padding(.horizontal)
            .padding(.top)

            OnBoardingHeaderView(title: title)
                .shadow(color: .black, radius: 1, y: 3)
                .opacity(hasAppeared ? 1 : 0)
                .offset(y: hasAppeared ? 0 : -20)
                .animation(AppAnimations.headerSpring, value: hasAppeared)
        }
    }
}

struct GoalOptionsList: View {
    let options: [String]
    @Binding var selectedGoals: Set<String>
    let hasAppeared: Bool
    private let staggerDelay: TimeInterval = 0.1

    var body: some View {
        VStack(spacing: 16) {
            ForEach(Array(options.enumerated()), id: \.element) { index, option in
                GoalOptionButton(
                    title: option,
                    isSelected: selectedGoals.contains(option)
                ) {
                    toggleSelection(option)
                }
                .opacity(hasAppeared ? 1 : 0)
                .offset(y: hasAppeared ? 0 : 20)
                .animation(
                    AppAnimations.defaultEaseOut.delay(Double(index) * staggerDelay + 0.3),
                    value: hasAppeared
                )
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 32)
    }

    private func toggleSelection(_ option: String) {
        withAnimation(AppAnimations.selection) {
            if selectedGoals.contains(option) {
                selectedGoals.remove(option)
            } else {
                selectedGoals.insert(option)
            }
        }
    }
}



// MARK: - Goal Option Button Component

struct GoalOptionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    private let hapticProvider: HapticFeedbackProviding
    @State private var isPressed = false

    init(
        title: String,
        isSelected: Bool,
        action: @escaping () -> Void,
        hapticProvider: HapticFeedbackProviding = HapticFeedbackManager()
    ) {
        self.title = title
        self.isSelected = isSelected
        self.action = action
        self.hapticProvider = hapticProvider
    }

    var body: some View {
        Button(action: handleButtonTap) {
            HStack {
                Text(title)
                    .font(AppTypography.body)
                    .foregroundColor(isSelected ? .black : AppColors.primaryText)

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(AppColors.primaryText)
                        .background(
                            Circle()
                                .strokeBorder(AppColors.primaryText, lineWidth: 1)
                                .fill(AppColors.accent)
                                .frame(width: 24, height: 24)
                        )
                        .transition(.scale)
                }
            }
            .padding(.horizontal, 24)
            .frame(height: 56)
            .background(isSelected ? AppColors.primaryButton : Color.black.opacity(0.3))
            .cornerRadius(28)
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isPressed ? ButtonAnimation.buttonScalePressed : ButtonAnimation.buttonScaleNormal)
        .shadow(
            color: isPressed ? AppColors.pressedShadow : AppColors.shadow,
            radius: isPressed ? 0 : 1,
            x: 0,
            y: isPressed ? 2 : 6
        )
        .animation(AppAnimations.buttonRelease, value: isPressed)
        .animation(AppAnimations.selection, value: isSelected)
    }

    private func handleButtonTap() {
        animatePress()
        hapticProvider.provideMediumImpact()
        action()
        scheduleRelease()
    }

    private func animatePress() {
        withAnimation(AppAnimations.buttonPress) {
            isPressed = true
        }
    }

    private func scheduleRelease() {
        DispatchQueue.main.asyncAfter(deadline: .now() + ButtonAnimation.pressDelay) {
            withAnimation(AppAnimations.buttonRelease) {
                isPressed = false
            }
        }
    }
}
