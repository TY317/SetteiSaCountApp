//
//  railgunTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/08.
//

import SwiftUI

struct railgunTableKoyakuPattern: View {
    var body: some View {
        VStack(spacing:20) {
            // //// 1段目
            VStack(alignment: .leading) {
                HStack(spacing: 15) {
                    // チェリー
                    unitReelPattern(
                        titleText: "🍒",
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍒"),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelBar()
                        ),
                        centerReel: unitReelAny(),
                        rightReel: unitReelAny(),
                    )
                    // スイカ
                    unitReelPattern(
                        titleText: "🍉",
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelBar(),
                            lower: unitReelText(textBody: "🔔"),
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault(),
                        ),
                    )
                }
                Text("※ 超電磁砲コイン揃い時を除く")
                    .font(.caption)
                    .foregroundStyle(Color.secondary)
            }
            
            // //// 2段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "超電磁砲コイン(1枚orリプレイ)")
                VStack {
                    HStack(spacing: 15) {
                        // コイン揃い１
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "🪙"),
                                lower: unitReelDefault(),
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "🪙"),
                                lower: unitReelDefault(),
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "🪙"),
                                lower: unitReelDefault(),
                            ),
                        )
                        // コイン揃い１
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelBar(),
                                lower: unitReelDefault(),
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "🪙"),
                                lower: unitReelDefault(),
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "🪙"),
                                lower: unitReelDefault(),
                            ),
                        )
                    }
                    Text("※全ライン有効")
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                }
            }
        }
    }
}

#Preview {
    railgunTableKoyakuPattern()
}
