//
//  gareiTableFirstHitSpecial.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/19.
//

import SwiftUI

struct gareiTableFirstHitSpecial: View {
    var body: some View {
        VStack {
            Text("・ボーナス揃えた際のWINランプ色が当選契機と連動")
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "🍉＋赤BB\n🍉＋青頭RB",
                        "🍉＋青BB\n🍉＋赤頭RB",
                        "強🍒＋RB",
                    ],
                    lineList: [2,2,1]
                )
                unitTableString(
                    columTitle: "特徴",
                    stringList: [
                        "奇数設定優遇",
                        "偶数設定優遇",
                        "高設定の大チャンス",
                    ],
                    maxWidth: 200,
                    lineList: [2,2,1]
                )
            }
        }
    }
}

#Preview {
    gareiTableFirstHitSpecial()
}
