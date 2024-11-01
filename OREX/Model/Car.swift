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
    var status: CarStatus
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
    // MARK: - инициализатор для получения техники из базы данных
    init?(data: [String : Any]) {
        guard let id = data["id"] as? String,
              let statusRawValue = data["status"] as? String,
              let timestamp = data["date"] as? Timestamp,
              let _ = data["car"] as? String,
              let carTitle = data["carTitle"] as? String,
              let carImage = data["carImage"] as? String,
              let carType = data["carType"] as? String,
              let carStateNumber = data["carStateNumber"] as? String,
              let equipmentRawValue = data["equipment"] as? [String] else { return nil }
        guard let status = CarStatus(rawValue: statusRawValue) else { return nil }
        let date = timestamp.dateValue()
        let equipment = equipmentRawValue.compactMap { item in
            let equipment = CarModel.Equipment(rawValue: item)
            return equipment
        }
        let car: CarModel = .init(type: CarModel.CarType(rawValue: carType) ?? .backhoeLoader, title: carTitle, image: carImage, stateNumber: carStateNumber, equipment: [], description: "", free: false, dates: [])
        self.id = id
        self.status = status
        self.date = date
        self.car = car
        self.equipment = equipment
    }
    enum CarStatus: String, CaseIterable {
        case inWork = "В работе"
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
        repres["carTitle"] = car.title
        repres["carImage"] = car.image
        repres["carType"] = car.type.rawValue
        repres["carStateNumber"] = car.stateNumber
        return repres
    }
}
enum CarStatus: String {
    case reservation = "Забронированно"
    case completed = "Выполнено"
    case cancel = "Отменено"
    case inWork = "В работе"
}
