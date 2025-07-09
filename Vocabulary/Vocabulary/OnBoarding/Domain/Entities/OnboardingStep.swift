//
//  OnboardingStep.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 08/07/2025.
//

import Foundation

enum OnboardingStep: Int, CaseIterable {
    case referral
    case age
    case gender
    case success
    case nameInput
    case goals
    case topics
    case done
    
    var title: String {
        switch self {
        case .referral:
            return "How did you hear about Vocabulary?"
        case .age:
            return "What is your age group?"
        case .gender:
            return "What is your gender?"
        case .success:
            return "Customize the app to improve your experience 🎉"
        case .nameInput:
            return "What do you want to be called?"
        case .goals:
            return "Do you have a specific goal in mind?"
        case .topics:
            return "Which topics are you interested in?"
        case .done:
            return "Ready to Unlock New Words?"
        }
    }
    
    var animationName: String? {
        switch self {
        case .success:
            return "learn.json"
        case .done:
            return "learn2.json"
        default:
            return nil
        }
    }
    
    var next: OnboardingStep? {
        guard let currentIndex = OnboardingStep.allCases.firstIndex(of: self),
              currentIndex < OnboardingStep.allCases.count - 1 else {
            return nil
        }
        return OnboardingStep.allCases[currentIndex + 1]
    }
    
    var previous: OnboardingStep? {
        guard let currentIndex = OnboardingStep.allCases.firstIndex(of: self),
              currentIndex > 0 else {
            return nil
        }
        return OnboardingStep.allCases[currentIndex - 1]
    }
    
    var allowsSkip: Bool {
        switch self {
        case .nameInput, .goals, .topics:
            return true
        default:
            return false
        }
    }
}
