//
//  mhrTableEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/27.
//

import SwiftUI

struct mhrTableEnding: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "青",
                    "緑",
                    "赤",
                    "銅",
                    "銀",
                    "金",
                    "紅葉柄",
                    "虹"
                ],
                maxWidth: 80
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "奇数示唆",
                    "偶数示唆",
                    "高設定示唆 強",
                    "設定2 以上濃厚",
                    "設定3 以上濃厚",
                    "設定4 以上濃厚",
                    "設定5 以上濃厚",
                    "設定6 濃厚"
                ],
                maxWidth: 200
            )
        }
    }
}

#Preview {
    mhrTableEnding()
}
