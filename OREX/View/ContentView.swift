//
//  ContentView.swift
//  OREX
//
//  Created by admin on 6/10/2024.
//

import SwiftUI
import FirebaseCore

struct ContentView: View {
    @StateObject var vm = ContentViewModel()
    var body: some View {
        switch vm.appState {
            case .unauthorized:
            AuthView()
                .environmentObject(vm)
        case .authorized(let id):
            let vm = HomeViewModel(userId: id)
            NavigationView {
                HomeView(vm: vm)
                    .environmentObject(self.vm)
                //MARK: - для бронирования и создания коллекции в User
                    .environmentObject(vm)
            }
        }
    }
}

#Preview {
    ContentView()
}
