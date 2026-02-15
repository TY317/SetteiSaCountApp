//
//  hokutoTenseiTableKokakuSisa.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/23.
//

import SwiftUI

struct hokutoTenseiTableKokakuSisa: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("・第3停止での告知頻発で高確に期待")
                Text("・カサンドラステージ滞在で高確or伝承モード示唆")
                Text("・小役入賞時のLED色矛盾の一部で高確示唆")
            }
            .padding(.bottom)
            Text("[小役入賞時のLED示唆]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "リプレイ",
                        "右下がり🔔",
                        "🍉",
                        "弱🍒",
                        "強🍒",
                        "勝舞揃い\nチャンス目\n確定🍒",
                    ],
                    maxWidth: 100,
                    lineList: [2,4,4,4,3,3],
                    colorList: [.tableBlue,.tableYellow,.tableGreen,.tableRed,.personalSummerLightRed,]
                )
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "青点滅","上記以外",
                        "黄点滅","白点滅","白高速点滅","虹",
                        "緑点滅","白点滅","白高速点滅","虹",
                        "赤点滅","白点滅","白高速点滅","虹",
                        "赤高速点滅","白高速点滅","虹",
                        "白高速点滅","白点滅","虹",
                    ],
                    maxWidth: 100,
                    colorList: [
                        .tableBlue,.tableBlue,
                        .tableYellow,.tableYellow,.tableYellow,.tableYellow,
                        .tableGreen,.tableGreen,.tableGreen,.tableGreen,
                        .tableRed,.tableRed,.tableRed,.tableRed,
                        .personalSummerLightRed,.personalSummerLightRed,.personalSummerLightRed,
                    ]
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "デフォルト","AT本前兆濃厚",
                        "デフォルト","高確以上示唆","天破orAT本前兆示唆","AT本前兆濃厚",
                        "デフォルト","高確以上示唆","天破orAT本前兆示唆","AT本前兆濃厚",
                        "デフォルト","高確以上示唆","天破orAT本前兆示唆","AT本前兆濃厚",
                        "デフォルト","天破orAT本前兆示唆","AT本前兆濃厚",
                        "デフォルト","天破orAT本前兆示唆","AT本前兆濃厚",
                    ],
                    colorList: [
                        .tableBlue,.tableBlue,
                        .tableYellow,.tableYellow,.tableYellow,.tableYellow,
                        .tableGreen,.tableGreen,.tableGreen,.tableGreen,
                        .tableRed,.tableRed,.tableRed,.tableRed,
                        .personalSummerLightRed,.personalSummerLightRed,.personalSummerLightRed,
                    ]
                )
            }
            .padding(.bottom)
            Text("[カサンドラステージでの法則]")
                .font(.title3)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "立ち止まり演出＋松明消灯",
                        "レア役＋\n立ち止まり演出＋赤絨毯の部屋表示",
                        "非レア役＋\n立ち止まり演出＋赤絨毯の部屋表示",
                    ],
                    lineList: [3,3,3],
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "高確率滞在\nor 天破 本前兆中\nor AT本前兆中",
                        "高確率へ移行\nor 高確滞在中\n(天破、AT前兆中の可能性も！)",
                        "天破 or AT濃厚",
                    ],
                    maxWidth: 200,
                    lineList: [3,3,3],
                )
            }
        }
    }
}

#Preview {
    ScrollView {
        hokutoTenseiTableKokakuSisa()
    }
        .padding(.horizontal)
}
