//
//  ragnadorView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ragnadorView95Ci: View {
    @ObservedObject var ragnador: Ragnador
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // 弱🍒 高確以上への昇格率
            unitListSection95Ci(
                grafTitle: "弱🍒 高確への昇格率",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $ragnador.weakCherryUpCountHighOver,
                        bigNumber: $ragnador.weakCherryCount,
                        setting1Percent: ragnador.ratioWeakCherryUpHighOver[0],
                        setting2Percent: ragnador.ratioWeakCherryUpHighOver[1],
                        setting3Percent: ragnador.ratioWeakCherryUpHighOver[2],
                        setting4Percent: ragnador.ratioWeakCherryUpHighOver[3],
                        setting5Percent: ragnador.ratioWeakCherryUpHighOver[4],
                        setting6Percent: ragnador.ratioWeakCherryUpHighOver[5]
                    )
                )
            )
            .tag(1)

            // 弱🍒 超高確への昇格率
            unitListSection95Ci(
                grafTitle: "弱🍒 超高確への昇格率",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $ragnador.weakCherryUpCountSuperHigh,
                        bigNumber: $ragnador.weakCherryCount,
                        setting1Percent: ragnador.ratioWeakCherryUpSuperHigh[0],
                        setting2Percent: ragnador.ratioWeakCherryUpSuperHigh[1],
                        setting3Percent: ragnador.ratioWeakCherryUpSuperHigh[2],
                        setting4Percent: ragnador.ratioWeakCherryUpSuperHigh[3],
                        setting5Percent: ragnador.ratioWeakCherryUpSuperHigh[4],
                        setting6Percent: ragnador.ratioWeakCherryUpSuperHigh[5]
                    )
                )
            )
            .tag(2)

            // 回数
//            unitListSection95Ci(
//                grafTitle: "回数",
//                titleFont: .title2,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $ragnador.otomeAttackHit,
//                        bigNumber: $ragnador.otomeAttackSum,
//                        setting1Percent: ragnador.ratioOtomeAttack[0],
//                        setting2Percent: ragnador.ratioOtomeAttack[1],
//                        setting3Percent: ragnador.ratioOtomeAttack[2],
//                        setting4Percent: ragnador.ratioOtomeAttack[3],
//                        setting5Percent: ragnador.ratioOtomeAttack[4],
//                        setting6Percent: ragnador.ratioOtomeAttack[5]
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
//                        currentCount: $ragnador.firstHitCountCz,
//                        bigNumber: $ragnador.normalGame,
//                        setting1Denominate: ragnador.ratioFirstHitCz[0],
//                        setting2Denominate: ragnador.ratioFirstHitCz[1],
//                        setting3Denominate: ragnador.ratioFirstHitCz[2],
//                        setting4Denominate: ragnador.ratioFirstHitCz[3],
//                        setting5Denominate: ragnador.ratioFirstHitCz[4],
//                        setting6Denominate: ragnador.ratioFirstHitCz[5]
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
//                        currentCount: $ragnador.firstHitCountAt,
//                        bigNumber: $ragnador.normalGame,
//                        setting1Denominate: ragnador.ratioFirstHitAt[0],
//                        setting2Denominate: ragnador.ratioFirstHitAt[1],
//                        setting3Denominate: ragnador.ratioFirstHitAt[2],
//                        setting4Denominate: ragnador.ratioFirstHitAt[3],
//                        setting5Denominate: ragnador.ratioFirstHitAt[4],
//                        setting6Denominate: ragnador.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ragnador.machineName,
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
    ragnadorView95Ci(
        ragnador: Ragnador(),
    )
}
