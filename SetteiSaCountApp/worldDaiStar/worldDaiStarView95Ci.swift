//
//  worldDaiStarView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct worldDaiStarView95Ci: View {
    @ObservedObject var worldDaiStar: WorldDaiStar
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
//                        currentCount: $worldDaiStar.otomeAttackHit,
//                        bigNumber: $worldDaiStar.otomeAttackSum,
//                        setting1Percent: worldDaiStar.ratioOtomeAttack[0],
//                        setting2Percent: worldDaiStar.ratioOtomeAttack[1],
//                        setting3Percent: worldDaiStar.ratioOtomeAttack[2],
//                        setting4Percent: worldDaiStar.ratioOtomeAttack[3],
//                        setting5Percent: worldDaiStar.ratioOtomeAttack[4],
//                        setting6Percent: worldDaiStar.ratioOtomeAttack[5]
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
//                        currentCount: $worldDaiStar.firstHitCountCz,
//                        bigNumber: $worldDaiStar.normalGame,
//                        setting1Denominate: worldDaiStar.ratioFirstHitCz[0],
//                        setting2Denominate: worldDaiStar.ratioFirstHitCz[1],
//                        setting3Denominate: worldDaiStar.ratioFirstHitCz[2],
//                        setting4Denominate: worldDaiStar.ratioFirstHitCz[3],
//                        setting5Denominate: worldDaiStar.ratioFirstHitCz[4],
//                        setting6Denominate: worldDaiStar.ratioFirstHitCz[5]
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
//                        currentCount: $worldDaiStar.firstHitCountAt,
//                        bigNumber: $worldDaiStar.normalGame,
//                        setting1Denominate: worldDaiStar.ratioFirstHitAt[0],
//                        setting2Denominate: worldDaiStar.ratioFirstHitAt[1],
//                        setting3Denominate: worldDaiStar.ratioFirstHitAt[2],
//                        setting4Denominate: worldDaiStar.ratioFirstHitAt[3],
//                        setting5Denominate: worldDaiStar.ratioFirstHitAt[4],
//                        setting6Denominate: worldDaiStar.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: worldDaiStar.machineName,
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
    worldDaiStarView95Ci(
        worldDaiStar: WorldDaiStar(),
    )
}
