//
//  IntroHeaderView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 05/07/2025.
//

import SwiftUI

struct IntroHeaderView: View {
    let intro: IntroItem
    let animationState: IntroAnimationState
    let textWidth: CGFloat
    let screenWidth: CGFloat
    
    var body: some View {
        Rectangle()
            .fill(intro.backgroundColor)
            .overlay {
                Circle()
                    .fill(intro.circleColor)
                    .frame(width: OnboardingConfiguration().circleSize,
                           height: OnboardingConfiguration().circleSize)
                    .background(alignment: .leading) {
                        Capsule()
                            .fill(intro.backgroundColor)
                            .frame(width: screenWidth)
                    }
                    .background(alignment: .leading) {
                        Text(intro.text)
                            .font(.title2.bold())
                            .foregroundStyle(intro.textColor)
                            .frame(width: textWidth)
                            .offset(x: 10 + animationState.textOffset)
                    }
                    .offset(x: -animationState.circleOffset)
            }
            .padding(.bottom, -30)
    }
}
