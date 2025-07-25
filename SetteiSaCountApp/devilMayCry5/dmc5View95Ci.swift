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
            // CZ当選周期　1周期目での当選回数
            unitListSection95Ci(
                grafTitle: "CZ当選周期\n1周期目での当選回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $dmc5.czCycleCountHit1,
                        bigNumber: $dmc5.czHitCountAll,
                        setting1Percent: dmc5.ratioCzCycleUpTo1[0],
                        setting2Percent: dmc5.ratioCzCycleUpTo1[1],
                        setting3Percent: dmc5.ratioCzCycleUpTo1[2],
                        setting4Percent: dmc5.ratioCzCycleUpTo1[3],
                        setting5Percent: dmc5.ratioCzCycleUpTo1[4],
                        setting6Percent: dmc5.ratioCzCycleUpTo1[5]
                    )
                )
            )
            .tag(4)
            // CZ当選周期　4周期目での当選回数
            unitListSection95Ci(
                grafTitle: "CZ当選周期\n4周期までの当選回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $dmc5.czHitCountUpTo4,
                        bigNumber: $dmc5.czHitCountAll,
                        setting1Percent: dmc5.ratioCzCycleUpTo4[0],
                        setting2Percent: dmc5.ratioCzCycleUpTo4[1],
                        setting3Percent: dmc5.ratioCzCycleUpTo4[2],
                        setting4Percent: dmc5.ratioCzCycleUpTo4[3],
                        setting5Percent: dmc5.ratioCzCycleUpTo4[4],
                        setting6Percent: dmc5.ratioCzCycleUpTo4[5]
                    )
                )
            )
            .tag(5)
            // CZ当選周期　7周期目までの当選回数
            unitListSection95Ci(
                grafTitle: "CZ当選周期\n7周期まででの当選回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $dmc5.czHitCountUpTo7,
                        bigNumber: $dmc5.czHitCountAll,
                        setting1Percent: dmc5.ratioCzCycleUpTo7[0],
                        setting2Percent: dmc5.ratioCzCycleUpTo7[1],
                        setting3Percent: dmc5.ratioCzCycleUpTo7[2],
                        setting4Percent: dmc5.ratioCzCycleUpTo7[3],
                        setting5Percent: dmc5.ratioCzCycleUpTo7[4],
                        setting6Percent: dmc5.ratioCzCycleUpTo7[5]
                    )
                )
            )
            .tag(6)
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
            // ST エンブレム種別
            unitListSection95Ci(
                grafTitle: "ST開始時 エンブレム\n赤 回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $dmc5.stEmblemCountRed,
                        bigNumber: $dmc5.stEmblemCountColorSum,
                        setting1Percent: dmc5.ratioStEmblemRed[0],
                        setting2Percent: dmc5.ratioStEmblemRed[1],
                        setting3Percent: dmc5.ratioStEmblemRed[2],
                        setting4Percent: dmc5.ratioStEmblemRed[3],
                        setting5Percent: dmc5.ratioStEmblemRed[4],
                        setting6Percent: dmc5.ratioStEmblemRed[5]
                    )
                )
            )
            .tag(9)
            // 上位ST エンブレム2個点灯回数
            unitListSection95Ci(
                grafTitle: "上位ST中 エンブレム\n2個点灯回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $dmc5.premiumStEmblemCount2,
                        bigNumber: $dmc5.premiumStEmblemCountSum,
                        setting1Percent: dmc5.ratioEmblem2[0],
                        setting2Percent: dmc5.ratioEmblem2[1],
                        setting3Percent: dmc5.ratioEmblem2[2],
                        setting4Percent: dmc5.ratioEmblem2[3],
                        setting5Percent: dmc5.ratioEmblem2[4],
                        setting6Percent: dmc5.ratioEmblem2[5]
                    )
                )
            )
            .tag(7)
            // 上位ST エンブレム種別
            unitListSection95Ci(
                grafTitle: "上位ST開始時 エンブレム\n赤 回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $dmc5.premiumStEmblemCountRed,
                        bigNumber: $dmc5.premiumStEmblemCountColorSum,
                        setting1Percent: dmc5.ratioPremiumEmblemRed[0],
                        setting2Percent: dmc5.ratioPremiumEmblemRed[1],
                        setting3Percent: dmc5.ratioPremiumEmblemRed[2],
                        setting4Percent: dmc5.ratioPremiumEmblemRed[3],
                        setting5Percent: dmc5.ratioPremiumEmblemRed[4],
                        setting6Percent: dmc5.ratioPremiumEmblemRed[5]
                    )
                )
            )
            .tag(8)
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
//                    .popoverTip(tipUnitButton95CiExplain())
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
