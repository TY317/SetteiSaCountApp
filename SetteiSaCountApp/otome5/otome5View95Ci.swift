//
//  otome5View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/02.
//

import SwiftUI

struct otome5View95Ci: View {
    @ObservedObject var otome5: Otome5
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // 乙女アタック当選回数
            unitListSection95Ci(
                grafTitle: "乙女アタック当選回数",
//                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $otome5.otomeAttackHit,
                        bigNumber: $otome5.otomeAttackSum,
                        setting1Percent: otome5.ratioOtomeAttack[0],
                        setting2Percent: otome5.ratioOtomeAttack[1],
                        setting3Percent: otome5.ratioOtomeAttack[2],
                        setting4Percent: otome5.ratioOtomeAttack[3],
                        setting5Percent: otome5.ratioOtomeAttack[4],
                        setting6Percent: otome5.ratioOtomeAttack[5]
                    )
                )
            )
            .tag(1)
            
//            // 低確強チェリーからのCZ当選回数
//            unitListSection95Ci(
//                grafTitle: "低確 強🍒\nCZ当選回数",
//                titleFont: .title2,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $otome5.kyoCherryCountCzHit,
//                        bigNumber: $otome5.kyoCherryCount,
//                        setting1Percent: otome5.ratioKyoCherryCz[0],
//                        setting2Percent: otome5.ratioKyoCherryCz[1],
//                        setting3Percent: otome5.ratioKyoCherryCz[2],
//                        setting4Percent: otome5.ratioKyoCherryCz[3],
//                        setting5Percent: otome5.ratioKyoCherryCz[4],
//                        setting6Percent: otome5.ratioKyoCherryCz[5]
//                    )
//                )
//            )
//            .tag(2)
//            
//            // 高確　強チェリーからのCZ当選回数
//            unitListSection95Ci(
//                grafTitle: "高確 強🍒\nCZ当選回数",
//                titleFont: .title2,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $otome5.highKyoCherryCountCzHit,
//                        bigNumber: $otome5.highKyoCherryCount,
//                        setting1Percent: otome5.ratioHighKyoCherryCz[0],
//                        setting2Percent: otome5.ratioHighKyoCherryCz[1],
//                        setting3Percent: otome5.ratioHighKyoCherryCz[2],
//                        setting4Percent: otome5.ratioHighKyoCherryCz[3],
//                        setting5Percent: otome5.ratioHighKyoCherryCz[4],
//                        setting6Percent: otome5.ratioHighKyoCherryCz[5]
//                    )
//                )
//            )
//            .tag(3)
//
//            // 天井短縮回数
//            unitListSection95Ci(
//                grafTitle: "天井短縮回数",
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $otome5.tenjoCountHit,
//                        bigNumber: $otome5.tenjoCountSum,
//                        setting1Percent: otome5.ratioTenjoCut[0],
//                        setting2Percent: otome5.ratioTenjoCut[1],
//                        setting3Percent: otome5.ratioTenjoCut[2],
//                        setting4Percent: otome5.ratioTenjoCut[3],
//                        setting5Percent: otome5.ratioTenjoCut[4],
//                        setting6Percent: otome5.ratioTenjoCut[5]
//                    )
//                )
//            )
//            .tag(5)
//
//            // CZ初当り回数
//            unitListSection95Ci(
//                grafTitle: "CZ初当り回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $otome5.firstHitCountCz,
//                        bigNumber: $otome5.normalGame,
//                        setting1Denominate: otome5.ratioFirstHitCz[0],
//                        setting2Denominate: otome5.ratioFirstHitCz[1],
//                        setting3Denominate: otome5.ratioFirstHitCz[2],
//                        setting4Denominate: otome5.ratioFirstHitCz[3],
//                        setting5Denominate: otome5.ratioFirstHitCz[4],
//                        setting6Denominate: otome5.ratioFirstHitCz[5]
//                    )
//                )
//            )
//            .tag(1)
            
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $otome5.firstHitCountAt,
                        bigNumber: $otome5.normalGame,
                        setting1Denominate: otome5.ratioFirstHitAt[0],
                        setting2Denominate: otome5.ratioFirstHitAt[1],
                        setting3Denominate: otome5.ratioFirstHitAt[2],
                        setting4Denominate: otome5.ratioFirstHitAt[3],
                        setting5Denominate: otome5.ratioFirstHitAt[4],
                        setting6Denominate: otome5.ratioFirstHitAt[5]
                    )
                )
            )
            .tag(2)
            
            // 直撃ボーナス初当り回数
            unitListSection95Ci(
                grafTitle: "直撃ボーナス初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $otome5.firstHitCountDirect,
                        bigNumber: $otome5.normalGame,
                        setting1Denominate: otome5.ratioFirstHitDirect[0],
                        setting2Denominate: otome5.ratioFirstHitDirect[1],
                        setting3Denominate: otome5.ratioFirstHitDirect[2],
                        setting4Denominate: otome5.ratioFirstHitDirect[3],
                        setting5Denominate: otome5.ratioFirstHitDirect[4],
                        setting6Denominate: otome5.ratioFirstHitDirect[5]
                    )
                )
            )
            .tag(3)
            
            // Z-ZONE昇格回数
//            unitListSection95Ci(
//                grafTitle: "Z-ZONE昇格回数",
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $otome5.riseZzoneCount,
//                        bigNumber: $otome5.firstHitCountAt,
//                        setting1Percent: otome5.ratioRiseZzone[0],
//                        setting2Percent: otome5.ratioRiseZzone[1],
//                        setting3Percent: otome5.ratioRiseZzone[2],
//                        setting4Percent: otome5.ratioRiseZzone[3],
//                        setting5Percent: otome5.ratioRiseZzone[4],
//                        setting6Percent: otome5.ratioRiseZzone[5]
//                    )
//                )
//            )
//            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: otome5.machineName,
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
    otome5View95Ci(
        otome5: Otome5(),
    )
}
