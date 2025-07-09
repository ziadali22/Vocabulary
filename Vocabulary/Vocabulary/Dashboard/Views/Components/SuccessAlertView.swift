//
//  SuccessAlertView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 10/07/2025.
//

import SwiftUI
import Lottie

struct SuccessAlertView: View {
    @Binding var isPresented: Bool
    @State private var cardVisible = false
    @State private var confettiVisible = false

    var body: some View {
        if isPresented {
            ZStack {
                Color.clear
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    }
                
                VStack(spacing: 16) {
                    LottieView(animation: .named("good"))
                        .configure { lottie in
                            lottie.contentMode = .scaleAspectFit
                        }
                        .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
                        .frame(width: 200, height: 200)
                        .padding(.vertical, 16)
                    
                    HStack(spacing: 20) {
                        StatBadge(icon: "book.fill", value: "5", label: "Words")
                        StatBadge(icon: "clock.fill", value: "2m", label: "Time")
                        StatBadge(icon: "", value: "🔥", label: "Streak")
                    }
                    .opacity(cardVisible ? 1 : 0)
                    .offset(y: cardVisible ? 0 : 15)
                    .padding(.bottom, 20)
                    
                    Text("Well Done 🎉")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(AppColors.primaryText)
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 28)
                        .fill(AppColors.background)
                }
                .cornerRadius(20)
                .padding(40)
                .shadow(radius: 20)
                .scaleEffect(cardVisible ? 1.0 : 0.8)
                .opacity(cardVisible ? 1 : 0)
                .offset(y: cardVisible ? 0 : -50)
                
                if confettiVisible {
                    TopConfettiView()
                        .allowsHitTesting(false)
                }
            }
            .onAppear {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    cardVisible = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                    confettiVisible = true
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    dismissPopup()
                }
            }
        }
    }
    
    private func dismissPopup() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            cardVisible = false
            confettiVisible = false
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isPresented = false
        }
    }
}
