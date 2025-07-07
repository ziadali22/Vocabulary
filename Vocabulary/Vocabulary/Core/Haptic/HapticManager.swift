//
//  HapticManager.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 07/07/2025.
//

import SwiftUI

// MARK: - Haptic Feedback Manager
protocol HapticFeedbackProviding {
    func provideMediumImpact()
}

struct HapticFeedbackManager: HapticFeedbackProviding {
    func provideMediumImpact() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
}
