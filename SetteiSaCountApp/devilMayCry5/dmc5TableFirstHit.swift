//
//  dmc5TableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/01.
//

import SwiftUI

struct dmc5TableFirstHit: View {
    @ObservedObject var dmc5: Dmc5
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "ボーナス",
                denominateList: dmc5.ratioFirstHitBonus
            )
            unitTableDenominate(
                columTitle: "ST",
                denominateList: dmc5.ratioFirstHitSt
            )
        }
    }
}

#Preview {
    dmc5TableFirstHit(
        dmc5: Dmc5()
    )
}
