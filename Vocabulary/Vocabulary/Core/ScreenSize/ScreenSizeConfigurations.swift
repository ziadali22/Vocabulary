//
//  ScreenSizeConfigurations.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 10/07/2025.
//

import SwiftUI
struct ScreenSizeConfiguration {
    static let isCompactHeight = UIScreen.main.bounds.height <= 667
    static let isCompactWidth = UIScreen.main.bounds.width <= 375
}
