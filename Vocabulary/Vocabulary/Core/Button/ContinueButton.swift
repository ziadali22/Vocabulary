//
//  ContinueButton.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 07/07/2025.
//

import SwiftUI

struct ContinueButton: View {
    let isEnabled: Bool
    let hasAppeared: Bool
    let delay: Double
    let onTap: () -> Void

    var body: some View {
        Button("Continue") {
            if isEnabled { onTap() }
        }
        .buttonStyle(GoalsButtonStyle())
        .opacity(hasAppeared ? (isEnabled ? 1 : 0.6) : 0)
        .offset(y: hasAppeared ? 0 : 50)
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
        .disabled(!isEnabled)
        .animation(AppAnimations.defaultEaseOut.delay(delay), value: hasAppeared)
        .animation(AppAnimations.selection, value: isEnabled)
    }
}

fileprivate struct GoalsButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTypography.button)
            .foregroundColor(.black)
            .frame(height: 56)
            .frame(maxWidth: .infinity)
            .background(AppColors.primaryButton)
            .cornerRadius(28)
            .shadow(
                color:AppColors.shadow,
                radius: 1,
                x: 0,
                y: 6
            )
            .opacity(configuration.isPressed ? 0.8 : 1)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
