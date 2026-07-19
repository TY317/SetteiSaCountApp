//
//  kerottoView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct kerottoView95Ci: View {
    @ObservedObject var kerotto: Kerotto
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
//                        currentCount: $kerotto.otomeAttackHit,
//                        bigNumber: $kerotto.otomeAttackSum,
//                        setting1Percent: kerotto.ratioOtomeAttack[0],
//                        setting2Percent: kerotto.ratioOtomeAttack[1],
//                        setting3Percent: kerotto.ratioOtomeAttack[2],
//                        setting4Percent: kerotto.ratioOtomeAttack[3],
//                        setting5Percent: kerotto.ratioOtomeAttack[4],
//                        setting6Percent: kerotto.ratioOtomeAttack[5]
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
//                        currentCount: $kerotto.firstHitCountCz,
//                        bigNumber: $kerotto.normalGame,
//                        setting1Denominate: kerotto.ratioFirstHitCz[0],
//                        setting2Denominate: kerotto.ratioFirstHitCz[1],
//                        setting3Denominate: kerotto.ratioFirstHitCz[2],
//                        setting4Denominate: kerotto.ratioFirstHitCz[3],
//                        setting5Denominate: kerotto.ratioFirstHitCz[4],
//                        setting6Denominate: kerotto.ratioFirstHitCz[5]
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
//                        currentCount: $kerotto.firstHitCountAt,
//                        bigNumber: $kerotto.normalGame,
//                        setting1Denominate: kerotto.ratioFirstHitAt[0],
//                        setting2Denominate: kerotto.ratioFirstHitAt[1],
//                        setting3Denominate: kerotto.ratioFirstHitAt[2],
//                        setting4Denominate: kerotto.ratioFirstHitAt[3],
//                        setting5Denominate: kerotto.ratioFirstHitAt[4],
//                        setting6Denominate: kerotto.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kerotto.machineName,
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
    kerottoView95Ci(
        kerotto: Kerotto(),
    )
}
