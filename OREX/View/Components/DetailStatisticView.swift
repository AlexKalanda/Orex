//
//  DetailStatisticView.swift
//  OREX
//
//  Created by admin on 30/10/2024.
//

import SwiftUI

struct DetailStatisticView: View {
    @State var statisticsVM: StatisticsViewModel
    var body: some View {
        ScrollView(.vertical) {
            ForEach(statisticsVM.cars,id: \.id) { car in
                RowDetailStatisticView(statisticsVM: statisticsVM, car: car)
            }
        }
    }
}

#Preview {
    DetailStatisticView(statisticsVM: .init(user: .init(id: "", name: "", email: "", phone: "")))
}


struct RowDetailStatisticView: View {
    @State var statisticsVM: StatisticsViewModel
    var car: Car
    var body: some View {
        HStack {
            if let url = URL(string: car.car.image) {
                CardImageView(url: url,width: 50,height: 50)
            }
            VStack {
                Text(DateHelper.shared.dateToString(car.date))
                    .frame(maxWidth: .infinity)
                    .fontWeight(.bold)
                Text("\(car.car.title) c гос. номером: \(car.car.stateNumber)")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
