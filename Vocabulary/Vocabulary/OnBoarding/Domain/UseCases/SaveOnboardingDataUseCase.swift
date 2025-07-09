//
//  SaveOnboardingDataUseCase.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 08/07/2025.
//

import Foundation
import Combine

protocol SaveOnboardingDataUseCaseProtocol {
    func execute(_ data: OnboardingData) -> AnyPublisher<Void, Error>
}

final class SaveOnboardingDataUseCase: SaveOnboardingDataUseCaseProtocol {
    private let repository: OnboardingRepositoryProtocol
    
    init(repository: OnboardingRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(_ data: OnboardingData) -> AnyPublisher<Void, Error> {
        var updatedData = data
        
        // Mark as completed when saving at the done step
        if updatedData.completedAt == nil && hasAllRequiredData(updatedData) {
            updatedData.completedAt = Date()
        }
        
        return repository.save(updatedData)
    }
    
    private func hasAllRequiredData(_ data: OnboardingData) -> Bool {
        // Check if all required fields are filled
        // Name, goals, and topics are optional (can be skipped)
        return data.referral != nil &&
               data.ageRange != nil &&
               data.gender != nil
    }
}
