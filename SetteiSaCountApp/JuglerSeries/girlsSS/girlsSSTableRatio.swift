//
//  girlsSSTableRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/27.
//

import SwiftUI

struct girlsSSTableRatio: View {
//    @ObservedObject var girlsSS = GirlsSS()
    @ObservedObject var girlsSS: GirlsSS
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "ぶどう",
                    denominateList: girlsSS.denominateListBell,
                    numberofDicimal: 2
                )
                unitTableDenominate(
                    columTitle: "BIG",
                    denominateList: girlsSS.denominateListBigSum
                )
                unitTableDenominate(
                    columTitle: "REG",
                    denominateList: girlsSS.denominateListRegSum
                )
                unitTableDenominate(
                    columTitle: "合算",
                    denominateList: girlsSS.denominateListBonusSum
                )
            }
            Text("[5号機数値からの予測値]")
                .font(.title2)
                .padding(.top)
            Text("※独自の予測です。参考程度に")
                .foregroundStyle(Color.secondary)
                .font(.caption)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "単独REG",
                    denominateList: girlsSS.denominateListRegAlone
                )
                unitTableDenominate(
                    columTitle: "🍒REG",
                    denominateList: girlsSS.denominateListRegCherry
                )
            }
        }
    }
}

#Preview {
    girlsSSTableRatio(girlsSS: GirlsSS())
}
