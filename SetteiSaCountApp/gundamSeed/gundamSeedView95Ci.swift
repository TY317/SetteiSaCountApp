//
//  gundamSeedView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/10.
//

import SwiftUI

struct gundamSeedView95Ci: View {
    @ObservedObject var gundamSeed: GundamSeed
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // CZ回数
            unitListSection95Ci(
                grafTitle: "CZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $gundamSeed.czCount,
                        bigNumber: $gundamSeed.playGameSum,
                        setting1Denominate: gundamSeed.ratioCz[0],
                        setting2Denominate: gundamSeed.ratioCz[1],
                        setting3Denominate: gundamSeed.ratioCz[2],
                        setting4Denominate: gundamSeed.ratioCz[3],
                        setting5Denominate: gundamSeed.ratioCz[4],
                        setting6Denominate: gundamSeed.ratioCz[5]
                    )
                )
            )
            .tag(1)
            // AT回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $gundamSeed.atCount,
                        bigNumber: $gundamSeed.playGameSum,
                        setting1Denominate: gundamSeed.ratioAt[0],
                        setting2Denominate: gundamSeed.ratioAt[1],
                        setting3Denominate: gundamSeed.ratioAt[2],
                        setting4Denominate: gundamSeed.ratioAt[3],
                        setting5Denominate: gundamSeed.ratioAt[4],
                        setting6Denominate: gundamSeed.ratioAt[5]
                    )
                )
            )
            .tag(2)
            // 99G以内の当選回数
            unitListSection95Ci(
                grafTitle: "99G以内の当選回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $gundamSeed.under100CountSum,
                        bigNumber: $gundamSeed.underOver100CountSum,
                        setting1Percent: gundamSeed.ratio0to99[0],
                        setting2Percent: gundamSeed.ratio0to99[1],
                        setting3Percent: gundamSeed.ratio0to99[2],
                        setting4Percent: gundamSeed.ratio0to99[3],
                        setting5Percent: gundamSeed.ratio0to99[4],
                        setting6Percent: gundamSeed.ratio0to99[5]
                    )
                )
            )
            .tag(3)
        }
        .navigationTitle("95%信頼区間グラフ")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButton95CiExplain(isShow95CiExplain: isShow95CiExplain)
                    .popoverTip(tipUnitButton95CiExplain())
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    gundamSeedView95Ci(
        gundamSeed: GundamSeed()
    )
}
