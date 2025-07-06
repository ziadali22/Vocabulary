//
//  RatingColumn.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 05/07/2025.
//

import SwiftUI

struct RatingColumn: View {
    var body: some View {
        VStack(spacing: 4) {
            Text("4.8")
                .font(.title2.bold())
                .foregroundStyle(.white)
            HStack(spacing: 2) {
                ForEach(0..<4, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                }
            }
        }
    }
}
