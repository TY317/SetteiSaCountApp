//
//  mt5Table5Coin.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/22.
//

import SwiftUI

struct mt5Table5Coin: View {
    var body: some View {
        VStack(spacing: 7) {
            HStack(spacing: 0) {
                unitTableSettingIndex(settingList: [1,2,4,5,6])
                unitTableDenominate(
                    columTitle: "5枚役",
                    denominateList: [38,36,30,24,22]
                )
            }
            .padding(.bottom)
            unitReelLongTitle(titleText: "5枚役")
            HStack(spacing: 15) {
                unitReelPattern(
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
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelDefault()
                    )
                )
                unitReelPattern(
                    leftReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelReplay(),
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
            HStack(spacing: 15) {
                unitReelPattern(
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
                        middle: unitReelText(textBody: "🍉"),
                        lower: unitReelDefault()
                    )
                )
                unitReelSpacer()
            }
            .offset(y:-15)
        }
    }
}

#Preview {
    mt5Table5Coin()
}
