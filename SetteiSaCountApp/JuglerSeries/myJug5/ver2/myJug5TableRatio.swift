//
//  myJug5TableRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/03.
//

import SwiftUI

struct myJug5TableRatio: View {
    @ObservedObject var myJug5: MyJug5
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "ぶどう",
                denominateList: myJug5.denominateListBell,
                numberofDicimal: 2
            )
            unitTableDenominate(
                columTitle: "BIG",
                denominateList: myJug5.denominateListBigSum
            )
            unitTableDenominate(
                columTitle: "REG",
                denominateList: myJug5.denominateListRegSum
            )
            unitTableDenominate(
                columTitle: "合算",
                denominateList: myJug5.denominateListBonusSum
            )
        }
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "単独REG",
                denominateList: myJug5.denominateListRegAlone
            )
            unitTableDenominate(
                columTitle: "🍒REG",
                denominateList: myJug5.denominateListRegCherry
            )
        }
        .padding(.top)
    }
}

#Preview {
    myJug5TableRatio(
        myJug5: MyJug5()
    )
}
