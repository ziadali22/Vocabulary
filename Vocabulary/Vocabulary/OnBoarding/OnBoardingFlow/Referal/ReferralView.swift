//
//  ReferralView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 05/07/2025.
//

import SwiftUI

enum ReferralSource: String, CaseIterable {
    case appStore = "App Store"
    case instagram = "Instagram"
    case tikTok = "TikTok"
    case friendFamily = "Friend/family"
    case webSearch = "Web search"
    case facebook = "Facebook"
}

struct ReferralView: View {
    @State private var selectedSource: ReferralSource?
    @Binding var showWalkThrough: Bool
    @Environment(Router.self) var router

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            ScrollView {
                VStack(spacing: 40) {
                    Text("How did you hear about Vocabulary?")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.top, 40)
                    
                    VStack(spacing: 12) {
                        ForEach(ReferralSource.allCases, id: \.self) { source in
                            SimpleOptionButton(
                                title: source.rawValue,
                                isSelected: selectedSource == source,
                                action: {
                                    selectedSource = source
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                        router.navigateToageAskingView()
                                    }
                                    
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .frame(maxWidth: .infinity, alignment: .top)
            }
            .background(Color(hex: "2A324B"))
            .offset(y: showWalkThrough ? 0 : size.height)
        }
    }
}


struct SimpleOptionButton: View {
    let title: String
    var isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.black)
                
                Spacer()
                
                Circle()
                    .fill(isSelected ? Color.orange : Color.clear)
                    .stroke(isSelected ? Color.white : Color.white, lineWidth: 1)
                    .frame(width: 24, height: 24)
                    .overlay {
                        if isSelected {
                            Image(systemName: "bookmark.circle.fill")
                                .foregroundStyle(.white)
                        }
                    }
                    .animation(.easeInOut(duration: 0.2), value: isSelected)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 18)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(hex: "F7C59F"))
                    .stroke(Color(.white), lineWidth: 1)
            )
            .shadow(color: .white,radius: 1)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
