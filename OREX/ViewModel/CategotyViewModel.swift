//
//  CategotyViewModel.swift
//  OREX
//
//  Created by admin on 14/10/2024.
//

import Foundation

class CategotyViewModel: ObservableObject {
    @Published var cars: [CarModel]

    init(cars: [CarModel]) {
        self.cars = cars
    }
}

