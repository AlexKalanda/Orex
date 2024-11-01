//
//  SettingsView.swift
//  OREX
//
//  Created by admin on 8/10/2024.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject var vm: ProfileViewModel
    @StateObject var homeVM: HomeViewModel
    @State private var ppItem: PhotosPickerItem?
    @State private var ppImage = Image(systemName: "circle.fill")
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
            .tint(Color(light: .black, dark: .white))
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .navigationTitle(SideBarEnum.profile.rawValue)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                PhotosPicker(selection: $ppItem, matching: .images) {
                    ZStack {
                        Circle()
                            .frame(width: 42, height: 42)
                            .foregroundStyle(.white)
                        ppImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .tint(.gray)
                            .clipShape(Circle())
                        Image(systemName: "camera")
                            .frame(width: 5, height: 5)
                            .foregroundColor(.white)
                            .opacity(0.5)
                    }
                }
            }
            Spacer()
        }
        .background {
            LinearGradient(colors: [Color(light: .white, dark: .black), .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
        }
        //MARK: - Отслеживает фото для его отбражения при выборе
        .onChange(of: vm.imageData) {
            if let imageData = vm.imageData,
               let uiImage = UIImage(data: imageData) {
                self.ppImage = Image(uiImage: uiImage)
                vm.imageData = imageData
                homeVM.imageData = imageData
                
            }
        }
        //MARK: - Отслеживает фото для его отправки в базу
        .onChange(of: ppItem) {
            Task {
                if let loadedImage = try? await
                    ppItem?.loadTransferable(type: Data.self) {
                    vm.imageData = loadedImage
                    if let uiImage = UIImage(data: vm.imageData!) {
                        let image = Image(uiImage: uiImage)
                        self.ppImage = image
                        vm.uploadImage(data: loadedImage)
                        homeVM.imageData = loadedImage
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView(vm: .init(user: .init(id: "", name: "jhjvhhjv", email: "", phone: "")), homeVM: .init(userId: ""))
}
