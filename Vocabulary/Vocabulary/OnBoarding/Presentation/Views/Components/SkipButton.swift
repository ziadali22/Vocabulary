//
//  SkipButton.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 08/07/2025.
//

import SwiftUI

struct SkipButton: View {
    let hasAppeared: Bool
    let onSkip: () -> Void
    
    var body: some View {
        Button("Skip", action: onSkip)
            .font(AppTypography.body)
            .foregroundColor(AppColors.primaryText)
            .opacity(hasAppeared ? 1 : 0)
            .animation(AppAnimations.defaultEaseOut.delay(0.2), value: hasAppeared)
    }
}
