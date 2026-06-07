//
//  sao2View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/30.
//

import SwiftUI

struct sao2View95Ci: View {
    @ObservedObject var sao2: Sao2
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // 低確スイカからのシューティングチャージ当選回数
            unitListSection95Ci(
                grafTitle: "低確 🍉\nシューティングチャージ当選回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $sao2.lowSuikaCountShootingHit,
                        bigNumber: $sao2.lowSuikaCount,
                        setting1Percent: sao2.ratioLowSuikaShooting[0],
                        setting2Percent: sao2.ratioLowSuikaShooting[1],
                        setting3Percent: sao2.ratioLowSuikaShooting[2],
                        setting4Percent: sao2.ratioLowSuikaShooting[3],
                        setting5Percent: sao2.ratioLowSuikaShooting[4],
                        setting6Percent: sao2.ratioLowSuikaShooting[5]
                    )
                )
            )
            .tag(1)
            
            // 低確強チェリーからのCZ当選回数
            unitListSection95Ci(
                grafTitle: "低確 強🍒\nCZ当選回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $sao2.kyoCherryCountCzHit,
                        bigNumber: $sao2.kyoCherryCount,
                        setting1Percent: sao2.ratioKyoCherryCz[0],
                        setting2Percent: sao2.ratioKyoCherryCz[1],
                        setting3Percent: sao2.ratioKyoCherryCz[2],
                        setting4Percent: sao2.ratioKyoCherryCz[3],
                        setting5Percent: sao2.ratioKyoCherryCz[4],
                        setting6Percent: sao2.ratioKyoCherryCz[5]
                    )
                )
            )
            .tag(2)
            
            // 高確　強チェリーからのCZ当選回数
            unitListSection95Ci(
                grafTitle: "高確 強🍒\nCZ当選回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $sao2.highKyoCherryCountCzHit,
                        bigNumber: $sao2.highKyoCherryCount,
                        setting1Percent: sao2.ratioHighKyoCherryCz[0],
                        setting2Percent: sao2.ratioHighKyoCherryCz[1],
                        setting3Percent: sao2.ratioHighKyoCherryCz[2],
                        setting4Percent: sao2.ratioHighKyoCherryCz[3],
                        setting5Percent: sao2.ratioHighKyoCherryCz[4],
                        setting6Percent: sao2.ratioHighKyoCherryCz[5]
                    )
                )
            )
            .tag(3)

            // CZ失敗時のアイテム獲得回数
            unitListSection95Ci(
                grafTitle: "CZ失敗時\nアイテム獲得回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $sao2.czItemCountHit,
                        bigNumber: $sao2.czItemCountSum,
                        setting1Percent: sao2.ratioCzItemGet[0],
                        setting2Percent: sao2.ratioCzItemGet[1],
                        setting3Percent: sao2.ratioCzItemGet[2],
                        setting4Percent: sao2.ratioCzItemGet[3],
                        setting5Percent: sao2.ratioCzItemGet[4],
                        setting6Percent: sao2.ratioCzItemGet[5]
                    )
                )
            )
            .tag(4)

            // CZ失敗時の決闘突入回数
            unitListSection95Ci(
                grafTitle: "CZ失敗時\n曠野の決闘 突入回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $sao2.czKettouCountHit,
                        bigNumber: $sao2.czKettouCountSum,
                        setting1Percent: sao2.ratioCzKettouGet[0],
                        setting2Percent: sao2.ratioCzKettouGet[1],
                        setting3Percent: sao2.ratioCzKettouGet[2],
                        setting4Percent: sao2.ratioCzKettouGet[3],
                        setting5Percent: sao2.ratioCzKettouGet[4],
                        setting6Percent: sao2.ratioCzKettouGet[5]
                    )
                )
            )
            .tag(5)
            // CZ初当り回数
            unitListSection95Ci(
                grafTitle: "CZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $sao2.firstHitCountCz,
                        bigNumber: $sao2.normalGame,
                        setting1Denominate: sao2.ratioFirstHitCz[0],
                        setting2Denominate: sao2.ratioFirstHitCz[1],
                        setting3Denominate: sao2.ratioFirstHitCz[2],
                        setting4Denominate: sao2.ratioFirstHitCz[3],
                        setting5Denominate: sao2.ratioFirstHitCz[4],
                        setting6Denominate: sao2.ratioFirstHitCz[5]
                    )
                )
            )
            .tag(6)
            
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $sao2.firstHitCountAt,
                        bigNumber: $sao2.normalGame,
                        setting1Denominate: sao2.ratioFirstHitAt[0],
                        setting2Denominate: sao2.ratioFirstHitAt[1],
                        setting3Denominate: sao2.ratioFirstHitAt[2],
                        setting4Denominate: sao2.ratioFirstHitAt[3],
                        setting5Denominate: sao2.ratioFirstHitAt[4],
                        setting6Denominate: sao2.ratioFirstHitAt[5]
                    )
                )
            )
            .tag(7)
            
//            // 炎炎ループ初当り回数
//            unitListSection95Ci(
//                grafTitle: "炎炎ループ初当り回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $sao2.firstHitCountLoop,
//                        bigNumber: $sao2.normalGame,
//                        setting1Denominate: sao2.ratioFirstHitLoop[0],
//                        setting2Denominate: sao2.ratioFirstHitLoop[1],
//                        setting3Denominate: sao2.ratioFirstHitLoop[2],
//                        setting4Denominate: sao2.ratioFirstHitLoop[3],
//                        setting5Denominate: sao2.ratioFirstHitLoop[4],
//                        setting6Denominate: sao2.ratioFirstHitLoop[5]
//                    )
//                )
//            )
//            .tag(2)
//
//
            // Z-ZONE昇格回数
//            unitListSection95Ci(
//                grafTitle: "Z-ZONE昇格回数",
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $sao2.riseZzoneCount,
//                        bigNumber: $sao2.firstHitCountAt,
//                        setting1Percent: sao2.ratioRiseZzone[0],
//                        setting2Percent: sao2.ratioRiseZzone[1],
//                        setting3Percent: sao2.ratioRiseZzone[2],
//                        setting4Percent: sao2.ratioRiseZzone[3],
//                        setting5Percent: sao2.ratioRiseZzone[4],
//                        setting6Percent: sao2.ratioRiseZzone[5]
//                    )
//                )
//            )
//            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: sao2.machineName,
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
    sao2View95Ci(
        sao2: Sao2(),
    )
}
