//
//  darlingTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/27.
//

import SwiftUI

struct darlingTableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            HStack(spacing: 15) {
                // チェリー
                unitReelPattern(
                    titleText: "チェリー",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍒"),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelBar()
                    ),
                    centerReel: unitReelAny(),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelReplay()
                    )
                )
                // チャンス目
                unitReelPattern(
                    titleText: "チャンス目",
                    leftReel: unitReelColumn(
                        upper: unitReelBar(),
                        middle: unitReelReplay(),
                        lower: unitReelDefault()
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
                    )
                )
            }
            
            // //// 2段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "フランクス目")
                HStack(spacing: 15) {
                    // パターン１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍒"),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelBar()
                        ),
                        centerReel: unitReelAny(),
                        rightReel: unitReelColumn(
                            upper: unitReelWhiteBar(),
                            middle: unitReelWhiteBar(),
                            lower: unitReelDefault()
                        )
                    )
                    // パターン2
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelBar(),
                            middle: unitReelReplay(),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelAny(),
                        rightReel: unitReelColumn(
                            upper: unitReelWhiteBar(),
                            middle: unitReelWhiteBar(),
                            lower: unitReelDefault()
                        )
                    )
                }
                .padding(.bottom, 8)
                HStack(spacing: 15) {
                    // パターン3
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelBar(),
                            lower: unitReelReplay()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelWhiteBar(),
                            middle: unitReelWhiteBar(),
                            lower: unitReelDefault()
                        )
                    )
                    // パターン4
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelBar(),
                            lower: unitReelReplay()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelReplay()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelWhiteBar(),
                            middle: unitReelWhiteBar(),
                            lower: unitReelDefault()
                        )
                    )
                }
                Text("※ 右リールは中下段でも有効")
                    .foregroundStyle(Color.secondary)
            }
            
            // //// 4段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "ストレリチア目")
                HStack(spacing: 15) {
                    // パターン1
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelBar(),
                            lower: unitReelReplay()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelWhiteBar(),
                            middle: unitReelWhiteBar(),
                            lower: unitReelWhiteBar()
                        )
                    )
                    // パターン2
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelBar(),
                            lower: unitReelReplay()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelReplay()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelWhiteBar(),
                            middle: unitReelWhiteBar(),
                            lower: unitReelWhiteBar()
                        )
                    )
                }
                .padding(.bottom, 8)
                HStack(spacing: 15) {
                    // パターン3
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍒"),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelBar()
                        ),
                        centerReel: unitReelAny(),
                        rightReel: unitReelColumn(
                            upper: unitReelWhiteBar(),
                            middle: unitReelWhiteBar(),
                            lower: unitReelWhiteBar()
                        )
                    )
                    // パターン4
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍒"),
                            lower: unitReelText(textBody: "🔔")
                        ),
                        centerReel: unitReelAny(),
                        rightReel: unitReelColumn(
                            upper: unitReelWhiteBar(),
                            middle: unitReelWhiteBar(),
                            lower: unitReelWhiteBar()
                        )
                    )
                }
                .padding(.bottom, 8)
                HStack(spacing: 15) {
                    // パターン5
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelBar(),
                            middle: unitReelReplay(),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelAny(),
                        rightReel: unitReelColumn(
                            upper: unitReelWhiteBar(),
                            middle: unitReelWhiteBar(),
                            lower: unitReelWhiteBar()
                        )
                    )
//                    unitReelSpacer()
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        darlingTableKoyakuPattern()
    }
}
