//
//  shamanKingTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct shamanKingTableFirstHit: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "初当り合算",
                denominateList: [288.8,280.0,268.4,248.1,227.6,207.1]
            )
            unitTableDenominate(
                columTitle: "AT初当り",
                denominateList: [573.6,553.2,523.0,461.2,412.8,367.3]
            )
        }
    }
}

#Preview {
    shamanKingTableFirstHit()
}
