//
//  danvineTableEnemyNumberSisa.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct danvineTableEnemyNumberSisa: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "初期敵機数",
                    stringList: [
                        "1000機",
                        "1001機"
                    ]
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "デフォルト",
                        "設定6 濃厚"
                    ]
                )
            }
            .padding(.bottom)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "撃破数",
                    stringList: [
                        "22機",
                        "33機",
                        "44機",
                        "55機",
                        "66機"
                    ],
                    maxWidth: 120
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
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
}

#Preview {
    danvineTableEnemyNumberSisa()
}
