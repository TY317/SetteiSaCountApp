//
//  kanokariView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct kanokariView95Ci: View {
    @ObservedObject var kanokari: Kanokari
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // 回数
//            unitListSection95Ci(
//                grafTitle: "回数",
//                titleFont: .title2,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $kanokari.otomeAttackHit,
//                        bigNumber: $kanokari.otomeAttackSum,
//                        setting1Percent: kanokari.ratioOtomeAttack[0],
//                        setting2Percent: kanokari.ratioOtomeAttack[1],
//                        setting3Percent: kanokari.ratioOtomeAttack[2],
//                        setting4Percent: kanokari.ratioOtomeAttack[3],
//                        setting5Percent: kanokari.ratioOtomeAttack[4],
//                        setting6Percent: kanokari.ratioOtomeAttack[5]
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
//                        currentCount: $kanokari.firstHitCountCz,
//                        bigNumber: $kanokari.normalGame,
//                        setting1Denominate: kanokari.ratioFirstHitCz[0],
//                        setting2Denominate: kanokari.ratioFirstHitCz[1],
//                        setting3Denominate: kanokari.ratioFirstHitCz[2],
//                        setting4Denominate: kanokari.ratioFirstHitCz[3],
//                        setting5Denominate: kanokari.ratioFirstHitCz[4],
//                        setting6Denominate: kanokari.ratioFirstHitCz[5]
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
//                        currentCount: $kanokari.firstHitCountAt,
//                        bigNumber: $kanokari.normalGame,
//                        setting1Denominate: kanokari.ratioFirstHitAt[0],
//                        setting2Denominate: kanokari.ratioFirstHitAt[1],
//                        setting3Denominate: kanokari.ratioFirstHitAt[2],
//                        setting4Denominate: kanokari.ratioFirstHitAt[3],
//                        setting5Denominate: kanokari.ratioFirstHitAt[4],
//                        setting6Denominate: kanokari.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kanokari.machineName,
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
    kanokariView95Ci(
        kanokari: Kanokari(),
    )
}
