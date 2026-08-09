//
//  worldDaiStarTableEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/02.
//

import SwiftUI

struct worldDaiStarTableEnding: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "白サイン",
                    "紫サイン",
                    "金サイン",
                    "虹サイン",
                ],
                maxWidth: 100,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
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
    worldDaiStarTableEnding()
}
