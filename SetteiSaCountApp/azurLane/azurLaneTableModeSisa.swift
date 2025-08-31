//
//  azurLaneTableModeSisa.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/30.
//

import SwiftUI

struct azurLaneTableModeSisa: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "分類",
                stringList: [
                    "パンケーキ系",
                    "会話系",
                    "ミニキャラ\nダブルナビ",
                    "ミニキャラ\n戦艦破壊",
                    "ミニキャラ\nダッシュ",
                    "ミニキャラ\nゴソゴソ",
                    "ミニキャラ\n全般",
                ],
                maxWidth: 100,
                lineList: [1,2,5,4,2,2,2],
                contentFont: .body,
                colorList: [.white,.tableBlue,.tableRed,.tableYellow,.tableGreen,.tableBlue,.tablePurple]
            )
            unitTableString(
                columTitle: "演出",
                stringList: [
                    "皿の色が白",
                    "小役成立時に返事なし",
                    "赤城と加賀が出現",
                    "白＆黄、白＆青\n黄＆青、黄＆黒\n青＆黄\n青＆CHANCE",
                    "右を選ぶ",
                    "紫アイコンゲット",
                    "戦艦が大きい",
                    "赤城と加賀が出現",
                    "ラフィ頻発",
                    "綾波が出現",
                    "頻発",
                    "黒アイコンゲット",
                ],
                lineList: [1,2,1,3,1,1,1,2,1,1,2,2],
                contentFont: .body,
                colorList: [
                    .white,
                    .tableBlue,
                    .tableRed,
                    .tableRed,
                    .tableRed,
                    .tableYellow,
                    .tableYellow,
                    .tableYellow,
                    .tableGreen,
                    .tableGreen,
                    .tableBlue,
                    .tablePurple,
                ],
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "高確期待度UP",
                    "高確濃厚",
                    "高確期待度UP",
                    "高確期待度UP",
                    "高確期待度大",
                    "高確期待度UP",
                    "高確期待度UP",
                    "高確濃厚\n超高確の期待大",
                    "高確期待度UP",
                    "超高確濃厚",
                    "高確期待度UP",
                    "高確濃厚",
                ],
                lineList: [1,2,1,3,1,1,1,2,1,1,2,2],
                contentFont: .body,
                colorList: [
                    .white,
                    .tableBlue,
                    .tableRed,
                    .tableRed,
                    .tableRed,
                    .tableYellow,
                    .tableYellow,
                    .tableYellow,
                    .tableGreen,
                    .tableGreen,
                    .tableBlue,
                    .tablePurple,
                ],
            )
        }
    }
}

#Preview {
    azurLaneTableModeSisa()
        .padding(.horizontal)
}
