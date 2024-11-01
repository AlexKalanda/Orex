//
//  HomeView.swift
//  OREX
//
//  Created by admin on 6/10/2024.
//

import SwiftUI
import PhotosUI

struct HomeView: View {
    //MARK: - главные свойства View
    @StateObject var vm: HomeViewModel
    @EnvironmentObject var contentVM: ContentViewModel
    //MARK: - Свойства жестов
    @State private var offset: CGFloat = 0
    @State private var lastDragOffset: CGFloat = 0
    @State private var progress: CGFloat = 0
    //MARK: - Сойства для View
    @State private var columns = [
        GridItem(.flexible(),spacing: 0),
        GridItem(.flexible(),spacing: 0)
    ]
    
    var body: some View {
        //MARK: - Адаптивное вью работает во всех оринтациях
        AdaptiveView { size, isLandscape in
            let sideBarWidth: CGFloat = 250
            let layout = isLandscape ? AnyLayout(HStackLayout(spacing: 0)) : AnyLayout(ZStackLayout(alignment: .leading))
            NavigationStack {
                layout {
                    SideBarView( homeVM: vm) {
                        withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                            progress = 0
                            offset = 0
                            lastDragOffset = 0
                        }
                    } actonExit: { vm.quit() }
                        .frame(width: sideBarWidth)
                        .offset(x: isLandscape ? 0 : -sideBarWidth)
                        .offset(x: isLandscape ? 0 : offset)
                    //MARK: - скрол главнрой ленты
                    ScrollView(.vertical,showsIndicators: false) {
                        LazyVGrid(columns: columns,spacing: 0) {
                            ForEach(CategoryCar.all, id: \.id) { categoryCar in
                                let viewModel = CategotyViewModel(cars: vm.filterCategoty(categoryCar.title))
                                NavigationLink {
                                    CategotyView(vm: viewModel)
                                } label: {
                                    CategoryCardView(category: categoryCar)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background {
                        LinearGradient(colors: [Color(light: .white, dark: .black), .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                            .ignoresSafeArea()
                    }
                    
                    .overlay {
                        Rectangle()
                            .fill(.black.opacity(0.25))
                            .ignoresSafeArea()
                            .opacity(isLandscape ? 0 : progress)
                    }
                    .offset(x: isLandscape ? 0 : offset)
                }
                //MARK: - Cдвиг мею жестом
                .gesture(
                    CustomGesture(isEnabled: !isLandscape) { gesture in
                        let state = gesture.state
                        let translation = gesture.translation(in: gesture.view).x + lastDragOffset
                        let velocity = gesture.velocity(in: gesture.view).x
                        
                        if state == .began || state == .changed {
                            offset = max(min(translation,sideBarWidth), 0)
                            progress = max(min(offset / sideBarWidth, 1), 0)
                        } else {
                            withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                                if (velocity + offset) > (sideBarWidth * 0.5) {
                                    offset = sideBarWidth
                                    progress = 1
                                } else {
                                    offset = 0
                                    progress = 0
                                }
                            }
                            lastDragOffset = offset
                        }
                    }
                )
                //MARK: - Отслеживает состояния авторитизации
                .onChange(of: vm.authorized) { oldValue, newValue in
                    if newValue == false {
                        withAnimation(.easeInOut) {
                            contentVM.appState = .unauthorized
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    HomeView(vm: .init(userId: "1"))
}
