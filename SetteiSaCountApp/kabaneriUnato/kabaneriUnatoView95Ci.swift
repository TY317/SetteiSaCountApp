//
//  kabaneriUnatoView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/02.
//

import SwiftUI

struct kabaneriUnatoView95Ci: View {
    @ObservedObject var kabaneriUnato: KabaneriUnato
    @State var selection = 1
    @State var isShow95CiExplain = false
    var body: some View {
        TabView(selection: self.$selection) {
//            // 300or500G到達時のCZ当選回数
//            unitListSection95Ci(
//                grafTitle: "300・500G到達時\nCZ当選回数",
//                titleFont: .title2,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $kabaneriUnato.game35HitCountHit,
//                        bigNumber: $kabaneriUnato.game35HitCountSum,
//                        setting1Percent: kabaneriUnato.ratio35Hit[0],
//                        setting2Percent: kabaneriUnato.ratio35Hit[1],
//                        setting3Percent: kabaneriUnato.ratio35Hit[2],
//                        setting4Percent: kabaneriUnato.ratio35Hit[3],
//                        setting5Percent: kabaneriUnato.ratio35Hit[4],
//                        setting6Percent: kabaneriUnato.ratio35Hit[5]
//                    )
//                )
//            )
//            .tag(2)
//            
//            // 規定兜pt 20pt以下回数
//            unitListSection95Ci(
//                grafTitle: "規定兜pt\n20pt以下回数",
//                titleFont: .title2,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $kabaneriUnato.ptCountU20,
//                        bigNumber: $kabaneriUnato.ptCountSum,
//                        setting1Percent: kabaneriUnato.ratioPtU20[0],
//                        setting2Percent: kabaneriUnato.ratioPtU20[1],
//                        setting3Percent: kabaneriUnato.ratioPtU20[2],
//                        setting4Percent: kabaneriUnato.ratioPtU20[3],
//                        setting5Percent: kabaneriUnato.ratioPtU20[4],
//                        setting6Percent: kabaneriUnato.ratioPtU20[5]
//                    )
//                )
//            )
//            .tag(3)
//            
            // CZ初当り回数
            unitListSection95Ci(
                grafTitle: "下段ベル回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kabaneriUnato.koyakuCountLowerBell,
                        bigNumber: $kabaneriUnato.normalGame,
                        setting1Denominate: kabaneriUnato.ratioLowerBell[0],
                        setting2Denominate: kabaneriUnato.ratioLowerBell[1],
                        setting3Denominate: kabaneriUnato.ratioLowerBell[2],
                        setting4Denominate: kabaneriUnato.ratioLowerBell[3],
                        setting5Denominate: kabaneriUnato.ratioLowerBell[4],
                        setting6Denominate: kabaneriUnato.ratioLowerBell[5]
                    )
                )
            )
            .tag(1)
//            // AT初当り回数
//            unitListSection95Ci(
//                grafTitle: "AT初当り回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $kabaneriUnato.atCount,
//                        bigNumber: $kabaneriUnato.normalGame,
//                        setting1Denominate: kabaneriUnato.ratioFirstHitAt[0],
//                        setting2Denominate: kabaneriUnato.ratioFirstHitAt[1],
//                        setting3Denominate: kabaneriUnato.ratioFirstHitAt[2],
//                        setting4Denominate: kabaneriUnato.ratioFirstHitAt[3],
//                        setting5Denominate: kabaneriUnato.ratioFirstHitAt[4],
//                        setting6Denominate: kabaneriUnato.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(5)
//
//            // 引き戻し成功ストック回数
//            unitListSection95Ci(
//                grafTitle: "REBOOTCHANCE\n成功ストック回数",
//                titleFont: .title2,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $kabaneriUnato.rebootCountSuccess,
//                        bigNumber: $kabaneriUnato.rebootCountSum,
//                        setting1Percent: kabaneriUnato.ratioReboot[0],
//                        setting2Percent: kabaneriUnato.ratioReboot[1],
//                        setting3Percent: kabaneriUnato.ratioReboot[2],
//                        setting4Percent: kabaneriUnato.ratioReboot[3],
//                        setting5Percent: kabaneriUnato.ratioReboot[4],
//                        setting6Percent: kabaneriUnato.ratioReboot[5]
//                    )
//                )
//            )
//            .tag(2)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kabaneriUnato.machineName,
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
    kabaneriUnatoView95Ci(
        kabaneriUnato: KabaneriUnato(),
    )
}
