//
//  enen2TableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/02.
//

import SwiftUI

struct enen2TableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            HStack(spacing: 15) {
                // 弱チェリー
                unitReelPattern(
                    titleText: "リプレイ小V",
                    leftReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelBar()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelReplay(),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
                    ),
                )
                // スイカ
                unitReelPattern(
                    titleText: "🍉",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🔔"),
                        middle: unitReelBar(),
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
                    ),
                )
            }
            
            // 2段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "🍒")
                HStack(spacing: 15) {
                    // チャンス目１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍒"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelAny(),
                        rightReel: unitReelAny(),
                    )
                    // チャンス目２
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "🍒")
                        ),
                        centerReel: unitReelAny(),
                        rightReel: unitReelAny(),
                    )
                }
            }
            
            // //// 3段目
            HStack(spacing: 15) {
                // チャンス目
                unitReelPattern(
                    titleText: "チャンス目",
                    leftReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelBar()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelReplay(),
                        lower: unitReelDefault()
                    ),
                )
                // 十字目
                unitReelPattern(
                    titleText: "十字目",
                    leftReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelReplay(),
                        lower: unitReelDefault()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelDefault(),
                        lower: unitReelReplay()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelReplay(),
                        lower: unitReelDefault()
                    ),
                )
            }
        }
    }
}

#Preview {
    enen2TableKoyakuPattern()
}
