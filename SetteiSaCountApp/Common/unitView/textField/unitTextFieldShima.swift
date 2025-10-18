//
//  unitTextFieldShima.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/18.
//

import SwiftUI

func unitTextFieldShima(placeholder: String, value: Binding<String>) -> some View {
    TextField(placeholder, text: value)
        .keyboardType(.numberPad)
        .multilineTextAlignment(.center)
        .textFieldStyle(.roundedBorder)
        .frame(maxWidth: .infinity)
}
