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
            // FB初当り回数
            unitListSection95Ci(
                grafTitle: "FB初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $streetFighter6.firstHitCountFb,
                        bigNumber: $streetFighter6.normalGame,
                        setting1Denominate: streetFighter6.ratioFirstHitFb[0],
                        setting2Denominate: streetFighter6.ratioFirstHitFb[1],
                        setting3Denominate: streetFighter6.ratioFirstHitFb[2],
                        setting4Denominate: streetFighter6.ratioFirstHitFb[3],
                        setting5Denominate: streetFighter6.ratioFirstHitFb[4],
                        setting6Denominate: streetFighter6.ratioFirstHitFb[5]
                    )
                )
            )
            .tag(2)

            // ボーナス初当り回数
            unitListSection95Ci(
                grafTitle: "ボーナス初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $streetFighter6.firstHitCountBonus,
                        bigNumber: $streetFighter6.normalGame,
                        setting1Denominate: streetFighter6.ratioFirstHitBonus[0],
                        setting2Denominate: streetFighter6.ratioFirstHitBonus[1],
                        setting3Denominate: streetFighter6.ratioFirstHitBonus[2],
                        setting4Denominate: streetFighter6.ratioFirstHitBonus[3],
                        setting5Denominate: streetFighter6.ratioFirstHitBonus[4],
                        setting6Denominate: streetFighter6.ratioFirstHitBonus[5]
                    )
                )
            )
            .tag(3)

            // ベル・リプレイでの成功率
            unitListSection95Ci(
                grafTitle: "コンティニュー\nベル・リプレイ成功率",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $streetFighter6.continueBellReplayCountHit,
                        bigNumber: $streetFighter6.continueBellReplayCountSum,
                        setting1Percent: streetFighter6.ratioContinueBellReplay[0],
                        setting2Percent: streetFighter6.ratioContinueBellReplay[1],
                        setting3Percent: streetFighter6.ratioContinueBellReplay[2],
                        setting4Percent: streetFighter6.ratioContinueBellReplay[3],
                        setting5Percent: streetFighter6.ratioContinueBellReplay[4],
                        setting6Percent: streetFighter6.ratioContinueBellReplay[5]
                    )
                )
            )
            .tag(4)
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
