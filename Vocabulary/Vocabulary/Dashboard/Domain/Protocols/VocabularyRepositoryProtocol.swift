//
//  VocabularyRepositoryProtocol.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 09/07/2025.
//

protocol VocabularyRepositoryProtocol {
    func fetchVocabularies() async throws -> [Vocabulary]
}
