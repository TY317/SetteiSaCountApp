//
//  midoriDonTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/04.
//

import SwiftUI

struct midoriDonTableFirstHit: View {
    @ObservedObject var midoriDon: MidoriDon
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "ボーナス",
                denominateList: midoriDon.ratioFirstHitBonus
            )
            unitTableDenominate(
                columTitle: "AT",
                denominateList: midoriDon.ratioFirstHitAt
            )
        }
    }
}

#Preview {
    midoriDonTableFirstHit(
        midoriDon: MidoriDon()
    )
}
