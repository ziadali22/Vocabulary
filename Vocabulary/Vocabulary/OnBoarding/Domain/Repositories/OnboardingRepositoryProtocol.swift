//
//  OnboardingRepositoryProtocol.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 08/07/2025.
//

import Foundation
import Combine

protocol OnboardingRepositoryProtocol {
    func save(_ data: OnboardingData) -> AnyPublisher<Void, Error>
    func get() -> AnyPublisher<OnboardingData?, Error>
    func clear() -> AnyPublisher<Void, Error>
}
