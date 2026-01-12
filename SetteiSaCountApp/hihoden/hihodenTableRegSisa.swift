//
//  hihodenTableRegSisa.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/12.
//

import SwiftUI

struct hihodenTableRegSisa: View {
    let lineList: [Int] = [1,1,1,1,2,2,1]
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "ヤクナシ",
                    "ワンペア",
                    "ツーペア",
                    "スリーカード",
                    "フラッシュ",
                    "フルハウス",
                    "フォーカード",
                ],
                lineList: self.lineList,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "伝説モード滞在濃厚",
                    "伝説モード滞在示唆",
                    "伝説モード滞在示唆 強",
                    "伝説モード滞在濃厚",
                    "オタカラ導まで200pt以内濃厚",
                    "次回の高確率が無限高確率濃厚",
                    "伝説ロング滞在濃厚",
                ],
                maxWidth: 200,
                lineList: self.lineList,
            )
        }
    }
}

#Preview {
    hihodenTableRegSisa()
}
