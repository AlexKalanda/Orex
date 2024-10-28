//
//  CategotyCiew.swift
//  OREX
//
//  Created by admin on 14/10/2024.
//

import SwiftUI

struct CategotyView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: CategotyViewModel
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.vertical) {
                    ForEach(vm.cars, id: \.id) { car in
                        DetailCategoryCardView(car: car)
                            .containerRelativeFrame(.vertical,count: 1, spacing: 0)
                    }
                }
                .toolbar(.hidden)
                .scrollTargetLayout()
            }
            .background {
                LinearGradient(colors: [Color(light: .white, dark: .black), .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
            }
            .contentMargins(0, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
            .ignoresSafeArea()
            .overlay(alignment: .topLeading) {
                Button {
                    dismiss()
                } label: {
                    ButtonBack()
                        .padding(.leading)
                }
            }
        }
    }
}

#Preview {
    CategotyView(vm: .init(cars: []))
}
