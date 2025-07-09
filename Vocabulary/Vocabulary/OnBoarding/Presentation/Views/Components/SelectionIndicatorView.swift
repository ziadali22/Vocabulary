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
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(AppColors.primaryText)
                    .background(
                        Circle()
                            .strokeBorder(AppColors.primaryText, lineWidth: 1)
                            .fill(AppColors.accent)
                            .frame(width: 24, height: 24)
                    )
                    .transition(.scale)
            }
        }
        .frame(
            width: OnBoardingSpacing.selectionIndicatorSize,
            height: OnBoardingSpacing.selectionIndicatorSize
        )
        .animation(AppAnimations.selection, value: isSelected)
    }
}
