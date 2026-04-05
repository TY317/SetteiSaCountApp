//
//  akudamaTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/05.
//

import SwiftUI

struct akudamaTableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            VStack {
                HStack(spacing: 15) {
                    // 弱チェリー
                    VStack {
                        unitReelPattern(
                            titleText: "悪揃い",
                            leftReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "悪", textColor: .purple),
                                lower: unitReelDefault()
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "悪", textColor: .purple),
                                lower: unitReelDefault()
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "悪", textColor: .purple),
                                lower: unitReelDefault()
                            ),
                        )
                        Text("※ 全ライン有効")
                            .foregroundStyle(Color.secondary)
                    }
                    // 強チェリー
                    VStack {
                        unitReelPattern(
                            titleText: "チャンス目",
                            leftReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "悪", textColor: .purple),
                                lower: unitReelDefault()
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelText(textBody: "悪", textColor: .purple),
                                lower: unitReelDefault()
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelText(textBody: "悪", textColor: .purple),
                                middle: unitReelDefault(),
                                lower: unitReelDefault()
                            ),
                        )
                        Text("※ 全ライン有効")
                            .foregroundStyle(Color.clear)
                    }
                }
            }
            
            // //// 4段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "チャンス目")
                VStack {
                    HStack(spacing: 15) {
                        // チャンス目１
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelBar(),
                                middle: unitReelDefault(),
                                lower: unitReelDefault()
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelBar(),
                                lower: unitReelDefault(),
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelBar(),
                                middle: unitReelDefault(),
                                lower: unitReelDefault(),
                            ),
                        )
                        // チャンス目２
                        unitReelPattern(
                            leftReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelDefault(),
                                lower: unitReelBar()
                            ),
                            centerReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelBar(),
                                lower: unitReelDefault(),
                            ),
                            rightReel: unitReelColumn(
                                upper: unitReelDefault(),
                                middle: unitReelDefault(),
                                lower: unitReelBar()
                            ),
                        )
                    }
                    Text("※ 赤BAR、青BARどちらでも有効")
                        .foregroundStyle(Color.secondary)
                }
            }
        }
    }
}

#Preview {
    akudamaTableKoyakuPattern()
}
