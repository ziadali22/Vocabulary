//
//  OnboardingFlowViewModel.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 08/07/2025.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class OnboardingFlowViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published private(set) var currentStep: OnboardingStep = .referral
    @Published private(set) var onboardingData = OnboardingData()
    @Published var error: Error?
    @Published var showOnboarding = false
    
    // MARK: - Use Cases
    private let saveDataUseCase: SaveOnboardingDataUseCaseProtocol
    private let getDataUseCase: GetOnboardingDataUseCaseProtocol
    private let clearDataUseCase: ClearOnboardingDataUseCaseProtocol
    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    private let onboardingCompleted: () -> Void
    
    // MARK: - Initialization
    init(
        saveDataUseCase: SaveOnboardingDataUseCaseProtocol,
        getDataUseCase: GetOnboardingDataUseCaseProtocol,
        clearDataUseCase: ClearOnboardingDataUseCaseProtocol,
        onboardingCompleted: @escaping () -> Void
    ) {
        self.saveDataUseCase = saveDataUseCase
        self.getDataUseCase = getDataUseCase
        self.clearDataUseCase = clearDataUseCase
        self.onboardingCompleted = onboardingCompleted
        
        loadExistingData()
    }
    
    // MARK: - Public Methods
    func proceedToNext() {
        guard let nextStep = currentStep.next else {
            if currentStep == .done {
                completeOnboarding()
            }
            return
        }
        
        // Save data when moving to the next step
        saveCurrentData()
        
        withAnimation(.easeInOut(duration: 0.3)) {
            currentStep = nextStep
        }
    }
    
    func goBack() {
        guard let previousStep = currentStep.previous else { return }
        
        withAnimation(.easeInOut(duration: 0.3)) {
            currentStep = previousStep
        }
    }
    
    func skip() {
        guard currentStep.allowsSkip else { return }
        proceedToNext()
    }
    
    func updateReferral(_ referral: Referral?) {
        onboardingData.referral = referral
    }
    
    func updateAge(_ age: AgeRange?) {
        onboardingData.ageRange = age
    }
    
    func updateGender(_ gender: GenderOptions?) {
        onboardingData.gender = gender
    }
    
    func updateName(_ name: String) {
        onboardingData.name = name.isEmpty ? nil : name
    }
    
    func updateGoals(_ goals: Set<GoalsOptions>) {
        onboardingData.goals = goals
    }
    
    func updateTopics(_ topics: Set<TopicsOptions>) {
        onboardingData.topics = topics
    }
    
    func restart() {
        clearDataUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] in
                    self?.onboardingData = OnboardingData()
                    self?.currentStep = .referral
                }
            )
            .store(in: &cancellables)
    }
    
    // MARK: - Private Methods
    private func loadExistingData() {
        
        getDataUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.error = error
                    }
                },
                receiveValue: { [weak self] data in
                    if let data, !data.isComplete {
                        self?.onboardingData = data
                        // Resume from where user left off
                        self?.determineCurrentStep(from: data)
                    }
                }
            )
            .store(in: &cancellables)
    }
    
    private func saveCurrentData() {
        saveDataUseCase.execute(onboardingData)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.error = error
                    }
                },
                receiveValue: { _ in
                    // Data saved successfully
                }
            )
            .store(in: &cancellables)
    }
    
    private func completeOnboarding() {
        // Mark as completed and save
        onboardingData.completedAt = Date()
        
        saveDataUseCase.execute(onboardingData)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.error = error
                    } else {
                        self?.onboardingCompleted()
                    }
                },
                receiveValue: { _ in }
            )
            .store(in: &cancellables)
    }
    
    private func determineCurrentStep(from data: OnboardingData) {
        // Determine which step to show based on saved data
        if data.referral == nil {
            currentStep = .referral
        } else if data.ageRange == nil {
            currentStep = .age
        } else if data.gender == nil {
            currentStep = .gender
        } else {
            // Continue through the flow
            currentStep = .success
        }
    }
}
