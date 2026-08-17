//
//  tonskillView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct tonskillView95Ci: View {
    @ObservedObject var tonskill: Tonskill
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
//                        currentCount: $tonskill.otomeAttackHit,
//                        bigNumber: $tonskill.otomeAttackSum,
//                        setting1Percent: tonskill.ratioOtomeAttack[0],
//                        setting2Percent: tonskill.ratioOtomeAttack[1],
//                        setting3Percent: tonskill.ratioOtomeAttack[2],
//                        setting4Percent: tonskill.ratioOtomeAttack[3],
//                        setting5Percent: tonskill.ratioOtomeAttack[4],
//                        setting6Percent: tonskill.ratioOtomeAttack[5]
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
//                        currentCount: $tonskill.firstHitCountCz,
//                        bigNumber: $tonskill.normalGame,
//                        setting1Denominate: tonskill.ratioFirstHitCz[0],
//                        setting2Denominate: tonskill.ratioFirstHitCz[1],
//                        setting3Denominate: tonskill.ratioFirstHitCz[2],
//                        setting4Denominate: tonskill.ratioFirstHitCz[3],
//                        setting5Denominate: tonskill.ratioFirstHitCz[4],
//                        setting6Denominate: tonskill.ratioFirstHitCz[5]
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
//                        currentCount: $tonskill.firstHitCountAt,
//                        bigNumber: $tonskill.normalGame,
//                        setting1Denominate: tonskill.ratioFirstHitAt[0],
//                        setting2Denominate: tonskill.ratioFirstHitAt[1],
//                        setting3Denominate: tonskill.ratioFirstHitAt[2],
//                        setting4Denominate: tonskill.ratioFirstHitAt[3],
//                        setting5Denominate: tonskill.ratioFirstHitAt[4],
//                        setting6Denominate: tonskill.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: tonskill.machineName,
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
    tonskillView95Ci(
        tonskill: Tonskill(),
    )
}
