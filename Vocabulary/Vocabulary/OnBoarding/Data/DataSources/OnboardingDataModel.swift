//
//  OnboardingDataModel.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 08/07/2025.
//

import Foundation
import SwiftData

@Model
final class OnboardingDataModel {
    @Attribute(.unique) var id: UUID
    var referralRaw: String?
    var ageRangeRaw: String?
    var genderRaw: String?
    var name: String?
    var goalsRaw: [String]
    var topicsRaw: [String]
    var completedAt: Date?
    var createdAt: Date
    var updatedAt: Date
    
    init() {
        self.id = UUID()
        self.goalsRaw = []
        self.topicsRaw = []
        self.createdAt = Date()
        self.updatedAt = Date()
    }
    
    // MARK: - Computed Properties for Domain Mapping
    var referral: Referral? {
        get { referralRaw.flatMap { Referral(rawValue: $0) } }
        set { referralRaw = newValue?.rawValue }
    }
    
    var ageRange: AgeRange? {
        get { ageRangeRaw.flatMap { AgeRange(rawValue: $0) } }
        set { ageRangeRaw = newValue?.rawValue }
    }
    
    var gender: GenderOptions? {
        get { genderRaw.flatMap { GenderOptions(rawValue: $0) } }
        set { genderRaw = newValue?.rawValue }
    }
    
    var goals: Set<GoalsOptions> {
        get {
            Set(goalsRaw.compactMap { GoalsOptions(rawValue: $0) })
        }
        set {
            goalsRaw = Array(newValue.map { $0.rawValue })
        }
    }
    
    var topics: Set<TopicsOptions> {
        get {
            Set(topicsRaw.compactMap { TopicsOptions(rawValue: $0) })
        }
        set {
            topicsRaw = Array(newValue.map { $0.rawValue })
        }
    }
}

// MARK: - Domain Mapping
extension OnboardingDataModel {
    convenience init(from domain: OnboardingData) {
        self.init()
        self.referral = domain.referral
        self.ageRange = domain.ageRange
        self.gender = domain.gender
        self.name = domain.name
        self.goals = domain.goals
        self.topics = domain.topics
        self.completedAt = domain.completedAt
    }
    
    func toDomain() -> OnboardingData {
        var data = OnboardingData()
        data.referral = referral
        data.ageRange = ageRange
        data.gender = gender
        data.name = name
        data.goals = goals
        data.topics = topics
        data.completedAt = completedAt
        return data
    }
    
    func update(from domain: OnboardingData) {
        self.referral = domain.referral
        self.ageRange = domain.ageRange
        self.gender = domain.gender
        self.name = domain.name
        self.goals = domain.goals
        self.topics = domain.topics
        self.completedAt = domain.completedAt
        self.updatedAt = Date()
    }
}
