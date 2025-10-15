//
//  zeni5TableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/14.
//

import SwiftUI

struct zeni5TableKoyakuPattern: View {
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
                        middle: unitReelText(textBody: "🍒"),
                        lower: unitReelDefault()
                    ),
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
            
            // //// 2段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "🔔")
                HStack(spacing: 15) {
                    // スイカ１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelText(textBody: "●", textColor: .blue),
                            lower: unitReelReplay()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault(),
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault(),
                        )
                    )
                    // スイカ１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelText(textBody: "●", textColor: .blue),
                            lower: unitReelReplay()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelDefault(),
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "🔔"),
                        )
                    )
                }
            }
            
            // //// 3段目
            HStack(spacing: 15) {
                // チャンスリプ
                unitReelPattern(
                    titleText: "チャンスリプ",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "●", textColor: .blue),
                        middle: unitReelReplay(),
                        lower: unitReelBar()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelText(textBody: "●", textColor: .blue),
                        middle: unitReelReplay(),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "●", textColor: .blue),
                        lower: unitReelDefault()
                    ),
                )
                unitReelSpacer()
            }
            HStack {
                Text("●")
                    .foregroundStyle(Color.blue)
                Text("：プラム")
            }
        }
    }
}

#Preview {
    zeni5TableKoyakuPattern()
}
