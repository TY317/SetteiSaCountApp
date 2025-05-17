//
//  gundamSeedTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/11.
//

import SwiftUI

struct gundamSeedTableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 15) {
                // 弱チェリー
                unitReelPattern(
                    titleText: "弱チェリー",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🔔"),
                        middle: unitReelBar(),
                        lower: unitReelText(textBody: "🍒")
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
            // 強チェリー
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "強チェリー")
                HStack(spacing: 15) {
                    // パターン１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelBar(),
                            lower: unitReelText(textBody: "🍒")
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
                            upper: unitReelText(textBody: "🍒"),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelReplay()
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
                        )
                    )
                }
            }
            HStack(spacing: 15) {
                // 弱スイカ
                unitReelPattern(
                    titleText: "弱スイカ",
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
                    titleText: "強スイカ",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelReplay(),
                        lower: unitReelText(textBody: "🔔")
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "🔔")
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "🔔")
                    )
                )
            }
            // チャンス目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "チャンス目")
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
                            middle: unitReelReplay(),
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
                            upper: unitReelDefault(),
                            middle: unitReelReplay(),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelReplay(),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        )
                    )
                }
            }
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
    gundamSeedTableKoyakuPattern()
        .padding(.horizontal)
}
