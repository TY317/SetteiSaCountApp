//
//  mt5TableFunaken.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/09.
//

import SwiftUI

struct mt5TableFunaken: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "青",
                    "黄",
                    "銀",
                    "金",
                    "虹",
                ],
                maxWidth: 80,
                lineList: [2,2,1,1,1],
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "最上段選手のライバルモード\n期待度アップ(弱)",
                    "最上段選手のライバルモード\n期待度アップ(強)",
                    "偶数濃厚",
                    "設定4 以上濃厚",
                    "設定6 濃厚",
                ],
                maxWidth: 250,
                lineList: [2,2,1,1,1],
            )
        }
    }
}

#Preview {
    mt5TableFunaken()
    
}
