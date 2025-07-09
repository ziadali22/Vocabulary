//
//  SessionTitleViewModern.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 09/07/2025.
//

import SwiftUI

struct SessionTitleViewModern: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("Today Session")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            .purple,
                            .blue,
                            .cyan,
                            .mint
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .purple.opacity(0.3), radius: 10, x: 0, y: 5)
        }
    }
}
