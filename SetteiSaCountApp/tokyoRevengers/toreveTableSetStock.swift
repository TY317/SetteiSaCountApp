//
//  toreveTableSetStock.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/27.
//

import SwiftUI

struct toreveTableSetStock: View {
    @ObservedObject var toreve: Toreve
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "なし",
                percentList: toreve.ratioStockNone
            )
            unitTablePercent(
                columTitle: "＋１",
                percentList: toreve.ratioStock1,
                numberofDicimal: 1,
            )
            unitTablePercent(
                columTitle: "＋２",
                percentList: [toreve.ratioStock2[0]],
                numberofDicimal: 1,
                lineList: [6],
                colorList: [.white],
            )
            unitTablePercent(
                columTitle: "＋３",
                percentList: [toreve.ratioStock3[0],toreve.ratioStock3[2],toreve.ratioStock3[4],toreve.ratioStock3[5],],
                numberofDicimal: 1,
                lineList: [2,2,1,1],
//                colorList: [.white],
            )
        }
    }
}

#Preview {
    toreveTableSetStock(
        toreve: Toreve(),
    )
    .padding(.horizontal)
}
