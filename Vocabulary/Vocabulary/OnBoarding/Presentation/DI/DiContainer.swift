//
//  DiContainer.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 09/07/2025.
//

import Foundation
import SwiftUI

// MARK: - DI Container
final class DIContainer {
    static let shared = DIContainer()
    
    // MARK: - Data Layer
    private lazy var onboardingLocalDataSource: OnboardingLocalDataSourceProtocol = {
        do {
            return try OnboardingLocalDataSource()
        } catch {
            fatalError("Failed to initialize OnboardingLocalDataSource: \(error)")
        }
    }()
    
    private lazy var onboardingRepository: OnboardingRepositoryProtocol = {
        OnboardingRepository(localDataSource: onboardingLocalDataSource)
    }()
    
    // MARK: - Domain Layer
    private lazy var saveOnboardingDataUseCase: SaveOnboardingDataUseCaseProtocol = {
        SaveOnboardingDataUseCase(repository: onboardingRepository)
    }()
    
    private lazy var getOnboardingDataUseCase: GetOnboardingDataUseCaseProtocol = {
        GetOnboardingDataUseCase(repository: onboardingRepository)
    }()
    
    private lazy var clearOnboardingDataUseCase: ClearOnboardingDataUseCaseProtocol = {
        ClearOnboardingDataUseCase(repository: onboardingRepository)
    }()
    
    // MARK: - ViewModels
    @MainActor func makeOnboardingFlowViewModel(onboardingCompleted: @escaping () -> Void) -> OnboardingFlowViewModel {
        OnboardingFlowViewModel(
            saveDataUseCase: saveOnboardingDataUseCase,
            getDataUseCase: getOnboardingDataUseCase,
            clearDataUseCase: clearOnboardingDataUseCase,
            onboardingCompleted: onboardingCompleted
        )
    }
}
