//
//  idolMasterTableKokaku.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct idolMasterTableKokaku: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "分類",
                stringList: [
                    "液晶出目",
                    "ステージ"
                ],
                maxWidth: 100,
                lineList: [2,1],
                colorList: [.white,.white]
            )
            unitTableString(
                columTitle: "演出",
                stringList: [
                    "順目",
                    "逆順目",
                    "宇宙ステージ"
                ]
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "高確示唆 弱",
                    "高確濃厚",
                    "高確示唆"
                ]
            )
        }
    }
}

#Preview {
    idolMasterTableKokaku()
        .padding(.horizontal)
}
