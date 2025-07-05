//
//  IntroView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 04/07/2025.
//

import SwiftUI

struct IntroView: View {
    @StateObject private var viewModel = IntroViewModel()
    @Binding var showWalkThrough: Bool
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let safeArea = geometry.safeAreaInsets
            
            VStack(spacing: 0) {
                if let intro = viewModel.activeIntro {
                    IntroHeaderView(
                        intro: intro,
                        animationState: viewModel.animationState,
                        textWidth: viewModel.calculateTextWidth(for: intro.text),
                        screenWidth: size.width
                    )
                }
                
                CardView(showWalkthrough: $showWalkThrough)
                    .padding(.bottom, safeArea.bottom)
                    .padding(.top, 10)
                    .background(
                        Color(.systemBackground),
                        in: .rect(topLeadingRadius: 25, topTrailingRadius: 25)
                    )
            }
            .ignoresSafeArea()
            .offset(y: showWalkThrough ? -size.height : 0)
        }
        .task {
            viewModel.startIntroSequence()
        }
        .onDisappear {
            viewModel.stopAnimations()
        }
    }
}

#Preview {
    IntroView(showWalkThrough: .constant(false))
}
