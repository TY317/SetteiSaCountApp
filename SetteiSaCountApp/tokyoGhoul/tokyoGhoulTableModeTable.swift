//
//  tokyoGhoulTableModeTable.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/12.
//

import SwiftUI

struct tokyoGhoulTableModeTable: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableGameIndex(
                gameList: [50,100,150,200,250,300,400,500,600],
                titleLine: 2,
                contentFont: .body
            )
            unitTableString(
                columTitle: "通常\nA",
                stringList: [
                    "-",
                    "-",
                    "-",
                    "◯",
                    "-",
                    "◯",
                    "-",
                    "-",
                    "天井"
                ],
                titleLine: 2,
                titleFont: .body
            )
            unitTableString(
                columTitle: "通常\nB",
                stringList: [
                    "-",
                    "◯",
                    "-",
                    "-",
                    "-",
                    "-",
                    "-",
                    "◎",
                    "天井"
                ],
                titleLine: 2,
                titleFont: .body
            )
            unitTableString(
                columTitle: "通常\nC",
                stringList: [
                    "-",
                    "◯",
                    "-",
                    "◯",
                    "-",
                    "◯",
                    "◯",
                    "天井",
                    "grayOut"
                ],
                titleLine: 2,
                titleFont: .body
            )
            unitTableString(
                columTitle: "ﾁｬﾝｽ",
                stringList: [
                    "△",
                    "◯",
                    "△",
                    "◯",
                    "△",
                    "◎",
                    "-",
                    "-",
                    "天井"
                ],
                titleLine: 2,
                titleFont: .body
            )
            unitTableString(
                columTitle: "天国\n準備",
                stringList: [
                    "△",
                    "◯",
                    "◯",
                    "◎",
                    "-",
                    "天井",
                    "grayOut",
                    "grayOut",
                    "grayOut"
                ],
                titleLine: 2,
                titleFont: .body
            )
            unitTableString(
                columTitle: "天国",
                stringList: [
                    "◯",
                    "天井",
                    "grayOut",
                    "grayOut",
                    "grayOut",
                    "grayOut",
                    "grayOut",
                    "grayOut",
                    "grayOut"
                ],
                titleLine: 2,
                titleFont: .body
            )
        }
//        .padding(.horizontal)
    }
}

#Preview {
    tokyoGhoulTableModeTable()
}
