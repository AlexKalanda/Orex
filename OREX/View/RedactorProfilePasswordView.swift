//
//  RedactorProfilePasswordView.swift
//  OREX
//
//  Created by admin on 22/10/2024.
//

import SwiftUI

struct RedactorProfilePasswordView: View {
    @StateObject var profileVM: ProfileViewModel
    @Environment(\.dismiss) var dismiss
    @State var oldValue: String = ""
    @State var newValue: String = ""
    @State var confirm: String = ""
    @State var isPresentedAlert: Bool = false
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                LinearGradient(colors: [Color(light: .white, dark: .black), .orange], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea(.all)
                VStack {
                    SecureField("Новый пароль", text: $newValue)
                        .padding(12)
                        .background(.gray.opacity(0.1))
                        .clipShape(.buttonBorder)
                        .padding(.horizontal,8)
                    SecureField("Подтвердите новый пароль", text: $confirm)
                        .padding(12)
                        .background(.gray.opacity(0.1))
                        .clipShape(.buttonBorder)
                        .padding(.bottom, 40)
                        .padding(.horizontal,8)
                    Button {
                        //сделать ошибки и прописать все во VM
                        profileVM.changePassword(id: profileVM.user.id, newPassword: newValue, confirmPassword: confirm)
                        if newValue == confirm && newValue.count > 5 && confirm.count > 5 {
                            dismiss()
                        } else {
                            isPresentedAlert.toggle()
                        }
                        
                    } label: {
                        Text("Сохранить")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical)
                            .background(.orange)
                            .clipShape(.buttonBorder)
                            .padding(.horizontal, 8)
                    }
                }
                .navigationTitle("Пароль")
                .navigationBarTitleDisplayMode(.inline)
                Spacer()
            }
            .foregroundStyle(Color(light: .black, dark: .white))
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .alert(isPresented: $isPresentedAlert) {
                Alert(title: Text("Ошибка"), message: Text("Пароли не совпадают"), dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    RedactorProfilePasswordView(profileVM: .init(user: .init(id: "", name: "", email: "", phone: "")), oldValue: "", newValue: "", confirm: "")
}
