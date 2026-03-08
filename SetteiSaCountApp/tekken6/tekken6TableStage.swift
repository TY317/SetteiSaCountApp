//
//  tekken6TableStage.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/04.
//

import SwiftUI

struct tekken6TableStage: View {
    var body: some View {
        VStack {
            Text("[ステージでの示唆]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "ラース",
                        "シャオユウ",
                        "キング",
                        "BAR",
                        "仁",
                        "平八",
                        "クマ",
                    ],
                    maxWidth: 100,
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "デフォルト",
                        "CZモードC 以上濃厚",
                        "CZモードD 以上濃厚",
                        "CZモードE 以上濃厚",
                        "本前兆濃厚",
                    ],
                    maxWidth: 200,
                    lineList: [3],
                )
            }
        }
    }
}

#Preview {
    tekken6TableStage()
}
