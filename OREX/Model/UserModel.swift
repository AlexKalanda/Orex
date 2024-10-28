//
//  UserModel.swift
//  OREX
//
//  Created by admin on 6/10/2024.
//

import Foundation
import FirebaseFirestore

class UserModel: Identifiable {
    var id: String
    var name: String
    var email: String
    var phone: String
    var cars: [Car] = []
    
    init(id: String, name: String, email: String, phone: String, cars: [Car] = []) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.cars = cars
    }
    
    // MARK: - инициализатор для получения пользователя из базы данных
    init?(data: [String: Any]) {
        guard let id = data["id"] as? String,
              let name = data["name"] as? String,
              let phone = data["phone"] as? String,
              let email = data["email"] as? String else { return nil }
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
    }
}

extension UserModel {
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["name"] = name
        repres["email"] = email
        repres["phone"] = phone
        return repres
    }
}
