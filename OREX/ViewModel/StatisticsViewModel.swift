//
//  StatisticsViewModel.swift
//  OREX
//
//  Created by admin on 29/10/2024.
//

import Foundation
import SwiftUI

class StatisticsViewModel: ObservableObject {
    @Published var user: UserModel
    @Published var cars: [Car] = []
    init(user: UserModel) {
        self.user = user
        getCars()
        print(cars)
    }
    init (user: UserModel,cars: [Car]) {
        self.user = user
        self.cars = cars
    }
    func getCars() {
        Task {
            let cars = try await FirestoreService.shared.getBookedCars(user.id)
            DispatchQueue.main.async {
                self.cars = cars
            }
        }
        
    }
    func filterStatistics(status: Car.CarStatus) -> [Car] {
        return cars.filter { $0.status == status }
    }
    
    func changeOfStatus()->[Car] {
        for car in cars {
            car.status = .completed
        }
        return cars
    }
    
}

