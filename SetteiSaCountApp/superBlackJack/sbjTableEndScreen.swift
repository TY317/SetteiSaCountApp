//
//  sbjTableEndScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/12.
//

import SwiftUI

struct sbjTableEndScreen: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "ティファニー",
                    "イル＆エル",
                    "ローザ",
                    "ミント",
                    "リオ",
                    "リナ",
                    "リオ＆リナ",
                    "リオ＆リナ＆ミント"
                ],
                maxWidth: 160,
                lineList: [1,1,1,2,2,2,1,1],
                contentFont: .body
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "設定2 以上示唆",
                    "偶数示唆",
                    "高設定示唆 弱\n(ｻｲﾝ付きは期待度ｱｯﾌﾟ)",
                    "高設定示唆 中\n(ｻｲﾝ付きは期待度ｱｯﾌﾟ)",
                    "高設定示唆 強\n(ｻｲﾝ付きは期待度ｱｯﾌﾟ)",
                    "設定5 以上濃厚",
                    "設定6 濃厚"
                ],
                maxWidth: 250,
                lineList: [1,1,1,2,2,2,1,1],
                contentFont: .body
            )
        }
//        .padding(.horizontal)
    }
}

#Preview {
    sbjTableEndScreen()
}
