//
//  kabaneriTableMumeiNavi.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/09.
//

import SwiftUI

struct kabaneriTableMumeiNavi: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "ナビ発生",
                    percentList: [48.1,48.1,50.3,53.9,56.2,62.8]
                )
            }
            .padding(.bottom)
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "ベルこぼし目")
                HStack(spacing: 15) {
                    unitReelPattern(
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
                            upper: unitReelText(textBody: "🔔", xmarkBool: true),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        )
                    )
                    unitReelPattern(
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
                            upper: unitReelText(textBody: "🔔", xmarkBool: true),
                            middle: unitReelText(textBody: "🔔", xmarkBool: true),
                            lower: unitReelDefault()
                        )
                    )
                }
            }
        }
    }
}

#Preview {
    kabaneriTableMumeiNavi()
}
