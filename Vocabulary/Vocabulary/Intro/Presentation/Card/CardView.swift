//
//  CardView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 05/07/2025.

import SwiftUI

struct CardView: View {
    // MARK: - State Properties
    @State private var isTextVisible = false
    @Binding var showWalkthrough: Bool
    @State private var isDownloadIconAnimating = false
    @State private var hasAppeared = false
    
    // MARK: - Design Constants
    private struct DesignConstants {
        static let cardCornerRadius: CGFloat = 20
        static let cardHorizontalPadding: CGFloat = 24
        static let cardVerticalPadding: CGFloat = 32
        
        // Spacing hierarchy for better visual structure
        static let headerBottomSpacing: CGFloat = 32
        static let subtitleBottomSpacing: CGFloat = 24
        static let statsBottomSpacing: CGFloat = 40
        
        // Animation constants
        static let textAnimationDuration: Double = 0.9
        static let iconAnimationDuration: Double = 0.8
        static let buttonDelayDuration: Double = 0.4
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HeaderTextSection(isTextVisible: isTextVisible)
                .padding(.bottom, DesignConstants.headerBottomSpacing)
            
            SubtitleSection()
                .padding(.bottom, DesignConstants.subtitleBottomSpacing)
            
            StatsSection()
                .padding(.bottom, DesignConstants.statsBottomSpacing)
            
            HStack {
                Spacer()
                StartButton(hasAppeared: hasAppeared) {
                    handleStartButtonTap()
                }
                Spacer()
            }
        }
        .padding(.horizontal, DesignConstants.cardHorizontalPadding)
        .padding(.vertical, DesignConstants.cardVerticalPadding)
        .background(AppColors.background)
        .clipShape(RoundedRectangle(cornerRadius: DesignConstants.cardCornerRadius))
        .onAppear {
            startAnimationSequence()
        }
    }
}

// MARK: - Private Methods
private extension CardView {
    func startAnimationSequence() {
        animateTextVisibility()
        animateDownloadIcon()
        animateAppearanceState()
    }
    
    func animateTextVisibility() {
        withAnimation(.easeOut(duration: DesignConstants.textAnimationDuration)) {
            isTextVisible = true
        }
    }
    
    func animateDownloadIcon() {
        withAnimation(
            Animation.easeInOut(duration: DesignConstants.iconAnimationDuration)
                .repeatForever(autoreverses: true)
        ) {
            isDownloadIconAnimating = true
        }
    }
    
    func animateAppearanceState() {
        withAnimation {
            hasAppeared = true
        }
    }
    
    func handleStartButtonTap() {
        DispatchQueue.main.asyncAfter(deadline: .now() + DesignConstants.buttonDelayDuration) {
            showWalkthrough.toggle()
        }
    }
}

// MARK: - Preview
#Preview {
    CardView(showWalkthrough: .constant(false))
        .background(Color.gray.opacity(0.1))
}
