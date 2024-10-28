//
//  AuthView.swift
//  OREX
//
//  Created by admin on 6/10/2024.
//

import SwiftUI

struct AuthView: View {
    //MARK: - Свойства
    
    @StateObject var vm = AuthViewModel()
    @EnvironmentObject var contentVM: ContentViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirm: String = ""
    @State private var name: String = "No Name"
    @State private var phone: String = "No Phone"
    @State private var isAuth: Bool = true
    @State private var isSecurePassword: Bool = true
    @State private var isSecureConfirm: Bool = true
    
    //MARK: - Тело
    var body: some View {
        AdaptiveView { size, isLandscape in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ZStack {
                        VStack {
                            Text(isAuth ? "Авторизация" : "Регистрация")
                                .font(.title)
                                .foregroundStyle(.secondary)
                            TextField("", text: $email)
                                .customTFAuth()
                                .overlay(alignment: .leading) {
                                    Image(systemName: "envelope.fill")
                                        .customTFImage()
                                }
                            
                            if isSecurePassword {
                                
                                SecureField("", text: $password)
                                    .customTFAuth()
                                    .overlay(alignment: .leading) {
                                        Image(systemName: "lock.rectangle")
                                            .customTFImage()
                                    }
                                    .overlay(alignment: .trailing) {
                                        Image(systemName: isSecurePassword ? "eye.slash" : "eye")
                                            .customTFImageSecure()
                                    }
                                    .onTapGesture {
                                        isSecurePassword.toggle()
                                    }
                            } else {
                                
                                TextField("", text: $password)
                                    .customTFAuth()
                                    .overlay(alignment: .leading) {
                                        Image(systemName: "lock.rectangle")
                                            .customTFImage()
                                    }
                                    .overlay(alignment: .trailing) {
                                        Image(systemName: isSecurePassword ? "eye.slash" : "eye")
                                            .customTFImageSecure()
                                    }
                                    .onTapGesture {
                                        isSecurePassword.toggle()
                                    }
                            }
                            
                            if !isAuth {
                                if isSecureConfirm {
                                    SecureField("", text: $confirm)
                                        .customTFAuth()
                                        .overlay(alignment: .leading) {
                                            Image(systemName: "lock.rectangle")
                                                .customTFImage()
                                        }
                                        .overlay(alignment: .trailing) {
                                            Image(systemName: isSecureConfirm ? "eye.slash" : "eye")
                                                .customTFImageSecure()
                                        }
                                        .onTapGesture {
                                            isSecureConfirm.toggle()
                                            print("tap")
                                        }
                                } else {
                                    TextField("", text: $confirm)
                                        .customTFAuth()
                                        .overlay(alignment: .leading) {
                                            Image(systemName: "lock.rectangle")
                                                .customTFImage()
                                        }
                                        .overlay(alignment: .trailing) {
                                            Image(systemName: isSecureConfirm ? "eye.slash" : "eye")
                                                .customTFImageSecure()
                                        }
                                        .onTapGesture {
                                            isSecureConfirm.toggle()
                                            print("tap")
                                        }
                                }
                            }
                            Spacer()
                            VStack(spacing: 10) {
                                //MARK: - Кнопка осуществляет регестрацию или вход в ЛК
                                Button {
                                    switch isAuth {
                                    case true:
                                        vm.authorization(login: email, password: password)
                                    case false:
                                        vm.createAccount(login: email, password: password, confirm: confirm,name: name,phone: phone)
                                    }
                                } label: {
                                    Text(isAuth ? "Войти" : "Регистрация")
                                        .font(.footnote)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal)
                                        .background(.black)
                                        .clipShape(.buttonBorder)
                                }
                                Button {
                                    withAnimation {
                                        email = ""
                                        password = ""
                                        confirm = ""
                                        isAuth.toggle()
                                    }
                                } label: {
                                    Text(isAuth ? "Регистрация" : "Авторизация")
                                        .font(.footnote)
                                }
                                .tint(.secondary)
                                .padding(.bottom,10)
                            }
                        }
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .foregroundStyle(Color(light: .black, dark: .white))
                    }
                    .background(.orange)
                    .clipShape(.rect(cornerRadius: 10))
                    .frame(width: size.width * 0.7, height: size.height * 0.3)
                    .shadow(color: Color(light: .black, dark: .white), radius: 5)
                    Spacer()
                }
                Spacer()
            }
        }
        .background {
            LinearGradient(colors: [Color(light: .white, dark: .black), .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
        }
        //MARK: - Наблюдение какое View показывать
        .onChange(of: vm.userId) { oldValue, newValue in
            guard let newValue else {
                contentVM.appState = .unauthorized
                return
            }
            contentVM.appState = .authorized(id: newValue)
        }
    }
}

#Preview {
    ContentView ()
}

