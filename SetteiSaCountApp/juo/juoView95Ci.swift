//
//  juoView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct juoView95Ci: View {
    @ObservedObject var juo: Juo
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
//                        currentCount: $juo.otomeAttackHit,
//                        bigNumber: $juo.otomeAttackSum,
//                        setting1Percent: juo.ratioOtomeAttack[0],
//                        setting2Percent: juo.ratioOtomeAttack[1],
//                        setting3Percent: juo.ratioOtomeAttack[2],
//                        setting4Percent: juo.ratioOtomeAttack[3],
//                        setting5Percent: juo.ratioOtomeAttack[4],
//                        setting6Percent: juo.ratioOtomeAttack[5]
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
//                        currentCount: $juo.firstHitCountCz,
//                        bigNumber: $juo.normalGame,
//                        setting1Denominate: juo.ratioFirstHitCz[0],
//                        setting2Denominate: juo.ratioFirstHitCz[1],
//                        setting3Denominate: juo.ratioFirstHitCz[2],
//                        setting4Denominate: juo.ratioFirstHitCz[3],
//                        setting5Denominate: juo.ratioFirstHitCz[4],
//                        setting6Denominate: juo.ratioFirstHitCz[5]
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
//                        currentCount: $juo.firstHitCountAt,
//                        bigNumber: $juo.normalGame,
//                        setting1Denominate: juo.ratioFirstHitAt[0],
//                        setting2Denominate: juo.ratioFirstHitAt[1],
//                        setting3Denominate: juo.ratioFirstHitAt[2],
//                        setting4Denominate: juo.ratioFirstHitAt[3],
//                        setting5Denominate: juo.ratioFirstHitAt[4],
//                        setting6Denominate: juo.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: juo.machineName,
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
    juoView95Ci(
        juo: Juo(),
    )
}
