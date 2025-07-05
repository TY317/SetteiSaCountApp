//
//  symphoTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/15.
//

import SwiftUI

struct symphoTableFirstHit: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex(
                    settingList: [1,2,4,5,6]
                )
                unitTableDenominate(
                    columTitle: "AT",
                    denominateList: [295,285,250,227,199]
                )
                unitTableDenominate(
                    columTitle: "CZ 最終決戦",
                    denominateList: [13000,10900,4600,2900,2500]
                )
            }
            .padding(.bottom)
            HStack(spacing: 0) {
                unitTableSettingIndex(
                    settingList: [1,2,4,5,6]
                )
                unitTablePercent(
                    columTitle: "高確中 🍒でのAT当選",
                    percentList: [4,6,11,17,21],
                    maxWidth: 200,
                )
            }
        }
    }
}

#Preview {
    symphoTableFirstHit()
}
