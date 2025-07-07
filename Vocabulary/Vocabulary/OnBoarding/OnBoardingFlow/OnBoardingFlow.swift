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

enum GoalsOptions: String, OnboardingOption {
    case enjoy = "Enjoy learning new words"
    case improve = "Improve my job prospects"
    case getReady = "Get ready for a test"
    case enhance = "Enhance my lexicon"
    case other = "Other"
}

enum TopicsOptions: String, OnboardingOption {
    case emotions = "Emotions"
    case socity = "Socity"
    case human = "Human body"
    case foreign = "Words in foreign languages"
    case business = "Business"
}

struct OnboardingFlowView: View {
    enum Step: CaseIterable {
        case referral
        case age
        case gender
        case success
        case nameInput
        case goals
        case topics
        case done
        
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
            case .goals:
                return "Do you have a specific goal in mind?"
            case .topics:
                return "Which topics are you interested in?"
            case .done:
                return "Ready to Unlock New Words?"
            }
        }
    }
    
    @State private var currentStep: Step = .referral
    @State private var selectedReferral: Referral?
    @State private var selectedAge: AgeRange?
    @State private var selectedGender: GenderOptions?
    @State private var selectedGoals: Set<String> = []
    @State private var selectedTopics: Set<String> = []
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
                    SuccessView(title: currentStep.title, animationName: "learn.json", onSelect: {
                        proceedToNext()
                    })
                    .transition(.opacity)
                    
                case .nameInput:
                    NameInputView(title: currentStep.title) {
                        proceedToNext()
                    } onSkip: {
                        
                    }
                    
                case .goals:
                    MultiSelectionView(
                        title: currentStep.title,
                        options: GoalsOptions.allCases.map(\.rawValue),
                        selectedOptions: $selectedGoals,
                        onContinue: {
                            proceedToNext()
                        },
                        onSkip: {
                            proceedToNext()
                        }
                    )
                    .transition(.opacity)
                    
                case .topics:
                    MultiSelectionView(title: currentStep.title,
                                       options: TopicsOptions.allCases.map(\.rawValue),
                                       selectedOptions: $selectedTopics,
                                       onContinue: {proceedToNext()},
                                       onSkip: {})
                case .done:
                    SuccessView(title: currentStep.title, animationName: "learn2.json", onSelect: {
                        proceedToNext()
                    })
                    .transition(.opacity)
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
                currentStep = .goals
            case .goals:
                currentStep = .topics
            case .topics:
                currentStep = .done
            case .done:
                break
            }
        }
    }
}
