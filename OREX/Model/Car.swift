//
//  Car.swift
//  OREX
//
//  Created by admin on 12/10/2024.
//

import Foundation
import FirebaseFirestore

class Car: Identifiable {
    let id: String
    let status: CarStatus
    let date: Date
    let car: CarModel
    let equipment: [CarModel.Equipment]
    init(id: String = UUID().uuidString, status: CarStatus, date: Date, car: CarModel, equipment: [CarModel.Equipment]) {
        self.id = id
        self.status = status
        self.date = date
        self.car = car
        self.equipment = equipment
    }
    enum CarStatus: String {
        case reservation = "Забронированно"
        case completed = "Выполнено"
        case cancel = "Отменено"
    }
}

extension Car {
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["status"] = status.rawValue
        repres["car"] = car.id
        repres["date"] = Timestamp(date: date)
//        repres["date"] = date.compactMap({ timestamp in
//            Timestamp(date: timestamp)
//        })
        repres["equipment"] = equipment.map({ item in
            item.rawValue
        })
        return repres
    }
}
