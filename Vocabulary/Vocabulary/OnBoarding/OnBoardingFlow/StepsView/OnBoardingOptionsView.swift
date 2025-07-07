//
//  OnBoardingOptionsView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 06/07/2025.
//
import SwiftUI

// MARK: - Design System

struct OnBoardingSpacing {
    static let headerHorizontal: CGFloat = 20
    static let headerTop: CGFloat = 40
    static let buttonHorizontal: CGFloat = 20
    static let buttonVertical: CGFloat = 18
    static let selectionIndicatorSize: CGFloat = 26
}

// MARK: - Header View
struct OnBoardingHeaderView: View {
    private let title: String
    @State private var hasAppeared = false
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .font(AppTypography.headerFont)
            .foregroundStyle(AppColors.primaryText)
            .multilineTextAlignment(.center)
            .scaleEffect(hasAppeared ? 1.0 : 0.6)
            .opacity(hasAppeared ? 1 : 0)
            .offset(y: hasAppeared ? 0 : -30)
            .padding(.horizontal, OnBoardingSpacing.headerHorizontal)
            .padding(.top, OnBoardingSpacing.headerTop)
            .shadow(color: .black.opacity(0.2), radius: 4, y: 2)
            .onAppear {
                withAnimation(AppAnimations.headerSpring) {
                    hasAppeared = true
                }
            }
    }
}

// MARK: - Option Button
struct OptionButton: View {
    private let title: String
    private let isSelected: Bool
    private let action: () -> Void
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
            OptionButtonContentView(title: title, isSelected: isSelected)
        }
        .buttonStyle(.plain)
        .modifier(OnBoardingButtonBackgroundStyle(isPressed: isPressed))
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

// MARK: - Button Content View
struct OptionButtonContentView: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
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
}

// MARK: - Selection Indicator
struct SelectionIndicatorView: View {
    let isSelected: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(AppColors.primaryText, lineWidth: 1)
                .background(
                    Circle().fill(
                        isSelected ? AppColors.accent : Color.clear
                    )
                )
            
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(AppColors.primaryText)
                    .transition(.scale)
            }
        }
        .frame(
            width: OnBoardingSpacing.selectionIndicatorSize,
            height: OnBoardingSpacing.selectionIndicatorSize
        )
    }
}

// MARK: - Button Background Style
struct OnBoardingButtonBackgroundStyle: ViewModifier {
    let isPressed: Bool
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        LinearGradient(
                            colors: [
                                AppColors.backgroundOptionGradientStart,
                                AppColors.backgroundOptionGradientEnd
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(AppColors.border, lineWidth: 1)
                    )
            )
            .scaleEffect(
                isPressed ? ButtonAnimation.buttonScalePressed : ButtonAnimation.buttonScaleNormal
            )
            .shadow(
                color: isPressed ? AppColors.pressedShadow : AppColors.shadow,
                radius: isPressed ? 0 : 1,
                x: 0,
                y: isPressed ? 2 : 6
            )
            .animation(AppAnimations.buttonRelease, value: isPressed)
    }
}
