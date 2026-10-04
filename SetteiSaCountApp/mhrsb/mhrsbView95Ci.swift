//
//  mhrsbView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct mhrsbView95Ci: View {
    @ObservedObject var mhrsb: Mhrsb
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
//                        currentCount: $mhrsb.otomeAttackHit,
//                        bigNumber: $mhrsb.otomeAttackSum,
//                        setting1Percent: mhrsb.ratioOtomeAttack[0],
//                        setting2Percent: mhrsb.ratioOtomeAttack[1],
//                        setting3Percent: mhrsb.ratioOtomeAttack[2],
//                        setting4Percent: mhrsb.ratioOtomeAttack[3],
//                        setting5Percent: mhrsb.ratioOtomeAttack[4],
//                        setting6Percent: mhrsb.ratioOtomeAttack[5]
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
//                        currentCount: $mhrsb.firstHitCountCz,
//                        bigNumber: $mhrsb.normalGame,
//                        setting1Denominate: mhrsb.ratioFirstHitCz[0],
//                        setting2Denominate: mhrsb.ratioFirstHitCz[1],
//                        setting3Denominate: mhrsb.ratioFirstHitCz[2],
//                        setting4Denominate: mhrsb.ratioFirstHitCz[3],
//                        setting5Denominate: mhrsb.ratioFirstHitCz[4],
//                        setting6Denominate: mhrsb.ratioFirstHitCz[5]
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
//                        currentCount: $mhrsb.firstHitCountAt,
//                        bigNumber: $mhrsb.normalGame,
//                        setting1Denominate: mhrsb.ratioFirstHitAt[0],
//                        setting2Denominate: mhrsb.ratioFirstHitAt[1],
//                        setting3Denominate: mhrsb.ratioFirstHitAt[2],
//                        setting4Denominate: mhrsb.ratioFirstHitAt[3],
//                        setting5Denominate: mhrsb.ratioFirstHitAt[4],
//                        setting6Denominate: mhrsb.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: mhrsb.machineName,
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
    mhrsbView95Ci(
        mhrsb: Mhrsb(),
    )
}
