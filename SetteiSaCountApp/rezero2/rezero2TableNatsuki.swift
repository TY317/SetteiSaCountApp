//
//  rezero2TableNatsuki.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/29.
//

import SwiftUI

struct rezero2TableNatsuki: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "3時過ぎ",
                    "4時56分",
                    "5時6分",
                    "6時6分"
                ],
                maxWidth: 120
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "設定3 以上濃厚",
                    "設定4 以上濃厚",
                    "設定5 以上濃厚",
                    "設定6 濃厚",
                ],
                maxWidth: 180
            )
        }
    }
}

#Preview {
    rezero2TableNatsuki()
}
