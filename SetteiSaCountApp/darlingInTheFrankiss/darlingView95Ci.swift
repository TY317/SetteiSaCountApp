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
                        bigNumber: $darling.kokakuCountChanceSum,
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
            // CZ最終レベル　白成功回数
            unitListSection95Ci(
                grafTitle: "CZ最終レベル\n白 成功回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $darling.czFLCountWhiteHit,
                        bigNumber: $darling.czFLCountWhiteSum,
                        setting1Percent: darling.ratioCzFLWhite[0],
                        setting2Percent: darling.ratioCzFLWhite[1],
                        setting3Percent: darling.ratioCzFLWhite[2],
                        setting4Percent: darling.ratioCzFLWhite[3],
                        setting5Percent: darling.ratioCzFLWhite[4],
                        setting6Percent: darling.ratioCzFLWhite[5]
                    )
                )
            )
            .tag(7)
            // CZ最終レベル　青成功回数
            unitListSection95Ci(
                grafTitle: "CZ最終レベル\n青 成功回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $darling.czFLCountBlueHit,
                        bigNumber: $darling.czFLCountBlueSum,
                        setting1Percent: darling.ratioCzFLBlue[0],
                        setting2Percent: darling.ratioCzFLBlue[1],
                        setting3Percent: darling.ratioCzFLBlue[2],
                        setting4Percent: darling.ratioCzFLBlue[3],
                        setting5Percent: darling.ratioCzFLBlue[4],
                        setting6Percent: darling.ratioCzFLBlue[5]
                    )
                )
            )
            .tag(8)
            // CZ最終レベル　黄色成功回数
            unitListSection95Ci(
                grafTitle: "CZ最終レベル\n黄 成功回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $darling.czFLCountYellowHit,
                        bigNumber: $darling.czFLCountYellowSum,
                        setting1Percent: darling.ratioCzFLYellow[0],
                        setting2Percent: darling.ratioCzFLYellow[1],
                        setting3Percent: darling.ratioCzFLYellow[2],
                        setting4Percent: darling.ratioCzFLYellow[3],
                        setting5Percent: darling.ratioCzFLYellow[4],
                        setting6Percent: darling.ratioCzFLYellow[5]
                    )
                )
            )
            .tag(9)
            // CZ最終レベル　緑成功回数
            unitListSection95Ci(
                grafTitle: "CZ最終レベル\n緑 成功回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $darling.czFLCountGreenHit,
                        bigNumber: $darling.czFLCountGreenSum,
                        setting1Percent: darling.ratioCzFLGreen[0],
                        setting2Percent: darling.ratioCzFLGreen[1],
                        setting3Percent: darling.ratioCzFLGreen[2],
                        setting4Percent: darling.ratioCzFLGreen[3],
                        setting5Percent: darling.ratioCzFLGreen[4],
                        setting6Percent: darling.ratioCzFLGreen[5]
                    )
                )
            )
            .tag(10)
            // CZ最終レベル　赤成功回数
            unitListSection95Ci(
                grafTitle: "CZ最終レベル\n赤 成功回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $darling.czFLCountRedHit,
                        bigNumber: $darling.czFLCountRedSum,
                        setting1Percent: darling.ratioCzFLRed[0],
                        setting2Percent: darling.ratioCzFLRed[1],
                        setting3Percent: darling.ratioCzFLRed[2],
                        setting4Percent: darling.ratioCzFLRed[3],
                        setting5Percent: darling.ratioCzFLRed[4],
                        setting6Percent: darling.ratioCzFLRed[5]
                    )
                )
            )
            .tag(11)
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
