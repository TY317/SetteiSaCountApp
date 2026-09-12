//
//  ricoricoTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/09/02.
//

import SwiftUI

struct ricoricoTableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("★：ボーナス図柄、ブランク図柄")
                .foregroundStyle(Color.secondary)
                .font(.caption)
            // //// 1段目
            VStack {
                HStack(spacing: 15) {
                    // チェリー
                    unitReelPattern(
                        titleText: "🍒",
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
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "★", xmarkBool: true),
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
            
            // //// 2段目
            VStack {
                HStack(spacing: 15) {
                    // 中段チェリー
                    unitReelPattern(
                        titleText: "中段🍒",
                        leftReel: unitReelColumn(
                            upper: unitReelBar(),
                            middle: unitReelText(textBody: "🍒"),
                            lower: unitReelText(textBody: "🍉")
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelBar(),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelBar()
                        ),
                    )
                    // 弱リコリス目
                    unitReelPattern(
                        titleText: "弱リコリス目",
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
                            middle: unitReelText(textBody: "◆", textColor: .purple),
                            lower: unitReelDefault()
                        ),
                    )
                }
            }

            // //// 3段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "強リコリス目")
                VStack {
                    HStack(spacing: 15) {
                        // 強リコリス目１
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelReplay(),
                                middle: unitReelBar(),
                                lower: unitReelText(textBody: "🍒")
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelReplay(),
                                lower: unitReelDefault(),
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelDefault(),
                                lower: unitReelText(textBody: "◆", textColor: .purple),
                            ),
                        )
                        // 強リコリス目２
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelReplay(),
                                middle: unitReelBar(),
                                lower: unitReelText(textBody: "🍒")
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelReplay(),
                                middle: unitReelDefault(),
                                lower: unitReelDefault(),
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelText(textBody: "◆", textColor: .purple),
                                middle: unitReelDefault(),
                                lower: unitReelDefault(),
                            ),
                        )
                    }
                    
                    HStack(spacing: 15) {
                        // 強リコリス目３
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelText(textBody: "🍉"),
                                middle: unitReelText(textBody: "🔔"),
                                lower: unitReelReplay()
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelDefault(),
                                lower: unitReelReplay(),
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "★"),
                                lower: unitReelText(textBody: "◆", textColor: .purple),
                            ),
                        )
                        // 強リコリス目４
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelText(textBody: "🍉"),
                                middle: unitReelText(textBody: "🔔"),
                                lower: unitReelReplay()
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelReplay(),
                                lower: unitReelDefault(),
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelText(textBody: "◆", textColor: .purple),
                                middle: unitReelDefault(),
                                lower: unitReelDefault(),
                            ),
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    ricoricoTableKoyakuPattern()
}
