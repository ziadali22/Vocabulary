//
//  VocabularyLearningUseCaseProtocol.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 09/07/2025.
//

protocol VocabularyLearningUseCaseProtocol {
    func getVocabularies() async throws -> [Vocabulary]
}
