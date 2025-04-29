//
//  kingHanaTableBellBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct kingHanaTableBellBonus: View {
//    @ObservedObject var kingHana = KingHana()
    @ObservedObject var kingHana: KingHana
    
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "ベル",
                denominateList: kingHana.denominateListBell,
                numberofDicimal: 2
            )
            unitTableDenominate(
                columTitle: "BIG",
                denominateList: kingHana.denominateListBig
            )
            unitTableDenominate(
                columTitle: "REG",
                denominateList: kingHana.denominateListReg
            )
            unitTableDenominate(
                columTitle: "合算",
                denominateList: kingHana.denominateListBonusSum
            )
        }
    }
}

#Preview {
    kingHanaTableBellBonus(kingHana: KingHana())
}
