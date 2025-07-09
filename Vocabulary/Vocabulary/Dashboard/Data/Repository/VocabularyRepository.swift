//
//  VocabularyRepository 2.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 09/07/2025.
//


class VocabularyRepository: VocabularyRepositoryProtocol {
    func fetchVocabularies() async throws -> [Vocabulary] {
        return [
            Vocabulary(
                word: "sedulous",
                pronunciation: "ˈsedʒələs",
                partOfSpeech: "adj.",
                definition: "Working hard and never giving up",
                example: "Her sedulous study habits paid off.",
            ),
            Vocabulary(
                word: "ubiquitous",
                pronunciation: "juːˈbɪkwɪtəs",
                partOfSpeech: "adj.",
                definition: "Present everywhere at the same time",
                example: "Smartphones have become ubiquitous in modern society.",
            ),
            Vocabulary(
                word: "perspicacious",
                pronunciation: "ˌpɜːrspɪˈkeɪʃəs",
                partOfSpeech: "adj.",
                definition: "Having great insight and understanding",
                example: "The perspicacious detective solved the case quickly.",
            ),
            Vocabulary(
                word: "ephemeral",
                pronunciation: "ɪˈfemərəl",
                partOfSpeech: "adj.",
                definition: "Lasting for a very short time",
                example: "The beauty of cherry blossoms is ephemeral.",
            ),
            Vocabulary(
                word: "magnanimous",
                pronunciation: "mæɡˈnænɪməs",
                partOfSpeech: "adj.",
                definition: "Generous in forgiving; noble in spirit",
                example: "She was magnanimous in victory, praising her opponents.",
            )
        ]
    }
}
