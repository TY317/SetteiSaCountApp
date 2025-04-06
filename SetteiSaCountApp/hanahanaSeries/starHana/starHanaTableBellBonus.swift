//
//  starHanaTableBellBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/05.
//

import SwiftUI

struct starHanaTableBellBonus: View {
    @ObservedObject var starHana = StarHana()
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "ベル※",
                    denominateList: starHana.denominateListBell,
                    numberofDicimal: 2
                )
                unitTableDenominate(
                    columTitle: "BIG",
                    denominateList: starHana.denominateListBig
                )
                unitTableDenominate(
                    columTitle: "REG",
                    denominateList: starHana.denominateListReg
                )
                unitTableDenominate(
                    columTitle: "合算",
                    denominateList: starHana.denominateListBonusSum
                )
            }
            Text("※ 独自算出値です。ご理解の上参考ください")
                .foregroundStyle(Color.secondary
                )
        }
    }
}

#Preview {
    starHanaTableBellBonus()
}
