//
//  SideBarAction.swift
//  OREX
//
//  Created by admin on 9/10/2024.
//

import Foundation

enum SideBarEnum: String, CaseIterable {
    case profile =  "Профиль"
    case massages = "Сообщения"
    case map = "Карта"
    case statistics = "Статистика"
    
    var simbolImage: String {
        switch self {
        case .profile: "person.fill"
        case .massages: "envelope.fill"
        case .map: "map.fill"
        case .statistics: "chart.bar.fill"
        }
    }
}

enum Profiletitle: String, CaseIterable {
    case name =  "Имя"
    case numberPhone = "Номер телефона"
    case email = "Почта"
    case password = "Пароль"
   
}
