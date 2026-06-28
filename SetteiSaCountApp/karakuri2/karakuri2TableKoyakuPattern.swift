//
//  karakuri2TableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/27.
//

import SwiftUI

struct karakuri2TableKoyakuPattern: View {
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
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "🔔")
                        ),
                    )
                }
            }
            
            // //// 2段目
            VStack {
                HStack(spacing: 15) {
                    // チャンスベル
                    unitReelPattern(
                        titleText: "チャンスベル",
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
                            lower: unitReelText(textBody: "🔔")
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
                    // チャンス目A
                    unitReelPattern(
                        titleText: "チャンス目A",
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
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "🔔")
                        ),
                    )
                    // チャンス目B
                    unitReelPattern(
                        titleText: "チャンス目B",
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
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "🔔")
                        ),
                    )
                }
            }
        }
    }
}

#Preview {
    karakuri2TableKoyakuPattern()
}
