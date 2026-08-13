//
//  streetFighter6View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct streetFighter6View95Ci: View {
    @ObservedObject var streetFighter6: StreetFighter6
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
//                        currentCount: $streetFighter6.otomeAttackHit,
//                        bigNumber: $streetFighter6.otomeAttackSum,
//                        setting1Percent: streetFighter6.ratioOtomeAttack[0],
//                        setting2Percent: streetFighter6.ratioOtomeAttack[1],
//                        setting3Percent: streetFighter6.ratioOtomeAttack[2],
//                        setting4Percent: streetFighter6.ratioOtomeAttack[3],
//                        setting5Percent: streetFighter6.ratioOtomeAttack[4],
//                        setting6Percent: streetFighter6.ratioOtomeAttack[5]
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
//                        currentCount: $streetFighter6.firstHitCountCz,
//                        bigNumber: $streetFighter6.normalGame,
//                        setting1Denominate: streetFighter6.ratioFirstHitCz[0],
//                        setting2Denominate: streetFighter6.ratioFirstHitCz[1],
//                        setting3Denominate: streetFighter6.ratioFirstHitCz[2],
//                        setting4Denominate: streetFighter6.ratioFirstHitCz[3],
//                        setting5Denominate: streetFighter6.ratioFirstHitCz[4],
//                        setting6Denominate: streetFighter6.ratioFirstHitCz[5]
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
//                        currentCount: $streetFighter6.firstHitCountAt,
//                        bigNumber: $streetFighter6.normalGame,
//                        setting1Denominate: streetFighter6.ratioFirstHitAt[0],
//                        setting2Denominate: streetFighter6.ratioFirstHitAt[1],
//                        setting3Denominate: streetFighter6.ratioFirstHitAt[2],
//                        setting4Denominate: streetFighter6.ratioFirstHitAt[3],
//                        setting5Denominate: streetFighter6.ratioFirstHitAt[4],
//                        setting6Denominate: streetFighter6.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: streetFighter6.machineName,
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
    streetFighter6View95Ci(
        streetFighter6: StreetFighter6(),
    )
}
