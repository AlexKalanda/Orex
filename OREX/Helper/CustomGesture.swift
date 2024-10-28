//
//  CustomGesture.swift
//  OREX
//
//  Created by admin on 9/10/2024.
//

import SwiftUI

struct CustomGesture: UIGestureRecognizerRepresentable {
    var isEnabled: Bool
    var hundle: (UIPanGestureRecognizer) -> ()
    func makeUIGestureRecognizer(context: Context) -> UIPanGestureRecognizer {
        let gesture = UIPanGestureRecognizer()
        return gesture
    }
    func updateUIGestureRecognizer(_ recognizer: UIPanGestureRecognizer, context: Context) {
        recognizer.isEnabled = isEnabled
    }
    func handleUIGestureRecognizerAction(_ recognizer: UIPanGestureRecognizer, context: Context) {
        hundle(recognizer)
    }
}
