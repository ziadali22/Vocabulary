//
//  MultiSelectionHeader.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 08/07/2025.
//

import SwiftUI

struct MultiSelectionHeader: View {
    let title: String
    let onSkip: (() -> Void)?
    let hasAppeared: Bool

    var body: some View {
        VStack(spacing: 0) {
            if let onSkip = onSkip {
                HStack {
                    Spacer()
                    SkipButton(hasAppeared: hasAppeared, onSkip: onSkip)
                }
                .padding(.horizontal)
                .padding(.top)
            }

            OnBoardingHeaderView(title: title)
                .shadow(color: .black, radius: 1, y: 3)
                .opacity(hasAppeared ? 1 : 0)
                .offset(y: hasAppeared ? 0 : -20)
                .animation(AppAnimations.headerSpring, value: hasAppeared)
        }
    }
}
