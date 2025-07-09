//
//  StartButton.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 09/07/2025.
//

import SwiftUI

struct StartButton: View {
    let hasAppeared: Bool
    let onTap: () -> Void
    
    @State private var isTransitioning = false
    
    var body: some View {
        Button(action: handleTap) {
            ButtonContentView(isTransitioning: isTransitioning)
        }
        .buttonStyle(AnimatedButtonStyle(isTransitioning: isTransitioning))
        .opacity(hasAppeared ? 1 : 0)
        .offset(y: hasAppeared ? (isTransitioning ? 15 : 0) : 50)
        .padding(.horizontal, 20)
        .animation(AppAnimations.defaultEaseOut.delay(0.6), value: hasAppeared)
        .animation(.spring(response: 0.8, dampingFraction: 0.7, blendDuration: 0), value: isTransitioning)
    }
    
    private func handleTap() {
        guard !isTransitioning else { return }
        
        withAnimation(.spring(response: 0.8, dampingFraction: 0.7, blendDuration: 0)) {
            isTransitioning = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            onTap()
        }
    }
}

// MARK: - Button Content View
private struct ButtonContentView: View {
    let isTransitioning: Bool
    
    var body: some View {
        Group {
            if isTransitioning {
                ArrowIcon()
            } else {
                Text("Jump In")
            }
        }
        .animation(.easeInOut(duration: 0.8), value: isTransitioning)
    }
}

// MARK: - Arrow Icon Component
private struct ArrowIcon: View {
    var body: some View {
        Image(systemName: "arrow.down.app")
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(.black)
            .transition(.scale.combined(with: .opacity))
    }
}

// MARK: - Animated Button Style
private struct AnimatedButtonStyle: ButtonStyle {
    let isTransitioning: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTypography.button)
            .foregroundColor(.black)
            .frame(
                width: isTransitioning ? 56 : nil,
                height: isTransitioning ? 45 : 56
            )
            .frame(maxWidth: isTransitioning ? 56 : .infinity)
            .background(AppColors.primaryButton)
            .cornerRadius(28)
            .shadow(
                color: AppColors.shadow,
                radius: 1,
                x: 0,
                y: 6
            )
            .opacity(configuration.isPressed ? 0.8 : 1)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
