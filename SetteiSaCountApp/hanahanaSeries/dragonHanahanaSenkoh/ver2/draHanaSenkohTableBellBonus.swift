//
//  draHanaSenkohTableBellBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/05.
//

import SwiftUI

struct draHanaSenkohTableBellBonus: View {
//    @ObservedObject var draHanaSenkoh = DraHanaSenkoh()
    @ObservedObject var draHanaSenkoh: DraHanaSenkoh
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "ベル",
                    denominateList: draHanaSenkoh.denominateListBell,
                    numberofDicimal: 2
                )
                unitTableDenominate(
                    columTitle: "BIG",
                    denominateList: draHanaSenkoh.denominateListBig
                )
                unitTableDenominate(
                    columTitle: "REG",
                    denominateList: draHanaSenkoh.denominateListReg
                )
                unitTableDenominate(
                    columTitle: "合算",
                    denominateList: draHanaSenkoh.denominateListBonusSum
                )
            }
//            Text("※ 独自算出値です。ご理解の上参考ください")
//                .foregroundStyle(Color.secondary
//                )
        }
    }
}

#Preview {
    draHanaSenkohTableBellBonus(draHanaSenkoh: DraHanaSenkoh())
}
