//
//  VocabularyApp.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 04/07/2025.
//

import SwiftUI
import SwiftData

@main
struct VocabularyApp: App {
    var body: some Scene {
        WindowGroup {
            OnboardingContainerView()
                .modelContainer(for: OnboardingDataModel.self)
        }
    }
}
