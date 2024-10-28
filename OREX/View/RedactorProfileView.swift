//
//  RedactorProfileView.swift
//  OREX
//
//  Created by admin on 21/10/2024.
//

import SwiftUI

struct RedactorProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State var value: String
    @Binding var newValue: String
    var placeholder: String
    var navigationTitle: String
    var action: () -> ()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                LinearGradient(colors: [Color(light: .white, dark: .black), .orange], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea(.all)
                VStack {
                    TextField(placeholder, text: $value)
                        .customTFRedactor()
                    Button {
                        newValue = value
                        action()
                        dismiss()
                    } label: {
                        Text("Сохранить")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical)
                            .background(.orange)
                            .clipShape(.buttonBorder)
                            .padding(.horizontal, 8)
                    }
                }
                .navigationTitle(navigationTitle)
                .navigationBarTitleDisplayMode(.inline)
                Spacer()
            }
            .foregroundStyle(Color(light: .black, dark: .white))
            .frame(maxWidth: .infinity,maxHeight: .infinity)
        }
    }
}

#Preview {
    RedactorProfileView(value: "", newValue: .constant(""), placeholder: "", navigationTitle: "sdfds", action: {})
}
