//
//  HomeViewModel.swift
//  OREX
//
//  Created by admin on 6/10/2024.
//

import Foundation
import FirebaseCore
import SwiftUI

class HomeViewModel: ObservableObject {
    let currentUserID: String
    @Published var authorized: Bool = true
    @Published var user: UserModel?
    @Published var cars: [CarModel] = []
    @Published var imageData = Data()
    @Published var ava: Image?
    init(userId: String) {
        self.currentUserID = userId
        getUser()
        getCars()
        dowloadPP()
        dataInImage()
    }
    // MARK: - получение текущего пользователя из базы
    func getUser() {
        Task {
            let user = try await FirestoreService.shared.getUser(byId: currentUserID)
            DispatchQueue.main.async {
                self.user = user
            }
        }
    }
    // MARK: - VM метод получения модели техники из базы данных
    func getCars() {
        Task {
            let cars = try await FirestoreService.shared.getCars()
            DispatchQueue.main.async {
                self.cars = cars
            }
        }
    }
    //MARK: - VM метод выхода из аккаунта
    func quit() {
        let result = try! AuthService.shared.signOut()
        guard result == true else { return }
        authorized = false
    }
    // MARK: - метод бронирования для Usera (создание у него коллекции техники)
    
    func creareCar(status: Car.CarStatus, car: CarModel, date: [Date], equipment: [CarModel.Equipment]) {
        var carsArray: [Car] = []
        for dat in date {
            let car = Car(status: status, date: dat, car: car, equipment: equipment) // 
            carsArray.append(car)
        }
        Task {
            for car in carsArray {
                try await FirestoreService.shared.createCar(car, userId: user!.id, equipment: equipment) // 
            }
        }
    }
    // MARK: - бронирование техники
    func addDate(car: CarModel ,dates: [Date]) {
        Task {
            var timestamps: [Timestamp] = []
            
            for date in dates {
                timestamps.append(Timestamp(date: date))
            }
            
            for timestamp in timestamps {
                try await FirestoreService.shared.addNewDate(carModelID: car.id, timestamps: timestamp)
            }
        }
    }
    
    
    // MARK: -  Метод фильтрафии техники под категории
    func filterCategoty(_ category : String) -> [CarModel] {
        return cars.filter { $0.type.rawValue == category }
    }
    
    //MARK: - метод загрузки аватарки
    func dowloadPP() {
        Task {
           let data = try await StorageService.shared.dowlodPP(byUserId: currentUserID)
            DispatchQueue.main.async {
                self.imageData = data
                print("отработал \(data.debugDescription)")
            }
        }
    }
    //MARK: - метод преобразования Data в Image
    func dataInImage() {
        Task {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.ava = Image(uiImage: .init(data: self.imageData) ?? UIImage(systemName: "person.crop.circle")!)
            }
            
        }
    }
}


