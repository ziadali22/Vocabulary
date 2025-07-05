//
//  OnBoarding.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 05/07/2025.
//

import SwiftUI

struct OnBoarding: View {
    @State private var showWalkthrough: Bool = false
    
    var body: some View {
        ZStack {
            IntroView(showWalkThrough: $showWalkthrough)
                .animation(
                    .interactiveSpring(response: 1.1, dampingFraction: 0.85, blendDuration: 0.85),
                    value: showWalkthrough
                )
        }
        .background(Color(.systemBackground))
    }
}

#Preview {
    OnBoarding()
}
