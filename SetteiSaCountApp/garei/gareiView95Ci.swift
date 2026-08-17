//
//  gareiView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct gareiView95Ci: View {
    @ObservedObject var garei: Garei
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
//                        currentCount: $garei.otomeAttackHit,
//                        bigNumber: $garei.otomeAttackSum,
//                        setting1Percent: garei.ratioOtomeAttack[0],
//                        setting2Percent: garei.ratioOtomeAttack[1],
//                        setting3Percent: garei.ratioOtomeAttack[2],
//                        setting4Percent: garei.ratioOtomeAttack[3],
//                        setting5Percent: garei.ratioOtomeAttack[4],
//                        setting6Percent: garei.ratioOtomeAttack[5]
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
//                        currentCount: $garei.firstHitCountCz,
//                        bigNumber: $garei.normalGame,
//                        setting1Denominate: garei.ratioFirstHitCz[0],
//                        setting2Denominate: garei.ratioFirstHitCz[1],
//                        setting3Denominate: garei.ratioFirstHitCz[2],
//                        setting4Denominate: garei.ratioFirstHitCz[3],
//                        setting5Denominate: garei.ratioFirstHitCz[4],
//                        setting6Denominate: garei.ratioFirstHitCz[5]
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
//                        currentCount: $garei.firstHitCountAt,
//                        bigNumber: $garei.normalGame,
//                        setting1Denominate: garei.ratioFirstHitAt[0],
//                        setting2Denominate: garei.ratioFirstHitAt[1],
//                        setting3Denominate: garei.ratioFirstHitAt[2],
//                        setting4Denominate: garei.ratioFirstHitAt[3],
//                        setting5Denominate: garei.ratioFirstHitAt[4],
//                        setting6Denominate: garei.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: garei.machineName,
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
    gareiView95Ci(
        garei: Garei(),
    )
}
