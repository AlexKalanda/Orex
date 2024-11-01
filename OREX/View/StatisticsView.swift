//
//  StatisticsView.swift
//  OREX
//
//  Created by admin on 18/10/2024.
//

import SwiftUI

struct StatisticsView: View {
    @StateObject var vm : StatisticsViewModel
    
    var body: some View {
        NavigationStack {
            List(Car.CarStatus.allCases, id: \.self) { status in
                NavigationLink {
                    DetailStatisticView(statisticsVM: .init(user: vm.user, cars: vm.filterStatistics(status: status)))
                } label: {
                    Text(status.rawValue)
                }
                .badge(Text(vm.filterStatistics(status: status).count.description))
            }
            .navigationTitle(SideBarEnum.statistics.rawValue)
        }
    }
}

#Preview {
    StatisticsView(vm: .init(user: .init(id: "", name: "", email: "", phone: "")))
}
