//
//  ragnadorView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ragnadorView95Ci: View {
    @ObservedObject var ragnador: Ragnador
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // 弱🍒 高確以上への昇格率
            unitListSection95Ci(
                grafTitle: "弱🍒 高確への昇格率",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $ragnador.weakCherryUpCountHighOver,
                        bigNumber: $ragnador.weakCherryCount,
                        setting1Percent: ragnador.ratioWeakCherryUpHighOver[0],
                        setting2Percent: ragnador.ratioWeakCherryUpHighOver[1],
                        setting3Percent: ragnador.ratioWeakCherryUpHighOver[2],
                        setting4Percent: ragnador.ratioWeakCherryUpHighOver[3],
                        setting5Percent: ragnador.ratioWeakCherryUpHighOver[4],
                        setting6Percent: ragnador.ratioWeakCherryUpHighOver[5]
                    )
                )
            )
            .tag(1)

            // 弱🍒 超高確への昇格率
            unitListSection95Ci(
                grafTitle: "弱🍒 超高確への昇格率",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $ragnador.weakCherryUpCountSuperHigh,
                        bigNumber: $ragnador.weakCherryCount,
                        setting1Percent: ragnador.ratioWeakCherryUpSuperHigh[0],
                        setting2Percent: ragnador.ratioWeakCherryUpSuperHigh[1],
                        setting3Percent: ragnador.ratioWeakCherryUpSuperHigh[2],
                        setting4Percent: ragnador.ratioWeakCherryUpSuperHigh[3],
                        setting5Percent: ragnador.ratioWeakCherryUpSuperHigh[4],
                        setting6Percent: ragnador.ratioWeakCherryUpSuperHigh[5]
                    )
                )
            )
            .tag(2)

            // 通常 チャンス目→CZ
            unitListSection95Ci(
                grafTitle: "通常 チャンス目→CZ",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $ragnador.rareCzCountNormalChance,
                        bigNumber: $ragnador.rareCountNormalChance,
                        setting1Percent: ragnador.ratioRareCzNormalChance[0],
                        setting2Percent: ragnador.ratioRareCzNormalChance[1],
                        setting3Percent: ragnador.ratioRareCzNormalChance[2],
                        setting4Percent: ragnador.ratioRareCzNormalChance[3],
                        setting5Percent: ragnador.ratioRareCzNormalChance[4],
                        setting6Percent: ragnador.ratioRareCzNormalChance[5]
                    )
                )
            )
            .tag(3)

            // 通常 強🍒→CZ
            unitListSection95Ci(
                grafTitle: "通常 強🍒→CZ",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $ragnador.rareCzCountNormalKyo,
                        bigNumber: $ragnador.rareCountNormalKyo,
                        setting1Percent: ragnador.ratioRareCzNormalKyo[0],
                        setting2Percent: ragnador.ratioRareCzNormalKyo[1],
                        setting3Percent: ragnador.ratioRareCzNormalKyo[2],
                        setting4Percent: ragnador.ratioRareCzNormalKyo[3],
                        setting5Percent: ragnador.ratioRareCzNormalKyo[4],
                        setting6Percent: ragnador.ratioRareCzNormalKyo[5]
                    )
                )
            )
            .tag(4)

            // 通常 🍉→AT
            unitListSection95Ci(
                grafTitle: "通常 🍉→AT",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $ragnador.rareAtCountNormalSuika,
                        bigNumber: $ragnador.rareCountNormalSuika,
                        setting1Percent: ragnador.ratioRareAtNormalSuika[0],
                        setting2Percent: ragnador.ratioRareAtNormalSuika[1],
                        setting3Percent: ragnador.ratioRareAtNormalSuika[2],
                        setting4Percent: ragnador.ratioRareAtNormalSuika[3],
                        setting5Percent: ragnador.ratioRareAtNormalSuika[4],
                        setting6Percent: ragnador.ratioRareAtNormalSuika[5]
                    )
                )
            )
            .tag(6)

            // 通常 チャンス目→AT
            unitListSection95Ci(
                grafTitle: "通常 チャンス目→AT",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $ragnador.rareAtCountNormalChance,
                        bigNumber: $ragnador.rareCountNormalChance,
                        setting1Percent: ragnador.ratioRareAtNormalChance[0],
                        setting2Percent: ragnador.ratioRareAtNormalChance[1],
                        setting3Percent: ragnador.ratioRareAtNormalChance[2],
                        setting4Percent: ragnador.ratioRareAtNormalChance[3],
                        setting5Percent: ragnador.ratioRareAtNormalChance[4],
                        setting6Percent: ragnador.ratioRareAtNormalChance[5]
                    )
                )
            )
            .tag(7)

            // 通常 強🍒→AT
            unitListSection95Ci(
                grafTitle: "通常 強🍒→AT",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $ragnador.rareAtCountNormalKyo,
                        bigNumber: $ragnador.rareCountNormalKyo,
                        setting1Percent: ragnador.ratioRareAtNormalKyo[0],
                        setting2Percent: ragnador.ratioRareAtNormalKyo[1],
                        setting3Percent: ragnador.ratioRareAtNormalKyo[2],
                        setting4Percent: ragnador.ratioRareAtNormalKyo[3],
                        setting5Percent: ragnador.ratioRareAtNormalKyo[4],
                        setting6Percent: ragnador.ratioRareAtNormalKyo[5]
                    )
                )
            )
            .tag(8)

            // 通常 極チャンス目→AT
            unitListSection95Ci(
                grafTitle: "通常 極チャンス目→AT",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $ragnador.rareAtCountNormalGoku,
                        bigNumber: $ragnador.rareCountNormalGoku,
                        setting1Percent: ragnador.ratioRareAtNormalGoku[0],
                        setting2Percent: ragnador.ratioRareAtNormalGoku[1],
                        setting3Percent: ragnador.ratioRareAtNormalGoku[2],
                        setting4Percent: ragnador.ratioRareAtNormalGoku[3],
                        setting5Percent: ragnador.ratioRareAtNormalGoku[4],
                        setting6Percent: ragnador.ratioRareAtNormalGoku[5]
                    )
                )
            )
            .tag(9)

            // 高確 チャンス目→CZ
            unitListSection95Ci(
                grafTitle: "高確 チャンス目→CZ",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $ragnador.rareCzCountHighChance,
                        bigNumber: $ragnador.rareCountHighChance,
                        setting1Percent: ragnador.ratioRareCzHighChance[0],
                        setting2Percent: ragnador.ratioRareCzHighChance[1],
                        setting3Percent: ragnador.ratioRareCzHighChance[2],
                        setting4Percent: ragnador.ratioRareCzHighChance[3],
                        setting5Percent: ragnador.ratioRareCzHighChance[4],
                        setting6Percent: ragnador.ratioRareCzHighChance[5]
                    )
                )
            )
            .tag(10)

            // 高確 強🍒→CZ
            unitListSection95Ci(
                grafTitle: "高確 強🍒→CZ",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $ragnador.rareCzCountHighKyo,
                        bigNumber: $ragnador.rareCountHighKyo,
                        setting1Percent: ragnador.ratioRareCzHighKyo[0],
                        setting2Percent: ragnador.ratioRareCzHighKyo[1],
                        setting3Percent: ragnador.ratioRareCzHighKyo[2],
                        setting4Percent: ragnador.ratioRareCzHighKyo[3],
                        setting5Percent: ragnador.ratioRareCzHighKyo[4],
                        setting6Percent: ragnador.ratioRareCzHighKyo[5]
                    )
                )
            )
            .tag(11)

            // 高確 🍉→AT
            unitListSection95Ci(
                grafTitle: "高確 🍉→AT",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $ragnador.rareAtCountHighSuika,
                        bigNumber: $ragnador.rareCountHighSuika,
                        setting1Percent: ragnador.ratioRareAtHighSuika[0],
                        setting2Percent: ragnador.ratioRareAtHighSuika[1],
                        setting3Percent: ragnador.ratioRareAtHighSuika[2],
                        setting4Percent: ragnador.ratioRareAtHighSuika[3],
                        setting5Percent: ragnador.ratioRareAtHighSuika[4],
                        setting6Percent: ragnador.ratioRareAtHighSuika[5]
                    )
                )
            )
            .tag(12)

            // 高確 チャンス目→AT
            unitListSection95Ci(
                grafTitle: "高確 チャンス目→AT",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $ragnador.rareAtCountHighChance,
                        bigNumber: $ragnador.rareCountHighChance,
                        setting1Percent: ragnador.ratioRareAtHighChance[0],
                        setting2Percent: ragnador.ratioRareAtHighChance[1],
                        setting3Percent: ragnador.ratioRareAtHighChance[2],
                        setting4Percent: ragnador.ratioRareAtHighChance[3],
                        setting5Percent: ragnador.ratioRareAtHighChance[4],
                        setting6Percent: ragnador.ratioRareAtHighChance[5]
                    )
                )
            )
            .tag(13)

            // 高確 強🍒→AT
            unitListSection95Ci(
                grafTitle: "高確 強🍒→AT",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $ragnador.rareAtCountHighKyo,
                        bigNumber: $ragnador.rareCountHighKyo,
                        setting1Percent: ragnador.ratioRareAtHighKyo[0],
                        setting2Percent: ragnador.ratioRareAtHighKyo[1],
                        setting3Percent: ragnador.ratioRareAtHighKyo[2],
                        setting4Percent: ragnador.ratioRareAtHighKyo[3],
                        setting5Percent: ragnador.ratioRareAtHighKyo[4],
                        setting6Percent: ragnador.ratioRareAtHighKyo[5]
                    )
                )
            )
            .tag(14)

            // CZ初当り回数
            unitListSection95Ci(
                grafTitle: "CZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $ragnador.activeFirstHitCountCz,
                        bigNumber: $ragnador.activeNormalGame,
                        setting1Denominate: ragnador.ratioFirstHitCz[0],
                        setting2Denominate: ragnador.ratioFirstHitCz[1],
                        setting3Denominate: ragnador.ratioFirstHitCz[2],
                        setting4Denominate: ragnador.ratioFirstHitCz[3],
                        setting5Denominate: ragnador.ratioFirstHitCz[4],
                        setting6Denominate: ragnador.ratioFirstHitCz[5]
                    )
                )
            )
            .tag(15)

            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $ragnador.activeFirstHitCountAt,
                        bigNumber: $ragnador.activeNormalGame,
                        setting1Denominate: ragnador.ratioFirstHitAt[0],
                        setting2Denominate: ragnador.ratioFirstHitAt[1],
                        setting3Denominate: ragnador.ratioFirstHitAt[2],
                        setting4Denominate: ragnador.ratioFirstHitAt[3],
                        setting5Denominate: ragnador.ratioFirstHitAt[4],
                        setting6Denominate: ragnador.ratioFirstHitAt[5]
                    )
                )
            )
            .tag(16)

            // 回数
//            unitListSection95Ci(
//                grafTitle: "回数",
//                titleFont: .title2,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $ragnador.otomeAttackHit,
//                        bigNumber: $ragnador.otomeAttackSum,
//                        setting1Percent: ragnador.ratioOtomeAttack[0],
//                        setting2Percent: ragnador.ratioOtomeAttack[1],
//                        setting3Percent: ragnador.ratioOtomeAttack[2],
//                        setting4Percent: ragnador.ratioOtomeAttack[3],
//                        setting5Percent: ragnador.ratioOtomeAttack[4],
//                        setting6Percent: ragnador.ratioOtomeAttack[5]
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
//                        currentCount: $ragnador.firstHitCountCz,
//                        bigNumber: $ragnador.normalGame,
//                        setting1Denominate: ragnador.ratioFirstHitCz[0],
//                        setting2Denominate: ragnador.ratioFirstHitCz[1],
//                        setting3Denominate: ragnador.ratioFirstHitCz[2],
//                        setting4Denominate: ragnador.ratioFirstHitCz[3],
//                        setting5Denominate: ragnador.ratioFirstHitCz[4],
//                        setting6Denominate: ragnador.ratioFirstHitCz[5]
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
//                        currentCount: $ragnador.firstHitCountAt,
//                        bigNumber: $ragnador.normalGame,
//                        setting1Denominate: ragnador.ratioFirstHitAt[0],
//                        setting2Denominate: ragnador.ratioFirstHitAt[1],
//                        setting3Denominate: ragnador.ratioFirstHitAt[2],
//                        setting4Denominate: ragnador.ratioFirstHitAt[3],
//                        setting5Denominate: ragnador.ratioFirstHitAt[4],
//                        setting6Denominate: ragnador.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ragnador.machineName,
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
    ragnadorView95Ci(
        ragnador: Ragnador(),
    )
}
