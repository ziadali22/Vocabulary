//
//  Vocabulary.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 09/07/2025.
//

import Foundation
struct Vocabulary: Identifiable, Hashable {
    let id = UUID()
    let word: String
    let pronunciation: String
    let partOfSpeech: String
    let definition: String
    let example: String
}
