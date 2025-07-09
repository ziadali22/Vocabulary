//
//  VocabularyLearningUseCase.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 09/07/2025.
//

class VocabularyLearningUseCase: VocabularyLearningUseCaseProtocol {
    private let repository: VocabularyRepositoryProtocol
    
    init(repository: VocabularyRepositoryProtocol) {
        self.repository = repository
    }
    
    func getVocabularies() async throws -> [Vocabulary] {
        return try await repository.fetchVocabularies()
    }
}
