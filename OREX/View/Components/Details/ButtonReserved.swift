//
//  ButtonReserved.swift
//  OREX
//
//  Created by admin on 14/10/2024.
//

import SwiftUI
// MARK: - Кнопка бронирования
struct ButtonReserved: View {
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "calendar")
                .tint(Color(light: .white, dark: .black))
            Text("Забронировать")
                .font(.headline)
                .tint(Color(light: .white, dark: .black))
        }
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(.orange)
        .clipShape(.capsule)
        .shadow(color: Color(light: .white, dark: .black), radius: 10)
        .overlay {
            Capsule()
                .stroke(Color(light: .white, dark: .black), lineWidth: 1)
        }
    }
}

#Preview {
    ButtonReserved()
}
