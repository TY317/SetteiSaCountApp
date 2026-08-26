//
//  yajikitaTableAkaneChance.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/26.
//

import SwiftUI

struct yajikitaTableAkaneChance: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "青コメント & +2G",
                    "黄コメント & +7G",
                    "白コメント & +10G",
                    "赤コメント & +66G",
                ],
                maxWidth: 200,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "設定2 以上濃厚",
                    "設定4 以上濃厚",
                    "設定5 以上濃厚",
                    "設定6 濃厚",
                ],
                maxWidth: 200,
            )
        }
    }
}

#Preview {
    yajikitaTableAkaneChance()
        .padding(.horizontal)
}
