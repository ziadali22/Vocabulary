//
//  CardView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 05/07/2025.
//

import SwiftUI

struct CardView: View {
    @State private var isTextVisible = false
    @Binding var showWalkthrough: Bool
    @State private var isDownloadIconAnimating = false
    
    var body: some View {
        VStack(spacing: 24) {
            HeaderTextSection(isTextVisible: isTextVisible)
            SubtitleSection()
            StatsSection()
            ContinueButtonSection(
                isDownloadIconAnimating: isDownloadIconAnimating,
                showWalkthrough: $showWalkthrough
            )
        }
        .padding(24)
        .background(AppColors.background)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onAppear {
            startAnimations()
        }
    }
    
    private func startAnimations() {
        withAnimation(.easeOut(duration: 0.9)) {
            isTextVisible = true
        }
        
        withAnimation(
            Animation.easeInOut(duration: 0.8)
                .repeatForever(autoreverses: true)
        ) {
            isDownloadIconAnimating = true
        }
    }
}
