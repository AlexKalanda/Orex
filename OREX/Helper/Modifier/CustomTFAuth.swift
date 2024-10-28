//
//  CustomTFAuth.swift
//  OREX
//
//  Created by admin on 10/10/2024.
//

import SwiftUI

struct CustomTFAuth: ViewModifier {
    func body(content: Content) -> some View {
            content
            .frame(height: 20)
                .foregroundStyle(Color(light: .black, dark: .black))
                .padding(.horizontal)
                .padding(.leading, 8)
                .font(.footnote)
                .background(Color(light: .white, dark: .white))
                .clipShape(.buttonBorder)
                .padding(.horizontal)
    }
}

struct CustomTFImage: ViewModifier {
    func body(content: Content) -> some View {
            content
            .font(.footnote)
            .foregroundStyle(.black)
            .padding(.leading)
    }
}

struct CustomTFImageSecure: ViewModifier {
    func body(content: Content) -> some View {
            content
            .font(.footnote)
            .foregroundStyle(.black)
            .padding(.trailing)
    }
}

extension View {
    public func customTFAuth() -> some View {
        self.modifier(CustomTFAuth())
    }
    public func customTFImage() -> some View {
        self.modifier(CustomTFImage())
    }
    public func customTFImageSecure() -> some View {
        self.modifier(CustomTFImageSecure())
    }
    public func customTFRedactor() -> some View {
        self.modifier(CustomTFRedactor())
    }
}

extension Color {
    init(light: UIColor, dark: UIColor) {
        self.init(UIColor(dynamicProvider: { traits in
            switch traits.userInterfaceStyle {
            case .light, .unspecified: return light
            case .dark: return dark
            default:
                assertionFailure("Unknown userInterfaceStyle: \(traits.userInterfaceStyle)")
                return light
            }
        }))
    }
}

extension View {
    func blurredSheet<Content: View>(_ style: AnyShapeStyle, show: Binding<Bool>, onDismiss: @escaping () -> (), @ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .sheet(isPresented: show, onDismiss: onDismiss) {
                content()
                    .background(RemovebackgroundColor())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background {
                        Rectangle()
                            .fill(style)
                            .ignoresSafeArea(.container, edges: .all)
                    }
            }
    }
}


fileprivate struct RemovebackgroundColor: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            uiView.superview?.superview?.backgroundColor = .clear
        }
    }
}


struct CustomTFRedactor: ViewModifier {
    func body(content: Content) -> some View {
            content
            .padding(12)
            .background(.gray.opacity(0.1))
            .clipShape(.buttonBorder)
            .padding(.top, 20)
            .padding(.bottom, 40)
            .padding(.horizontal,8)
    }
}
