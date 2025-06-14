//
//  guiltyCrown2TableBellPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/07.
//

import SwiftUI

struct guiltyCrown2TableBellPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            HStack(spacing: 15) {
                // 1枚ベル
                unitReelPattern(
                    titleText: "1枚ベル",
                    leftReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "🔔")
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "🔔")
                    )
                )
                // 共通ベル
                unitReelPattern(
                    titleText: "共通ベル",
                    leftReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "🔔")
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "🔔")
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "🔔")
                    )
                )
            }
            // //// 2段目
            HStack(spacing: 15) {
                // 15枚ベル
                unitReelPattern(
                    titleText: "15枚ベル",
                    leftReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "🔔")
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelText(textBody: "🔔"),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelDefault()
                    )
                )
                // 強ベル
                unitReelPattern(
                    titleText: "強ベル",
                    leftReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelDefault()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelDefault()
                    )
                )
            }
        }
    }
}

#Preview {
    guiltyCrown2TableBellPattern()
}
