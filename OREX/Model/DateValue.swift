//
//  DateValue.swift
//  OREX
//
//  Created by admin on 24/10/2024.
//

import Foundation

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
