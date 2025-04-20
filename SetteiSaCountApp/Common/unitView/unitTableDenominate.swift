//
//  unitTableDenominate.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/13.
//

import SwiftUI

struct unitTableDenominate: View {
    var columTitle: String //= "ぶどう"
    var denominateList: [Double] //= [6.29, 6.22, 6.15, 6.09, 6.02, 5.96]
    var numberofDicimal: Int = 0
    var aboutBool: Bool = false
    var maxWidth: CGFloat = 150.0
    var titleLine: Int = 1
    var lineList: [Int] = [1,1,1,1,1,1]
    var titleFont: Font = .title3
    var contentFont: Font = .title3
    let valueHstackSpacing: CGFloat = 3
    let unitFont: Font = .footnote
    let verticlaPadding: CGFloat = 2.0
    let lineHeight: CGFloat = 29  // ver270で25から29へ変更。代わりに垂直padding無くした
    
    var body: some View {
        VStack(spacing: 0) {
            if self.columTitle != "" {
                Text(self.columTitle)
                    .multilineTextAlignment(.center)
                    .frame(height: (self.lineHeight*CGFloat(self.titleLine)))
                    .frame(maxWidth: self.maxWidth)
//                    .padding(.vertical, self.verticlaPadding)
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)
                    .background(Color.columnTitle)
//                    .font(.title3)
                    .font(self.titleFont)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                            .stroke(Color.black, lineWidth: 1) // 黒色の線を追加
                    )
            } else {
                Text(" ")
                    .frame(height: (self.lineHeight*CGFloat(self.titleLine)))
                    .frame(maxWidth: self.maxWidth)
//                    .padding(.vertical, self.verticlaPadding)
                    .foregroundStyle(Color.clear)
                    .fontWeight(.bold)
                    .background(Color.clear)
//                    .font(.title3)
                    .font(self.titleFont)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                            .stroke(Color.clear, lineWidth: 1) // 黒色の線を追加
                    )
            }
            ForEach(self.denominateList.indices, id: \.self) { index in
                    HStack(spacing:self.valueHstackSpacing) {
                        if self.denominateList[index] > 0 {
                            if self.aboutBool {
                                Text("約")
                                    .foregroundStyle(Color.black)
                                    .font(self.unitFont)
                            }
                            Text("1/")
                                .foregroundStyle(Color.black)
                                .font(self.unitFont)
                            Text("\(String(format: "%.\(self.numberofDicimal)f", self.denominateList[index]))")
                                .fontWeight(.bold)
//                                .font(.title3)
                                .font(self.contentFont)
                                .foregroundStyle(Color.black)
                        }
                        // 0より小さい場合は？
                        else if self.denominateList[index] < 0 {
                            Text("?")
                                .fontWeight(.bold)
                                .font(self.contentFont)
                                .foregroundStyle(Color.black)
                        }
                        // 0の場合はー
                        else {
                            Text("-")
                                .fontWeight(.bold)
                                .font(self.contentFont)
                                .foregroundStyle(Color.black)
                        }
                    }
                    .frame(height: lineNumber(ind: index))
                    .frame(maxWidth: self.maxWidth)
//                    .padding(.vertical, self.verticlaPadding)
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
        if ind % 2 == 0 {
            textBackColor = Color.tableBlue
        } else {
            textBackColor = Color.white
        }
        
        return textBackColor
    }
}

//#Preview {
//    unitTableDenominate()
//}
