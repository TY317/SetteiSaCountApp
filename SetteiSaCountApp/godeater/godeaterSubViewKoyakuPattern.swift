//
//  godeaterSubViewKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/03.
//

import SwiftUI

struct godeaterSubViewKoyakuPattern: View {
    let komaWidth: CGFloat = 60
    let komaHeight: CGFloat = 40
    var body: some View {
        VStack (spacing: 20) {
            HStack(spacing: 15) {
                // 弱チェリー
                unitReelPattern(
                    titleText: "弱チェリー",
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
                    )
                )
                // 強チェリー
                unitReelPattern(
                    titleText: "強チェリー",
                    leftReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelBar(),
                        lower: unitReelText(textBody: "🍒")
                    ),
                    centerReel: unitReelAny(),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "7", textColor: .red),
                        lower: unitReelDefault()
                    )
                )
            }
            HStack(spacing: 15) {
                // 神チェリー
                unitReelPattern(
                    titleText: "神チェリー",
                    leftReel: unitReelColumn(
                        upper: unitReelBar(),
                        middle: unitReelText(textBody: "🍒"),
                        lower: unitReelText(textBody: "🍉")
                    ),
                    centerReel: unitReelAny(),
                    rightReel: unitReelAny()
                )
                // スイカ
                unitReelPattern(
                    titleText: "スイカ",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
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
                    )
                )
            }
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
                        upper: unitReelText(textBody: "🔔"),
                        middle: unitReelText(textBody: "🍉"),
                        lower: unitReelText(textBody: "🔔")
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelReplay(),
                        lower: unitReelText(textBody: "🔔")
                    )
                )
                // チャンス目B
                unitReelPattern(
                    titleText: "チャンス目B",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
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
                    )
                )
            }
        }
    }
}

#Preview {
    godeaterSubViewKoyakuPattern()
        .padding(.horizontal)
}
