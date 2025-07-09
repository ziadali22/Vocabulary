//
//  GetOnboardingDataUseCase.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 08/07/2025.
//

import Foundation
import Combine

protocol GetOnboardingDataUseCaseProtocol {
    func execute() -> AnyPublisher<OnboardingData?, Error>
}

final class GetOnboardingDataUseCase: GetOnboardingDataUseCaseProtocol {
    private let repository: OnboardingRepositoryProtocol
    
    init(repository: OnboardingRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<OnboardingData?, Error> {
        repository.get()
    }
}
