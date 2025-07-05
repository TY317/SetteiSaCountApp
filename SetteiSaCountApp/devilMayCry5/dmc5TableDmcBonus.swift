//
//  dmc5TableDmcBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/28.
//

import SwiftUI

struct dmc5TableDmcBonus: View {
    @ObservedObject var dmc5: Dmc5
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "シングルチャンス目",
                percentList: [
                    dmc5.ratioDmcBonusChanceBattle[0],
                    dmc5.ratioDmcBonusChanceBattle[2],
                    dmc5.ratioDmcBonusChanceBattle[4],
                ],
                maxWidth: 200,
                lineList: [2,2,2]
            )
            unitTablePercent(
                columTitle: "その他",
                percentList: [
                    dmc5.ratioDmcBonusAnyBattle[0],
                    dmc5.ratioDmcBonusAnyBattle[2],
                    dmc5.ratioDmcBonusAnyBattle[4],
                ],
                numberofDicimal: 1,
                maxWidth: 100,
                lineList: [2,2,2],
            )
        }
    }
}

#Preview {
    dmc5TableDmcBonus(
        dmc5: Dmc5(),
    )
}
