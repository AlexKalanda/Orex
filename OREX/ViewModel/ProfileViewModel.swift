//
//  SettingsViewModel.swift
//  OREX
//
//  Created by admin on 8/10/2024.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var user: UserModel
    @Published var imageData: Data?
    init(user: UserModel) {
        self.user = user
        dowloadPP()
    }
    // MARK: - изменение имени
    func changeName(id: String, newName: String) {
        Task {
            try await FirestoreService.shared.setUserName(id: id, name: newName)
        }
    }
    // MARK: - изменение номера телефона
    func changeNumberPhone(id: String, newPhone: String) {
        Task {
            try await FirestoreService.shared.setUserNumber(id: id, phone: newPhone)
        }
    }
    // MARK: - смена e-mail
    func changeEmail(id: String, newEmail: String) {
        Task {
            try await FirestoreService.shared.changeUserEmail(id: id, email: newEmail)
        }
    }
   // MARK: - смена пароля
    func changePassword(id: String, newPassword: String, confirmPassword: String) {
        Task {
            try await FirestoreService.shared.changeUserPassword(id: id, newPassword: newPassword, confirmPassword: confirmPassword)
        }
    }
    //MARK: - метод загрузки аватарки в базу данных 
    func uploadImage(data: Data) {
        Task {
            try await StorageService.shared.upload(data: data, for: user.id)
        }
    }
    //MARK: - метод загрузки аватарки
    func dowloadPP() {
        Task {
            let data = try await StorageService.shared.dowlodPP(byUserId: user.id)
            DispatchQueue.main.async {
                self.imageData = data
            }
        }
    }
}
