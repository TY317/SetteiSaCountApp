//
//  unitTableSettingIndex.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/08.
//

import SwiftUI

struct unitTableSettingIndex: View {
    var settingList: [Int] = [1,2,3,4,5,6]
    var numberofDicimal: Int = 0
    var maxWidth: CGFloat = 55.0
    var titleLine: Int = 1
    var lineList: [Int] = [1,1,1,1,1,1]
    let unitFont: Font = .footnote
    let verticlaPadding: CGFloat = 2.0
    let lineHeight: CGFloat = 29  // ver270で25から29へ変更。代わりに垂直padding無くした
    
    var body: some View {
        VStack(spacing: 0) {
            //            Spacer()
            Text(" ")
                .frame(height: (self.lineHeight*CGFloat(self.titleLine)))
                .frame(maxWidth: self.maxWidth)
//                .padding(.vertical, self.verticlaPadding)
                .foregroundStyle(Color.clear)
                .fontWeight(.bold)
                .background(Color.clear)
                .font(.title3)
                .overlay(
                    RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                        .stroke(Color.clear, lineWidth: 1) // 黒色の線を追加
                )
            ForEach(self.settingList.indices, id: \.self) { index in
//                if index % 2 == 0 {
                    HStack(spacing: 2.0) {
                        Text("設定")
                            .foregroundStyle(Color.black)
                            .font(.footnote)
                        Text("\(self.settingList[index])")
                            .fontWeight(.bold)
                            .font(.title3)
                            .foregroundStyle(Color.black)
                    }
                    .frame(height: lineNumber(ind: index))
                    .frame(maxWidth: self.maxWidth)
//                    .padding(.vertical, self.verticlaPadding)
                    .background(backColor(ind: index))
                    .overlay(
                        RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                            .stroke(Color.black, lineWidth: 1) // 黒色の線を追加
                    )
//                } else {
//                    HStack(spacing: 2.0) {
//                        Text("設定")
//                            .foregroundStyle(Color.black)
//                            .font(.footnote)
//                        Text("\(self.settingList[index])")
//                            .fontWeight(.bold)
//                            .font(.title3)
//                            .foregroundStyle(Color.black)
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

#Preview {
    unitTableSettingIndex()
}
