//
//  midoriDonTableJakuRareRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/04.
//

import SwiftUI

struct midoriDonTableJakuRareRatio: View {
    @ObservedObject var midoriDon: MidoriDon
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "弱🍒",
                denominateList: midoriDon.ratioJakuCherry,
                numberofDicimal: 0
            )
            unitTableDenominate(
                columTitle: "弱🍉",
                denominateList: midoriDon.ratioJakuSuika,
                numberofDicimal: 0
            )
            unitTableDenominate(
                columTitle: "合算",
                denominateList: midoriDon.ratioJakuSum,
                numberofDicimal: 1
            )
        }
    }
}

#Preview {
    midoriDonTableJakuRareRatio(
        midoriDon: MidoriDon()
    )
    .padding(.horizontal)
}
