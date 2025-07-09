//
//  OnboardingLocalDataSource.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 08/07/2025.
//

import Foundation
import SwiftData
import Combine

protocol OnboardingLocalDataSourceProtocol {
    func save(_ model: OnboardingDataModel) -> AnyPublisher<Void, Error>
    func get() -> AnyPublisher<OnboardingDataModel?, Error>
    func clear() -> AnyPublisher<Void, Error>
}

final class OnboardingLocalDataSource: OnboardingLocalDataSourceProtocol {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    init() throws {
        self.modelContainer = try ModelContainer(for: OnboardingDataModel.self)
        self.modelContext = ModelContext(modelContainer)
    }
    
    func save(_ model: OnboardingDataModel) -> AnyPublisher<Void, Error> {
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(OnboardingError.dataSourceDeallocated))
                return
            }
            
            do {
                // Check if there's an existing model
                let descriptor = FetchDescriptor<OnboardingDataModel>()
                let existing = try self.modelContext.fetch(descriptor).first
                
                if let existing {
                    // Update existing model
                    existing.update(from: model.toDomain())
                } else {
                    // Insert new model
                    self.modelContext.insert(model)
                }
                
                try self.modelContext.save()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func get() -> AnyPublisher<OnboardingDataModel?, Error> {
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(OnboardingError.dataSourceDeallocated))
                return
            }
            
            do {
                let descriptor = FetchDescriptor<OnboardingDataModel>()
                let models = try self.modelContext.fetch(descriptor)
                promise(.success(models.first))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func clear() -> AnyPublisher<Void, Error> {
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(OnboardingError.dataSourceDeallocated))
                return
            }
            
            do {
                let descriptor = FetchDescriptor<OnboardingDataModel>()
                let models = try self.modelContext.fetch(descriptor)
                
                for model in models {
                    self.modelContext.delete(model)
                }
                
                try self.modelContext.save()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}

// MARK: - Error Types
enum OnboardingError: LocalizedError {
    case dataSourceDeallocated
    case invalidData
    
    var errorDescription: String? {
        switch self {
        case .dataSourceDeallocated:
            return "Data source was deallocated"
        case .invalidData:
            return "Invalid onboarding data"
        }
    }
}
