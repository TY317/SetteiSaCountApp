//
//  godKisekiKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/18.
//

import SwiftUI

struct godKisekiKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            VStack {
                HStack(spacing: 15) {
                    // 下段黄7A
                    unitReelPattern(
                        titleText: "下段黄7 A",
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "7", textColor: .yellow)
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelText(textBody: "7", textColor: .yellow),
                            middle: unitReelText(textBody: "7", textColor: .blue),
                            lower: unitReelText(textBody: "7", textColor: .yellow)
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "7", textColor: .yellow)
                        ),
                    )
                    // 下段黄7B
                    unitReelPattern(
                        titleText: "下段黄7 B",
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "7", textColor: .yellow)
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelText(textBody: "GOD", textFont: .body),
                            middle: unitReelText(textBody: "7", textColor: .red),
                            lower: unitReelText(textBody: "7", textColor: .yellow)
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "7", textColor: .yellow)
                        ),
                    )
                }
            }
            
            // //// 2段目
            VStack {
                HStack(spacing: 15) {
                    // 右上がり黄7
                    unitReelPattern(
                        titleText: "右上がり黄7",
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "7", textColor: .yellow)
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "7", textColor: .yellow),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "7", textColor: .yellow),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                    )
                    // 中段黄7
                    unitReelPattern(
                        titleText: "中段黄7",
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "7", textColor: .yellow),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "7", textColor: .yellow),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "7", textColor: .yellow),
                            lower: unitReelDefault()
                        ),
                    )
                }
            }
            
            // //// 3段目
            VStack {
                HStack(spacing: 15) {
                    // ガイアベル
                    unitReelPattern(
                        titleText: "ガイアベル",
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "7", textColor: .yellow),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelText(textBody: "7", textColor: .blue),
                            middle: unitReelText(textBody: "7", textColor: .yellow),
                            lower: unitReelText(textBody: "GOD", textFont: .body)
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "7", textColor: .yellow),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                    )
                    // 中段青7
                    unitReelPattern(
                        titleText: "中段青7",
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "7", textColor: .blue),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "7", textColor: .blue),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "7", textColor: .blue),
                            lower: unitReelDefault()
                        ),
                    )
                }
            }
        }
    }
}

#Preview {
    godKisekiKoyakuPattern()
}
