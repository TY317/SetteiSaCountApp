//
//  azurLaneTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/24.
//

import SwiftUI

struct azurLaneTableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            HStack(spacing: 15) {
                // 弱チェリー
                unitReelPattern(
                    titleText: "弱🍒",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🔔"),
                        middle: unitReelBar(),
                        lower: unitReelText(textBody: "🍒")
                    ),
                    centerReel: unitReelAny(),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelDefault()
                    )
                )
                // 強チェリー
                unitReelPattern(
                    titleText: "強🍒",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🔔"),
                        middle: unitReelBar(),
                        lower: unitReelText(textBody: "🍒")
                    ),
                    centerReel: unitReelAny(),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🔔", xmarkBool: true),
                        lower: unitReelDefault()
                    )
                )
            }
            
            // //// 2段目
            HStack(spacing: 15) {
                // 弱スイカ
                unitReelPattern(
                    titleText: "弱🍉",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelReplay(),
                        lower: unitReelText(textBody: "🔔")
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
                // 強スイカ
                unitReelPattern(
                    titleText: "強🍉",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelReplay(),
                        lower: unitReelText(textBody: "🔔")
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
                    )
                )
            }
            
            // //// 3段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "チャンス目")
                HStack(spacing: 15) {
                    // パターン1
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelReplay(),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelBar()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelReplay(),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "7", textColor: .gray),
                            lower: unitReelDefault()
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
                            upper: unitReelReplay(),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault()
                        )
                    )
                }
                HStack(spacing: 15) {
                    // パターン3
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelText(textBody: "🔔")
                        )
                    )
                    // パターン4
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelText(textBody: "7", textColor: .gray),
                            lower: unitReelText(textBody: "🔔")
                        )
                    )
                }
                HStack(spacing: 15) {
                    // パターン5
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelReplay(),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelBar()
                        ),
                        centerReel: unitReelHazure(),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelReplay()
                        )
                    )
                }
            }
            // //// 6段目
            HStack(spacing: 15) {
                // 共通ベル
                unitReelPattern(
                    titleText: "共通ベル",
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
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelDefault()
                    )
                )
                unitReelSpacer()
            }
        }
    }
}

#Preview {
    azurLaneTableKoyakuPattern()
}
