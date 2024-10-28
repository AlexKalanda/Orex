//
//  ButtomBack.swift
//  OREX
//
//  Created by admin on 14/10/2024.
//

import SwiftUI
// MARK: - Кастомная кнопка назад
struct ButtonBack: View {
    var body: some View {
        Image(systemName: "chevron.backward")
            .tint(.black)
            .padding()
            .background(.white.opacity(0.3))
            .clipShape(.circle)
        
    }
}

#Preview {
    ButtonBack()
}
