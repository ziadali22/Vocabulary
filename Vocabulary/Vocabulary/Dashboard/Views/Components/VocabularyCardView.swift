//
//  VocabularyCardView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 09/07/2025.
//

import SwiftUI

struct VocabularyCardView: View {
    let vocabulary: Vocabulary
    let isLearned: Bool
    let onPronunciationTap: () -> Void
    let onMarkLearned: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            // Word and pronunciation
            VStack(spacing: 12) {
                Text(vocabulary.word)
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Button(action: onPronunciationTap) {
                    HStack(spacing: 8) {
                        Text(vocabulary.pronunciation)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                        
                        Image(systemName: "speaker.2")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                    }
                }
            }
            
            VStack(spacing: 16) {
                Text("(\(vocabulary.partOfSpeech)) \(vocabulary.definition)")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                
                Text(vocabulary.example)
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .italic()
            }
            
            MarkLearnedButton(isLearned: isLearned, onMarkLearned: onMarkLearned)
            Spacer()
        }
        .padding(.horizontal, 32)
    }
}
