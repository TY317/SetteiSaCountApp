//
//  arifureTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/31.
//

import SwiftUI

struct arifureTableFirstHit: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "ミュウボーナス",
                denominateList: [523,513,497,471,455,420]
            )
            unitTableDenominate(
                columTitle: "AT",
                denominateList: [395,382,360,323,301,268]
            )
        }
    }
}

#Preview {
    arifureTableFirstHit()
}
