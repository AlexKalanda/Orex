//
//  CardImageView.swift
//  OREX
//
//  Created by admin on 11/10/2024.
//

import SwiftUI
// MARK: -  View для картинки
struct CardImageView: View {
    let url: URL
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.horizontal,4)
                    
            } placeholder: {
                ProgressView()
                    .frame(width: width, height: height)
            }
    }
}

#Preview {
    CardImageView(url: .init(string: "https://firebasestorage.googleapis.com/v0/b/orex-99f70.appspot.com/o/cukurov1.jpeg?alt=media&token=5de7a4e9-68e3-49fe-a333-ecf4825710f8")!, width: 300, height: 200)
}
