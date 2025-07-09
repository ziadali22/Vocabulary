//
//  PopUpSuccessView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 09/07/2025.
//

import SwiftUI
import Lottie


// MARK: - Supporting Views

//struct StatBadge: View {
//    let icon: String
//    let value: String
//    let label: String
//    
//    var body: some View {
//        VStack(spacing: 4) {
//            Image(systemName: icon)
//                .font(.system(size: 16, weight: .medium))
//                .foregroundColor(.green)
//            
//            Text(value)
//                .font(.system(size: 14, weight: .bold, design: .rounded))
//                .foregroundColor(AppColors.primaryText)
//            
//            Text(label)
//                .font(.system(size: 10, weight: .medium))
//                .foregroundColor(.gray)
//        }
//        .frame(width: 60)
//    }
//}

struct TopConfettiView: View {
    @State private var animate = false
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<12, id: \.self) { i in
                    ConfettiParticle()
                        .offset(
                            x: animate ? CGFloat.random(in: -150...150) : CGFloat.random(in: -30...30),
                            y: animate ? CGFloat.random(in: 100...400) : 0
                        )
                        .rotationEffect(.degrees(animate ? Double.random(in: 0...720) : 0))
                        .opacity(animate ? 0 : 1)
                        .animation(
                            .easeOut(duration: Double.random(in: 2...3))
                            .delay(Double(i) * 0.1),
                            value: animate
                        )
                }
            }
            .frame(height: 200)
            .padding(.top, 120)
            
            Spacer()
        }
        .onAppear {
            animate = true
        }
    }
}

struct ConfettiParticle: View {
    let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple, .pink, .mint]
    let shapes = ["circle.fill", "star.fill", "heart.fill"]
    
    var body: some View {
        Image(systemName: shapes.randomElement() ?? "circle.fill")
            .foregroundColor(.white)
            .font(.system(size: CGFloat.random(in: 8...14)))
    }
}



