//
//  tonskillTableGoblinRemain.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/24.
//

import SwiftUI

struct tonskillTableGoblinRemain: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "残り1体",
                    "残り2体",
                    "残り3体",
                    "残り4体",
                    "残り5体",
                    "残り6体",
                ],
                maxWidth: 100,
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
            )
        }
    }
}

#Preview {
    tonskillTableGoblinRemain()
}
