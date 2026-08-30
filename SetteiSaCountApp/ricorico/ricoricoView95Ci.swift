//
//  ricoricoView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ricoricoView95Ci: View {
    @ObservedObject var ricorico: Ricorico
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
//                        currentCount: $ricorico.otomeAttackHit,
//                        bigNumber: $ricorico.otomeAttackSum,
//                        setting1Percent: ricorico.ratioOtomeAttack[0],
//                        setting2Percent: ricorico.ratioOtomeAttack[1],
//                        setting3Percent: ricorico.ratioOtomeAttack[2],
//                        setting4Percent: ricorico.ratioOtomeAttack[3],
//                        setting5Percent: ricorico.ratioOtomeAttack[4],
//                        setting6Percent: ricorico.ratioOtomeAttack[5]
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
//                        currentCount: $ricorico.firstHitCountCz,
//                        bigNumber: $ricorico.normalGame,
//                        setting1Denominate: ricorico.ratioFirstHitCz[0],
//                        setting2Denominate: ricorico.ratioFirstHitCz[1],
//                        setting3Denominate: ricorico.ratioFirstHitCz[2],
//                        setting4Denominate: ricorico.ratioFirstHitCz[3],
//                        setting5Denominate: ricorico.ratioFirstHitCz[4],
//                        setting6Denominate: ricorico.ratioFirstHitCz[5]
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
//                        currentCount: $ricorico.firstHitCountAt,
//                        bigNumber: $ricorico.normalGame,
//                        setting1Denominate: ricorico.ratioFirstHitAt[0],
//                        setting2Denominate: ricorico.ratioFirstHitAt[1],
//                        setting3Denominate: ricorico.ratioFirstHitAt[2],
//                        setting4Denominate: ricorico.ratioFirstHitAt[3],
//                        setting5Denominate: ricorico.ratioFirstHitAt[4],
//                        setting6Denominate: ricorico.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ricorico.machineName,
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
    ricoricoView95Ci(
        ricorico: Ricorico(),
    )
}
