//
//  neoplaTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/16.
//

import SwiftUI

struct neoplaTableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            HStack(spacing: 15) {
                // 角チェリー
                unitReelPattern(
                    titleText: "角🍒",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🔔"),
                        middle: unitReelText(textBody: "7", textColor: .red),
                        lower: unitReelText(textBody: "🍒")
                    ),
                    centerReel: unitReelAny(),
                    rightReel: unitReelAny(),
                )
                // 中段チェリー
                unitReelPattern(
                    titleText: "中段🍒",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "7", textColor: .red),
                        middle: unitReelText(textBody: "🍒"),
                        lower: unitReelText(textBody: "🪐")
                    ),
                    centerReel: unitReelAny(),
                    rightReel: unitReelAny(),
                )
            }
            // //// 2段目
            HStack(spacing: 15) {
                // オレンジ
                unitReelPattern(
                    titleText: "オレンジ",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "7", textColor: .red),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelText(textBody: "🍊")
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🍊"),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍊"),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
                    ),
                )
                unitReelSpacer()
            }
        }
    }
}

#Preview {
    neoplaTableKoyakuPattern()
}
