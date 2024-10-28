//
//  CustomCalendar.swift
//  OREX
//
//  Created by admin on 25/10/2024.
//

import SwiftUI

struct CustomCalendar: View {
    //MARK: - Cвойства кастомного календаря
    // текущая дата
    @State var date = Date.now
    // получение чисел месяца
    @State private var days: [Date] = []
    // текушее ТС для занятых чисел
    @State var car: CarModel
    // для показа числа(в кружечке)
    @Binding var selectedDate: [Date]
    // выбор мксяца
    @State private var selectedMonth = Date.now.monthInt
    // выбор года
    @State private var selectedYear = Date.now.yearInt
    // наименование ня недели
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekday
    // заполнение календаря числами
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        VStack {
            Picker("", selection: $selectedMonth) {
                ForEach(Date.fulMonthNames.indices, id: \.self) { index in
                    Text(Date.fulMonthNames[index]).tag(index + 1)
                }
            }
            .tint(.black)
            .buttonStyle(.borderedProminent)

            HStack {
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    Text(daysOfWeek[index])
                        .fontWeight(.black)
                        .foregroundStyle(index == 0 || index == 6 ? .red : .black)
                        .frame(maxWidth: .infinity)
                }
            }
            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self) { day in
                    if day.monthInt != date.monthInt {
                        Text("")
                    } else {
                        Button {
                            if selectedDate.first(where: { $0.startOfDay == day.startOfDay }) != nil {
                                selectedDate.removeAll(where: { $0.startOfDay == day.startOfDay })
                            } else {
                                selectedDate.append(day)
                            }
                        } label: {
                            if day > Date() || day.isToday {
                                Text(day.formatted(.dateTime.day()))
                                    .fontWeight(.bold)
                                    .foregroundStyle(car.dates.first(where: { $0.startOfDay == day.startOfDay }) != nil ? .red : .black)
                                    .frame(maxWidth: .infinity, minHeight: 40)
                                    .background {
                                        if selectedDate.first(where: { $0.startOfDay == day.startOfDay }) != nil {
                                            Circle()
                                                .foregroundStyle(.secondary.opacity(0.3))
                                        }
                                    }
                                    .overlay {
                                        if day.isToday {
                                            Circle().stroke(lineWidth: 2).fill(Color.red)
                                        }
                                    }
                            } else {
                                Text(day.formatted(.dateTime.day()))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, minHeight: 40)
                                    .tint(.secondary)
                            }
                        }
                        .disabled(day > Date() || day.isToday ? false : true)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            days = date.calendarDisplayDays
        }
        .onChange(of: date) {
            days = date.calendarDisplayDays
        }
        .onChange(of: selectedMonth) {
            updateDate()
        }
    }
    func updateDate() {
        date = Calendar.current.date(from: DateComponents(year: date.yearInt ,month: selectedMonth , day: 1))!
    }
}

#Preview {
    CustomCalendar(car: .init(type: .backhoeLoader, title: "", image: "", stateNumber: "", equipment: .init(), description: "", free: false, dates: []), selectedDate: .init(projectedValue: .constant([])))
}
