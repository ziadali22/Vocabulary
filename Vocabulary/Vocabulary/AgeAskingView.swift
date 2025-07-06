//
//  AgeAskingView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 06/07/2025.
//

import SwiftUI

enum AgeGroup: String, CaseIterable {
    case teen = "13 to 17"
    case youngAdult = "18 to 24"
    case adult1 = "25 to 34"
    case adult2 = "35 to 44"
    case adult3 = "45 to 54"
    case senior = "55+"
}

struct AgeAskingView: View {
    @State private var selectedSource: AgeGroup?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                onBoardingHeaderQuestionView(title: "How Old Are You?")
                
                OnBoardingOptionsView()

            }
            .frame(maxWidth: .infinity, alignment: .top)
        }
        .background(Color(hex: "2A324B"))
        .navigationBarHidden(true)
    }
}

#Preview {
    AgeAskingView()
        .router()
}

struct onBoardingHeaderQuestionView: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.title2.bold())
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 20)
            .padding(.top, 40)
    }
}

struct OnBoardingOptionsView: View {
    @State private var selectedSource: AgeGroup?
    @Environment(Router.self) var router
    
    var body: some View {
        Group {
            VStack(spacing: 16) {
                ForEach(AgeGroup.allCases, id: \.self) { source in
                    SimpleOptionButton(title: source.rawValue,
                                       isSelected: selectedSource == source) {
                        selectedSource = source
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                            router.navigateToGenderView()
                        }
                        
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
}
