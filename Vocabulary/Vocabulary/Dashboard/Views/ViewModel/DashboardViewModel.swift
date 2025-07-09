//
//  DashboardViewModel.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 09/07/2025.
//

import SwiftUI

@MainActor
class DashboardViewModel: ObservableObject {
    @Published var vocabularies: [Vocabulary] = []
    @Published var currentIndex: Int = 0
    @Published var learnedVocabularyIds: Set<UUID> = []
    
    private let useCase: VocabularyLearningUseCaseProtocol
    private let audioPlayer = AudioPlayerService()
    
    var currentVocabulary: Vocabulary? {
        guard currentIndex < vocabularies.count else { return nil }
        return vocabularies[currentIndex]
    }
    
    var learnedCount: Int {
        learnedVocabularyIds.count
    }
    
    var progress: Double {
        guard !vocabularies.isEmpty else { return 0 }
        return Double(learnedCount) / Double(vocabularies.count)
    }
    
    var progressText: String {
        "\(learnedCount)/\(vocabularies.count)"
    }
    
    var isCurrentVocabularyLearned: Bool {
        guard let current = currentVocabulary else { return false }
        return learnedVocabularyIds.contains(current.id)
    }
    
    var allVocabulariesLearned: Bool {
        !vocabularies.isEmpty && learnedCount == vocabularies.count
    }
    
    init(useCase: VocabularyLearningUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func loadVocabularies() async {
        do {
            vocabularies = try await useCase.getVocabularies()
        } catch {
            print("Error loading vocabularies: \(error)")
        }
    }
    
    func nextVocabulary() {
        guard currentIndex < vocabularies.count - 1 else { return }
        
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            currentIndex += 1
        }
    }
    
    func previousVocabulary() {
        guard currentIndex > 0 else { return }
        
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            currentIndex -= 1
        }
    }
    
    func markCurrentAsLearned() async {
        guard let current = currentVocabulary else { return }
        
        // Check if already learned to prevent double counting
        guard !learnedVocabularyIds.contains(current.id) else { return }
        
        do {
            
            // Add to learned set
            learnedVocabularyIds.insert(current.id)
            
            audioPlayer.playSuccessSound()
            
            // Wait a bit to show the animation before advancing
            try await Task.sleep(nanoseconds: 700_000_000)
            
            // Auto-advance to next word only if not at the last vocabulary
            await MainActor.run {
                if allVocabulariesLearned {
                    return
                } else if currentIndex < vocabularies.count - 1 {
                    nextVocabulary()
                }
            }
        } catch {
            print("Error marking vocabulary as learned: \(error)")
        }
    }
    
    func playPronunciation() {
        guard let vocabulary = currentVocabulary else { return }
        audioPlayer.playPronunciation(for: vocabulary.word)
    }
}
