//
//  CategoryCar.swift
//  OREX
//
//  Created by admin on 12/10/2024.
//

import Foundation


class CategoryCar: Identifiable {
    var id: String
    var title: String
    var image: String
    
    init(id: String = UUID().uuidString, title: String, image: String) {
        self.id = id
        self.title = title
        self.image = image
    }
    static var all: [CategoryCar] = [
        .init(title: "Бульдозер", image: "https://firebasestorage.googleapis.com/v0/b/orex-99f70.appspot.com/o/b10.jpeg?alt=media&token=10cd00e6-e185-4682-92f1-39d05e683e73"),
        .init(title: "Экскаватор-погрузчик", image: "https://firebasestorage.googleapis.com/v0/b/orex-99f70.appspot.com/o/cukurova3.jpeg?alt=media&token=cea00e72-3a48-4634-957b-01bc7e7c4fd5"),
        .init(title: "Колесный экскаватор", image: "https://firebasestorage.googleapis.com/v0/b/orex-99f70.appspot.com/o/xcmgK.jpeg?alt=media&token=36a38c66-fc4b-4cda-83f1-4d1b32318cfb"),
        .init(title: "Гусеничный экскаватор", image: "https://firebasestorage.googleapis.com/v0/b/orex-99f70.appspot.com/o/xcmg1.jpeg?alt=media&token=7295137f-89d3-4404-a6c8-2058dac89443"),
        .init(title: "Манипулятор", image: "https://firebasestorage.googleapis.com/v0/b/orex-99f70.appspot.com/o/kmyKAMAZ.jpeg?alt=media&token=81d0fc3e-a7c2-40dc-ab13-4ba8b71a02d1"),
        .init(title: "Телескопический погрузчик", image: "https://firebasestorage.googleapis.com/v0/b/orex-99f70.appspot.com/o/STH.jpeg?alt=media&token=13e49146-cf2f-474e-8363-10c70030605d"),
        .init(title: "Мини-погрузчик", image: "https://firebasestorage.googleapis.com/v0/b/orex-99f70.appspot.com/o/bobcat1.jpeg?alt=media&token=c25d456f-48e5-4609-b30b-2ac5fbc40f62"),
        .init(title: "Вилочный погрузчик", image: "https://firebasestorage.googleapis.com/v0/b/orex-99f70.appspot.com/o/vil2.jpeg?alt=media&token=ae0d61d8-bdc9-4c86-b7f9-cbe97f5e9f2a"),
        .init(title: "Компрессор", image: "https://firebasestorage.googleapis.com/v0/b/orex-99f70.appspot.com/o/compressor1.jpeg?alt=media&token=321f5506-8681-467c-9bca-09f87a4c1649"),
        ]
}
