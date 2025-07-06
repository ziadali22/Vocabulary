//
//  NameInputView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 06/07/2025.
//

import SwiftUI

struct NameInputView: View {
    @State private var name: String = ""
    @FocusState private var isTextFieldFocused: Bool
    
    @State private var titleVisible = false
    @State private var lottieVisible = false
    @State private var buttonVisible = false
    
    let title: String
    let onContinue: (String) -> Void
    let onSkip: () -> Void
    
    private let suggestedNames = ["Ziad Ali", "Ziad"]
    
    var body: some View {
        VStack {

            HStack {
                Spacer()
                Button("Skip") {
                    onSkip()
                }
                .foregroundColor(.white)
                .font(.system(size: 17))
            }
            .padding(.horizontal, 40)
            .padding(.top, 80)
            
            
            VStack(spacing: 24) {
                
                VStack(spacing: 16) {
                    Text(title)
                        .font(.system(size: 32, weight: .medium))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black, radius: 1, y: 3)
                    
                    Text("Your name is used to personalize your experience")
                        .font(.system(size: 17))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                
                TextField("Your name", text: $name)
                    .focused($isTextFieldFocused)
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.black.opacity(0.3))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(isTextFieldFocused ? Color.blue : Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    )
                    .padding(.horizontal)
                    .padding(.top, 32)
            }
            .padding(.top, 60)
            
            
            Button(action: {
                onContinue(name)
            }) {
                Text("Continue")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(AppColors.primaryButton)
                    .cornerRadius(28)
            }
            .padding(.horizontal)
            .padding(.top, 32)
            .shadow(color: .black, radius: 1, y: 5)
            .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
            .opacity(name.trimmingCharacters(in: .whitespaces).isEmpty ? 0.6 : 1.0)
            
            Spacer()
        }
        
        .background(AppColors.background)
        .ignoresSafeArea()
        .onTapGesture {
            isTextFieldFocused = false
        }
    }
}

#Preview {
    NameInputView(title: "", onContinue: {_ in }, onSkip: {})

}
