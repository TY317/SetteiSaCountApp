//
//  enen2TableEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/19.
//

import SwiftUI

struct enen2TableEnding: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "シンラ",
                    "アーサー",
                    "タマキ",
                    "119",
                    "アイリス",
                    "紅丸＆ジョーカー",
                    "ショウ",
                ]
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "奇数示唆",
                    "偶数示唆",
                    "高設定示唆",
                    "設定2 以上濃厚",
                    "設定4 以上濃厚",
                    "設定5 以上濃厚",
                    "設定6 濃厚",
                ]
            )
        }
    }
}

#Preview {
    enen2TableEnding()
}
