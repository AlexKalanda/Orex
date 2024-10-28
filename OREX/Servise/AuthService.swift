//
//  AuthService.swift
//  OREX
//
//  Created by admin on 6/10/2024.
//

import Foundation
import FirebaseAuth

class AuthService {
    static let shared = AuthService(); private init() { }
    private let auth = Auth.auth()
    //MARK: - сервисные методы
    var currentUser: User? { auth.currentUser }
    //MARK: - сервисный метод регестрации
    func signUp(email: String, password: String,name: String, phone: String) async throws -> User {
        let result = try await auth.createUser(withEmail: email, password: password)
        try await FirestoreService.shared.createUser(id: result.user.uid, email: result.user.email!, name: name, phone: phone)
        return result.user
    }
    //MARK: - сервисный метод авторитизации 
    func signIn(email: String, password: String) async throws -> UserModel {
        let result = try await auth.signIn(withEmail: email, password: password)
        let user = try await FirestoreService.shared.getUser(byId: result.user.uid)
        return user
    }
    //MARK: - сервисный метод выхода
    func signOut() throws -> Bool {
        try auth.signOut()
        return true
    }
    //MARK: - получение юзера аунтификации(модель Firebase)
    func getUser(byId id: String) async throws -> User {
        let user = currentUser!
        return user
    }
}
