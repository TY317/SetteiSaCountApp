//
//  mt5TableTrophy.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/09.
//

import SwiftUI

struct mt5TableTrophy: View {
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            unitTableString(
                columTitle: "",
                stringList: ["銅","金","ケロット柄","虹"]
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "設定2 以上濃厚",
//                    "設定3 以上濃厚",
                    "設定4 以上濃厚",
                    "設定5 以上濃厚",
                    "設定6 濃厚"
                ],
                maxWidth: 200
            )
            Spacer()
        }
    }
}

#Preview {
    mt5TableTrophy()
}
