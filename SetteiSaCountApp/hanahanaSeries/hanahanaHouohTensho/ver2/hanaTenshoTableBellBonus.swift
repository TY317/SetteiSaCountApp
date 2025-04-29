//
//  hanaTenshoTableBellBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct hanaTenshoTableBellBonus: View {
//    @ObservedObject var hanaTensho = HanaTensho()
    @ObservedObject var hanaTensho: HanaTensho
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "ベル",
                denominateList: hanaTensho.denominateListBell,
                numberofDicimal: 2
            )
            unitTableDenominate(
                columTitle: "BIG",
                denominateList: hanaTensho.denominateListBig
            )
            unitTableDenominate(
                columTitle: "REG",
                denominateList: hanaTensho.denominateListReg
            )
            unitTableDenominate(
                columTitle: "合算",
                denominateList: hanaTensho.denominateListBonusSum
            )
        }
    }
}

#Preview {
    hanaTenshoTableBellBonus(hanaTensho: HanaTensho())
}
