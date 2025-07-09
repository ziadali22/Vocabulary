//
//  PagingScrollingView.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 09/07/2025.
//

import SwiftUI

struct PagingScrollView<Item: Identifiable, Content: View>: View {
    let items: [Item]
    @Binding var currentIndex: Int
    let geometry: GeometryProxy
    let content: (Int, Item) -> Content
    
    @State private var scrollPosition: Int?
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                        content(index, item)
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height)
                            .id(index)
                    }
                }
            }
            .scrollTargetLayout()
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $scrollPosition)
            .onChange(of: scrollPosition) { _, newPosition in
                if let newPosition = newPosition {
                    currentIndex = newPosition
                }
            }
            .onChange(of: currentIndex) { _, newIndex in
                if scrollPosition != newIndex {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        proxy.scrollTo(newIndex, anchor: .top)
                    }
                }
            }
        }
    }
}
