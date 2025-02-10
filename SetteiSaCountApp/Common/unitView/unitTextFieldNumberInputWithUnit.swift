//
//  unitTextFieldNumberInputWithUnit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/08.
//

import SwiftUI

struct unitTextFieldNumberInputWithUnit: View {
    @State var title: String
    @Binding var inputValue: Int
    @State var numberPadTypeSelect: Bool = true
    var titleColor: Color = .primary
    var inputNumberColor: Color = .primary
    var unitText: String = "回"
    var unitTextColor: Color = .secondary
    var unitTextFont: Font = .footnote
    
    var body: some View {
        HStack {
            Text(self.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(self.titleColor)
            if self.numberPadTypeSelect {
                HStack {
                    TextField(self.title, value: self.$inputValue, format: .number)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(self.inputNumberColor)
                    Text(self.unitText)
                        .foregroundStyle(self.unitTextColor)
                        .font(self.unitTextFont)
                }
            } else {
                HStack {
                    TextField(self.title, value: self.$inputValue, format: .number)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(self.inputNumberColor)
                    Text(self.unitText)
                        .foregroundStyle(self.unitTextColor)
                        .font(self.unitTextFont)
                }
            }
        }
    }
}

//#Preview {
//    unitTextFieldNumberInputWithUnit()
//}
