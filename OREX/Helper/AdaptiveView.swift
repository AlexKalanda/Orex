//
//  AdaptiveView.swift
//  OREX
//
//  Created by admin on 9/10/2024.
//

import SwiftUI

struct AdaptiveView<Content: View>: View {
    @ViewBuilder var content: (CGSize, Bool) -> Content
    var body: some View {
        GeometryReader {
            let size = $0.size
            let isLandscape = size.width > size.height
            content(size, isLandscape)
        }
    }
}
