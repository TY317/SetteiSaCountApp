//
//  hihodenTableLegendSisa.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/23.
//

import SwiftUI

struct hihodenTableLegendSisa: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "クレアランプ",
                    "アイキャッチ",
                    "初代演出",
                    "壁画演出",
                    "リール演出",
                    "壁押し演出",
                    "インターフェース",
                    "BIG入賞ライン",
                ],
                maxWidth: 80,
                lineList: [2,2,4,2,8,2,3,2],
                colorList: [.white,.tableBlue,.white,.tableBlue,.white,.tableBlue,.white,.tableBlue,]
            )
            unitTableString(
                columTitle: "",
                stringList: [
                    "点滅",
                    "赤点滅",
                    "砂金",
                    "ベロベロ大魔神",
                    "通常時",
                    "高確率中",
                    "天の神(座り)＋\nリプレイ",
                    "通常ステージ＋\nクレア出現",
                    "通常ステージ以外＋\nクレア出現",
                    "リプレイ＋\n特殊フラッシュ",
                    "ベル＋\n特殊フラッシュ",
                    "左扉＋リプレイ",
                    "右扉＋🔔",
                    "満月",
                    "赤満月",
                    "ピラミッドに否",
                    "ダブル揃い",
                ],
                lineList: [1,1,1,1,2,2,2,2,2,2,2,1,1,1,1,1,2]
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "伝説モード濃厚",
                    "伝説ロング濃厚",
                    "伝説モード濃厚",
                    "伝説ロング濃厚",
                    "高確率以上＋\n伝説ロング濃厚",
                    "BIG以上＋\n伝説ロング濃厚",
                    "伝説モード濃厚",
                    "伝説モード濃厚",
                    "伝説モードに期待",
                    "伝説モード濃厚",
                    "伝説モード濃厚",
                    "伝説モード濃厚",
                    "伝説モード濃厚",
                    "伝説モード濃厚",
                    "伝説ロング濃厚",
                    "伝説モード濃厚",
                    "伝説モード濃厚",
                ],
                lineList: [1,1,1,1,2,2,2,2,2,2,2,1,1,1,1,1,2]
            )
        }
    }
}

#Preview {
    ScrollView {
        hihodenTableLegendSisa()
    }
    .padding(.horizontal)
}
