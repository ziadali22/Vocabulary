//
//  ContinueButtonSection.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 05/07/2025.
//

import SwiftUI

struct ContinueButtonSection: View {
    let isDownloadIconAnimating: Bool
    @Binding var showWalkthrough: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            Button {
                withAnimation {
                    showWalkthrough.toggle()
                }
            } label: {
                if !showWalkthrough {
                    animateContinueButton()
                }
            }
            .padding(.top, 8)
            .padding(.horizontal, 16)
        }
        .padding(.horizontal, 24)
    }
    
    private func animateContinueButton() -> some View {
        VStack(spacing: 24) {
            Image(systemName: "arrow.down.circle")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundStyle(.white)
                .offset(y: isDownloadIconAnimating ? 10 : -10)
            
            Text("Let's Start")
                .font(.title3)
                .foregroundStyle(.white)
        }
    }
}
