//
//  hokutoTenseiTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/27.
//

import SwiftUI

struct hokutoTenseiTableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            HStack(spacing: 15) {
                // 右下がりベル
                unitReelPattern(
                    titleText: "右下がり🔔",
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
            }
            
            // //// 2段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "強🍒")
                HStack(spacing: 15) {
                    // 強チェリー１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelReplay(),
                            middle: unitReelBar(),
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
                    // 強チェリー２
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelBar(),
                            middle: unitReelText(textBody: "🍒"),
                            lower: unitReelText(textBody: "🍉")
                        ),
                        centerReel: unitReelAny(),
                        rightReel: unitReelAny(),
                    )
                }
            }
            
            // 3段目
            HStack(spacing: 15) {
                // スイカ
                unitReelPattern(
                    titleText: "🍉",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelReplay(),
                        lower: unitReelBar()
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
                // チャンス目
                unitReelPattern(
                    titleText: "チャンス目",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelReplay(),
                        lower: unitReelBar()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🍉"),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "🍉", xmarkBool: true)
                    ),
                )
            }
            
            // //// 4段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "勝舞揃い")
                HStack(spacing: 15) {
                    // 強チェリー１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelReplay(),
                            lower: unitReelBar()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "勝舞", textFont: .title2, textColor: .purple),
                            lower: unitReelDefault(),
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "勝舞", textFont: .title2, textColor: .purple),
                            middle: unitReelDefault(),
                            lower: unitReelDefault(),
                        ),
                    )
                    // 強チェリー２
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelReplay(),
                            lower: unitReelBar()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "勝舞", textFont: .title2, textColor: .purple),
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "勝舞", textFont: .title2, textColor: .purple),
                        ),
                    )
                }
            }
            
            // //// 5段目
            HStack(spacing: 15) {
                // 確定チェリー
                unitReelPattern(
                    titleText: "確定🍒",
                    leftReel: unitReelColumn(
                        upper: unitReelBar(),
                        middle: unitReelText(textBody: "🍒"),
                        lower: unitReelText(textBody: "🍉")
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🍒"),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🍒"),
                        lower: unitReelDefault()
                    ),
                )
                unitReelSpacer()
            }
        }
    }
}

#Preview {
    ScrollView {
        hokutoTenseiTableKoyakuPattern()
    }
}
