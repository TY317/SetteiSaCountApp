//
//  thunderTableScreenBig.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/15.
//

import SwiftUI

struct thunderTableScreenBig: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "回路背景",
                    "夜空背景",
                ],
                maxWidth: 80,
                lineList: [2,2]
            )
            unitTableString(
                columTitle: "",
                stringList: [
                    "発光なし",
                    "発光あり",
                    "流れ星なし",
                    "流れ星あり",
                ],
                maxWidth: 100,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "設定2 以上濃厚",
                    "1G連時 デフォルト",
                    "設定2 以上濃厚",
                ]
            )
        }
    }
}

#Preview {
    List {
        thunderTableScreenBig()
    }
}
