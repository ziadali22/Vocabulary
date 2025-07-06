//
//  OnBoardingOptionsView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 06/07/2025.
//
import SwiftUI

// MARK: - Animation Configuration
struct AnimationConfiguration {
    static let headerSpring = Animation.interpolatingSpring(stiffness: 180, damping: 12).delay(0.1)
    static let buttonPress = Animation.easeInOut(duration: 0.15)
    static let buttonRelease = Animation.easeOut(duration: 0.2)
}

// MARK: - Haptic Feedback Manager
protocol HapticFeedbackProviding {
    func provideMediumImpact()
}

struct HapticFeedbackManager: HapticFeedbackProviding {
    func provideMediumImpact() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
}

// MARK: - Design System
struct OnBoardingDesignSystem {
    struct Colors {
        static let primaryText = Color.white
        static let backgroundGradientStart = Color(hex: "#2D2D2D")
        static let backgroundGradientEnd = Color(hex: "#1A1A1A")
        static let accent = Color.orange
        static let border = Color.white.opacity(0.15)
        static let shadow = Color.black.opacity(0.4)
        static let pressedShadow = Color.black.opacity(0.2)
    }
    
    struct Typography {
        static let headerFont = Font.system(size: 28, weight: .medium)
        static let buttonFont = Font.system(size: 16, weight: .semibold)
    }
    
    struct Spacing {
        static let headerHorizontal: CGFloat = 20
        static let headerTop: CGFloat = 40
        static let buttonHorizontal: CGFloat = 20
        static let buttonVertical: CGFloat = 18
        static let selectionIndicatorSize: CGFloat = 26
    }
    
    struct Animation {
        static let buttonScalePressed: CGFloat = 0.96
        static let buttonScaleNormal: CGFloat = 1.0
        static let pressDelay: TimeInterval = 0.15
    }
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
            .font(OnBoardingDesignSystem.Typography.headerFont)
            .foregroundStyle(OnBoardingDesignSystem.Colors.primaryText)
            .multilineTextAlignment(.center)
            .scaleEffect(hasAppeared ? 1.0 : 0.6)
            .opacity(hasAppeared ? 1 : 0)
            .offset(y: hasAppeared ? 0 : -30)
            .padding(.horizontal, OnBoardingDesignSystem.Spacing.headerHorizontal)
            .padding(.top, OnBoardingDesignSystem.Spacing.headerTop)
            .shadow(color: .black.opacity(0.2), radius: 4, y: 2)
            .onAppear {
                withAnimation(AnimationConfiguration.headerSpring) {
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
        withAnimation(AnimationConfiguration.buttonPress) {
            isPressed = true
        }
    }
    
    private func scheduleRelease() {
        DispatchQueue.main.asyncAfter(deadline: .now() + OnBoardingDesignSystem.Animation.pressDelay) {
            withAnimation(AnimationConfiguration.buttonRelease) {
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
                .font(OnBoardingDesignSystem.Typography.buttonFont)
                .foregroundStyle(OnBoardingDesignSystem.Colors.primaryText)
            
            Spacer()
            
            SelectionIndicatorView(isSelected: isSelected)
        }
        .padding(.horizontal, OnBoardingDesignSystem.Spacing.buttonHorizontal)
        .padding(.vertical, OnBoardingDesignSystem.Spacing.buttonVertical)
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
                .strokeBorder(OnBoardingDesignSystem.Colors.primaryText, lineWidth: 1)
                .background(
                    Circle().fill(
                        isSelected ? OnBoardingDesignSystem.Colors.accent : Color.clear
                    )
                )
            
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(OnBoardingDesignSystem.Colors.primaryText)
                    .transition(.scale)
            }
        }
        .frame(
            width: OnBoardingDesignSystem.Spacing.selectionIndicatorSize,
            height: OnBoardingDesignSystem.Spacing.selectionIndicatorSize
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
                                OnBoardingDesignSystem.Colors.backgroundGradientStart,
                                OnBoardingDesignSystem.Colors.backgroundGradientEnd
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(OnBoardingDesignSystem.Colors.border, lineWidth: 1)
                    )
            )
            .scaleEffect(
                isPressed ? OnBoardingDesignSystem.Animation.buttonScalePressed : OnBoardingDesignSystem.Animation.buttonScaleNormal
            )
            .shadow(
                color: isPressed ? OnBoardingDesignSystem.Colors.pressedShadow : OnBoardingDesignSystem.Colors.shadow,
                radius: isPressed ? 0 : 1,
                x: 0,
                y: isPressed ? 2 : 6
            )
            .animation(AnimationConfiguration.buttonRelease, value: isPressed)
    }
}
