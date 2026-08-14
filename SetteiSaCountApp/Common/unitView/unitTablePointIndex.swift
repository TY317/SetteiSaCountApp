//
//  unitTablePointIndex.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct unitTablePointIndex: View {
    var pointList: [Int]
    var maxWidth: CGFloat = 60.0
    var titleLine: Int = 1
    var lineList: [Int] = [1,1,1,1,1,1]
    var contentFont: Font = .body
    let unitFont: Font = .footnote
    let verticlaPadding: CGFloat = 2.0
    let horizontalPadding: CGFloat = 3.0
    let lineHeight: CGFloat = 29
    var body: some View {
        VStack(spacing: 0) {
            Text(" ")
                .frame(height: (self.lineHeight*CGFloat(self.titleLine)))
                .frame(maxWidth: self.maxWidth)
                .padding(.horizontal, self.horizontalPadding)
                .foregroundStyle(Color.clear)
                .fontWeight(.bold)
                .background(Color.clear)
                .font(.title3)
                .overlay(
                    RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                        .stroke(Color.clear, lineWidth: 1) // 黒色の線を追加
                )
            ForEach(self.pointList.indices, id: \.self) { index in
                    HStack(spacing: 1.0) {
                        Text("\(self.pointList[index])")
                            .fontWeight(.bold)
                            .font(self.contentFont)
                            .foregroundStyle(Color.black)
                            .minimumScaleFactor(0.7)
                        Text("pt")
                            .foregroundStyle(Color.black)
                            .font(self.unitFont)
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
        if ind % 2 == 0 {
            textBackColor = Color.tableBlue
        } else {
            textBackColor = Color.white
        }

        return textBackColor
    }
}

#Preview {
    unitTablePointIndex(
        pointList: [50,100,500,],
        maxWidth: 60,
    )
}
