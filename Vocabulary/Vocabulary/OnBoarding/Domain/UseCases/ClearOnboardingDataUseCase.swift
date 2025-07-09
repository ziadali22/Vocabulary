//
//  ClearOnboardingDataUseCase.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 08/07/2025.
//

import Foundation
import Combine

protocol ClearOnboardingDataUseCaseProtocol {
    func execute() -> AnyPublisher<Void, Error>
}

final class ClearOnboardingDataUseCase: ClearOnboardingDataUseCaseProtocol {
    private let repository: OnboardingRepositoryProtocol
    
    init(repository: OnboardingRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<Void, Error> {
        repository.clear()
    }
}
