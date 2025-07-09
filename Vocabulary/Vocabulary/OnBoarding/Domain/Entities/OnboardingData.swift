//
//  OnboardingData.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 08/07/2025.
//

import Foundation

// MARK: - Domain Entity
struct OnboardingData: Equatable {
    var referral: Referral?
    var ageRange: AgeRange?
    var gender: GenderOptions?
    var name: String?
    var goals: Set<GoalsOptions>
    var topics: Set<TopicsOptions>
    var completedAt: Date?
    
    init() {
        self.goals = []
        self.topics = []
    }
    
    var isComplete: Bool {
        completedAt != nil
    }
}

// MARK: - Onboarding Options (Domain Enums)
protocol OnboardingOption: RawRepresentable, CaseIterable, Hashable, Codable where RawValue == String {}

enum Referral: String, OnboardingOption {
    case appStore = "App Store"
    case instagram = "Instagram"
    case tikTok = "TikTok"
    case friendFamily = "Friend/family"
    case webSearch = "Web search"
    case facebook = "Facebook"
}

enum AgeRange: String, OnboardingOption {
    case under18 = "Under 18"
    case from18to24 = "18-24"
    case from25to34 = "25-34"
    case from35to44 = "35-44"
    case over55 = "55+"
}

enum GenderOptions: String, OnboardingOption {
    case female = "Female"
    case male = "Male"
    case other = "Other"
    case preferNotToSay = "Prefer not to say"
}

enum GoalsOptions: String, OnboardingOption {
    case enjoy = "Enjoy learning new words"
    case improve = "Improve my job prospects"
    case getReady = "Get ready for a test"
    case enhance = "Enhance my lexicon"
    case other = "Other"
}

enum TopicsOptions: String, OnboardingOption {
    case emotions = "Emotions"
    case society = "Society"
    case human = "Human body"
    case foreign = "Words in foreign languages"
    case business = "Business"
}
