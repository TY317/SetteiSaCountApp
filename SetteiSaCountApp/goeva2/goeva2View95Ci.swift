//
//  goeva2View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct goeva2View95Ci: View {
    @ObservedObject var goeva2: Goeva2
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // スイカ成立時のCZ当選率
            unitListSection95Ci(
                grafTitle: "🍉からのCZ当選率",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $goeva2.suikaCzCount,
                        bigNumber: $goeva2.suikaCount,
                        setting1Percent: goeva2.ratioSuikaCz[0],
                        setting2Percent: goeva2.ratioSuikaCz[1],
                        setting3Percent: goeva2.ratioSuikaCz[2],
                        setting4Percent: goeva2.ratioSuikaCz[3],
                        setting5Percent: goeva2.ratioSuikaCz[4],
                        setting6Percent: goeva2.ratioSuikaCz[5]
                    )
                )
            )
            .tag(1)

            // 通常 弱レア系からのボーナス当選率
            unitListSection95Ci(
                grafTitle: "通常 弱レア系→ボーナス",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $goeva2.bonusNormalWeakCountHit,
                        bigNumber: $goeva2.bonusNormalWeakCount,
                        setting1Percent: goeva2.ratioBonusNormalWeak[0],
                        setting2Percent: goeva2.ratioBonusNormalWeak[1],
                        setting3Percent: goeva2.ratioBonusNormalWeak[2],
                        setting4Percent: goeva2.ratioBonusNormalWeak[3],
                        setting5Percent: goeva2.ratioBonusNormalWeak[4],
                        setting6Percent: goeva2.ratioBonusNormalWeak[5]
                    )
                )
            )
            .tag(2)

            // 通常 強レア系①からのボーナス当選率
            unitListSection95Ci(
                grafTitle: "通常 強レア系①→ボーナス",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $goeva2.bonusNormalStrong1CountHit,
                        bigNumber: $goeva2.bonusNormalStrong1Count,
                        setting1Percent: goeva2.ratioBonusNormalStrong1[0],
                        setting2Percent: goeva2.ratioBonusNormalStrong1[1],
                        setting3Percent: goeva2.ratioBonusNormalStrong1[2],
                        setting4Percent: goeva2.ratioBonusNormalStrong1[3],
                        setting5Percent: goeva2.ratioBonusNormalStrong1[4],
                        setting6Percent: goeva2.ratioBonusNormalStrong1[5]
                    )
                )
            )
            .tag(3)

            // 通常 強レア系②からのボーナス当選率
            unitListSection95Ci(
                grafTitle: "通常 強レア系②→ボーナス",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $goeva2.bonusNormalStrong2CountHit,
                        bigNumber: $goeva2.bonusNormalStrong2Count,
                        setting1Percent: goeva2.ratioBonusNormalStrong2[0],
                        setting2Percent: goeva2.ratioBonusNormalStrong2[1],
                        setting3Percent: goeva2.ratioBonusNormalStrong2[2],
                        setting4Percent: goeva2.ratioBonusNormalStrong2[3],
                        setting5Percent: goeva2.ratioBonusNormalStrong2[4],
                        setting6Percent: goeva2.ratioBonusNormalStrong2[5]
                    )
                )
            )
            .tag(4)

            // 高確 弱レア系からのボーナス当選率
            unitListSection95Ci(
                grafTitle: "高確 弱レア系→ボーナス",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $goeva2.bonusHighWeakCountHit,
                        bigNumber: $goeva2.bonusHighWeakCount,
                        setting1Percent: goeva2.ratioBonusHighWeak[0],
                        setting2Percent: goeva2.ratioBonusHighWeak[1],
                        setting3Percent: goeva2.ratioBonusHighWeak[2],
                        setting4Percent: goeva2.ratioBonusHighWeak[3],
                        setting5Percent: goeva2.ratioBonusHighWeak[4],
                        setting6Percent: goeva2.ratioBonusHighWeak[5]
                    )
                )
            )
            .tag(5)

            // 高確 強レア系①からのボーナス当選率
            unitListSection95Ci(
                grafTitle: "高確 強レア系①→ボーナス",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $goeva2.bonusHighStrong1CountHit,
                        bigNumber: $goeva2.bonusHighStrong1Count,
                        setting1Percent: goeva2.ratioBonusHighStrong1[0],
                        setting2Percent: goeva2.ratioBonusHighStrong1[1],
                        setting3Percent: goeva2.ratioBonusHighStrong1[2],
                        setting4Percent: goeva2.ratioBonusHighStrong1[3],
                        setting5Percent: goeva2.ratioBonusHighStrong1[4],
                        setting6Percent: goeva2.ratioBonusHighStrong1[5]
                    )
                )
            )
            .tag(6)

            // 高確 強レア系②からのボーナス当選率
            unitListSection95Ci(
                grafTitle: "高確 強レア系②→ボーナス",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $goeva2.bonusHighStrong2CountHit,
                        bigNumber: $goeva2.bonusHighStrong2Count,
                        setting1Percent: goeva2.ratioBonusHighStrong2[0],
                        setting2Percent: goeva2.ratioBonusHighStrong2[1],
                        setting3Percent: goeva2.ratioBonusHighStrong2[2],
                        setting4Percent: goeva2.ratioBonusHighStrong2[3],
                        setting5Percent: goeva2.ratioBonusHighStrong2[4],
                        setting6Percent: goeva2.ratioBonusHighStrong2[5]
                    )
                )
            )
            .tag(7)

            // 超高確 弱レア系からのボーナス当選率
            unitListSection95Ci(
                grafTitle: "超高確 弱レア系→ボーナス",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $goeva2.bonusSuperWeakCountHit,
                        bigNumber: $goeva2.bonusSuperWeakCount,
                        setting1Percent: goeva2.ratioBonusSuperWeak[0],
                        setting2Percent: goeva2.ratioBonusSuperWeak[1],
                        setting3Percent: goeva2.ratioBonusSuperWeak[2],
                        setting4Percent: goeva2.ratioBonusSuperWeak[3],
                        setting5Percent: goeva2.ratioBonusSuperWeak[4],
                        setting6Percent: goeva2.ratioBonusSuperWeak[5]
                    )
                )
            )
            .tag(8)

            // ボーナス初当り確率
            unitListSection95Ci(
                grafTitle: "ボーナス初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $goeva2.activeFirstHitCountBonus,
                        bigNumber: $goeva2.activeNormalGame,
                        setting1Denominate: goeva2.ratioFirstHitBonus[0],
                        setting2Denominate: goeva2.ratioFirstHitBonus[1],
                        setting3Denominate: goeva2.ratioFirstHitBonus[2],
                        setting4Denominate: goeva2.ratioFirstHitBonus[3],
                        setting5Denominate: goeva2.ratioFirstHitBonus[4],
                        setting6Denominate: goeva2.ratioFirstHitBonus[5]
                    )
                )
            )
            .tag(9)

            // AT初当り確率
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $goeva2.activeFirstHitCountAt,
                        bigNumber: $goeva2.activeNormalGame,
                        setting1Denominate: goeva2.ratioFirstHitAt[0],
                        setting2Denominate: goeva2.ratioFirstHitAt[1],
                        setting3Denominate: goeva2.ratioFirstHitAt[2],
                        setting4Denominate: goeva2.ratioFirstHitAt[3],
                        setting5Denominate: goeva2.ratioFirstHitAt[4],
                        setting6Denominate: goeva2.ratioFirstHitAt[5]
                    )
                )
            )
            .tag(10)

            // 月蝕変異の発生率
            unitListSection95Ci(
                grafTitle: "月蝕変異回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $goeva2.activeGesshokuCount,
                        bigNumber: $goeva2.activeNormalGame,
                        setting1Denominate: goeva2.ratioGesshoku[0],
                        setting2Denominate: goeva2.ratioGesshoku[1],
                        setting3Denominate: goeva2.ratioGesshoku[2],
                        setting4Denominate: goeva2.ratioGesshoku[3],
                        setting5Denominate: goeva2.ratioGesshoku[4],
                        setting6Denominate: goeva2.ratioGesshoku[5]
                    )
                )
            )
            .tag(11)

            // 回数
//            unitListSection95Ci(
//                grafTitle: "回数",
//                titleFont: .title2,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $goeva2.otomeAttackHit,
//                        bigNumber: $goeva2.otomeAttackSum,
//                        setting1Percent: goeva2.ratioOtomeAttack[0],
//                        setting2Percent: goeva2.ratioOtomeAttack[1],
//                        setting3Percent: goeva2.ratioOtomeAttack[2],
//                        setting4Percent: goeva2.ratioOtomeAttack[3],
//                        setting5Percent: goeva2.ratioOtomeAttack[4],
//                        setting6Percent: goeva2.ratioOtomeAttack[5]
//                    )
//                )
//            )
//            .tag(1)
//
//            // CZ初当り回数
//            unitListSection95Ci(
//                grafTitle: "CZ初当り回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $goeva2.firstHitCountCz,
//                        bigNumber: $goeva2.normalGame,
//                        setting1Denominate: goeva2.ratioFirstHitCz[0],
//                        setting2Denominate: goeva2.ratioFirstHitCz[1],
//                        setting3Denominate: goeva2.ratioFirstHitCz[2],
//                        setting4Denominate: goeva2.ratioFirstHitCz[3],
//                        setting5Denominate: goeva2.ratioFirstHitCz[4],
//                        setting6Denominate: goeva2.ratioFirstHitCz[5]
//                    )
//                )
//            )
//            .tag(2)
//
//            // AT初当り回数
//            unitListSection95Ci(
//                grafTitle: "AT初当り回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $goeva2.firstHitCountAt,
//                        bigNumber: $goeva2.normalGame,
//                        setting1Denominate: goeva2.ratioFirstHitAt[0],
//                        setting2Denominate: goeva2.ratioFirstHitAt[1],
//                        setting3Denominate: goeva2.ratioFirstHitAt[2],
//                        setting4Denominate: goeva2.ratioFirstHitAt[3],
//                        setting5Denominate: goeva2.ratioFirstHitAt[4],
//                        setting6Denominate: goeva2.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: goeva2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("95%信頼区間グラフ")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButton95CiExplain(isShow95CiExplain: isShow95CiExplain)
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    goeva2View95Ci(
        goeva2: Goeva2(),
    )
}
