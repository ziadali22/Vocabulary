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
        HStack {
            Spacer()
            Button(action: {
                withAnimation {
                    showWalkthrough.toggle()
                }
            }) {
                if !showWalkthrough {
                    Image(systemName: "arrow.down.app")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(Color(.label))
                        .offset(y: isDownloadIconAnimating ? 10 : -10)
                }
            }
            .padding(.top, 16)
            Spacer()
        }
    }
}
