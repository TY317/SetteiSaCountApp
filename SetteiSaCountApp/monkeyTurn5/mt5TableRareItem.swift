//
//  mt5TableRareItem.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/24.
//

import SwiftUI

struct mt5TableRareItem: View {
    @ObservedObject var mt5: Mt5
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(settingList: [1,2,4,5,6])
            unitTablePercent(
                columTitle: "弱🍒・🍉",
                percentList: mt5.ratioRareItemJakuCherrySuika
            )
            unitTablePercent(
                columTitle: "弱チャンス目",
                percentList: mt5.ratioRareItemJakuChance
            )
            unitTablePercent(
                columTitle: "強チャンス目",
                percentList: mt5.ratioRareItemKyoChance
            )
            unitTablePercent(
                columTitle: "強🍒",
                percentList: [100],
                lineList: [5],
                colorList: [.white],
            )
        }
    }
}

#Preview {
    mt5TableRareItem(
        mt5: Mt5(),
    )
}
