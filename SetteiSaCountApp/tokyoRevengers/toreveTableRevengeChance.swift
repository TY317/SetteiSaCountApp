//
//  toreveTableRevengeChance.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/10.
//

import SwiftUI

struct toreveTableRevengeChance: View {
    @ObservedObject var toreve: Toreve
    var body: some View {
        VStack(alignment: .leading) {
            Text("・2,3スルー時のリベンジ発生率に設定差あり")
            Text("・フェイク、ロングフリーズには設定差ないため注意")
            VStack (alignment: .center) {
                Text("[2スルー時]")
                    .font(.title2)
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTablePercent(
                        columTitle: "リベンジなし",
                        percentList: toreve.ratioRevengeChance2RevengeNone,
                        numberofDicimal: 1
                    )
                    unitTablePercent(
                        columTitle: "リベンジあり",
                        percentList: toreve.ratioRevengeChance2RevengeHit,
                        numberofDicimal: 1
                    )
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top)
            VStack (alignment: .center) {
                Text("[3スルー時]")
                    .font(.title2)
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTablePercent(
                        columTitle: "リベンジなし",
                        percentList: toreve.ratioRevengeChance3RevengeNone,
                        numberofDicimal: 1
                    )
                    unitTablePercent(
                        columTitle: "リベンジあり",
                        percentList: toreve.ratioRevengeChance3RevengeHit,
                        numberofDicimal: 1
                    )
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top)
        }
    }
}

#Preview {
    toreveTableRevengeChance(
        toreve: Toreve(),
    )
}
