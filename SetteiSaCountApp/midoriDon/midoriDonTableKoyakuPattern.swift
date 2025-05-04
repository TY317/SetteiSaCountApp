//
//  midoriDonTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/04.
//

import SwiftUI

struct midoriDonTableKoyakuPattern: View {
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 15) {
                // 弱チェリー
                unitReelPattern(
                    titleText: "弱チェリー",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍒"),
                        middle: unitReelBar(),
                        lower: unitReelReplay()
                    ),
                    centerReel: unitReelAny(),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelDefault()
                    )
                )
                // 強チェリー
                unitReelPattern(
                    titleText: "強チェリー",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍒"),
                        middle: unitReelBar(),
                        lower: unitReelReplay()
                    ),
                    centerReel: unitReelAny(),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🔔", xmarkBool: true),
                        lower: unitReelDefault()
                    )
                )
            }
            HStack(spacing: 15) {
                // 弱スイカ
                unitReelPattern(
                    titleText: "弱スイカ",
                    leftReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelText(textBody: "🍉")
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "🍉")
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
                        upper: unitReelReplay(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelText(textBody: "🍉")
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🍉"),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
                    )
                )
            }
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "チャンス目")
                HStack(spacing: 15) {
                    // パターン１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelBar(),
                            middle: unitReelReplay(),
                            lower: unitReelText(textBody: "🔔")
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
                        )
                    )
                    // パターン１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelBar(),
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
                            middle: unitReelReplay(),
                            lower: unitReelDefault()
                        )
                    )
                }
            }
            HStack(spacing: 15) {
                // 共通ベル
                unitReelPattern(
                    titleText: "共通ベル",
                    leftReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelText(textBody: "🍉")
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
                    )
                )
                unitReelSpacer()
            }
        }
    }
}

#Preview {
    midoriDonTableKoyakuPattern(
//        midoriDon: MidoriDon()
    )
}
