//
//  acceleratorTableTaidenModeRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct acceleratorTableTaidenModeRatio: View {
    var body: some View {
        VStack {
            Text("[ゲーム数モード毎の帯電モード振り分け]")
//                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "モードA",
                        "モードB",
                        "モードC",
                        "モードD"
                    ]
                )
                unitTablePercent(
                    columTitle: "モード1",
                    percentList: [100,0,25,50]
                )
                unitTablePercent(
                    columTitle: "モード2",
                    percentList: [0,100,25,25]
                )
                unitTablePercent(
                    columTitle: "モード3",
                    percentList: [0,0,50,25]
                )
            }
            .padding(.bottom)
            Text("[高確に期待できるゾーン]")
            HStack(spacing: 0) {
                unitTableGameIndex(
                    gameList: [150,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,950]
                )
                unitTableString(
                    columTitle: "モード1",
                    stringList: [
                        "濃厚",
                        "ー",
                        "濃厚",
                        "ー",
                        "濃厚",
                        "ー",
                        "濃厚",
                        "ー",
                        "濃厚",
                        "ー",
                        "濃厚",
                        "ー",
                        "濃厚",
                        "ー",
                        "濃厚",
                        "ー",
                        "濃厚"
                    ]
                )
                unitTableString(
                    columTitle: "モード2",
                    stringList: [
                        "ー",
                        "濃厚",
                        "ー",
                        "濃厚",
                        "ー",
                        "濃厚",
                        "ー",
                        "濃厚",
                        "ー",
                        "濃厚",
                        "ー",
                        "濃厚",
                        "ー",
                        "濃厚",
                        "ー",
                        "濃厚",
                        "ー"
                    ]
                )
                unitTableString(
                    columTitle: "モード3",
                    stringList: [
                        "全ゾーン50%以上"
                    ],
                    lineList: [17],
                    colorList: [.white]
                )
            }
        }
    }
}

#Preview {
    acceleratorTableTaidenModeRatio()
        .padding(.horizontal)
}
