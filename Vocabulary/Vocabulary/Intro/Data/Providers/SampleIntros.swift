//
//  IntroItem.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 05/07/2025.
//
import SwiftUI

final class IntroDataProvider: IntroDataProviding {
    let introItems: [IntroItem] = [
        .init(text: "Learn Smarter",
              textColor: Color(hex: "E3170A"),
              circleColor: Color(hex: "F7B32B"),
              backgroundColor: Color(hex: "FCF6B1")),
        
        .init(text: "Daily vocabulary",
              textColor: Color(hex: "FCF6B1"),
              circleColor: Color(hex:"FCF6B1"),
              backgroundColor: Color(hex: "2D1E2F")),
        
        .init(text: "10,000+ words",
              textColor: Color(hex: "2D1E2F"),
              circleColor: Color(hex: "2D1E2F"),
              backgroundColor: Color(hex: "E3170A")),
        
            .init(text: "Learn Smarter",
                  textColor: Color(hex: "E3170A"),
                  circleColor: Color(hex: "F7B32B"),
                  backgroundColor: Color(hex: "FCF6B1"))
    ]
}
