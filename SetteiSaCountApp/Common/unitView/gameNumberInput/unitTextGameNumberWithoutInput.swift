//
//  unitTextGameNumberWithoutInput.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/30.
//

import SwiftUI

struct unitTextGameNumberWithoutInput: View {
    var titleText:String = "プレイ数"
    var gameNumber: Int
    var numberTextColor: Color = .secondary
    var numberOffsetX: CGFloat = 5
    var titleFont: Font = .body
    var unitText: String = "Ｇ"
    var unitTextColor: Color = .secondary
    var unitTextFont: Font = .footnote
    
    var body: some View {
        HStack {
            Text(self.titleText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(self.titleFont)
                .minimumScaleFactor(0.7)
            Text("\(self.gameNumber)")
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundStyle(self.numberTextColor)
                .offset(x: self.numberOffsetX)
            Text(self.unitText)
                .foregroundStyle(self.unitTextColor)
                .font(self.unitTextFont)
        }
    }
}

#Preview {
    @Previewable var number: Int = 100
    List {
        unitTextGameNumberWithoutInput(
            gameNumber: number
        )
    }
}
