//
//  goeva2View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct goeva2View95Ci: View {
    @ObservedObject var goeva2: Goeva2
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // スイカ成立時のCZ当選率
            unitListSection95Ci(
                grafTitle: "🍉からのCZ当選率",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $goeva2.suikaCzCount,
                        bigNumber: $goeva2.suikaCount,
                        setting1Percent: goeva2.ratioSuikaCz[0],
                        setting2Percent: goeva2.ratioSuikaCz[1],
                        setting3Percent: goeva2.ratioSuikaCz[2],
                        setting4Percent: goeva2.ratioSuikaCz[3],
                        setting5Percent: goeva2.ratioSuikaCz[4],
                        setting6Percent: goeva2.ratioSuikaCz[5]
                    )
                )
            )
            .tag(1)

            // 回数
//            unitListSection95Ci(
//                grafTitle: "回数",
//                titleFont: .title2,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $goeva2.otomeAttackHit,
//                        bigNumber: $goeva2.otomeAttackSum,
//                        setting1Percent: goeva2.ratioOtomeAttack[0],
//                        setting2Percent: goeva2.ratioOtomeAttack[1],
//                        setting3Percent: goeva2.ratioOtomeAttack[2],
//                        setting4Percent: goeva2.ratioOtomeAttack[3],
//                        setting5Percent: goeva2.ratioOtomeAttack[4],
//                        setting6Percent: goeva2.ratioOtomeAttack[5]
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
//                        currentCount: $goeva2.firstHitCountCz,
//                        bigNumber: $goeva2.normalGame,
//                        setting1Denominate: goeva2.ratioFirstHitCz[0],
//                        setting2Denominate: goeva2.ratioFirstHitCz[1],
//                        setting3Denominate: goeva2.ratioFirstHitCz[2],
//                        setting4Denominate: goeva2.ratioFirstHitCz[3],
//                        setting5Denominate: goeva2.ratioFirstHitCz[4],
//                        setting6Denominate: goeva2.ratioFirstHitCz[5]
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
//                        currentCount: $goeva2.firstHitCountAt,
//                        bigNumber: $goeva2.normalGame,
//                        setting1Denominate: goeva2.ratioFirstHitAt[0],
//                        setting2Denominate: goeva2.ratioFirstHitAt[1],
//                        setting3Denominate: goeva2.ratioFirstHitAt[2],
//                        setting4Denominate: goeva2.ratioFirstHitAt[3],
//                        setting5Denominate: goeva2.ratioFirstHitAt[4],
//                        setting6Denominate: goeva2.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: goeva2.machineName,
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
    goeva2View95Ci(
        goeva2: Goeva2(),
    )
}
