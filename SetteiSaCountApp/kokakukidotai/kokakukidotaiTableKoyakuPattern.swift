//
//  kokakukidotaiTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/17.
//

import SwiftUI

struct kokakukidotaiTableKoyakuPattern: View {
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
                            middle: unitReelText(textBody: "★"),
                            lower: unitReelDefault()
                        ),
                    )
                }
                Text("★：7 or BAR 図柄")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
            }
            
            // //// 2段目
            VStack {
                HStack(spacing: 15) {
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
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelReplay(),
                            lower: unitReelDefault()
                        ),
                    )
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
                                middle: unitReelText(textBody: "★"),
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
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "🍉"),
                                lower: unitReelDefault(),
                            ),
                            rightReel: unitReelHazure(),
                        )
                    }
                    Text("★：7 or BAR 図柄")
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                }
            }
        }
    }
}

#Preview {
    kokakukidotaiTableKoyakuPattern()
}
