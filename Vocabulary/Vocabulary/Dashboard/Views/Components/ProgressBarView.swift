//
//  ProgressBarView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 09/07/2025.
//

import SwiftUI

struct ProgressBarView: View {
    let progress: Double
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "bookmark")
                .foregroundColor(.white)
                .font(.system(size: 16))
            
            Text(text)
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .medium))
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.white.opacity(0.3))
                        .frame(height: 4)
                        .cornerRadius(2)
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: geometry.size.width * progress, height: 4)
                        .cornerRadius(2)
                        .animation(.easeInOut(duration: 0.3), value: progress)
                }
            }
            .frame(height: 4)
        }
    }
}
