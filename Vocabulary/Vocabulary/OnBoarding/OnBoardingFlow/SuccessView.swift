//
//  SuccessView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 06/07/2025.
//

import SwiftUI
import Lottie

struct SuccessView: View {
    let onSelect: () -> Void
    
    @State private var titleVisible = false
    @State private var lottieVisible = false
    @State private var buttonVisible = false
    
    var body: some View {
        VStack(spacing: 40) {
            
            Text("Customize the app to improve your experience 🎉")
                .font(.title2.bold())
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .shadow(color: .black, radius: 1, y: 3)
                .padding(.horizontal)
                .offset(y: titleVisible ? 0 : -50)
                .opacity(titleVisible ? 1 : 0)
                .animation(.spring(response: 0.8, dampingFraction: 0.8).delay(0.2), value: titleVisible)
            
            LottieView(animation: .named("learn.json"))
                .configure({ lottie in
                    lottie.contentMode = .scaleAspectFill
                })
                .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
                .frame(maxWidth: .infinity, maxHeight: 400)
                .clipped()
                .scaleEffect(lottieVisible ? 1.0 : 0.3)
                .opacity(lottieVisible ? 1 : 0)
                .animation(.spring(response: 1.0, dampingFraction: 0.7).delay(0.4), value: lottieVisible)
            
            Button("Continue") {
                onSelect()
            }
            .font(.headline)
            .foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity, minHeight: 44)
            .background(AppColors.primaryButton)
            .cornerRadius(8)
            .shadow(color: .black, radius: 1, y: 5)
            .padding()
            .offset(y: buttonVisible ? 0 : 50)
            .opacity(buttonVisible ? 1 : 0)
            .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.6), value: buttonVisible)
        }
        .padding()
        .onAppear {
            titleVisible = true
            lottieVisible = true
            buttonVisible = true
        }
    }
}

#Preview {
    SuccessView(onSelect: {})
}
