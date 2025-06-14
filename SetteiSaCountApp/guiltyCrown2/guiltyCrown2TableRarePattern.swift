//
//  guiltyCrown2TableRarePattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/07.
//

import SwiftUI

struct guiltyCrown2TableRarePattern: View {
    var body: some View {
        VStack(spacing: 15) {
            // //// 1段目
            HStack(spacing: 15) {
                // 弱チェリー
                unitReelPattern(
                    titleText: "弱チェリー",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍒"),
                        middle: unitReelBar(),
                        lower: unitReelReplay()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🍒"),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelDefault()
                    )
                )
                // 強チェリー
                unitReelPattern(
                    titleText: "強チェリー",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍒"),
                        middle: unitReelBar(),
                        lower: unitReelReplay()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🍒"),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🔔",xmarkBool: true),
                        lower: unitReelDefault()
                    )
                )
            }
            
            // //// 2段目
            HStack(spacing: 15) {
                // 単チェリー
                unitReelPattern(
                    titleText: "単チェリー",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍒"),
                        middle: unitReelBar(),
                        lower: unitReelReplay()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "🍒")
                    ),
                    rightReel: unitReelAny()
                )
                // 確定チェリー
                unitReelPattern(
                    titleText: "確定チェリー",
                    leftReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelText(textBody: "🍒"),
                        lower: unitReelReplay()
                    ),
                    centerReel: unitReelAny(),
                    rightReel: unitReelAny()
                )
            }
            
            // //// 3段目
            HStack(spacing: 15) {
                // 弱スイカ
                unitReelPattern(
                    titleText: "弱スイカ",
                    leftReel: unitReelColumn(
                        upper: unitReelBar(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelText(textBody: "🍉")
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🍉"),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
                    )
                )
                // 強スイカ
                unitReelPattern(
                    titleText: "強スイカ",
                    leftReel: unitReelColumn(
                        upper: unitReelBar(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelText(textBody: "🍉")
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🍉"),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "🍉")
                    )
                )
            }
            
            // //// 4段目
            HStack(spacing: 15) {
                // チャンス目
                unitReelPattern(
                    titleText: "チャンス目",
                    leftReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelBar(),
                        lower: unitReelText(textBody: "🔔")
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🍒"),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelText(textBody: "🔔"),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
                    )
                )
                // SB
                unitReelPattern(
                    titleText: "SB",
                    leftReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "🔔")
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "🍒")
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "🔔")
                    )
                )
            }
        }
    }
}

#Preview {
    guiltyCrown2TableRarePattern()
}
