//
//  otome5TableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/02.
//

import SwiftUI

struct otome5TableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "弱🍒")
                VStack {
                    HStack(spacing: 15) {
                        // 弱チェリー
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelDefault(),
                                lower: unitReelText(textBody: "🍒")
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "🍒"),
                                lower: unitReelDefault(),
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "🍒"),
                                lower: unitReelDefault(),
                            ),
                        )
                        // 弱チェリー
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelDefault(),
                                lower: unitReelText(textBody: "🍒")
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelDefault(),
                                lower: unitReelText(textBody: "🍒"),
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelText(textBody: "🍒"),
                                middle: unitReelDefault(),
                                lower: unitReelDefault(),
                            ),
                        )
                    }
                }
            }
            
            // 2段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "強🍒")
                VStack {
                    HStack(spacing: 15) {
                        // 強チェリー
                        VStack {
                            unitReelPattern(
                                leftReel: unitReelColumn(
                                    upper: unitReelDefault(),
                                    middle: unitReelDefault(),
                                    lower: unitReelText(textBody: "🍒")
                                ),
                                centerReel: unitReelColumn(
                                    upper: unitReelDefault(),
                                    middle: unitReelText(textBody: "🍒"),
                                    lower: unitReelDefault(),
                                ),
                                rightReel: unitReelColumn(
                                    upper: unitReelText(textBody: "🍒"),
                                    middle: unitReelDefault(),
                                    lower: unitReelDefault(),
                                ),
                            )
                            Text("★：ボーナスorブランク図柄")
                                .foregroundStyle(Color.clear)
                                .font(.caption)
                        }
                        // 弱チェリー
                        VStack {
                            unitReelPattern(
                                leftReel: unitReelColumn(
                                    upper: unitReelText(textBody: "🍒"),
                                    middle: unitReelDefault(),
                                    lower: unitReelDefault()
                                ),
                                centerReel: unitReelColumn(
                                    upper: unitReelDefault(),
                                    middle: unitReelText(textBody: "🍒"),
                                    lower: unitReelDefault(),
                                ),
                                rightReel: unitReelColumn(
                                    upper: unitReelDefault(),
                                    middle: unitReelText(textBody: "★"),
                                    lower: unitReelDefault(),
                                ),
                            )
                            Text("★：ボーナスorブランク図柄")
                                .foregroundStyle(Color.secondary)
                                .font(.caption)
                        }
                    }
                }
            }
            
            // //// 3段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "チャンス目")
                VStack {
                    HStack(spacing: 15) {
                        // 弱チェリー
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelText(textBody: "🔔"),
                                middle: unitReelReplay(),
                                lower: unitReelDefault()
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "🔔"),
                                lower: unitReelDefault(),
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelText(textBody: "🔔"),
                                middle: unitReelDefault(),
                                lower: unitReelDefault(),
                            ),
                        )
                        // 弱チェリー
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelText(textBody: "🔔"),
                                middle: unitReelReplay(),
                                lower: unitReelBar()
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelReplay(),
                                lower: unitReelDefault(),
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "🔔"),
                                lower: unitReelDefault(),
                            ),
                        )
                    }
                    HStack(spacing: 15) {
                        unitReelPattern(
    //                        titleText: "",
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
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "🍉"),
                                lower: unitReelDefault()
                            ),
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        otome5TableKoyakuPattern()
    }
}
