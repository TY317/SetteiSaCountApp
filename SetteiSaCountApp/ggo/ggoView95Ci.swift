//
//  ggoView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ggoView95Ci: View {
    @ObservedObject var ggo: Ggo
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
//                        currentCount: $ggo.otomeAttackHit,
//                        bigNumber: $ggo.otomeAttackSum,
//                        setting1Percent: ggo.ratioOtomeAttack[0],
//                        setting2Percent: ggo.ratioOtomeAttack[1],
//                        setting3Percent: ggo.ratioOtomeAttack[2],
//                        setting4Percent: ggo.ratioOtomeAttack[3],
//                        setting5Percent: ggo.ratioOtomeAttack[4],
//                        setting6Percent: ggo.ratioOtomeAttack[5]
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
//                        currentCount: $ggo.firstHitCountCz,
//                        bigNumber: $ggo.normalGame,
//                        setting1Denominate: ggo.ratioFirstHitCz[0],
//                        setting2Denominate: ggo.ratioFirstHitCz[1],
//                        setting3Denominate: ggo.ratioFirstHitCz[2],
//                        setting4Denominate: ggo.ratioFirstHitCz[3],
//                        setting5Denominate: ggo.ratioFirstHitCz[4],
//                        setting6Denominate: ggo.ratioFirstHitCz[5]
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
//                        currentCount: $ggo.firstHitCountAt,
//                        bigNumber: $ggo.normalGame,
//                        setting1Denominate: ggo.ratioFirstHitAt[0],
//                        setting2Denominate: ggo.ratioFirstHitAt[1],
//                        setting3Denominate: ggo.ratioFirstHitAt[2],
//                        setting4Denominate: ggo.ratioFirstHitAt[3],
//                        setting5Denominate: ggo.ratioFirstHitAt[4],
//                        setting6Denominate: ggo.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ggo.machineName,
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
    ggoView95Ci(
        ggo: Ggo(),
    )
}
