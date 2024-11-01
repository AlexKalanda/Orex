//
//  SideBarView.swift
//  OREX
//
//  Created by admin on 9/10/2024.
//

import SwiftUI

struct SideBarView: View {
    //MARK: - View для бокового меню
    @StateObject var homeVM: HomeViewModel
    // MARK: - для возврата бокового меню
    var toggleSideBar: () -> ()
    // MARK: - для выхода из аккаунта
    var actonExit: () -> ()
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 6) {
                ZStack {
                    Circle()
                        .frame(width: 62, height: 62)
                        .foregroundStyle(.black)
                    homeVM.ava?
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(.circle)
                }
                Text(homeVM.user?.name ?? "")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(light: .black, dark: .black))
                
                Text(homeVM.user?.email ?? "")
                    .font(.caption2)
                    .foregroundStyle(Color(light: .black, dark: .black)).opacity(0.6)
                VStack(alignment: .leading, spacing: 25) {
                    
                    NavigationLink {
                        ProfileView(vm: .init(user: homeVM.user!), homeVM: homeVM)
                    } label: {
                        SideBarButton(titile: SideBarEnum.profile.rawValue , icon: SideBarEnum.profile.simbolImage)
                    }
                    NavigationLink {
                        //
                    } label: {
                        SideBarButton(titile: SideBarEnum.massages.rawValue , icon: SideBarEnum.massages.simbolImage)
                    }
                    NavigationLink {
                        //
                    } label: {
                        SideBarButton(titile: SideBarEnum.map.rawValue , icon: SideBarEnum.map.simbolImage)
                    }
                    NavigationLink {
                        StatisticsView(vm: .init(user: homeVM.user!))
                    } label: {
                        SideBarButton(titile: SideBarEnum.statistics.rawValue , icon: SideBarEnum.statistics.simbolImage)
                    }
                    // MARK: -  кнопка выхода
                    Button(action: actonExit, label: {
                        HStack(spacing: 12) {
                            Image(systemName: "rectangle.portrait.and.arrow.forward.fill")
                                .font(.title3)
                                .frame(width: 30)
                            Text("Выход")
                                .fontWeight(.semibold)
                        }
                        .foregroundStyle(Color(light: .white, dark: .black))
                        .contentShape(.rect)
                    })
                }
                .padding(.top, 25)
            }
            .padding(15)
        }
        .scrollClipDisabled()
        .scrollIndicators(.hidden)
        .background {
            Rectangle()
                .fill(.orange)
                .overlay(alignment: .trailing) {
                    Rectangle()
                        .fill(.black)
                        .frame(width: 1)
                }
                .ignoresSafeArea()
        }
        .onAppear {
            Task {
                if !homeVM.imageData.isEmpty {
                    homeVM.ava = Image(uiImage: .init(data: homeVM.imageData)!)
                }
            }
        }
    }
}

#Preview {
    SideBarView(homeVM: .init(userId: ""),  toggleSideBar: {}, actonExit: {})
}
