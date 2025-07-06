//
//  IntroViewModel.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 05/07/2025.
//

import SwiftUI
import Combine

struct IntroAnimationState {
    var circleOffset: CGFloat = 0
    var textOffset: CGFloat = 0
}

struct OnboardingConfiguration {
    let animationDuration: Double = 0.8
    let delayBetweenAnimations: UInt64 = 1_000_000_000
    let cycleDelay: UInt64 = 2_000_000_000
    let circleSize: CGFloat = 45
    let cornerRadius: CGFloat = 25
    let textPadding: CGFloat = 25
}


@MainActor
final class IntroViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var activeIntro: IntroItem?
    @Published var animationState = IntroAnimationState()
    
    // MARK: - Private Properties
    private let dataProvider: IntroDataProviding
    private let configuration: OnboardingConfiguration
    private var currentIndex: Int = 0
    private var animationTask: Task<Void, Never>?
    
    // MARK: - Initialization
    init(dataProvider: IntroDataProviding = IntroDataProvider(),
         configuration: OnboardingConfiguration = OnboardingConfiguration()) {
        self.dataProvider = dataProvider
        self.configuration = configuration
    }
    
    // MARK: - Public Methods
    func startIntroSequence() {
        guard activeIntro == nil else { return }
        activeIntro = dataProvider.introItems.first
        startAnimationLoop()
    }
    
    func stopAnimations() {
        animationTask?.cancel()
        animationTask = nil
    }
    
    func calculateTextWidth(for text: String) -> CGFloat {
        let font = UIFont.preferredFont(forTextStyle: .title2)
        let attributes = [NSAttributedString.Key.font: font]
        let size = NSString(string: text).size(withAttributes: attributes)
        return size.width + configuration.textPadding
    }
    
    // MARK: - Private Methods
    private func startAnimationLoop() {
        animationTask = Task {
            await performAnimationLoop()
        }
    }
    
    private func performAnimationLoop() async {
        while !Task.isCancelled {
            await animateToNextItem()
        }
    }
    
    private func animateToNextItem() async {
        let items = dataProvider.introItems
        guard items.indices.contains(currentIndex + 1) else {
            currentIndex = 0
            return
        }
        
        let currentItem = items[currentIndex]
        let nextItem = items[currentIndex + 1]
        
        // Update current item display
        activeIntro?.text = currentItem.text
        activeIntro?.textColor = currentItem.textColor
        
        // Calculate slide-out offset
        let textWidth = calculateTextWidth(for: currentItem.text)
        let offsetValue = -(textWidth + 20)
        
        // Step 1: Slide out animation
        withAnimation(.easeInOut(duration: configuration.animationDuration)) {
            animationState.textOffset = offsetValue
            animationState.circleOffset = offsetValue / 2
        }
        
        // Brief pause between animations
        try? await Task.sleep(nanoseconds: configuration.delayBetweenAnimations)
        
        // Step 2: Slide in with new content
        withAnimation(.easeInOut(duration: configuration.animationDuration)) {
            activeIntro?.text = nextItem.text
            activeIntro?.textColor = nextItem.textColor
            activeIntro?.circleColor = nextItem.circleColor
            activeIntro?.backgroundColor = nextItem.backgroundColor
            animationState.textOffset = 0
            animationState.circleOffset = 0
        }
        
        // Wait before next cycle
        try? await Task.sleep(nanoseconds: configuration.cycleDelay)
        currentIndex += 1
    }
}
