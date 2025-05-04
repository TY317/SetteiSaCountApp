//
//  goJugTableRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/27.
//

import SwiftUI

struct goJugTableRatio: View {
//    @ObservedObject var goJug3 = GoJug3()
    @ObservedObject var goJug3: GoJug3
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "ぶどう",
                denominateList: goJug3.denominateListBell,
                numberofDicimal: 2
            )
            unitTableDenominate(
                columTitle: "BIG",
                denominateList: goJug3.denominateListBigSum
            )
            unitTableDenominate(
                columTitle: "REG",
                denominateList: goJug3.denominateListRegSum
            )
            unitTableDenominate(
                columTitle: "合算",
                denominateList: goJug3.denominateListBonusSum
            )
        }
    }
}

#Preview {
    goJugTableRatio(goJug3: GoJug3())
}
