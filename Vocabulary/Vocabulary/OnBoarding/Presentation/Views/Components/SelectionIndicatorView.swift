//
//  SelectionIndicatorView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 09/07/2025.
//

import SwiftUI

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
                Image(systemName: "checkmark")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .frame(
            width: OnBoardingSpacing.selectionIndicatorSize,
            height: OnBoardingSpacing.selectionIndicatorSize
        )
        .animation(AppAnimations.selection, value: isSelected)
    }
}
