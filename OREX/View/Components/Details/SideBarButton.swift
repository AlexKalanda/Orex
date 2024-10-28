//
//  SideBarButton.swift
//  OREX
//
//  Created by admin on 21/10/2024.
//

import SwiftUI

// MARK: -  Кнопки раздела меню
struct SideBarButton: View {
    var titile: String
    var icon: String
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .frame(width: 30)
            Text(titile)
                .fontWeight(.semibold)
            Spacer()
        }
        .foregroundStyle(Color(light: .white, dark: .black))
        .padding(.vertical, 10)
        .contentShape(.rect)
    }
}

#Preview {
    SideBarButton(titile: "", icon: "")
}
