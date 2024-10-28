//
//  SettingsView.swift
//  OREX
//
//  Created by admin on 8/10/2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var vm: ProfileViewModel
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                // MARK: - переход на изменение Имени
                NavigationLink {
                    RedactorProfileView(value: vm.user.name,
                                        newValue: $vm.user.name,
                                        placeholder: Profiletitle.name.rawValue,
                                        navigationTitle: Profiletitle.name.rawValue) {
                        vm.changeName(id: vm.user.id, newName: vm.user.name)
                    }
                } label: {
                    RowProfileView(title: Profiletitle.name.rawValue,
                                   data: $vm.user.name)
                }
                // MARK: - переход на изменение номера телефона
                NavigationLink {
                    RedactorProfileView(value: vm.user.phone,
                                        newValue: $vm.user.phone,
                                        placeholder: Profiletitle.numberPhone.rawValue,
                                        navigationTitle: Profiletitle.numberPhone.rawValue) {
                        vm.changeNumberPhone(id: vm.user.id, newPhone: vm.user.phone)
                    }
                } label: {
                    RowProfileView(title: Profiletitle.numberPhone.rawValue,
                                   data: $vm.user.phone)
                }
                // MARK: - переход на изменение Е-mail
                NavigationLink {
                    RedactorProfileView(value: vm.user.email,
                                        newValue: $vm.user.email,
                                        placeholder: Profiletitle.email.rawValue,
                                        navigationTitle: Profiletitle.email.rawValue) {
                        vm.changeEmail(id: vm.user.id, newEmail: vm.user.email)
                    }
                } label: {
                    RowProfileView(title: Profiletitle.email.rawValue,
                                   data: $vm.user.email)
                }
                // MARK: - переход на изменение Пароля
                NavigationLink {
                    RedactorProfilePasswordView(profileVM: vm)
                } label: {
                    RowProfileView(title: Profiletitle.password.rawValue,
                                   data: .constant("●●●●●●●●"))
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .navigationTitle(SideBarEnum.profile.rawValue)
            .navigationBarTitleDisplayMode(.inline)
            Spacer()
        }
        .background {
            LinearGradient(colors: [Color(light: .white, dark: .black), .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ProfileView(vm: .init(user: .init(id: "", name: "jhjvhhjv", email: "", phone: "")))
}
