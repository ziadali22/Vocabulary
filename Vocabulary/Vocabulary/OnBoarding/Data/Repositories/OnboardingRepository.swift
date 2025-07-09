//
//  OnboardingRepository.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 08/07/2025.
//

import Foundation
import Combine

final class OnboardingRepository: OnboardingRepositoryProtocol {
    private let localDataSource: OnboardingLocalDataSourceProtocol
    
    init(localDataSource: OnboardingLocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }
    
    func save(_ data: OnboardingData) -> AnyPublisher<Void, Error> {
        let model = OnboardingDataModel(from: data)
        return localDataSource.save(model)
    }
    
    func get() -> AnyPublisher<OnboardingData?, Error> {
        localDataSource.get()
            .map { model in
                model?.toDomain()
            }
            .eraseToAnyPublisher()
    }
    
    func clear() -> AnyPublisher<Void, Error> {
        localDataSource.clear()
    }
}
