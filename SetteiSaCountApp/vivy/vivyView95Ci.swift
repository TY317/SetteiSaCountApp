//
//  vivyView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct vivyView95Ci: View {
    @ObservedObject var vivy: Vivy
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
//                        currentCount: $vivy.otomeAttackHit,
//                        bigNumber: $vivy.otomeAttackSum,
//                        setting1Percent: vivy.ratioOtomeAttack[0],
//                        setting2Percent: vivy.ratioOtomeAttack[1],
//                        setting3Percent: vivy.ratioOtomeAttack[2],
//                        setting4Percent: vivy.ratioOtomeAttack[3],
//                        setting5Percent: vivy.ratioOtomeAttack[4],
//                        setting6Percent: vivy.ratioOtomeAttack[5]
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
//                        currentCount: $vivy.firstHitCountCz,
//                        bigNumber: $vivy.normalGame,
//                        setting1Denominate: vivy.ratioFirstHitCz[0],
//                        setting2Denominate: vivy.ratioFirstHitCz[1],
//                        setting3Denominate: vivy.ratioFirstHitCz[2],
//                        setting4Denominate: vivy.ratioFirstHitCz[3],
//                        setting5Denominate: vivy.ratioFirstHitCz[4],
//                        setting6Denominate: vivy.ratioFirstHitCz[5]
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
//                        currentCount: $vivy.firstHitCountAt,
//                        bigNumber: $vivy.normalGame,
//                        setting1Denominate: vivy.ratioFirstHitAt[0],
//                        setting2Denominate: vivy.ratioFirstHitAt[1],
//                        setting3Denominate: vivy.ratioFirstHitAt[2],
//                        setting4Denominate: vivy.ratioFirstHitAt[3],
//                        setting5Denominate: vivy.ratioFirstHitAt[4],
//                        setting6Denominate: vivy.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: vivy.machineName,
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
    vivyView95Ci(
        vivy: Vivy(),
    )
}
