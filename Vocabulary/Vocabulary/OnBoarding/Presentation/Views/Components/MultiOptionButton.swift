//
//  MultiOptionButton.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 08/07/2025.
//

import SwiftUI

struct MultiOptionButton: View {
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
                titleText
                Spacer()
                if isSelected { checkmark }
            }
            .padding(.horizontal, 24)
            .frame(height: 56)
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .modifier(OptionButtonBackgroundStyle(isSelected: isSelected, isPressed: isPressed))
        .animation(AppAnimations.buttonRelease, value: isPressed)
        .animation(AppAnimations.selection, value: isSelected)
    }
}

// MARK: - Subviews

private extension MultiOptionButton {
    var titleText: some View {
        Text(title)
            .font(AppTypography.body)
            .foregroundColor(isSelected ? .black : AppColors.primaryText)
    }

    var checkmark: some View {
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

// MARK: - Actions

private extension MultiOptionButton {
    func handleButtonTap() {
        animatePress()
        hapticProvider.provideMediumImpact()
        action()
        scheduleRelease()
    }

    func animatePress() {
        withAnimation(AppAnimations.buttonPress) {
            isPressed = true
        }
    }

    func scheduleRelease() {
        DispatchQueue.main.asyncAfter(deadline: .now() + ButtonAnimation.pressDelay) {
            withAnimation(AppAnimations.buttonRelease) {
                isPressed = false
            }
        }
    }
}

// MARK: - Background Style Modifier

struct OptionButtonBackgroundStyle: ViewModifier {
    let isSelected: Bool
    let isPressed: Bool

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(backgroundFill)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(AppColors.border, lineWidth: 1)
                    )
            )
            .scaleEffect(isPressed ? ButtonAnimation.buttonScalePressed : ButtonAnimation.buttonScaleNormal)
            .shadow(
                color: isPressed ? AppColors.pressedShadow.opacity(0.3) : AppColors.shadow.opacity(0.3),
                radius: isPressed ? 0 : 0.5,
                x: 0,
                y: isPressed ? 1 : 3
            )
    }

    private var backgroundFill: AnyShapeStyle {
        isSelected
        ? AnyShapeStyle(AppColors.primaryButton)
        : AnyShapeStyle(
            LinearGradient(
                colors: [
                    AppColors.backgroundOptionGradientStart,
                    AppColors.backgroundOptionGradientEnd
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
}
