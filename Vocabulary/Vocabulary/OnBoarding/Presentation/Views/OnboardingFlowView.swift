//
//  OnboardingFlowView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 08/07/2025.
//

import SwiftUI

struct OnboardingFlowView: View {
    @StateObject private var viewModel: OnboardingFlowViewModel
    @Binding var showWalkThrough: Bool
    
    init(
        showWalkThrough: Binding<Bool>,
        viewModel: OnboardingFlowViewModel
    ) {
        self._showWalkThrough = showWalkThrough
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            ZStack {
                AppColors.background.ignoresSafeArea()
                stepContent
            }
            .animation(.easeInOut(duration: 0.3), value: viewModel.currentStep)
            .offset(y: showWalkThrough ? 0 : size.height)
            .animation(.easeInOut(duration: 0.5), value: showWalkThrough)
            .onAppear {
                viewModel.showOnboarding = showWalkThrough
            }
            .alert("Error", isPresented: .constant(viewModel.error != nil)) {
                Button("OK") {
                    viewModel.error = nil
                }
            } message: {
                Text(viewModel.error?.localizedDescription ?? "An error occurred")
            }
        }
    }
    
    @ViewBuilder
    private var stepContent: some View {
        switch viewModel.currentStep {
        case .referral:
            SingleSelectionStepView(
                title: viewModel.currentStep.title,
                options: Referral.allCases,
                initialValue: viewModel.onboardingData.referral
            ) { referral in
                viewModel.updateReferral(referral)
                viewModel.proceedToNext()
            }
            
        case .age:
            SingleSelectionStepView(
                title: viewModel.currentStep.title,
                options: AgeRange.allCases,
                initialValue: viewModel.onboardingData.ageRange
            ) { age in
                viewModel.updateAge(age)
                viewModel.proceedToNext()
            }
            
        case .gender:
            SingleSelectionStepView(
                title: viewModel.currentStep.title,
                options: GenderOptions.allCases,
                initialValue: viewModel.onboardingData.gender
            ) { gender in
                viewModel.updateGender(gender)
                viewModel.proceedToNext()
            }
            
        case .success:
            SuccessStepView(
                title: viewModel.currentStep.title,
                animationName: viewModel.currentStep.animationName!,
                onContinue: {
                    viewModel.proceedToNext()
                }
            )
            
        case .nameInput:
            NameInputStepView(
                viewModel: NameInputViewModel(initialValue: viewModel.onboardingData.name,
                                              onContinue: { name in
                                                  viewModel.updateName(name)
                                                  viewModel.proceedToNext()
                                              }, onSkip: {
                                                  viewModel.skip()
                                              }))
            
        case .goals:
            GoalsStepView(
                viewModel: MultiSelectionViewModel(
                    title: viewModel.currentStep.title,
                    options: GoalsOptions.allCases,
                    initialValues: viewModel.onboardingData.goals,
                    onContinue: { goals in
                        viewModel.updateGoals(goals)
                        viewModel.proceedToNext()
                    },
                    onSkip: {
                        viewModel.skip()
                    }
                )
            )
            
        case .topics:
            TopicsStepView(
                viewModel: MultiSelectionViewModel(
                    title: viewModel.currentStep.title,
                    options: TopicsOptions.allCases,
                    initialValues: viewModel.onboardingData.topics,
                    onContinue: { topics in
                        viewModel.updateTopics(topics)
                        viewModel.proceedToNext()
                    },
                    onSkip: {
                        viewModel.skip()
                    }
                )
            )
            .transition(.opacity)
            
        case .done:
            SuccessStepView(
                title: viewModel.currentStep.title,
                animationName: viewModel.currentStep.animationName!,
                onContinue: {
                    viewModel.proceedToNext()
                }
            )
        }
    }
}
