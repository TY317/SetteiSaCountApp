//
//  enen2TableMiniChara.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/15.
//

import SwiftUI

struct enen2TableMiniChara: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "アイリス",
                    "ヒバナ",
                ],
                maxWidth: 80,
                lineList: [3,3],
            )
            unitTableString(
                columTitle: "",
                stringList: [
                    "喜ぶ",
                    "照れ",
                    "祈り",
                    "悩む",
                    "泣く",
                    "ハート",
                ],
                maxWidth: 80,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "通常B以上示唆 弱",
                    "通常B以上示唆 中",
                    "通常B以上示唆 強",
                    "通常B以上濃厚",
                    "通常C以上濃厚",
                    "通常D濃厚",
                ],
                maxWidth: 200,
            )
        }
    }
}

#Preview {
    enen2TableMiniChara()
}
