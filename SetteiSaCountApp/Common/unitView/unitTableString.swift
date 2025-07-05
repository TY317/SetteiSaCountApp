//
//  unitTableString.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/08.
//

import SwiftUI

struct unitTableString: View {
    var columTitle: String
    var stringList: [String]
    //    var columTitle: String = ""
    //    var stringList: [String] = [
    //        "設定1",
    //        "設定2",
    //        "設定3",
    //        "設定4",
    //        "設定5",
    //        "設定6"
    //    ]
    var numberofDicimal: Int = 0
    var maxWidth: CGFloat = 150.0
    var titleLine: Int = 1
    var lineList: [Int] = [1,1,1,1,1,1]
    var titleFont: Font = .title3
    var contentFont: Font = .title3
    var colorList: [Color]?
    var contentTextColorList: [Color]?
    let valueHstackSpacing: CGFloat = 5
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
                    .minimumScaleFactor(0.7)
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
            ForEach(self.stringList.indices, id: \.self) { index in
                HStack(spacing:self.valueHstackSpacing) {
//                    Text(self.stringList[index])
                    Text(contentString(ind: index))
                        .fontWeight(.bold)
//                        .font(.title3)
                        .font(self.contentFont)
//                        .foregroundStyle(Color.black)
                        .foregroundStyle(contentTextColor(ind: index))
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.7)
                }
                .frame(height: lineNumber(ind: index))
                .frame(maxWidth: self.maxWidth)
//                .padding(.vertical, self.verticlaPadding)
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
            if self.stringList[ind] == "grayOut" {
                textBackColor = Color.gray
            }
        }
        
        return textBackColor
    }
    
    private func contentString(ind: Int) -> String {
        var contentString: String = ""
        if self.stringList[ind] == "grayOut" {
            contentString = ""
        } else {
            contentString = self.stringList[ind]
        }
        
        return contentString
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

//#Preview {
//    unitTableString()
//}
