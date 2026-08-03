//
//  unitTableZoneKitai.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/03.
//

import SwiftUI

struct unitTableZoneKitai: View {
    var columTitle: String
    var kitaiList: [Int]
    var numberofDicimal: Int = 0
    var maxWidth: CGFloat = 150.0
    var titleLine: Int = 1
    var lineList: [Int] = [1,1,1,1,1,1]
    var titleFont: Font = .body
    var contentFont: Font = .body
    var colorList: [Color]?
    var contentTextColorList: [Color]?
    let valueHstackSpacing: CGFloat = 5
    let unitFont: Font = .footnote
    let verticlaPadding: CGFloat = 2.0
    let horizontalPadding: CGFloat = 3.0
    let lineHeight: CGFloat = 29  // ver270で25から29へ変更。代わりに垂直padding無くした
    var textAlignment: TextAlignment = .center
    
    var body: some View {
        VStack(spacing: 0) {
            if self.columTitle != "" {
                Text(self.columTitle)
                    .multilineTextAlignment(.center)
                    .frame(height: (self.lineHeight*CGFloat(self.titleLine)))
                    .frame(maxWidth: self.maxWidth)
                    .padding(.horizontal, self.horizontalPadding)
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)
                    .background(Color.columnTitle)
                    .font(self.titleFont)
                    .minimumScaleFactor(0.7)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                            .stroke(Color.black, lineWidth: 1) // 黒色の線を追加
                    )
            } else {
                Text(" ")
                    .frame(height: (self.lineHeight*CGFloat(self.titleLine)))
                    .frame(maxWidth: self.maxWidth)
                    .padding(.horizontal, self.horizontalPadding)
                    .foregroundStyle(Color.clear)
                    .fontWeight(.bold)
                    .background(Color.clear)
                    .font(self.titleFont)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                            .stroke(Color.clear, lineWidth: 1) // 黒色の線を追加
                    )
            }
            ForEach(self.kitaiList.indices, id: \.self) { index in
                HStack(spacing:self.valueHstackSpacing) {
                    Text(contentMark(ind: index))
                        .fontWeight(.bold)
                        .font(self.contentFont)
                        .foregroundStyle(contentTextColor(ind: index))
                        .multilineTextAlignment(self.textAlignment)
                        .minimumScaleFactor(0.7)
                }
                .frame(height: lineNumber(ind: index))
                .frame(maxWidth: self.maxWidth)
                .padding(.horizontal, self.horizontalPadding)
                .background(backColor(ind: index))
                .overlay(
                    RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                        .stroke(Color.black, lineWidth: 1) // 黒色の線を追加
                )
            }
        }
    }
    private func lineNumber(ind: Int) -> CGFloat {
        var textLinenumber: CGFloat = 0
        if self.lineList.indices.contains(ind) {
            textLinenumber = self.lineHeight * CGFloat(self.lineList[ind])
        } else {
            textLinenumber = self.lineHeight
        }
        
        return textLinenumber
    }
    
    private func backColor(ind: Int) -> Color {
        var textBackColor: Color = .white
        if let colorList = colorList {
            if colorList.indices.contains(ind) {
                textBackColor = colorList[ind]
            } else {
                textBackColor = .white
            }
        } else {
            if ind % 2 == 0 {
                textBackColor = Color.tableBlue
            } else {
                textBackColor = Color.white
            }
            if self.kitaiList[ind] <= 0 {
                textBackColor = Color.gray
            }
        }
        
        return textBackColor
    }
    
    private func contentMark(ind: Int) -> String {
        switch self.kitaiList[ind] {
        case 0: return "-"
        case 1: return "△"
        case 2: return "◯"
        case 3: return "◎"
        case 10: return "天井"
        default: return ""
        }
    }
        
    private func contentTextColor(ind: Int) -> Color {
        var textColor: Color = .black
        if let colorList = contentTextColorList {
            if colorList.indices.contains(ind) {
                textColor = colorList[ind]
            } else {
                textColor = .black
            }
        } else {
            textColor = .black
        }
        
        return textColor
    }
}
#Preview {
    unitTableZoneKitai(
        columTitle: "test",
        kitaiList: [0,1,2,3,10,-1-1]
    )
}
