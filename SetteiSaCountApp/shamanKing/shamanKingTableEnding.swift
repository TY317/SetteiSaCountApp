//
//  shamanKingTableEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct shamanKingTableEnding: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: ["青","銅","銀","金","花火柄","虹"],
                maxWidth: 100
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "設定2 以上濃厚",
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
    shamanKingTableEnding()
}
