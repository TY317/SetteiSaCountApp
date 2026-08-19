//
//  gareiView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct gareiView95Ci: View {
    @ObservedObject var garei: Garei
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // 🍉
            unitListSection95Ci(
                grafTitle: "🍉",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $garei.koyakuCountSuika,
                        bigNumber: $garei.gameNumberPlay,
                        setting1Denominate: garei.ratioSuika[0],
                        setting2Denominate: garei.ratioSuika[1],
                        setting3Denominate: garei.ratioSuika[2],
                        setting4Denominate: garei.ratioSuika[3],
                        setting5Denominate: garei.ratioSuika[4],
                        setting6Denominate: garei.ratioSuika[5]
                    )
                )
            )
            .tag(1)

            // 弱🍒
            unitListSection95Ci(
                grafTitle: "弱🍒",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $garei.koyakuCountJakuCherry,
                        bigNumber: $garei.gameNumberPlay,
                        setting1Denominate: garei.ratioJakuCherry[0],
                        setting2Denominate: garei.ratioJakuCherry[1],
                        setting3Denominate: garei.ratioJakuCherry[2],
                        setting4Denominate: garei.ratioJakuCherry[3],
                        setting5Denominate: garei.ratioJakuCherry[4],
                        setting6Denominate: garei.ratioJakuCherry[5]
                    )
                )
            )
            .tag(2)

            // 強🍒
            unitListSection95Ci(
                grafTitle: "強🍒",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $garei.koyakuCountKyoCherry,
                        bigNumber: $garei.gameNumberPlay,
                        setting1Denominate: garei.ratioKyoCherry[0],
                        setting2Denominate: garei.ratioKyoCherry[1],
                        setting3Denominate: garei.ratioKyoCherry[2],
                        setting4Denominate: garei.ratioKyoCherry[3],
                        setting5Denominate: garei.ratioKyoCherry[4],
                        setting6Denominate: garei.ratioKyoCherry[5]
                    )
                )
            )
            .tag(3)

            // 弱チャンス目
            unitListSection95Ci(
                grafTitle: "弱チャンス目",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $garei.koyakuCountJakuChance,
                        bigNumber: $garei.gameNumberPlay,
                        setting1Denominate: garei.ratioJakuChance[0],
                        setting2Denominate: garei.ratioJakuChance[1],
                        setting3Denominate: garei.ratioJakuChance[2],
                        setting4Denominate: garei.ratioJakuChance[3],
                        setting5Denominate: garei.ratioJakuChance[4],
                        setting6Denominate: garei.ratioJakuChance[5]
                    )
                )
            )
            .tag(4)

            // 強チャンス目
            unitListSection95Ci(
                grafTitle: "強チャンス目",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $garei.koyakuCountKyoChance,
                        bigNumber: $garei.gameNumberPlay,
                        setting1Denominate: garei.ratioKyoChance[0],
                        setting2Denominate: garei.ratioKyoChance[1],
                        setting3Denominate: garei.ratioKyoChance[2],
                        setting4Denominate: garei.ratioKyoChance[3],
                        setting5Denominate: garei.ratioKyoChance[4],
                        setting6Denominate: garei.ratioKyoChance[5]
                    )
                )
            )
            .tag(5)

            // 弱🍒重複当選率
            unitListSection95Ci(
                grafTitle: "弱🍒重複",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $garei.chofukuCountJakuCherry,
                        bigNumber: $garei.koyakuCountJakuCherry,
                        setting1Percent: garei.ratioChofukuJakuCherry[0],
                        setting2Percent: garei.ratioChofukuJakuCherry[1],
                        setting3Percent: garei.ratioChofukuJakuCherry[2],
                        setting4Percent: garei.ratioChofukuJakuCherry[3],
                        setting5Percent: garei.ratioChofukuJakuCherry[4],
                        setting6Percent: garei.ratioChofukuJakuCherry[5]
                    )
                )
            )
            .tag(6)

            // 強🍒重複当選率
            unitListSection95Ci(
                grafTitle: "強🍒重複",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $garei.chofukuCountKyoCherry,
                        bigNumber: $garei.koyakuCountKyoCherry,
                        setting1Percent: garei.ratioChofukuKyoCherry[0],
                        setting2Percent: garei.ratioChofukuKyoCherry[1],
                        setting3Percent: garei.ratioChofukuKyoCherry[2],
                        setting4Percent: garei.ratioChofukuKyoCherry[3],
                        setting5Percent: garei.ratioChofukuKyoCherry[4],
                        setting6Percent: garei.ratioChofukuKyoCherry[5]
                    )
                )
            )
            .tag(7)

            // ボーナス初当り回数
            unitListSection95Ci(
                grafTitle: "ボーナス初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $garei.firstHitCountBonus,
                        bigNumber: $garei.normalGame,
                        setting1Denominate: garei.ratioFirstHitBonus[0],
                        setting2Denominate: garei.ratioFirstHitBonus[1],
                        setting3Denominate: garei.ratioFirstHitBonus[2],
                        setting4Denominate: garei.ratioFirstHitBonus[3],
                        setting5Denominate: garei.ratioFirstHitBonus[4],
                        setting6Denominate: garei.ratioFirstHitBonus[5]
                    )
                )
            )
            .tag(8)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: garei.machineName,
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
    gareiView95Ci(
        garei: Garei(),
    )
}
