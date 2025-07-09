//
//  OnboardingContainerView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 09/07/2025.
//

import SwiftUI

struct OnboardingContainerView: View {
    @State private var showWalkthrough = false
    @State private var isOnboardingComplete = false
    
    var body: some View {
        ZStack {
            if isOnboardingComplete {
                DashboardView()
            } else {
                ZStack {
                    IntroView(showWalkThrough: $showWalkthrough)
                    
                    OnboardingFlowView(
                        showWalkThrough: $showWalkthrough,
                        viewModel: DIContainer.shared.makeOnboardingFlowViewModel {
                            withAnimation {
                                isOnboardingComplete = true
                            }
                        }
                    )
                }
            }
        }
        .animation(
            .interactiveSpring(
                response: 0.85,
                dampingFraction: 0.85,
                blendDuration: 0.85
            ),
            value: showWalkthrough
        )
        .background(AppColors.background)
    }
}
