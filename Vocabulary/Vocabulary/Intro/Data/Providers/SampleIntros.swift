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
              textColor: Color(hex: "000000"),
              circleColor: Color(hex: "000000"),
              backgroundColor: Color(hex: "FFEFD3")),
        
        .init(text: "Daily vocabulary",
              textColor: Color(hex: "FFEFD3"),
              circleColor: Color(hex:"FFEFD3"),
              backgroundColor: Color(hex: "294C60")),
        
        .init(text: "10,000+ words",
              textColor: Color(hex: "294C60"),
              circleColor: Color(hex: "294C60"),
              backgroundColor: Color(hex: "FFC49B")),
        
            .init(text: "Learn Smarter",
                  textColor: Color(hex: "000000"),
                  circleColor: Color(hex: "000000"),
                  backgroundColor: Color(hex: "FFEFD3")),
    ]
}
