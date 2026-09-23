//
//  takosloView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct takosloView95Ci: View {
    @ObservedObject var takoslo: Takoslo
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
//                        currentCount: $takoslo.otomeAttackHit,
//                        bigNumber: $takoslo.otomeAttackSum,
//                        setting1Percent: takoslo.ratioOtomeAttack[0],
//                        setting2Percent: takoslo.ratioOtomeAttack[1],
//                        setting3Percent: takoslo.ratioOtomeAttack[2],
//                        setting4Percent: takoslo.ratioOtomeAttack[3],
//                        setting5Percent: takoslo.ratioOtomeAttack[4],
//                        setting6Percent: takoslo.ratioOtomeAttack[5]
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
//                        currentCount: $takoslo.firstHitCountCz,
//                        bigNumber: $takoslo.normalGame,
//                        setting1Denominate: takoslo.ratioFirstHitCz[0],
//                        setting2Denominate: takoslo.ratioFirstHitCz[1],
//                        setting3Denominate: takoslo.ratioFirstHitCz[2],
//                        setting4Denominate: takoslo.ratioFirstHitCz[3],
//                        setting5Denominate: takoslo.ratioFirstHitCz[4],
//                        setting6Denominate: takoslo.ratioFirstHitCz[5]
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
//                        currentCount: $takoslo.firstHitCountAt,
//                        bigNumber: $takoslo.normalGame,
//                        setting1Denominate: takoslo.ratioFirstHitAt[0],
//                        setting2Denominate: takoslo.ratioFirstHitAt[1],
//                        setting3Denominate: takoslo.ratioFirstHitAt[2],
//                        setting4Denominate: takoslo.ratioFirstHitAt[3],
//                        setting5Denominate: takoslo.ratioFirstHitAt[4],
//                        setting6Denominate: takoslo.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: takoslo.machineName,
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
    takosloView95Ci(
        takoslo: Takoslo(),
    )
}
