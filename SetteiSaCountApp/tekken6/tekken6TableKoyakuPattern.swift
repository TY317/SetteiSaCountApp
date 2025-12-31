//
//  tekken6TableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/31.
//

import SwiftUI

struct tekken6TableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            HStack(spacing: 15) {
                // 共通
                unitReelPattern(
                    titleText: "共通🔔",
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
            
            // //// 2段目
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
                            middle: unitReelText(textBody: "★", xmarkBool: true),
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
                Text("★：7 or BAR or ブランク図柄")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
            }
            
            // //// 3段目
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
                            lower: unitReelDefault(),
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelDefault(),
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
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault(),
                        ),
                    )
                }
            }
            
            // //// 4段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "ブースト目")
                HStack(spacing: 15) {
                    // ブースト目１
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
                    // ブースト目２
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
                }
            }
        }
    }
}

#Preview {
    tekken6TableKoyakuPattern()
}
