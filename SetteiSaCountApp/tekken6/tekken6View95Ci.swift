//
//  tekken6View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/31.
//

import SwiftUI

struct tekken6View95Ci: View {
    @ObservedObject var tekken6: Tekken6
    @State var selection = 1
    @State var isShow95CiExplain = false
    var body: some View {
        TabView(selection: self.$selection) {
            // ボーナス直撃回数
            unitListSection95Ci(
                grafTitle: "ボーナス直撃回数\n弱レア役から",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $tekken6.rareDirectCountJakuHit,
                        bigNumber: $tekken6.rareDirectCountJakuSum,
                        setting1Percent: tekken6.ratioRareDirectJaku[0],
                        setting2Percent: tekken6.ratioRareDirectJaku[1],
                        setting3Percent: tekken6.ratioRareDirectJaku[2],
                        setting4Percent: tekken6.ratioRareDirectJaku[3],
                        setting5Percent: tekken6.ratioRareDirectJaku[4],
                        setting6Percent: tekken6.ratioRareDirectJaku[5]
                    )
                )
            )
            .tag(5)
            // ボーナス直撃回数
            unitListSection95Ci(
                grafTitle: "ボーナス直撃回数\n強🍒から",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $tekken6.rareDirectCountKyoHit,
                        bigNumber: $tekken6.rareDirectCountKyoCherry,
                        setting1Percent: tekken6.ratioRareDirectKyo[0],
                        setting2Percent: tekken6.ratioRareDirectKyo[1],
                        setting3Percent: tekken6.ratioRareDirectKyo[2],
                        setting4Percent: tekken6.ratioRareDirectKyo[3],
                        setting5Percent: tekken6.ratioRareDirectKyo[4],
                        setting6Percent: tekken6.ratioRareDirectKyo[5]
                    )
                )
            )
            .tag(6)
            // CZ初当り回数
            unitListSection95Ci(
                grafTitle: "CZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $tekken6.firstHitCountCz,
                        bigNumber: $tekken6.normalGame,
                        setting1Denominate: tekken6.ratioFirstHitCz[0],
                        setting2Denominate: tekken6.ratioFirstHitCz[1],
                        setting3Denominate: tekken6.ratioFirstHitCz[2],
                        setting4Denominate: tekken6.ratioFirstHitCz[3],
                        setting5Denominate: tekken6.ratioFirstHitCz[4],
                        setting6Denominate: tekken6.ratioFirstHitCz[5]
                    )
                )
            )
            .tag(1)
            // ボーナス合算初当り回数
            unitListSection95Ci(
                grafTitle: "ボーナス合算初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $tekken6.firstHitCountBonusSum,
                        bigNumber: $tekken6.normalGame,
                        setting1Denominate: tekken6.ratioFirstHitBonus[0],
                        setting2Denominate: tekken6.ratioFirstHitBonus[1],
                        setting3Denominate: tekken6.ratioFirstHitBonus[2],
                        setting4Denominate: tekken6.ratioFirstHitBonus[3],
                        setting5Denominate: tekken6.ratioFirstHitBonus[4],
                        setting6Denominate: tekken6.ratioFirstHitBonus[5]
                    )
                )
            )
            .tag(2)
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $tekken6.firstHitCountAt,
                        bigNumber: $tekken6.normalGame,
                        setting1Denominate: tekken6.ratioFirstHitAt[0],
                        setting2Denominate: tekken6.ratioFirstHitAt[1],
                        setting3Denominate: tekken6.ratioFirstHitAt[2],
                        setting4Denominate: tekken6.ratioFirstHitAt[3],
                        setting5Denominate: tekken6.ratioFirstHitAt[4],
                        setting6Denominate: tekken6.ratioFirstHitAt[5]
                    )
                )
            )
            .tag(3)
            // 引き戻し回数
            unitListSection95Ci(
                grafTitle: "引き戻し回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $tekken6.backCountHit,
                        bigNumber: $tekken6.backCountSum,
                        setting1Percent: tekken6.ratioBack[0],
                        setting2Percent: tekken6.ratioBack[1],
                        setting3Percent: tekken6.ratioBack[2],
                        setting4Percent: tekken6.ratioBack[3],
                        setting5Percent: tekken6.ratioBack[4],
                        setting6Percent: tekken6.ratioBack[5]
                    )
                )
            )
            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: tekken6.machineName,
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
    tekken6View95Ci(
        tekken6: Tekken6(),
    )
}
