//
//  sbjTableDiceCheck.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/12.
//

import SwiftUI

struct sbjTableDiceCheck: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "出目",
                stringList: [
                    "奇数＋偶数",
                    "奇数＋奇数\n(ゾロ目以外)",
                    "偶数＋偶数\n(ゾロ目以外)",
                    "1ゾロ",
                    "2ゾロ",
                    "3ゾロ",
                    "4ゾロ",
                    "5ゾロ",
                    "6ゾロ",
                ],
                lineList: [2,2,2,1,2,2,2,2,2]
            )
            unitTableString(
                columTitle: "スイカ規定回数示唆",
                stringList: [
                    "合計数字が小さいほど\nチャンス",
                    "残り回数の十の位が奇数",
                    "残り回数の十の位が偶数",
                    "残り5回以内",
                    "残り10回以内\n(否定で設定2 以上濃厚)",
                    "残り15回以内\n(否定で設定3 以上濃厚)",
                    "残り20回以内\n(否定で設定4 以上濃厚)",
                    "残り25回以内\n(否定で設定5 以上濃厚)",
                    "残り30回以内\n(否定で設定6 以上濃厚)"
                ],
                maxWidth: 250,
                lineList: [2,2,2,1,2,2,2,2,2],
                contentFont: .body
            )
        }
//        .padding(.horizontal)
    }
}

#Preview {
    sbjTableDiceCheck()
}
