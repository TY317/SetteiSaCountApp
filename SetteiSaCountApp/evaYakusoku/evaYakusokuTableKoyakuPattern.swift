//
//  evaYakusokuTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/02.
//

import SwiftUI

struct evaYakusokuTableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "チェリー")
                HStack(spacing: 15) {
                    // チェリー
                    unitReelPattern(
                        leftReel: unitReelAny(),
                        centerReel: unitReelAny(),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍒"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        )
                    )
                    // チェリー
                    unitReelPattern(
                        leftReel: unitReelAny(),
                        centerReel: unitReelAny(),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "🍒")
                        )
                    )
                }
            }
            
            // //// 2段目
            VStack {
                HStack(spacing: 15) {
                    // 弱スイカ
                    unitReelPattern(
                        titleText: "弱スイカ",
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelReplay(),
                            lower: unitReelText(textBody: "🔔")
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        )
                    )
                    // 強スイカ
                    unitReelPattern(
                        titleText: "強スイカ",
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelReplay(),
                            lower: unitReelText(textBody: "🔔")
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
                }
                Text("※ 押す位置によっては弱・強が同じ停止形になることもある")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
            }
            
            // //// 3段目
            HStack(spacing: 15) {
                // 暴走リプレイ
                unitReelPattern(
                    titleText: "暴走リプレイ",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelReplay(),
                        lower: unitReelText(textBody: "🔔")
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
                    )
                )
                // リーチ目役
                unitReelPattern(
                    titleText: "リーチ目役",
                    leftReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelGrayMark(),
                        lower: unitReelDefault()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "7",textColor: .yellow),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "7", textColor: .red),
                        lower: unitReelDefault()
                    )
                )
            }
        }
    }
}

#Preview {
    evaYakusokuTableKoyakuPattern()
}
