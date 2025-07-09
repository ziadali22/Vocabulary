//
//  HeaderTextSection.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 05/07/2025.
//

import SwiftUI

struct HeaderTextSection: View {
    let isTextVisible: Bool
    
    var body: some View {
        Text("Expand Your Vocabulary in 1 minute a day")
            .font(ScreenSizeConfiguration.isCompactHeight ? .title3.bold() : .title.bold())
            .foregroundStyle(AppColors.primaryText)
            .multilineTextAlignment(.center)
            .shadow(color: .black.opacity(0.3), radius: 4, x: 2, y: 2)
            .offset(x: isTextVisible ? 0 : -250)
            .animation(.easeOut(duration: 0.9), value: isTextVisible)
            .padding(.horizontal, 8)
    }
}
