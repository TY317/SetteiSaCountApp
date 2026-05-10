//
//  rioAceTableVBellSystem.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/10.
//

import SwiftUI

struct rioAceTableVBellSystem: View {
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("・小Vベルの次ゲームがレア役チャンスとなる")
                Text("・弱と強の2種類がある")
                Text("・左リール赤７狙いすると強小Vベルを判別可能")
            }
            
            // 説明
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "弱小Vベル",
                        "強小Vベル",
                    ]
                )
                unitTableString(
                    columTitle: "確率",
                    stringList: [
                        "合算\n約1/20"
                    ],
                    maxWidth: 80,
                    lineList: [2],
                    colorList: [.white]
                )
                unitTableString(
                    columTitle: "次ゲーム",
                    stringList: [
                        "約20%でレア役",
                        "レア役濃厚"
                    ]
                )
            }
            // //// 1段目
            VStack {
                HStack(spacing: 15) {
                    // 弱小Vベル
                    unitReelPattern(
                        titleText: "弱小Vベル",
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelReplay(),
                            lower: unitReelText(textBody: "🍉")
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                    )
                    // 強チェリー
                    unitReelPattern(
                        titleText: "強小Vベル",
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelText(textBody: "7", textColor: .red),
                            lower: unitReelText(textBody: "🔔")
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                    )
                }
            }
        }
    }
}

#Preview {
    rioAceTableVBellSystem()
        .padding(.horizontal)
}
