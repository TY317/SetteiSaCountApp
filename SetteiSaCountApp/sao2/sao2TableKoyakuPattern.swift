//
//  sao2TableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/30.
//

import SwiftUI

struct sao2TableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            VStack {
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
            }
            
            // //// 2段目
            VStack {
                HStack(spacing: 15) {
                    // ウルティマチェリー
                    VStack {
                        unitReelPattern(
                            titleText: "ウルティマ🍒",
                            leftReel: unitReelColumn(
                                upper: unitReelBar(),
                                middle: unitReelText(textBody: "🍒"),
                                lower: unitReelText(textBody: "🍉")
                            ),
                            centerReel: unitReelAny(),
                            rightReel: unitReelAny(),
                        )
                    }
                    // 弱チャンス目
                    VStack {
                        unitReelPattern(
                            titleText: "🍉",
                            leftReel: unitReelColumn(
                                upper: unitReelText(textBody: "🍉"),
                                middle: unitReelText(textBody: "🔔"),
                                lower: unitReelReplay()
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
                    }
                }
            }
            
            // //// 2段目
            VStack {
                HStack(spacing: 15) {
                    // 弱チャンス目
                    VStack {
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
                                middle: unitReelText(textBody: "※"),
                                lower: unitReelDefault()
                            ),
                        )
                        Text("※：Bullet Chance")
                            .foregroundStyle(Color.secondary)
                            .font(.caption)
                    }
                    VStack {
                        unitReelSpacer()
                    }
                }
            }
            
            // //// 3段目
            VStack {
                HStack(spacing: 15) {
                    // 強チャンス目A
                    unitReelPattern(
                        titleText: "強チャンス目A",
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelReplay()
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
                    // 強チャンス目B
                    unitReelPattern(
                        titleText: "強チャンス目B",
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
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "🍉"),
                        ),
                    )
                }
            }
        }
    }
}

#Preview {
    sao2TableKoyakuPattern()
}
