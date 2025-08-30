//
//  darlingView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/27.
//

import SwiftUI

struct darlingView95Ci: View {
    @ObservedObject var darling: Darling
    @State var selection = 1
    @State var isShow95CiExplain = false
    var body: some View {
        TabView(selection: self.$selection) {
            // CZ回数
            unitListSection95Ci(
                grafTitle: "CZ回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $darling.czCount,
                        bigNumber: $darling.normalGame,
                        setting1Denominate: darling.ratioCz[0],
                        setting2Denominate: darling.ratioCz[1],
                        setting3Denominate: darling.ratioCz[2],
                        setting4Denominate: darling.ratioCz[3],
                        setting5Denominate: darling.ratioCz[4],
                        setting6Denominate: darling.ratioCz[5]
                    )
                )
            )
            .tag(1)
            // ボーナス回数
            unitListSection95Ci(
                grafTitle: "ボーナス回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $darling.bonusCount,
                        bigNumber: $darling.normalGame,
                        setting1Denominate: darling.ratioBonus[0],
                        setting2Denominate: darling.ratioBonus[1],
                        setting3Denominate: darling.ratioBonus[2],
                        setting4Denominate: darling.ratioBonus[3],
                        setting5Denominate: darling.ratioBonus[4],
                        setting6Denominate: darling.ratioBonus[5]
                    )
                )
            )
            .tag(2)
            // ボーナス高確率回数
            unitListSection95Ci(
                grafTitle: "ボーナス高確率回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $darling.kokakuCount,
                        bigNumber: $darling.normalGame,
                        setting1Denominate: darling.ratioKokaku[0],
                        setting2Denominate: darling.ratioKokaku[1],
                        setting3Denominate: darling.ratioKokaku[2],
                        setting4Denominate: darling.ratioKokaku[3],
                        setting5Denominate: darling.ratioKokaku[4],
                        setting6Denominate: darling.ratioKokaku[5]
                    )
                )
            )
            .tag(3)
            // フランクス高確　チェリーからの移行回数
            unitListSection95Ci(
                grafTitle: "フランクス高確\n🍒からの移行回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $darling.kokakuCountCherryHit,
                        bigNumber: $darling.kokakuCountCherrySum,
                        setting1Percent: darling.ratioKokakuCherry[0],
                        setting2Percent: darling.ratioKokakuCherry[1],
                        setting3Percent: darling.ratioKokakuCherry[2],
                        setting4Percent: darling.ratioKokakuCherry[3],
                        setting5Percent: darling.ratioKokakuCherry[4],
                        setting6Percent: darling.ratioKokakuCherry[5]
                    )
                )
            )
            .tag(4)
            // フランクス高確　チャンス目からの移行回数
            unitListSection95Ci(
                grafTitle: "フランクス高確\nチャンス目からの移行回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $darling.kokakuCountChanceHit,
                        bigNumber: $darling.kokakuCountChanceHit,
                        setting1Percent: darling.ratioKokakuChance[0],
                        setting2Percent: darling.ratioKokakuChance[1],
                        setting3Percent: darling.ratioKokakuChance[2],
                        setting4Percent: darling.ratioKokakuChance[3],
                        setting5Percent: darling.ratioKokakuChance[4],
                        setting6Percent: darling.ratioKokakuChance[5]
                    )
                )
            )
            .tag(5)
            // CZ初期レベル　白回数
            unitListSection95Ci(
                grafTitle: "CZ初期レベル\n白 回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $darling.czLevelCountWhite,
                        bigNumber: $darling.czLevelCountSum,
                        setting1Percent: darling.ratioCzLevelWhite[0],
                        setting2Percent: darling.ratioCzLevelWhite[1],
                        setting3Percent: darling.ratioCzLevelWhite[2],
                        setting4Percent: darling.ratioCzLevelWhite[3],
                        setting5Percent: darling.ratioCzLevelWhite[4],
                        setting6Percent: darling.ratioCzLevelWhite[5]
                    )
                )
            )
            .tag(6)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: darling.machineName,
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
    darlingView95Ci(
        darling: Darling(),
    )
}
