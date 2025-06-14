//
//  guiltyCrown2TableReplayPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/07.
//

import SwiftUI

struct guiltyCrown2TableReplayPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            HStack(spacing: 15) {
                // 斜めリプレイ
                unitReelPattern(
                    titleText: "斜めリプレイ",
                    leftReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
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
                    )
                )
                // 斜めリプレイ
                unitReelPattern(
                    titleText: "平行リプレイ",
                    leftReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
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
            }
            // //// 2段目
            HStack(spacing: 15) {
                // 弱チャンスプレイ
                unitReelPattern(
                    titleText: "弱チャンスリプレイ",
                    titleFont: .body,
                    leftReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelReplay(),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
                    )
                )
                // 強チャンスリプレイ
                unitReelPattern(
                    titleText: "強チャンスリプレイ",
                    titleFont: .body,
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
                        middle: unitReelDefault(),
                        lower: unitReelReplay()
                    )
                )
            }
            // //// 3段目
            HStack(spacing: 15) {
                // 赤７揃い
                unitReelPattern(
                    titleText: "赤7揃い",
                    leftReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "7",textColor: .red),
                        lower: unitReelDefault()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "7",textColor: .red),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "7",textColor: .red),
                        lower: unitReelDefault()
                    )
                )
                // 赤７フェイク
                unitReelPattern(
                    titleText: "赤7フェイク",
                    leftReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "7",textColor: .red),
                        lower: unitReelDefault()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "7",textColor: .red),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "7",textColor: .red)
                    )
                )
            }
        }
    }
}

#Preview {
    guiltyCrown2TableReplayPattern()
}
