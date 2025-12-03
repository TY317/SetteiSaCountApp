//
//  bakemonoTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/30.
//

import SwiftUI

struct bakemonoTableKoyakuPattern: View {
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
                // 中段チェリー
                unitReelPattern(
                    titleText: "中段🍒",
                    leftReel: unitReelColumn(
                        upper: unitReelBar(),
                        middle: unitReelText(textBody: "🍒"),
                        lower: unitReelText(textBody: "🍉")
                    ),
                    centerReel: unitReelAny(),
                    rightReel: unitReelAny(),
                )
            }
            // //// 2段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "強🍒")
                HStack(spacing: 15) {
                    // 強チェリー
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelReplay(),
                            middle: unitReelBar(),
                            lower: unitReelText(textBody: "🍒"),
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "怪異"),
                            lower: unitReelDefault(),
                        ),
                        rightReel: unitReelAny(),
                    )
                    // 強チェリー
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelReplay(),
                            middle: unitReelBar(),
                            lower: unitReelText(textBody: "🍒"),
                        ),
                        centerReel: unitReelAny(),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "怪異"),
                            lower: unitReelDefault(),
                        ),
                    )
                }
            }
            
            // //// 3段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "🍉")
                HStack(spacing: 15) {
                    // スイカ１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault(),
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
                        ),
                    )
                    // スイカ２
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault(),
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
                        ),
                    )
                }
            }
            
            // //// 4段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "チャンス目")
                VStack {
                    HStack(spacing: 15) {
                        // チャンス目１
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelText(textBody: "🔔"),
                                middle: unitReelReplay(),
                                lower: unitReelBar(),
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "怪異"),
                                lower: unitReelDefault(),
                            ),
                            rightReel: unitReelAny(),
                        )
                        // チャンス目１
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelText(textBody: "🔔"),
                                middle: unitReelReplay(),
                                lower: unitReelBar(),
                            ),
                            centerReel: unitReelAny(),
                            rightReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "怪異"),
                                lower: unitReelDefault(),
                            ),
                        )
                    }
                    Text("※ 枠内怪異停止＆非小役揃い")
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                }
            }
            
            // //// 5段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "チャンス目")
                HStack(spacing: 15) {
                    // スイカ１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault(),
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault(),
                        ),
                        rightReel: unitReelHazure(),
                    )
                    // スイカ２
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault(),
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault(),
                        ),
                        rightReel: unitReelHazure(),
                    )
                }
            }
            
            // //// 6段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "強チャンス目")
                HStack(spacing: 15) {
                    // 強チャンス目１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelReplay(),
                            middle: unitReelBar(),
                            lower: unitReelText(textBody: "🍒"),
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "怪異"),
                            lower: unitReelDefault(),
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "7", textColor: .red),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelText(textBody: "怪異"),
                        ),
                    )
                    // 強チャンス目２
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "怪異"),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelText(textBody: "🔔"),
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "怪異"),
                            lower: unitReelDefault(),
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "怪異"),
                        ),
                    )
                }
            }
            
            // //// 7段目
            HStack(spacing: 15) {
                // 強ベルA
                unitReelPattern(
                    titleText: "強🔔A",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelReplay()
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
                    ),
                )
                // 強ベルB
                unitReelPattern(
                    titleText: "強🔔B",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "怪異"),
                        middle: unitReelText(textBody: "🍉"),
                        lower: unitReelText(textBody: "🔔")
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "🔔")
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "🔔")
                    ),
                )
            }
        }
    }
}

#Preview {
    ScrollView {
        bakemonoTableKoyakuPattern()
    }
}
