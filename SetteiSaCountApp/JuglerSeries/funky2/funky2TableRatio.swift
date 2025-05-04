//
//  funky2TableRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/27.
//

import SwiftUI

struct funky2TableRatio: View {
//    @ObservedObject var funky2 = Funky2()
    @ObservedObject var funky2: Funky2
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "ぶどう",
                    denominateList: funky2.denominateListBell,
                    numberofDicimal: 2
                )
                unitTableDenominate(
                    columTitle: "BIG",
                    denominateList: funky2.denominateListBigSum
                )
                unitTableDenominate(
                    columTitle: "REG",
                    denominateList: funky2.denominateListRegSum
                )
                unitTableDenominate(
                    columTitle: "合算",
                    denominateList: funky2.denominateListBonusSum
                )
            }
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "単独BIG",
                    denominateList: funky2.denominateListBigAlone,
                    titleFont: .body
                )
                unitTableDenominate(
                    columTitle: "🍒BIG",
                    denominateList: funky2.denominateListBigCherry,
                    titleFont: .body
                )
                unitTableDenominate(
                    columTitle: "単独REG",
                    denominateList: funky2.denominateListRegAlone,
                    titleFont: .body
                )
                unitTableDenominate(
                    columTitle: "🍒REG",
                    denominateList: funky2.denominateListRegCherry,
                    titleFont: .body
                )
            }
            .padding(.top)
        }
    }
}

#Preview {
    funky2TableRatio(funky2: Funky2())
}
