//
//  tekken6TableRareDirect.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/31.
//

import SwiftUI

struct tekken6TableRareDirect: View {
    @ObservedObject var tekken6: Tekken6
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(titleLine: 2)
            unitTablePercent(
                columTitle: "弱🍒・🍉\nチャンス目",
                percentList: [tekken6.ratioRareDirectJaku[0],tekken6.ratioRareDirectJaku[3]],
                numberofDicimal: 1,
                titleLine: 2,
                lineList: [3,3],
            )
            unitTablePercent(
                columTitle: "強🍒",
                percentList: [tekken6.ratioRareDirectKyo[0],tekken6.ratioRareDirectKyo[3]],
                numberofDicimal: 1,
                titleLine: 2,
                lineList: [3,3],
            )
        }
    }
}

#Preview {
    tekken6TableRareDirect(
        tekken6: Tekken6(),
    )
}
