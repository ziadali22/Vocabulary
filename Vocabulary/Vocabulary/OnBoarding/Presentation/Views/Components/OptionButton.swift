//
//  OptionButton.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 08/07/2025.
//

import SwiftUI

struct OnBoardingSpacing {
    static let headerHorizontal: CGFloat = 20
    static let headerTop: CGFloat = 40
    static let buttonHorizontal: CGFloat = 20
    static let buttonVertical: CGFloat = 18
    static let selectionIndicatorSize: CGFloat = 26
}

struct OptionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    @State private var isPressed = false
    private let hapticProvider: HapticFeedbackProviding
    
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
                    .font(AppTypography.button)
                    .foregroundStyle(AppColors.primaryText)
                
                Spacer()
                
                SelectionIndicatorView(isSelected: isSelected)
            }
            .padding(.horizontal, OnBoardingSpacing.buttonHorizontal)
            .padding(.vertical, OnBoardingSpacing.buttonVertical)
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .modifier(SingleOptionButtonBackgroundStyle(isPressed: isPressed))
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

// MARK: - Button Background Style
struct SingleOptionButtonBackgroundStyle: ViewModifier {
    let isPressed: Bool

    func body(content: Content) -> some View {
        content
            .background(backgroundShape)
            .scaleEffect(scaleEffect)
            .shadow(
                color: shadowColor,
                radius: shadowRadius,
                x: 0,
                y: shadowOffsetY
            )
    }
    
    // MARK: - Private Computed Properties
    
    private var backgroundShape: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(backgroundFill)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(AppColors.border, lineWidth: 1)
            )
    }
    
    private var backgroundFill: LinearGradient {
            LinearGradient(
                colors: [
                    AppColors.backgroundOptionGradientStart,
                    AppColors.backgroundOptionGradientEnd
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
    }
    
    private var scaleEffect: CGFloat {
        isPressed ? ButtonAnimation.buttonScalePressed : ButtonAnimation.buttonScaleNormal
    }
    
    private var shadowColor: Color {
        isPressed ? AppColors.pressedShadow : AppColors.shadow
    }
    
    private var shadowRadius: CGFloat {
        isPressed ? 0 : 2
    }
    
    private var shadowOffsetY: CGFloat {
        isPressed ? 1 : 4
    }
}
