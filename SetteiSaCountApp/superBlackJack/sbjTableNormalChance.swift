//
//  sbjTableNormalChance.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/12.
//

import SwiftUI

struct sbjTableNormalChance: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "ボーナス高確移行",
                percentList: [40.1,40.7,41.5,52.1,56.6,59.5],
                titleFont: .body
            )
            unitTablePercent(
                columTitle: "ボーナス直撃",
                percentList: [5.0,5.1,5.2,6.9,7.6,7.8],
                numberofDicimal: 1
            )
        }
    }
}

#Preview {
    sbjTableNormalChance()
}
