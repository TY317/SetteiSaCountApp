//
//  juoTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//
//  ※これは代表的なレア役停止形の雛形。実機に合わせて図柄/役を編集すること。
//  使えるパーツ：unitReelPattern / unitReelColumn / unitReelAny / unitReelHazure /
//  unitReelSpacer / unitReelLongTitle / unitReelReplay(xmarkBool:) / unitReelBar /
//  unitReelText(textBody:) / unitReelDefault

import SwiftUI

struct juoTableKoyakuPattern: View {
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
                    // 中段チェリー
                    unitReelPattern(
                        titleText: "中段チェリー",
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍒"),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelAny(),
                        rightReel: unitReelAny(),
                    )
                }
                Text("※チェリーは赤・青どちらでも有効")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
            }

            // //// 2段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "チャンス目")
                HStack(spacing: 15) {
                    // チャンス目１（斜めチェリー）
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍒"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍒"),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "🍒")
                        ),
                    )
                    // チャンス目２（左 🦉/🌳/7 ＋ 中 中・下段チェリー非停止）
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🦉"),
                            middle: unitReelText(textBody: "🌳"),
                            lower: unitReelText(textBody: "7", textColor: .red)
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍒", xmarkBool: true),
                            lower: unitReelText(textBody: "🍒", xmarkBool: true)
                        ),
                        rightReel: unitReelAny(),
                    )
                }
                Text("※チェリーは赤・青どちらでも有効")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
            }
        }
    }
}

#Preview {
    juoTableKoyakuPattern()
}
