//
//  creaTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/27.
//

import SwiftUI

struct creaTableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            HStack(spacing: 15) {
                // 弱スイカ
                unitReelPattern(
                    titleText: "🍒",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🔔"),
                        middle: unitReelBar(),
                        lower: unitReelText(textBody: "🍒")
                    ),
                    centerReel: unitReelAny(),
                    rightReel: unitReelAny(),
                )
                unitReelSpacer()
            }
            
            // //// 2段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "🍉")
                HStack(spacing: 15) {
                    // スイカ１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelReplay(),
                            lower: unitReelText(textBody: "🔔")
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault(),
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault(),
                        )
                    )
                    // スイカ2
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelReplay(),
                            lower: unitReelText(textBody: "🔔")
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault(),
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "🍉"),
                        )
                    )
                }
            }
            
            // //// 3段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "チャンス目（停止例）")
                HStack(spacing: 15) {
                    // パターン１
                    unitReelPattern(
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
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "🔔")
                        )
                    )
                    // パターン2
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelReplay(),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelBar()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelReplay(),
                            lower: unitReelText(textBody: "▲", textColor: .blue)
                        ),
                        rightReel: unitReelHazure()
                    )
                }
                HStack(spacing: 15) {
                    // パターン3
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelReplay(),
                            lower: unitReelText(textBody: "🔔")
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault(),
                        ),
                        rightReel: unitReelHazure()
                    )
                    // パターン4
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "▲", textColor: .blue),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelReplay()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault(),
                        ),
                        rightReel: unitReelHazure()
                    )
                }
            }
        }
    }
}

#Preview {
    creaTableKoyakuPattern()
}
