//
//  FirestoreService.swift
//  OREX
//
//  Created by admin on 8/10/2024.
//

import Foundation
import FirebaseFirestore

final class FirestoreService {
    static let shared = FirestoreService(); private init() { }
    private let db = Firestore.firestore()
    private var users: CollectionReference { db.collection("users")}
    private var cars: CollectionReference { db.collection("cars")}
    
    // MARK: - сервисный метод создания пользователя в базе данных
    func createUser(id: String, email: String, name: String, phone: String) async throws {
        let user = UserModel(id: id, name: name, email: email, phone: phone )
        try await users.document(id).setData(user.representation)
    }
    
    // MARK: - сервисный метод получения пользовотеля по ID
    func getUser(byId id: String) async throws -> UserModel {
        let snapshot = try await users.document(id).getDocument()
        guard let data = snapshot.data() else { throw FirestoreErrorCode(.dataLoss) }
        guard let user = UserModel(data: data) else { throw FirestoreErrorCode(.invalidArgument) }
        return user
    }
    
    // MARK: - сервисный метод создания модели техники
    func createCarModel(_ carModel: CarModel) async throws {
        try await cars
            .document(carModel.id)
            .setData(carModel.representation)
    }
    
    // MARK: - метод отправки модели техники в базу данных
    private func carsParser() async throws {
        for car in CarModel.dataBase {
            try await createCarModel(car)
        }
    }
    
    // MARK: - метод получения техники из базы данных
    func getCars() async throws -> [CarModel] {
        let snaphot = try await cars.getDocuments()
        let docs = snaphot.documents
        let cars = docs.compactMap { snap in
            let car = CarModel(data: snap.data())
            return car
        }
        return cars
    }
    
    // MARK: - метод создания бронирования у User
    func createCar(_ car: Car, userId: String, equipment: [CarModel.Equipment]) async throws { //
        try await users
            .document(userId)
            .collection("cars")
            .document(car.id)
            .setData(car.representation)
    }
    
    // MARK: - добавление новой даты в массив дат объекта техники
    func addNewDate(carModelID: String, timestamps: Timestamp) async throws {
        try await cars.document(carModelID).updateData(["dates": FieldValue.arrayUnion([timestamps])])
    }
    
    
    
    
    //MARK: - сервисный метод смены имени пользователя
    func setUserName(id:String, name:String) async throws {
        try await users.document(id).setData(["name":name],merge:true)
    }
    //MARK: - сервисный метод смены номера телефона
    func setUserNumber(id:String, phone:String) async throws {
        try await users.document(id).setData(["phone":phone],merge:true)
    }
    //MARK: - сервисный метод смены E-mail в базе и в аунтификаторе
    func changeUserEmail(id:String, email:String) async throws {
        try await users.document(id).setData(["email":email],merge:true)
        let user = try await AuthService.shared.getUser(byId: id)
        if user.email != email {
            user.updateEmail(to: email) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    //MARK: - сервисный метод смены пароля в аунтификаторе
    func changeUserPassword(id:String,newPassword:String, confirmPassword:String) async throws {
        let user = try await AuthService.shared.getUser(byId: id)
        if newPassword != confirmPassword {
            print("пароли не совподают")
        } else {
            user.updatePassword(to: newPassword) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
