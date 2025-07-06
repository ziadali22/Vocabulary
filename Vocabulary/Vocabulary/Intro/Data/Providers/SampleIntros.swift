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
              backgroundColor: Color(hex: "A9E5BB")),
        
        .init(text: "10,000+ words",
              textColor: Color(hex: "A9E5BB"),
              circleColor: Color(hex: "A9E5BB"),
              backgroundColor: Color(hex: "E3170A")),
        
            .init(text: "Learn Smarter",
                  textColor: Color(hex: "E3170A"),
                  circleColor: Color(hex: "F7B32B"),
                  backgroundColor: Color(hex: "FCF6B1"))
    ]
}
