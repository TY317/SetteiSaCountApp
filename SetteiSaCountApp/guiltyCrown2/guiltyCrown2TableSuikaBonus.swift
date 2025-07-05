//
//  guiltyCrown2TableSuikaBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/28.
//

import SwiftUI

struct guiltyCrown2TableSuikaBonus: View {
    @ObservedObject var guiltyCrown2: GuiltyCrown2
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "弱🍉",
                percentList: guiltyCrown2.ratioSuikaBonusJaku,
                numberofDicimal: 1,
            )
            unitTablePercent(
                columTitle: "強🍉",
                percentList: guiltyCrown2.ratioSuikaBonusKyo,
                numberofDicimal: 0,
            )
        }
    }
}

#Preview {
    guiltyCrown2TableSuikaBonus(
        guiltyCrown2: GuiltyCrown2(),
    )
}
