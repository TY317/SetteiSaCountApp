//
//  izaBanchoTableKoyakuStyle.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/31.
//

import SwiftUI

struct izaBanchoTableKoyakuStyle: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            HStack(spacing: 15) {
                // 弱チェリー
                unitReelPattern(
                    titleText: "弱チェリー",
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
                    )
                )
                // 強チェリー
                unitReelPattern(
                    titleText: "強チェリー",
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
                    )
                )
            }
            
            // //// 2段目
            VStack(spacing: 7) {
                unitReelLongTitle(
                    titleText: "最強チェリー"
                )
                HStack(spacing: 15) {
                    VStack {
                        // 最強チェリー１
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelReplay(),
                                middle: unitReelBar(),
                                lower: unitReelText(textBody: "🍒")
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "7",textColor: .red),
                                lower: unitReelDefault()
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "7",textColor: .red),
                                lower: unitReelDefault()
                            )
                        )
                        Text("※ 赤7以外のボーナス図柄、いざ図柄でも可")
                            .foregroundStyle(Color.secondary)
                            .font(.caption)
                    }
                    .frame(maxWidth: 180)
                    // 最強チェリー2
                    VStack {
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelBar(),
                                middle: unitReelText(textBody: "🍒"),
                                lower: unitReelText(textBody: "🍉")
                            ),
                            centerReel: unitReelAny(),
                            rightReel: unitReelAny()
                        )
                        Text("※ 赤7以外のボーナス図柄、いざ図柄でも可")
                            .foregroundStyle(Color.clear)
                            .font(.caption)
                    }
                    .frame(maxWidth: 180)
                }
            }
            
            // //// 3段目
            HStack(spacing: 15) {
                // 弱スイカ
                unitReelPattern(
                    titleText: "弱スイカ",
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
                    )
                )
                // 強スイカ
                unitReelPattern(
                    titleText: "強スイカ",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "7", textColor: .blue),
                        middle: unitReelText(textBody: "🍉"),
                        lower: unitReelText(textBody: "🔔")
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
            
            // //// 4段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "チャンス目")
                HStack(spacing: 15) {
                    // チャンス目１
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
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        )
                    )
                    // チャンス目２
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelReplay()
                        ),
                        centerReel: unitReelHazure(),
                        rightReel: unitReelHazure()
                    )
                }
            }
            
            // //// 5段目
            HStack(spacing: 15) {
                VStack {
                    unitReelPattern(
                        titleText: "斬揃い",
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "斬", textColor: .red)
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "斬", textColor: .red),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "斬", textColor: .red),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        )
                    )
                    Text("※ 右上がり以外の停止ラインもあり。左リールはBAR図柄も可")
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                }
                .frame(maxWidth: 180)
                VStack {
                    unitReelPattern(
                        titleText: "いざ揃い",
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(
                                textBody: "いざ",
                                textFont: .title3
                            )
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(
                                textBody: "いざ",
                                textFont: .title3
                            ),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelText(
                                textBody: "いざ",
                                textFont: .title3
                            ),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        )
                    )
                    Text("※ 右上がり以外の停止ラインも\nあり")
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                }
                .frame(maxWidth: 180)
            }
        }
    }
}

#Preview {
    ScrollView {
        izaBanchoTableKoyakuStyle()
            .padding(.horizontal)
    }
}
