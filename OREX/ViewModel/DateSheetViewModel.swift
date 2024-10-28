//
//  DateSheetViewModel.swift
//  OREX
//
//  Created by admin on 17/10/2024.
//

import Foundation


class DateSheetViewModel: ObservableObject {
    
    @Published var car: CarModel
    @Published var equipments: [CarModel.Equipment]
    @Published var selectDate = [Date]()
    @Published var textAlertHeader: String = "Уже есть резервация на эти даты: \n"
    var textAlertDate: String {
        let setSet = checkDate()
        let res = DateHelper.shared.dateArrayToString(Array(setSet.0))
        return res.str
    }
    var carDate: [Date] {
        return car.dates
    }
  
    init(car: CarModel, equipments: [CarModel.Equipment]) {
        self.car = car
        self.equipments = equipments
    }
    // MARK: - метод провеки дат для бронирования 
    func checkDate() -> (Set<Date>,Set<Date>) {
        let setOme = Set(car.dates)
        let setTwo = Set(selectDate)
        let intersection = setOme.intersection(setTwo) // общие
        let sym = setOme.symmetricDifference(setTwo) // разные
        return (intersection,sym)
    }

}

