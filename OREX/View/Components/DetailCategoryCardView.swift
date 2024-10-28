//
//  DetailCategoryCardView.swift
//  OREX
//
//  Created by admin on 14/10/2024.
//

import SwiftUI
// MARK: -  View отдельной техники категории техники
struct DetailCategoryCardView: View {
    @StateObject var vm = DetailCategoryCardViewModel()
    var car: CarModel
    @State private var isShowDateSheet = false
    @State private var presentAlert = false
    var body: some View {
        VStack {
            if let url = URL(string: car.image) {
                CardImageView(url: url, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4)
            }
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(car.title)
                        .font(.headline)
                    Spacer()
                    Text("Гос. номер: **\(car.stateNumber)**")
                        .fontWeight(.light)
                }
                .padding(.horizontal,10)
            }
            VStack {
                ScrollView(.vertical) {
                    Text(car.description)
                        .font(.subheadline)
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.2)
            .padding(10)
            
            if car.equipment.isEmpty {
                
            } else {
                Text("Выбирете оборудование")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 10)
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(car.equipment, id: \.rawValue) { i in
                            Button {
                                withAnimation(.linear) {
                                    // сделать красиво во VM
                                    if vm.selectedEquipments.contains(i) {
                                        if let index = vm.selectedEquipments.firstIndex(of: i) {
                                            vm.selectedEquipments.remove(at: index)
                                        }
                                    } else {
                                        vm.selectedEquipments.append(i)
                                    }
                                }
                            } label: {
                                Text(i.rawValue)
                                    .tint(Color(light: .black, dark: .white))
                                    .padding(.horizontal)
                                    .background(vm.selectedEquipments.contains(i) ? Color(light: .white, dark: .black) : .clear)
                                    .opacity(0.6)
                                    .clipShape(.capsule)
                            }
                        }
                    }
                }
                .padding(.leading, 8)
            }
            Spacer()
            Button {
                if car.equipment.isEmpty {
                    withAnimation(.easeOut(duration: 0.2)) {
                        isShowDateSheet.toggle()
                    }
                } else if vm.selectedEquipments.isEmpty {
                    withAnimation(.easeOut(duration: 0.2)) {
                        presentAlert.toggle()
                    }
                } else {
                    withAnimation(.easeOut(duration: 0.2)) {
                        isShowDateSheet.toggle()
                    }
                }
                
            } label: {
                ButtonReserved()
            }
            .padding()
        }
        .blur(radius: isShowDateSheet ? 5 : 0)
        .blur(radius: presentAlert ? 5 : 0)
        //MARK: - кастомный Sheet
        .blurredSheet(.init(.ultraThinMaterial), show: $isShowDateSheet) {
            isShowDateSheet = false
        } content: {
            DateSheetView(vm: .init(car: car, equipments: vm.selectedEquipments))
                .presentationDetents([.fraction(0.7)])
                .presentationDragIndicator(.visible)
        }
        .alert(isPresented: $presentAlert) {
            Alert(title: Text("Ошибка"), message: Text("Выберите оборудование"), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    DetailCategoryCardView(car: .init(type: .backhoeLoader, title: "adfdwfw", image: "", stateNumber: "dewfwef", equipment: [.brush], description: "kjhljhgljhgljhvkjgvkjhgvkhjgckhjgckhgckhgc", free: true, dates: []))
}



