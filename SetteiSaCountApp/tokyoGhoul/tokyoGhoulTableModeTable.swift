//
//  tokyoGhoulTableModeTable.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/12.
//

import SwiftUI

struct tokyoGhoulTableModeTable: View {
    let lineList: [Int] = [1,2,1,1,1,1,1,1,1,1,1,1,1,]
    let colorList: [Color] = [.tableBlue,.tableBlue,.white,.tableBlue,.tableBlue,.white,.white,.tableBlue,.tableBlue,.white,.tableBlue,.white,.tableBlue,]
    var body: some View {
        VStack {
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
            .padding(.bottom)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "50G",
                        "100G",
                        "150G",
                        "200G",
                        "250G",
                        "300G",
                        "400G",
                        "500G",
                        "600G",
                    ],
                    maxWidth: 60,
                    lineList: [3,1,2,2,2,1,1,1,1,],
                )
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "前兆発生",
                        "前兆ステージ移行",
                        "前兆ステージ移行なし",
                        "前兆発生",
                        "前兆ステージ移行",
                        "前兆発生なし",
                        "前兆ステージ移行なし",
                        "前兆発生",
                        "前兆ステージ移行",
                        "前兆ステージ移行なし",
                        "前兆発生なし",
                        "前兆ステージ移行なし",
                        "-",
                    ],
                    lineList: self.lineList,
                    colorList: self.colorList,
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "チャンス以上",
                        "CZ当選のチャンス\n&天国濃厚",
                        "天国準備濃厚",
                        "通常B以上",
                        "本前兆濃厚",
                        "天国準備濃厚",
                        "通常B以上期待度UP",
                        "通常C以上濃厚",
                        "本前兆濃厚",
                        "チャンス濃厚",
                        "通常C濃厚",
                        "チャンス濃厚",
                        "本前兆濃厚",
                    ],
                    lineList: self.lineList,
                    colorList: self.colorList,
                )
            }
        }
//        .padding(.horizontal)
    }
}

#Preview {
    tokyoGhoulTableModeTable()
        .padding(.horizontal)
}
