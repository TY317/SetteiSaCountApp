//
//  newOni3TableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/05.
//

import SwiftUI

struct newOni3TableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            HStack(spacing: 15) {
                // 弱チェリー
                unitReelPattern(
                    titleText: "弱🍒",
                    leftReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelBar(),
                        lower: unitReelText(textBody: "🍒")
                    ),
                    centerReel: unitReelAny(),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelReplay(),
                        lower: unitReelDefault()
                    ),
                )
                // 強チェリー
                unitReelPattern(
                    titleText: "強🍒",
                    leftReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelBar(),
                        lower: unitReelText(textBody: "🍒")
                    ),
                    centerReel: unitReelAny(),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelReplay(xmarkBool: true),
                        lower: unitReelDefault()
                    ),
                )
            }
            
            // //// 2段目
            HStack(spacing: 15) {
                // 弱スイカ
                unitReelPattern(
                    titleText: "弱🍉",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelReplay()
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
                    ),
                )
                unitReelSpacer()
            }
            // //// 3段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "強🍉")
                HStack(spacing: 15) {
                    // スイカ１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelReplay()
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
                    // スイカ１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelText(textBody: "🔔")
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault(),
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault(),
                        )
                    )
                }
            }
            
            // //// 4段目
            HStack(spacing: 15) {
                // 弱チャンス目
                unitReelPattern(
                    titleText: "弱チャンス目",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🔔"),
                        middle: unitReelReplay(),
                        lower: unitReelBar()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelReplay(),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelDefault()
                    ),
                )
                unitReelSpacer()
            }
            
            // //// 5段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "強チャンス目")
                HStack(spacing: 15) {
                    // パターン１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelReplay(),
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
                    // パターン2
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelReplay()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault()
                        )
                    )
                }
            }
            
            // //// 6段目
            HStack(spacing: 15) {
                // 強リプレイ
                unitReelPattern(
                    titleText: "強リプレイ",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelReplay()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelReplay()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelReplay()
                    ),
                )
                unitReelSpacer()
            }
            
            // //// 7段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "強🔔")
                HStack(spacing: 15) {
                    // 強ベル１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelReplay()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelDefault(),
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelDefault(),
                        )
                    )
                    // 強ベル２
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelReplay(),
                            lower: unitReelText(textBody: "🔔")
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "🔔"),
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "🔔"),
                        )
                    )
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        newOni3TableKoyakuPattern()
    }
    .padding(.horizontal)
}
