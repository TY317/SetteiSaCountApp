//
//  magiaView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct magiaView95Ci: View {
    @ObservedObject var magia = Magia()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // スイカからのCZ当選回数
            unitListSection95Ci(
                grafTitle: "スイカからのCZ当選回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $magia.suikaCzCountCz,
                        bigNumber: $magia.suikaCzCountSuika,
                        setting1Percent: magia.ratioSuikaCz[0],
                        setting2Percent: magia.ratioSuikaCz[1],
                        setting3Percent: magia.ratioSuikaCz[2],
                        setting4Percent: magia.ratioSuikaCz[3],
                        setting5Percent: magia.ratioSuikaCz[4],
                        setting6Percent: magia.ratioSuikaCz[5]
                    )
                )
            )
            .tag(1)
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $magia.bonusCountSum,
                        bigNumber: $magia.normalPlayGame,
                        setting1Denominate: magia.ratioBonus[0],
                        setting2Denominate: magia.ratioBonus[1],
                        setting3Denominate: magia.ratioBonus[2],
                        setting4Denominate: magia.ratioBonus[3],
                        setting5Denominate: magia.ratioBonus[4],
                        setting6Denominate: magia.ratioBonus[5]
                    )
                )
            )
            .tag(2)
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $magia.atCount,
                        bigNumber: $magia.normalPlayGame,
                        setting1Denominate: magia.ratioAt[0],
                        setting2Denominate: magia.ratioAt[1],
                        setting3Denominate: magia.ratioAt[2],
                        setting4Denominate: magia.ratioAt[3],
                        setting5Denominate: magia.ratioAt[4],
                        setting6Denominate: magia.ratioAt[5]
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
    magiaView95Ci()
}
