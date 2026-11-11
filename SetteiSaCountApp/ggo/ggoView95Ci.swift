//
//  ggoView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ggoView95Ci: View {
    @ObservedObject var ggo: Ggo
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // ボーナス合算初当り回数
            unitListSection95Ci(
                grafTitle: "ボーナス合算初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $ggo.activeFirstHitCountBonus,
                        bigNumber: $ggo.activeNormalGame,
                        setting1Denominate: ggo.ratioFirstHitBonus[0],
                        setting2Denominate: ggo.ratioFirstHitBonus[1],
                        setting3Denominate: ggo.ratioFirstHitBonus[2],
                        setting4Denominate: ggo.ratioFirstHitBonus[3],
                        setting5Denominate: ggo.ratioFirstHitBonus[4],
                        setting6Denominate: ggo.ratioFirstHitBonus[5]
                    )
                )
            )
            .tag(2)

            // ST初当り回数
            unitListSection95Ci(
                grafTitle: "ST初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $ggo.activeFirstHitCountSt,
                        bigNumber: $ggo.activeNormalGame,
                        setting1Denominate: ggo.ratioFirstHitSt[0],
                        setting2Denominate: ggo.ratioFirstHitSt[1],
                        setting3Denominate: ggo.ratioFirstHitSt[2],
                        setting4Denominate: ggo.ratioFirstHitSt[3],
                        setting5Denominate: ggo.ratioFirstHitSt[4],
                        setting6Denominate: ggo.ratioFirstHitSt[5]
                    )
                )
            )
            .tag(3)

            // 天国選択率
            unitListSection95Ci(
                grafTitle: "天国選択率",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $ggo.modeHeavenCountHit,
                        bigNumber: $ggo.modeHeavenCountSum,
                        setting1Percent: ggo.ratioModeHeaven[0],
                        setting2Percent: ggo.ratioModeHeaven[1],
                        setting3Percent: ggo.ratioModeHeaven[2],
                        setting4Percent: ggo.ratioModeHeaven[3],
                        setting5Percent: ggo.ratioModeHeaven[4],
                        setting6Percent: ggo.ratioModeHeaven[5]
                    )
                )
            )
            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ggo.machineName,
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
    ggoView95Ci(
        ggo: Ggo(),
    )
}
