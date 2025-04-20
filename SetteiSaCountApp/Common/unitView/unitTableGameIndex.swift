//
//  unitTableGameIndex.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/12.
//

import SwiftUI

struct unitTableGameIndex: View {
    var gameList: [Int]
//    var gameList: [Int] = [50,100,150,200,250,350]
//    var numberofDicimal: Int = 0
    var maxWidth: CGFloat = 60.0
    var titleLine: Int = 1
    var lineList: [Int] = [1,1,1,1,1,1]
    var contentFont: Font = .title3
    let unitFont: Font = .footnote
    let verticlaPadding: CGFloat = 2.0
    let lineHeight: CGFloat = 29
    var body: some View {
        VStack(spacing: 0) {
            Text(" ")
                .frame(height: (self.lineHeight*CGFloat(self.titleLine)))
                .frame(maxWidth: self.maxWidth)
                .foregroundStyle(Color.clear)
                .fontWeight(.bold)
                .background(Color.clear)
                .font(.title3)
                .overlay(
                    RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                        .stroke(Color.clear, lineWidth: 1) // 黒色の線を追加
                )
            ForEach(self.gameList.indices, id: \.self) { index in
                    HStack(spacing: 1.0) {
                        Text("\(self.gameList[index])")
                            .fontWeight(.bold)
//                            .font(.title3)
                            .font(self.contentFont)
                            .foregroundStyle(Color.black)
                        Text("G")
                            .foregroundStyle(Color.black)
                            .font(self.unitFont)
                    }
                    .frame(height: lineNumber(ind: index))
                    .frame(maxWidth: self.maxWidth)
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
//    unitTableGameIndex()
//}
