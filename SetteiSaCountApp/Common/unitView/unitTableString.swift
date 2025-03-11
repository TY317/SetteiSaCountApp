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
    let valueHstackSpacing: CGFloat = 5
    let unitFont: Font = .footnote
    let verticlaPadding: CGFloat = 2.0
    
    var body: some View {
        VStack(spacing: 0) {
            if self.columTitle != "" {
                Text(self.columTitle)
                    .frame(maxWidth: self.maxWidth)
                    .padding(.vertical, self.verticlaPadding)
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)
                    .background(Color.columnTitle)
                    .font(.title3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                            .stroke(Color.black, lineWidth: 1) // 黒色の線を追加
                    )
            }
            ForEach(self.stringList.indices, id: \.self) { index in
                if index % 2 == 0 {
                    HStack(spacing:self.valueHstackSpacing) {
                        Text(self.stringList[index])
                            .fontWeight(.bold)
                            .font(.title3)
                            .foregroundStyle(Color.black)
                    }
                    .frame(maxWidth: self.maxWidth)
                    .padding(.vertical, self.verticlaPadding)
                    .background(Color.tableBlue)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                            .stroke(Color.black, lineWidth: 1) // 黒色の線を追加
                    )
                } else {
                    HStack(spacing:self.valueHstackSpacing) {
                        Text(self.stringList[index])
                            .fontWeight(.bold)
                            .font(.title3)
                            .foregroundStyle(Color.black)
                    }
                    .frame(maxWidth: self.maxWidth)
                    .padding(.vertical, self.verticlaPadding)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                            .stroke(Color.black, lineWidth: 1) // 黒色の線を追加
                    )
                }
            }
        }
    }
}

//#Preview {
//    unitTableString()
//}
