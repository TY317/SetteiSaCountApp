//
//  unitTablePercent.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/08.
//

import SwiftUI

struct unitTablePercent: View {
    var columTitle: String
    var percentList: [Double]
//    var columTitle: String = "チャイナ"
//    var percentList: [Double] = [
//        84.8,
//        84.0,
//        83.2,
//        80.5,
//        77.0,
//        76.2
//    ]
    var numberofDicimal: Int = 0
    var aboutBool: Bool = false
    var maxWidth: CGFloat = 150.0
    var titleLine: Int = 1
    var lineList: [Int] = [1,1,1,1,1,1]
    var titleFont: Font = .title3
    var contentFont: Font = .title3
    let valueHstackSpacing: CGFloat = 5
    let unitFont: Font = .footnote
    let verticlaPadding: CGFloat = 2.0
    let lineHeight: CGFloat = 24
    
    var body: some View {
        VStack(spacing: 0) {
            if self.columTitle != "" {
                Text(self.columTitle)
                    .frame(height: (self.lineHeight*CGFloat(self.titleLine)))
                    .frame(maxWidth: self.maxWidth)
                    .padding(.vertical, self.verticlaPadding)
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)
                    .background(Color.columnTitle)
                    .font(self.titleFont)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                            .stroke(Color.black, lineWidth: 1) // 黒色の線を追加
                    )
            } else {
                Text(" ")
                    .frame(height: (self.lineHeight*CGFloat(self.titleLine)))
                    .frame(maxWidth: self.maxWidth)
                    .padding(.vertical, self.verticlaPadding)
                    .foregroundStyle(Color.clear)
                    .fontWeight(.bold)
                    .background(Color.clear)
                    .font(self.titleFont)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                            .stroke(Color.clear, lineWidth: 1) // 黒色の線を追加
                    )
            }
            ForEach(self.percentList.indices, id: \.self) { index in
//                if index % 2 == 0 {
                    HStack(spacing:self.valueHstackSpacing) {
                        if self.percentList[index] > 0 {
                            if self.aboutBool {
                                Text("約")
                                    .foregroundStyle(Color.black)
                                    .font(self.unitFont)
                            }
                            Text("\(String(format: "%.\(self.numberofDicimal)f", self.percentList[index]))")
                                .fontWeight(.bold)
                                .font(self.contentFont)
                                .foregroundStyle(Color.black)
                            Text("%")
                                .foregroundStyle(Color.black)
                                .font(self.unitFont)
                        }
                        else if self.percentList[index] < 0 {
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
                    .padding(.vertical, self.verticlaPadding)
                    .background(backColor(ind: index))
                    .overlay(
                        RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                            .stroke(Color.black, lineWidth: 1) // 黒色の線を追加
                    )
//                } else {
//                    HStack(spacing:self.valueHstackSpacing) {
//                        if self.aboutBool {
//                            Text("約")
//                                .foregroundStyle(Color.black)
//                                .font(self.unitFont)
//                        }
//                        Text("\(String(format: "%.\(self.numberofDicimal)f", self.percentList[index]))")
//                            .fontWeight(.bold)
//                            .font(.title3)
//                            .foregroundStyle(Color.black)
//                        Text("%")
//                            .foregroundStyle(Color.black)
//                            .font(self.unitFont)
//                    }
//                    .frame(maxWidth: self.maxWidth)
//                    .padding(.vertical, self.verticlaPadding)
//                    .background(Color.white)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 0) // 四角の輪郭
//                            .stroke(Color.black, lineWidth: 1) // 黒色の線を追加
//                    )
//                }
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
//    unitTablePercent()
//}
