//
//  sbjTableHawaiiStage.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/12.
//

import SwiftUI

struct sbjTableHawaiiStage: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "レバーON時に下パネル点滅\n＋いずれかの停止ボタンで\n違和感演出発生",
                    "第1停止＋下パネル消灯",
                    "第2停止＋下パネル消灯",
                    "第3停止＋下パネル消灯",
                    "リナランプ点灯\n(筐体の❤︎にリナが出現)",
                    "下パネル点滅のみ発生"
                ],
                maxWidth: 250,
                lineList: [3,1,1,1,2,1],
                contentFont: .body
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "設定2 以上濃厚",
                    "設定2 以上濃厚",
                    "設定3 以上濃厚",
                    "設定4 以上濃厚",
                    "設定5 以上濃厚",
                    "設定6 濃厚"
                ],
                maxWidth: 140,
                lineList: [3,1,1,1,2,1],
                contentFont: .body
            )
        }
//        .padding(.horizontal)
    }
}

#Preview {
    sbjTableHawaiiStage()
}
