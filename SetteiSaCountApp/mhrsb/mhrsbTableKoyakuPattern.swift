//
//  mhrsbTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//
//  使えるパーツ：unitReelPattern / unitReelColumn / unitReelAny / unitReelHazure /
//  unitReelSpacer / unitReelLongTitle / unitReelReplay(xmarkBool:) / unitReelBar /
//  unitReelText(textBody:) / unitReelDefault

import SwiftUI

struct mhrsbTableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "共通🔔")
                VStack {
                    HStack(spacing: 15) {
                        // 共通🔔 A
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelText(textBody: "🔔"),
                                middle: unitReelReplay(),
                                lower: unitReelBar()
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelText(textBody: "🔔"),
                                middle: unitReelDefault(),
                                lower: unitReelDefault()
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelText(textBody: "🔔"),
                                middle: unitReelDefault(),
                                lower: unitReelDefault()
                            ),
                        )
                        // 共通🔔 B
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
                                middle: unitReelDefault(),
                                lower: unitReelText(textBody: "🔔")
                            ),
                        )
                    }
                }
            }
            
            // //// 2段目
            VStack {
                HStack(spacing: 15) {
                    // キュリア揃い
                    VStack {
                        unitReelPattern(
                            titleText: "キュリア揃い",
                            leftReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelDefault(),
                                lower: unitReelText(textBody: "◆", textColor: .purple)
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "◆", textColor: .purple),
                                lower: unitReelDefault()
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelText(textBody: "◆", textColor: .purple),
                                middle: unitReelDefault(),
                                lower: unitReelDefault()
                            ),
                        )
                        Text("左リールはBAR図柄も有効")
                            .foregroundStyle(Color.secondary)
                            .font(.caption)
                    }
                    // 🍉
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
                                lower: unitReelDefault()
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelDefault(),
                                lower: unitReelText(textBody: "🍉")
                            ),
                        )
                        Text("左リールはBAR図柄も有効")
                            .foregroundStyle(Color.clear)
                            .font(.caption)
                    }
                }
            }

            // //// 3段目
            VStack {
                HStack(spacing: 15) {
                    // 弱🍒
                    unitReelPattern(
                        titleText: "弱🍒",
                        leftReel: unitReelColumn(
                            upper: unitReelReplay(),
                            middle: unitReelBar(),
                            lower: unitReelText(textBody: "🍒")
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "◆", textColor: .purple),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "◆", textColor: .purple, xmarkBool: true),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                    )
                    // 強🍒
                    unitReelPattern(
                        titleText: "強🍒",
                        leftReel: unitReelColumn(
                            upper: unitReelReplay(),
                            middle: unitReelBar(),
                            lower: unitReelText(textBody: "🍒")
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "◆", textColor: .purple),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "◆", textColor: .purple),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                    )
                }
            }

            // //// 4段目
            VStack {
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
                            middle: unitReelText(textBody: "🔔🔔", textFont: .title3),
                            lower: unitReelDefault()
                        ),
                    )
                    // 強チャンス目
                    unitReelPattern(
                        titleText: "強チャンス目",
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
                        ),
                    )
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        mhrsbTableKoyakuPattern()
    }
        .padding(.horizontal)
}
