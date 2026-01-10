//
//  hokutTenseiHitstoryTable.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/10.
//

import SwiftUI

struct hokutTenseiHitstoryTable: View {
    var modeA: String = ""
    var modeB: String = ""
    var modeC: String = ""
    var modeHeaven: String = ""
    var body: some View {
        HStack(spacing: 0) {
            Text(self.modeA)
                .foregroundStyle(textColor(value: self.modeA))
//                .fontWeight(.bold)
                .frame(height: 25)
                .frame(maxWidth: .infinity)
                .background(backColor(value: self.modeA))
                .overlay(
                    RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                        .stroke(Color.gray, lineWidth: 1) // 黒色の線を追加
                )
            Text(self.modeB)
                .foregroundStyle(textColor(value: self.modeB))
//                .fontWeight(.bold)
                .frame(height: 25)
                .frame(maxWidth: .infinity)
                .background(backColor(value: self.modeB))
                .overlay(
                    RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                        .stroke(Color.gray, lineWidth: 1) // 黒色の線を追加
                )
            Text(self.modeC)
                .foregroundStyle(textColor(value: self.modeC))
//                .fontWeight(.bold)
                .frame(height: 25)
                .frame(maxWidth: .infinity)
                .background(backColor(value: self.modeC))
                .overlay(
                    RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                        .stroke(Color.gray, lineWidth: 1) // 黒色の線を追加
                )
            Text(self.modeHeaven)
                .foregroundStyle(textColor(value: self.modeHeaven))
//                .fontWeight(.bold)
                .frame(height: 25)
                .frame(maxWidth: .infinity)
                .background(backColor(value: self.modeHeaven))
                .overlay(
                    RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                        .stroke(Color.gray, lineWidth: 1) // 黒色の線を追加
                )
        }
        
    }
    
    private func backColor(value: String) -> Color {
        var textBackColor: Color = .clear
        if value == "" {
            textBackColor = .grayBack
        }
        return textBackColor
    }
    private func textColor(value: String) -> Color {
        var textColor: Color = .primary
        if value != "△" {
            textColor = .red
        }
        return textColor
    }
}

#Preview {
    List{
        ScrollView {
            HStack {
                Text("200")
                    .frame(maxWidth: .infinity, alignment: .center)
                hokutTenseiHitstoryTable(
                    modeA: "△",
                    modeB: "◯",
                    modeC: "◎",
                    modeHeaven: "天井"
                )
//                    .frame(maxWidth: .infinity, alignment: .center)
            }
            Divider()
        }
        .frame(height: 300)
    }
}
