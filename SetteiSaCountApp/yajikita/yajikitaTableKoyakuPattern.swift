//
//  yajikitaTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//
//  ※これは代表的なレア役停止形の雛形。実機に合わせて図柄/役を編集すること。
//  使えるパーツ：unitReelPattern / unitReelColumn / unitReelAny / unitReelHazure /
//  unitReelSpacer / unitReelLongTitle / unitReelReplay(xmarkBool:) / unitReelBar /
//  unitReelText(textBody:) / unitReelDefault

import SwiftUI

struct yajikitaTableKoyakuPattern: View {
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
                            middle: unitReelText(textBody: "7", textColor: .red),
                            lower: unitReelText(textBody: "🍒")
                        ),
                        centerReel: unitReelAny(),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelDefault()
                        ),
                    )
                    // 強チェリー
                    unitReelPattern(
                        titleText: "強🍒",
                        leftReel: unitReelColumn(
                            upper: unitReelReplay(),
                            middle: unitReelText(textBody: "7", textColor: .red),
                            lower: unitReelText(textBody: "🍒")
                        ),
                        centerReel: unitReelAny(),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🔔", xmarkBool: true),
                            lower: unitReelDefault()
                        ),
                    )
                }
            }

            // //// 2段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "弱チャンス目")
                VStack {
                    HStack(spacing: 15) {
                        // チャンス目１
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelText(textBody: "🔔"),
                                middle: unitReelReplay(),
                                lower: unitReelText(textBody: "7", textColor: .red)
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
                        // チャンス目２
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelText(textBody: "🔔"),
                                middle: unitReelReplay(),
                                lower: unitReelText(textBody: "7", textColor: .red)
                            ),
                            centerReel: unitReelHazure(),
                            rightReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelReplay(),
                                lower: unitReelText(textBody: "🔔"),
                            ),
                        )
                    }
                }
            }
            
            // //// 3段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "強チャンス目")
                VStack {
                    HStack(spacing: 15) {
                        // チャンス目１
                        unitReelPattern(
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
                        // チャンス目２
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
                                upper: unitReelDefault(),
                                middle: unitReelDefault(),
                                lower: unitReelText(textBody: "🍉"),
                            ),
                        )
                    }
                }
            }

            // //// 3段目
            VStack {
                HStack(spacing: 15) {
                    // 強チャンスリプレイ
                    unitReelPattern(
                        titleText: "強チャンスリプレイ",
                        titleFont: .body,
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelReplay(),
                            lower: unitReelText(textBody: "7", textColor: .red)
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
                    // スイカ
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
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "🍉")
                        ),
                    )
                }
            }
            
            // //// 3段目
            VStack {
                HStack(spacing: 15) {
                    // 祭り目
                    VStack {
                        unitReelPattern(
                            titleText: "祭目",
                            leftReel: unitReelColumn(
                                upper: unitReelText(textBody: "🔔"),
                                middle: unitReelReplay(),
                                lower: unitReelText(textBody: "7", textColor: .red)
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelReplay(),
                                lower: unitReelDefault()
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelDefault(),
                                lower: unitReelReplay()
                            ),
                        )
                        Text("※ 全ライン有効")
                            .foregroundStyle(Color.clear)
                            .font(.caption)
                    }
                    // わっしょい揃い
                    VStack {
                        unitReelPattern(
                            titleText: "わっしょい揃い",
                            leftReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelBar(),
                                lower: unitReelDefault()
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelBar(),
                                lower: unitReelDefault()
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelBar(),
                                lower: unitReelDefault()
                            ),
                        )
                        Text("※ 全ライン有効")
                            .foregroundStyle(Color.secondary)
                            .font(.caption)
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        yajikitaTableKoyakuPattern()
    }
}
