//
//  newKingHanaTableBellBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/21.
//

import SwiftUI

struct newKingHanaTableBellBonus: View {
    @ObservedObject var newKingHana: NewKingHana
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex(settingList: [1,2,3,4,6])
                unitTableDenominate(
                    columTitle: "🔔※",
                    denominateList: newKingHana.ratioBell,
                    numberofDicimal: 2,
                )
                unitTableDenominate(
                    columTitle: "BIG",
                    denominateList: newKingHana.ratioFirstHitBig
                )
                unitTableDenominate(
                    columTitle: "REG",
                    denominateList: newKingHana.ratioFirstHitReg
                )
                unitTableDenominate(
                    columTitle: "合算",
                    denominateList: newKingHana.ratioFirstHitSum
                )
            }
            Text("※ 独自算出値")
                .foregroundStyle(Color.secondary)
        }
    }
}

#Preview {
    newKingHanaTableBellBonus(
        newKingHana: NewKingHana(),
    )
    .padding(.horizontal)
}
