//
//  aobutaView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct aobutaView95Ci: View {
    @ObservedObject var aobuta: Aobuta
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
//                        currentCount: $aobuta.otomeAttackHit,
//                        bigNumber: $aobuta.otomeAttackSum,
//                        setting1Percent: aobuta.ratioOtomeAttack[0],
//                        setting2Percent: aobuta.ratioOtomeAttack[1],
//                        setting3Percent: aobuta.ratioOtomeAttack[2],
//                        setting4Percent: aobuta.ratioOtomeAttack[3],
//                        setting5Percent: aobuta.ratioOtomeAttack[4],
//                        setting6Percent: aobuta.ratioOtomeAttack[5]
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
//                        currentCount: $aobuta.firstHitCountCz,
//                        bigNumber: $aobuta.normalGame,
//                        setting1Denominate: aobuta.ratioFirstHitCz[0],
//                        setting2Denominate: aobuta.ratioFirstHitCz[1],
//                        setting3Denominate: aobuta.ratioFirstHitCz[2],
//                        setting4Denominate: aobuta.ratioFirstHitCz[3],
//                        setting5Denominate: aobuta.ratioFirstHitCz[4],
//                        setting6Denominate: aobuta.ratioFirstHitCz[5]
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
//                        currentCount: $aobuta.firstHitCountAt,
//                        bigNumber: $aobuta.normalGame,
//                        setting1Denominate: aobuta.ratioFirstHitAt[0],
//                        setting2Denominate: aobuta.ratioFirstHitAt[1],
//                        setting3Denominate: aobuta.ratioFirstHitAt[2],
//                        setting4Denominate: aobuta.ratioFirstHitAt[3],
//                        setting5Denominate: aobuta.ratioFirstHitAt[4],
//                        setting6Denominate: aobuta.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: aobuta.machineName,
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
    aobutaView95Ci(
        aobuta: Aobuta(),
    )
}
