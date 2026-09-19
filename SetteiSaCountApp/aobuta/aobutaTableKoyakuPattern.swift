//
//  aobutaTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct aobutaTableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            VStack(spacing: 7) {
                HStack(spacing: 15) {
                    // チェリー
                    unitReelPattern(
                        titleText: "チェリー",
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍒"),
                            middle: unitReelText(textBody: "↕︎"),
                            lower: unitReelText(textBody: "🍒")
                        ),
                        centerReel: unitReelAny(),
                        rightReel: unitReelAny(),
                    )
                    // スイカ
                    unitReelPattern(
                        titleText: "スイカ",
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
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
                        ),
                    )
                }
                Text("※チェリーは左リール上段・下段のどちらかに停止")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
            }

            // //// 2段目
            VStack {
                HStack(spacing: 15) {
                    // チャンス目A
                    unitReelPattern(
                        titleText: "チャンス目A",
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelReplay(),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelReplay(),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelDefault()
                        ),
                    )
                    // チャンス目B
                    unitReelPattern(
                        titleText: "チャンス目B",
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "🍉")
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

            // //// 3段目（観測目）
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "観測目")
                VStack {
                    HStack(spacing: 15) {
                        // 観測目１（セリフ枠揃い）
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelBar(),
                                lower: unitReelDefault()
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelBar(),
                                lower: unitReelDefault()
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelBar(),
                                lower: unitReelDefault()
                            ),
                        )
                        // 観測目２（右リールにキャラ図柄＋🍒）
                        unitReelPattern(
                            leftReel: unitReelAny(),
                            centerReel: unitReelAny(),
                            rightReel: unitReelColumn(
                                upper: unitReelText(textBody: "7", textColor: .gray),
                                middle: unitReelText(textBody: "🍒"),
                                lower: unitReelText(textBody: "7", textColor: .blue)
                            ),
                        )
                    }
                }
                VStack {
                    HStack(spacing: 15) {
                        // 観測目３
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelReplay(),
                                middle: unitReelText(textBody: "🍉"),
                                lower: unitReelText(textBody: "🍒")
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelReplay(),
                                lower: unitReelDefault()
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelDefault(),
                                lower: unitReelReplay()
                            ),
                        )
                        unitReelSpacer()
                    }
                    Text("※観測目は確定役扱い")
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                }
            }
        }
    }
}

#Preview {
    aobutaTableKoyakuPattern()
}
