//
//  AppAnimation.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 07/07/2025.
//

import SwiftUI

struct AppAnimations {
    static let defaultEaseOut = Animation.easeOut(duration: 0.4)
    static let buttonPress = Animation.easeIn(duration: 0.1)
    static let buttonRelease = Animation.spring(response: 0.3, dampingFraction: 0.6)
    static let headerSpring = Animation.spring(response: 0.5, dampingFraction: 0.7)
    static let selection = Animation.easeInOut(duration: 0.3)
}
