//
//  tekken6TableScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/31.
//

import SwiftUI

struct tekken6TableScreen: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "青背景",
                    "赤背景",
                ],
                maxWidth: 60,
                lineList: [3,3],
                colorList: [.tableBlue,.tableRed]
            )
            unitTableString(
                columTitle: "",
                stringList: [
                    "ラース",
                    "シャオユウ",
                    "キング",
                    "一八",
                    "平八",
                    "一美",
                ],
                maxWidth: 100,
                colorList: [.tableBlue,.tableBlue,.tableBlue,.tableRed,.tableRed,.tableRed,]
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "設定4 以上濃厚",
//                    "調査中",
//                    "調査中",
//                    "調査中",
                ],
                maxWidth: 200,
                lineList: [3,3],
                colorList: [.tableBlue,.tableRed],
//                colorList: [.tableBlue,.tableRed,.tableRed,.tableRed,],
            )
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    List {
        tekken6TableScreen()
    }
}
