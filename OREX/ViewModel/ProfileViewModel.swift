//
//  SettingsViewModel.swift
//  OREX
//
//  Created by admin on 8/10/2024.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var user: UserModel
    
    init(user: UserModel) {
        self.user = user
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
    
}
