//
//  CategoryCardView.swift
//  OREX
//
//  Created by admin on 12/10/2024.
//

import SwiftUI

// MARK: -  View для категории техники
struct CategoryCardView: View {
    var category: CategoryCar
    
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            ZStack(alignment: .bottom) {
                ZStack(alignment: .bottom) {
                    if let url = URL(string: category.image) {
                        CardImageView(url: url, width: size.width, height: size.height)
                    }
                }
                VStack(alignment: .center) {
                    Text(category.title)
                        .lineLimit(2)
                        .foregroundStyle(Color(light: .black, dark: .white))
                        .font(.system(size: 10))
                }
                .padding(6)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color(light: .white, dark: .black).opacity(0.5))
                .clipShape(.buttonBorder)
                .padding(6)
            }
        }
        .frame(height: UIScreen.main.bounds.width * 0.3)
        .background(.clear)
        .padding(8)
    }
}

#Preview {
    CategoryCardView(category: .init(title: "kudfh", image: ""))
}
