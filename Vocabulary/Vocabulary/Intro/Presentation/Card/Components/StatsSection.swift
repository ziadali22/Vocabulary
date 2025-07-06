//
//  StatsSection.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 05/07/2025.
//

import SwiftUI

struct StatsSection: View {
    var body: some View {
        HStack {
            StatColumn(title: "350 million", subtitle: "words learned")
            Spacer()
            RatingColumn()
            Spacer()
            StatColumn(title: "10 million", subtitle: "downloads")
        }
        .padding(.horizontal)
    }
}


