//
//  dmc5View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/01.
//

import SwiftUI

struct dmc5View95Ci: View {
    @ObservedObject var dmc5: Dmc5
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // ボーナス初当り回数
            unitListSection95Ci(
                grafTitle: "ボーナス初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $dmc5.bonusCount,
                        bigNumber: $dmc5.normalGame,
                        setting1Denominate: dmc5.ratioFirstHitBonus[0],
                        setting2Denominate: dmc5.ratioFirstHitBonus[1],
                        setting3Denominate: dmc5.ratioFirstHitBonus[2],
                        setting4Denominate: dmc5.ratioFirstHitBonus[3],
                        setting5Denominate: dmc5.ratioFirstHitBonus[4],
                        setting6Denominate: dmc5.ratioFirstHitBonus[5]
                    )
                )
            )
            .tag(1)
            // ST初当り回数
            unitListSection95Ci(
                grafTitle: "ST初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $dmc5.stCount,
                        bigNumber: $dmc5.normalGame,
                        setting1Denominate: dmc5.ratioFirstHitSt[0],
                        setting2Denominate: dmc5.ratioFirstHitSt[1],
                        setting3Denominate: dmc5.ratioFirstHitSt[2],
                        setting4Denominate: dmc5.ratioFirstHitSt[3],
                        setting5Denominate: dmc5.ratioFirstHitSt[4],
                        setting6Denominate: dmc5.ratioFirstHitSt[5]
                    )
                )
            )
            .tag(2)
            // ブラッディバトル当選回数
            unitListSection95Ci(
                grafTitle: "シングルチャンス目\nブラッディバトル当選回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $dmc5.dmcBonusCountBattle,
                        bigNumber: $dmc5.dmcBonusCountChance,
                        setting1Percent: dmc5.ratioDmcBonusChanceBattle[0],
                        setting2Percent: dmc5.ratioDmcBonusChanceBattle[1],
                        setting3Percent: dmc5.ratioDmcBonusChanceBattle[2],
                        setting4Percent: dmc5.ratioDmcBonusChanceBattle[3],
                        setting5Percent: dmc5.ratioDmcBonusChanceBattle[4],
                        setting6Percent: dmc5.ratioDmcBonusChanceBattle[5]
                    )
                )
            )
            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: dmc5.machineName,
                screenClass: screenClass
            )
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
    dmc5View95Ci(
        dmc5: Dmc5()
    )
}
