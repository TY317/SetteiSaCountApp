//
//  mushotenSectionCzPercent.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/03.
//

import SwiftUI

struct mushotenSectionCzPercent: View {
    var body: some View {
        Section {
            Text("押し順ナビ時の％表示でゾロ目の場合は設定示唆")
                .foregroundStyle(Color.secondary)
                .font(.caption)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "44%",
                        "55%",
                        "66%",
                    ],
                    maxWidth: 100,
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "設定4 以上濃厚",
                        "設定5 以上濃厚",
                        "設定6 濃厚",
                    ]
                )
            }
            .frame(maxWidth: .infinity, alignment: .center)
        } header: {
            Text("CZ中の％表示")
        }
    }
}

#Preview {
    List {
        mushotenSectionCzPercent()
    }
}
