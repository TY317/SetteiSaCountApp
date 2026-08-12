//
//  dropkickView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct dropkickView95Ci: View {
    @ObservedObject var dropkick: Dropkick
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
//                        currentCount: $dropkick.otomeAttackHit,
//                        bigNumber: $dropkick.otomeAttackSum,
//                        setting1Percent: dropkick.ratioOtomeAttack[0],
//                        setting2Percent: dropkick.ratioOtomeAttack[1],
//                        setting3Percent: dropkick.ratioOtomeAttack[2],
//                        setting4Percent: dropkick.ratioOtomeAttack[3],
//                        setting5Percent: dropkick.ratioOtomeAttack[4],
//                        setting6Percent: dropkick.ratioOtomeAttack[5]
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
//                        currentCount: $dropkick.firstHitCountCz,
//                        bigNumber: $dropkick.normalGame,
//                        setting1Denominate: dropkick.ratioFirstHitCz[0],
//                        setting2Denominate: dropkick.ratioFirstHitCz[1],
//                        setting3Denominate: dropkick.ratioFirstHitCz[2],
//                        setting4Denominate: dropkick.ratioFirstHitCz[3],
//                        setting5Denominate: dropkick.ratioFirstHitCz[4],
//                        setting6Denominate: dropkick.ratioFirstHitCz[5]
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
//                        currentCount: $dropkick.firstHitCountAt,
//                        bigNumber: $dropkick.normalGame,
//                        setting1Denominate: dropkick.ratioFirstHitAt[0],
//                        setting2Denominate: dropkick.ratioFirstHitAt[1],
//                        setting3Denominate: dropkick.ratioFirstHitAt[2],
//                        setting4Denominate: dropkick.ratioFirstHitAt[3],
//                        setting5Denominate: dropkick.ratioFirstHitAt[4],
//                        setting6Denominate: dropkick.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: dropkick.machineName,
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
    dropkickView95Ci(
        dropkick: Dropkick(),
    )
}
