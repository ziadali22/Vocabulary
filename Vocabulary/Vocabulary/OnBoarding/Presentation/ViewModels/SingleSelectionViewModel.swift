//
//  SingleSelectionViewModel.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 08/07/2025.
//

import Foundation
import Combine

@MainActor
final class SingleSelectionViewModel<T: OnboardingOption>: ObservableObject {
    @Published var selectedOption: T?
    @Published private(set) var isProcessing = false
    
    let title: String
    let options: [T]
    
    private let onSelect: (T) -> Void
    
    init(
        title: String,
        options: [T],
        initialValue: T? = nil,
        onSelect: @escaping (T) -> Void
    ) {
        self.title = title
        self.options = options
        self.selectedOption = initialValue
        self.onSelect = onSelect
    }
    
    func selectOption(_ option: T) {
        selectedOption = option
        isProcessing = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.isProcessing = false
            self?.onSelect(option)
        }
    }
}
