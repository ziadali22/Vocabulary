//
//  SuccessView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 06/07/2025.
//

import SwiftUI
import Lottie

struct SuccessView: View {
    let title: String
    let animationName: String
    let onSelect: () -> Void
    private let hapticProvider: HapticFeedbackProviding
    
    @State private var titleVisible = false
    @State private var lottieVisible = false
    @State private var buttonVisible = false
    
    init(title: String, animationName: String, onSelect: @escaping () -> Void,
         hapticProvider: HapticFeedbackProviding = HapticFeedbackManager(), ) {
        self.title = title
        self.animationName = animationName
        self.onSelect = onSelect
        self.hapticProvider = hapticProvider
    }
    
    var body: some View {
        VStack(spacing: 40) {
            
            Text(title)
                .font(.title2.bold())
                .multilineTextAlignment(.center)
                .foregroundStyle(AppColors.primaryText)
                .shadow(color: .black, radius: 1, y: 3)
                .padding(.horizontal)
                .offset(y: titleVisible ? 0 : -50)
                .opacity(titleVisible ? 1 : 0)
                .animation(.spring(response: 0.8, dampingFraction: 0.8).delay(0.2), value: titleVisible)
            
            LottieView(animation: .named(animationName))
                .configure({ lottie in
                    lottie.contentMode = .scaleAspectFill
                })
                .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
                .frame(maxWidth: .infinity, maxHeight: 400)
                .clipped()
                .scaleEffect(lottieVisible ? 1.0 : 0.3)
                .opacity(lottieVisible ? 1 : 0)
                .animation(.spring(response: 1.0, dampingFraction: 0.7).delay(0.4), value: lottieVisible)
            
            ContinueButton(
                isEnabled: true,
                hasAppeared: buttonVisible,
                delay: 0.6,
                onTap: onContinue
            )
        }
        .padding()
        .onAppear {
            titleVisible = true
            lottieVisible = true
            buttonVisible = true
        }
    }
    
    private func onContinue() {
        onSelect()
        hapticProvider.provideMediumImpact()
    }
}

#Preview {
    SuccessView(title: .init("Success"), animationName: "", onSelect: {})
}
