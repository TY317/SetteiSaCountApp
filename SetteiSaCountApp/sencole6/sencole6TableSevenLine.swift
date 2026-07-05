//
//  sencole6TableSevenLine.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/07/02.
//

import SwiftUI

struct sencole6TableSevenLine: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("数字の4or7の形の停止形で揃えば特定設定以上濃厚")
            HStack(spacing: 15) {
                // 4以上濃厚
                unitReelPattern(
                    titleText: "設定4 以上濃厚",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "7", textColor: .red),
                        middle: unitReelText(textBody: "7", textColor: .red),
                        lower: unitReelDefault()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "7", textColor: .red),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelText(textBody: "7", textColor: .red),
                        middle: unitReelText(textBody: "7", textColor: .red),
                        lower: unitReelText(textBody: "7", textColor: .red),
                    ),
                )
                // 6濃厚
                unitReelPattern(
                    titleText: "設定6 濃厚",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "7", textColor: .red),
                        middle: unitReelText(textBody: "7", textColor: .red),
                        lower: unitReelDefault()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelText(textBody: "7", textColor: .red),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelText(textBody: "7", textColor: .red),
                        middle: unitReelText(textBody: "7", textColor: .red),
                        lower: unitReelText(textBody: "7", textColor: .red),
                    ),
                )
            }
        }
    }
}

#Preview {
    sencole6TableSevenLine()
}
