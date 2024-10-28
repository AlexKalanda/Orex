//
//  AuthViewModel.swift
//  OREX
//
//  Created by admin on 6/10/2024.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var userId: String? = nil
    //MARK: - VM метод регестрации
    func createAccount(login: String, password: String, confirm: String,name: String, phone: String) {
        guard password == confirm else { return }
        Task {
            let user = try await AuthService.shared.signUp(email: login, password: password,name: name,phone: phone)
            DispatchQueue.main.async {
                self.userId = user.uid
            }
        }
    }
    
    //MARK: - VM метод авторитизации 
    func authorization(login: String, password: String) {
        Task {
            let user = try await AuthService.shared.signIn(email: login, password: password)
            DispatchQueue.main.async {
                self.userId = user.id
            }
        }
    }
    
}
