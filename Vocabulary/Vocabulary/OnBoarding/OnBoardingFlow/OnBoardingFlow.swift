//
//  OnBoardingFlow.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 06/07/2025.
//

import SwiftUI

protocol OnboardingOption: RawRepresentable, CaseIterable, Hashable where RawValue == String {}

enum Referral: String, OnboardingOption {
    case appStore = "App Store"
    case instagram = "Instagram"
    case tikTok = "TikTok"
    case friendFamily = "Friend/family"
    case webSearch = "Web search"
    case facebook = "Facebook"
}

enum AgeRange: String, OnboardingOption {
    case under18 = "Under 18"
    case from18to24 = "18-24"
    case from25to34 = "25-34"
    case from35to44 = "35-44"
    case over55 = "55+"
}

enum GenderOptions: String, OnboardingOption {
    case female = "Female"
    case male = "Male"
    case other = "Other"
    case preferNotToSay = "Prefer not to say"
}

struct OnboardingFlowView: View {
    enum Step: CaseIterable {
        case referral
        case age
        case gender
        case success
        case nameInput
        
        var title: String {
            switch self {
            case .referral:
                return "How did you hear about Vocabulary?"
            case .age:
                return "What is your age group?"
            case .gender:
                return "What is your gender?"
            case .success:
                return "Customize the app to improve your experience 🎉"
            case .nameInput:
                return "What do you want to be called?"
            }
        }
    }

    @State private var currentStep: Step = .referral
    @State private var selectedReferral: Referral?
    @State private var selectedAge: AgeRange?
    @State private var selectedGender: GenderOptions?
    @Binding var showWalkThrough: Bool

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ZStack {
                AppColors.background.ignoresSafeArea()
                
                switch currentStep {
                case .referral:
                    AnimatedOnboardingView<Referral>(
                        title: currentStep.title,
                        options: Referral.allCases,
                        selected: $selectedReferral
                    ) {
                        proceedToNext()
                    }
                    .transition(.opacity)
                    
                case .age:
                    AnimatedOnboardingView<AgeRange>(
                        title: currentStep.title,
                        options: AgeRange.allCases,
                        selected: $selectedAge
                    ) {
                        proceedToNext()
                    }
                    .transition(.opacity)
                    
                case .gender:
                    AnimatedOnboardingView<GenderOptions>(
                        title: currentStep.title,
                        options: GenderOptions.allCases,
                        selected: $selectedGender
                    ) {
                        proceedToNext()
                    }
                    .transition(.opacity)
                    
                case .success:
                    SuccessView(title: currentStep.title, onSelect: {
                        proceedToNext()
                    })
                        .transition(.opacity)
                    
                case .nameInput:
                    NameInputView(title: currentStep.title) { _ in
                        
                    } onSkip: {
                        
                    }

                }
            }
            .animation(.easeInOut(duration: 0.3), value: currentStep)
            .offset(y: showWalkThrough ? 0 : size.height)
            .animation(.easeInOut(duration: 0.5), value: showWalkThrough)
        }
    }
    
    private func proceedToNext() {
        withAnimation(.easeInOut(duration: 0.3)) {
            switch currentStep {
            case .referral:
                currentStep = .age
            case .age:
                currentStep = .gender
            case .gender:
                currentStep = .success
            case .success:
                currentStep = .nameInput
            case .nameInput:
                break
            }
        }
    }
}
