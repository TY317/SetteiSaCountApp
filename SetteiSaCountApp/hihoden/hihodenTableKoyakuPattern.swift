//
//  hihodenTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/14.
//

import SwiftUI

struct hihodenTableKoyakuPattern: View {
    var body: some View {
        // //// 1段目
        HStack(spacing: 15) {
            // チェリー
            unitReelPattern(
                titleText: "🍒",
                leftReel: unitReelColumn(
                    upper: unitReelText(textBody: "🔔"),
                    middle: unitReelBar(),
                    lower: unitReelText(textBody: "🍒")
                ),
                centerReel: unitReelAny(),
                rightReel: unitReelColumn(
                    upper: unitReelDefault(),
                    middle: unitReelText(textBody: "🔔"),
                    lower: unitReelDefault()
                ),
            )
            // 中段チェリー
            unitReelPattern(
                titleText: "🍒チャンス目",
                leftReel: unitReelColumn(
                    upper: unitReelText(textBody: "🔔"),
                    middle: unitReelBar(),
                    lower: unitReelText(textBody: "🍒")
                ),
                centerReel: unitReelAny(),
                rightReel: unitReelColumn(
                    upper: unitReelDefault(),
                    middle: unitReelText(textBody: "🔔", xmarkBool: true),
                    lower: unitReelDefault()
                ),
            )
        }
        
        // //// 2段目
        VStack(spacing: 7) {
            unitReelLongTitle(titleText: "🍉")
            HStack(spacing: 15) {
                // スイカ１
                unitReelPattern(
                    leftReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🍉"),
                        lower: unitReelDefault(),
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
                // スイカ２
                unitReelPattern(
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelDefault(),
                        lower: unitReelDefault(),
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🍉"),
                        lower: unitReelDefault(),
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "🍉"),
                    ),
                )
            }
        }
        // //// 2段目
        VStack(spacing: 7) {
            unitReelLongTitle(titleText: "チャンス目")
            Text("※ いずれかのリールにピラミッド停止して小役揃いなければチャンス目")
                .font(.caption)
                .padding(.vertical, 2)
                .foregroundStyle(Color.secondary)
            HStack(spacing: 15) {
                // チャンス目１
                unitReelPattern(
                    leftReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelBar(),
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelReplay(),
                        lower: unitReelDefault(),
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelDefault(),
                        lower: unitReelDefault(),
                    ),
                )
                // チャンス目２
                unitReelPattern(
                    leftReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelBar(),
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelText(textBody: "7", textColor: .red),
                        lower: unitReelText(textBody: "🍒"),
                    ),
                    rightReel: unitReelAny(),
                )
            }
            .padding(.bottom, 5)
            HStack(spacing: 15) {
                // チャンス目３
                unitReelPattern(
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelReplay(),
                        lower: unitReelText(textBody: "🔔"),
                    ),
                    centerReel: unitReelHazure(),
                    rightReel: unitReelHazure(),
                )
                // チャンス目４
                unitReelPattern(
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "▲", textColor: .blue),
                        middle: unitReelText(textBody: "🍉"),
                        lower: unitReelReplay(),
                    ),
                    centerReel: unitReelHazure(),
                    rightReel: unitReelHazure(),
                )
            }
        }
        
        // //// 5段目
        VStack(spacing: 7) {
            unitReelLongTitle(titleText: "強チャンス目")
            HStack(spacing: 15) {
                // 強チャンス目１
                unitReelPattern(
                    leftReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "▲", textColor: .blue),
                        lower: unitReelDefault(),
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "▲", textColor: .blue),
                        lower: unitReelDefault(),
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "▲", textColor: .blue),
                        lower: unitReelDefault(),
                    ),
                )
                // スイカ２
                unitReelPattern(
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "▲", textColor: .blue),
                        middle: unitReelDefault(),
                        lower: unitReelDefault(),
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "▲", textColor: .blue),
                        lower: unitReelDefault(),
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "▲", textColor: .blue),
                    ),
                )
            }
        }
    }
}

#Preview {
    ScrollView {
        hihodenTableKoyakuPattern()
    }
}
