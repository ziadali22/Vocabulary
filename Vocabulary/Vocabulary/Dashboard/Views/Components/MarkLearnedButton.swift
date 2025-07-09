//
//  MarkLearnedButton.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 09/07/2025.
//

import SwiftUI

struct MarkLearnedButton: View {
    let isLearned: Bool
    let onMarkLearned: () -> Void

    @State private var scale: CGFloat = 1.0

    var body: some View {
        Button(action: {
            animateTap()
            onMarkLearned()
        }) {
            HStack {
                Image(systemName: isLearned ? "checkmark.circle.fill" : "checkmark.circle")
                Text(isLearned ? "Learned" : "Mark as Learned")
            }
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(isLearned ? .white : .black)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(isLearned ? Color.green : Color.white)
            .cornerRadius(25)
            .scaleEffect(scale)
            .animation(.easeInOut(duration: 0.3), value: isLearned)
        }
        .disabled(isLearned)
        .opacity(isLearned ? 0.7 : 1.0)
    }

    private func animateTap() {
        scale = 0.95
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            scale = 1.0
        }
    }
}
