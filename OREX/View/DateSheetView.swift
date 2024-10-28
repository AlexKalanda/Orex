//
//  DateSheetView.swift
//  OREX
//
//  Created by admin on 17/10/2024.
//

import SwiftUI

struct DateSheetView: View {
    
    @StateObject var vm: DateSheetViewModel
    @EnvironmentObject var homeVM : HomeViewModel
    @Environment(\.dismiss) var dismiss
    @State private var presentAlert: Bool = false
    
    var body: some View {
        VStack(spacing: 4) {
            CustomCalendar(car: vm.car, selectedDate: $vm.selectDate)
            HStack {
                Button {
                    let setSet = vm.checkDate()
                    
                    if setSet.0.isEmpty {
                        homeVM.addDate(car: vm.car, dates: vm.selectDate)
                        homeVM.creareCar(status: .reservation, car: vm.car, date: vm.selectDate, equipment: vm.equipments)
                        vm.car.dates.append(contentsOf: vm.selectDate)
                        homeVM.getCars()
                        dismiss()
                    } else {
                        presentAlert.toggle()
                    }
                } label: {
                    Text("Подтвердить").bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.green)
                        .cornerRadius(20)
                }
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text("Отменить").bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.red)
                        .cornerRadius(20)
                }
            }
            .foregroundStyle(.black)
            .padding(.vertical)
        }
        .padding(.horizontal)
        .frame(maxHeight: .infinity,alignment: .top)
        .background(.clear)
        .alert(isPresented: $presentAlert) {
            Alert(title: Text("Ошибка"), message: Text(vm.textAlertHeader + vm.textAlertDate))
        }
    }
}


#Preview {
    DateSheetView(vm: .init(car: .init(type: .backhoeLoader, title: "", image: "", stateNumber: "", equipment: [], description: "", free: true, dates: []), equipments: []))
}
