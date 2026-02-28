//
//  gobsla2View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/25.
//

import SwiftUI

struct gobsla2View95Ci: View {
    @ObservedObject var gobsla2: Gobsla2
    @State var selection = 1
    @State var isShow95CiExplain = false
    var body: some View {
        TabView(selection: self.$selection) {
            // 弱レア役からのCZ当選回数
            unitListSection95Ci(
                grafTitle: "弱レア役からのCZ当選回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $gobsla2.jakuRareCountHit,
                        bigNumber: $gobsla2.jakuRareCountSum,
                        setting1Percent: gobsla2.ratioJakuRareCZ[0],
                        setting2Percent: gobsla2.ratioJakuRareCZ[1],
                        setting3Percent: gobsla2.ratioJakuRareCZ[2],
                        setting4Percent: gobsla2.ratioJakuRareCZ[3],
                        setting5Percent: gobsla2.ratioJakuRareCZ[4],
                        setting6Percent: gobsla2.ratioJakuRareCZ[5]
                    )
                )
            )
            .tag(1)
            
            // 300or500G到達時のCZ当選回数
            unitListSection95Ci(
                grafTitle: "300・500G到達時\nCZ当選回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $gobsla2.game35HitCountHit,
                        bigNumber: $gobsla2.game35HitCountSum,
                        setting1Percent: gobsla2.ratio35Hit[0],
                        setting2Percent: gobsla2.ratio35Hit[1],
                        setting3Percent: gobsla2.ratio35Hit[2],
                        setting4Percent: gobsla2.ratio35Hit[3],
                        setting5Percent: gobsla2.ratio35Hit[4],
                        setting6Percent: gobsla2.ratio35Hit[5]
                    )
                )
            )
            .tag(2)
            
            // 規定兜pt 20pt以下回数
            unitListSection95Ci(
                grafTitle: "規定兜pt\n20pt以下回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $gobsla2.ptCountU20,
                        bigNumber: $gobsla2.ptCountSum,
                        setting1Percent: gobsla2.ratioPtU20[0],
                        setting2Percent: gobsla2.ratioPtU20[1],
                        setting3Percent: gobsla2.ratioPtU20[2],
                        setting4Percent: gobsla2.ratioPtU20[3],
                        setting5Percent: gobsla2.ratioPtU20[4],
                        setting6Percent: gobsla2.ratioPtU20[5]
                    )
                )
            )
            .tag(3)
            
            // CZ初当り回数
            unitListSection95Ci(
                grafTitle: "CZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $gobsla2.czCount,
                        bigNumber: $gobsla2.normalGame,
                        setting1Denominate: gobsla2.ratioFirstHitCz[0],
                        setting2Denominate: gobsla2.ratioFirstHitCz[1],
                        setting3Denominate: gobsla2.ratioFirstHitCz[2],
                        setting4Denominate: gobsla2.ratioFirstHitCz[3],
                        setting5Denominate: gobsla2.ratioFirstHitCz[4],
                        setting6Denominate: gobsla2.ratioFirstHitCz[5]
                    )
                )
            )
            .tag(4)
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $gobsla2.atCount,
                        bigNumber: $gobsla2.normalGame,
                        setting1Denominate: gobsla2.ratioFirstHitAt[0],
                        setting2Denominate: gobsla2.ratioFirstHitAt[1],
                        setting3Denominate: gobsla2.ratioFirstHitAt[2],
                        setting4Denominate: gobsla2.ratioFirstHitAt[3],
                        setting5Denominate: gobsla2.ratioFirstHitAt[4],
                        setting6Denominate: gobsla2.ratioFirstHitAt[5]
                    )
                )
            )
            .tag(5)
//
//            // 引き戻し成功ストック回数
//            unitListSection95Ci(
//                grafTitle: "REBOOTCHANCE\n成功ストック回数",
//                titleFont: .title2,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $gobsla2.rebootCountSuccess,
//                        bigNumber: $gobsla2.rebootCountSum,
//                        setting1Percent: gobsla2.ratioReboot[0],
//                        setting2Percent: gobsla2.ratioReboot[1],
//                        setting3Percent: gobsla2.ratioReboot[2],
//                        setting4Percent: gobsla2.ratioReboot[3],
//                        setting5Percent: gobsla2.ratioReboot[4],
//                        setting6Percent: gobsla2.ratioReboot[5]
//                    )
//                )
//            )
//            .tag(2)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: gobsla2.machineName,
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
    gobsla2View95Ci(
        gobsla2: Gobsla2(),
    )
}
