//
//  RowProfileView.swift
//  OREX
//
//  Created by admin on 21/10/2024.
//

import SwiftUI

struct RowProfileView: View {
    var title: String
    @Binding var data: String
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity,alignment: .leading)
            Text(data)
                .frame(maxWidth: .infinity,alignment: .leading)
                .foregroundStyle(Color(light: .black, dark: .white))
                .font(.callout)
        }
        .padding(.leading,8)
        .overlay {
            Rectangle()
                .foregroundStyle(.gray.opacity(0.1))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipShape(.buttonBorder)
        }
        .overlay(alignment: .trailing) {
            Image(systemName: "chevron.right")
                .padding(.trailing, 10)
        }

    }
}

#Preview {
    RowProfileView(title: "", data: .constant(""))
}
