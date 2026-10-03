//
//  kanokariTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//
//  ※これは代表的なレア役停止形の雛形。実機に合わせて図柄/役を編集すること。
//  使えるパーツ：unitReelPattern / unitReelColumn / unitReelAny / unitReelHazure /
//  unitReelSpacer / unitReelLongTitle / unitReelReplay(xmarkBool:) / unitReelBar /
//  unitReelText(textBody:) / unitReelDefault

import SwiftUI

struct kanokariTableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            VStack {
                HStack(spacing: 15) {
                    // 弱チャンス目
                    unitReelPattern(
                        titleText: "弱チャンス目",
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "♥️"),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🩷"),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "♥️"),
                            lower: unitReelDefault()
                        ),
                    )
                    // チャンス目
                    unitReelPattern(
                        titleText: "チャンス目",
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "♥️"),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "♥️"),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "♥️"),
                            lower: unitReelDefault()
                        ),
                    )
                }
            }

            // //// 2段目
            VStack {
                HStack(spacing: 15) {
                    // 強チャンス目
                    unitReelPattern(
                        titleText: "強チャンス目",
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelBar(),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🩷"),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelBar(),
                            lower: unitReelDefault()
                        ),
                    )
                    // ガチ恋目
                    unitReelPattern(
                        titleText: "ガチ恋目",
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelBar(),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "♥️"),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelBar(),
                            lower: unitReelDefault()
                        ),
                    )
                }
            }

            // //// 3段目
            VStack {
                HStack(spacing: 15) {
                    // 最強目
                    unitReelPattern(
                        titleText: "最強目",
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelBar(),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "7", textColor: .red),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelBar(),
                            lower: unitReelDefault()
                        ),
                    )
                    unitReelSpacer()
                }
            }
            Text("※ 左リールBAR：和也図柄、右リールBAR：千鶴図柄")
                .font(.caption)
                .foregroundStyle(Color.secondary)
        }
    }
}

#Preview {
    kanokariTableKoyakuPattern()
        .padding(.horizontal)
}
