//
//  vvv2TableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/05.
//

import SwiftUI

struct vvv2TableKoyakuPattern: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("・基本的にレア役はルーンのみ")
                Text("・1個ルーンが弱レア、2個ルーン・🍒ルーンが強レア、3個ルーンが超強レア")
            }
            .padding(.bottom)
            Text("🟢：ルーン")
            VStack(spacing: 20) {
                // //// 1段目
                VStack(spacing: 7) {
                    unitReelLongTitle(titleText: "1個ルーン")
                    HStack(spacing: 15) {
                        // 1個ルーン１
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelText(textBody: "🟢"),
                                middle: unitReelDefault(),
                                lower: unitReelDefault(),
                            ),
                            centerReel: unitReelHazure(),
                            rightReel: unitReelHazure(),
                        )
                        // 1個ルーン２
                        unitReelPattern(
                            leftReel: unitReelHazure(),
                            centerReel: unitReelHazure(),
                            rightReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelDefault(),
                                lower: unitReelText(textBody: "🟢"),
                            )
                        )
                    }
                }
                // //// 2段目
                HStack(spacing: 15) {
                    // 1個ルーン
                    unitReelPattern(
                        titleText: "1個ルーン(2枚役)",
                        leftReel: unitReelHazure(),
                        centerReel: unitReelHazure(),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🟢"),
                            lower: unitReelDefault()
                        ),
                    )
                    // 🍒ルーン
                    unitReelPattern(
                        titleText: "🍒ルーン",
                        leftReel: unitReelColumn(
                            upper: unitReelReplay(),
                            middle: unitReelBar(),
                            lower: unitReelText(textBody: "🍒"),
                        ),
                        centerReel: unitReelAny(),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "🟢")
                        ),
                    )
                }
                // //// 3段目
                VStack(spacing: 7) {
                    unitReelLongTitle(titleText: "2個ルーン")
                    HStack(spacing: 15) {
                        // 2個ルーン１
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelText(textBody: "🟢"),
                                middle: unitReelDefault(),
                                lower: unitReelDefault(),
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "🟢"),
                                lower: unitReelDefault()
                            ),
                            rightReel: unitReelHazure(),
                        )
                        // 2個ルーン２
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelText(textBody: "🟢"),
                                middle: unitReelDefault(),
                                lower: unitReelDefault(),
                            ),
                            centerReel: unitReelHazure(),
                            rightReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelDefault(),
                                lower: unitReelText(textBody: "🟢")
                            ),
                        )
                    }
                }
                
                // //// 4段目
                HStack(spacing: 15) {
                    // 3個ルーン
                    unitReelPattern(
                        titleText: "3個ルーン",
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🟢"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🟢"),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "🟢")
                        ),
                    )
                    unitReelSpacer()
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        vvv2TableKoyakuPattern()
    }
        .padding(.horizontal)
}
