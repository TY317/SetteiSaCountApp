//
//  sencole6View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct sencole6View95Ci: View {
    @ObservedObject var sencole6: Sencole6
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
//                        currentCount: $sencole6.otomeAttackHit,
//                        bigNumber: $sencole6.otomeAttackSum,
//                        setting1Percent: sencole6.ratioOtomeAttack[0],
//                        setting2Percent: sencole6.ratioOtomeAttack[1],
//                        setting3Percent: sencole6.ratioOtomeAttack[2],
//                        setting4Percent: sencole6.ratioOtomeAttack[3],
//                        setting5Percent: sencole6.ratioOtomeAttack[4],
//                        setting6Percent: sencole6.ratioOtomeAttack[5]
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
//                        currentCount: $sencole6.firstHitCountCz,
//                        bigNumber: $sencole6.normalGame,
//                        setting1Denominate: sencole6.ratioFirstHitCz[0],
//                        setting2Denominate: sencole6.ratioFirstHitCz[1],
//                        setting3Denominate: sencole6.ratioFirstHitCz[2],
//                        setting4Denominate: sencole6.ratioFirstHitCz[3],
//                        setting5Denominate: sencole6.ratioFirstHitCz[4],
//                        setting6Denominate: sencole6.ratioFirstHitCz[5]
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
//                        currentCount: $sencole6.firstHitCountAt,
//                        bigNumber: $sencole6.normalGame,
//                        setting1Denominate: sencole6.ratioFirstHitAt[0],
//                        setting2Denominate: sencole6.ratioFirstHitAt[1],
//                        setting3Denominate: sencole6.ratioFirstHitAt[2],
//                        setting4Denominate: sencole6.ratioFirstHitAt[3],
//                        setting5Denominate: sencole6.ratioFirstHitAt[4],
//                        setting6Denominate: sencole6.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: sencole6.machineName,
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
    sencole6View95Ci(
        sencole6: Sencole6(),
    )
}
