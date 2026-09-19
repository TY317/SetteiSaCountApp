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
            // 共通🔔
            unitListSection95Ci(
                grafTitle: "共通🔔",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $garei.koyakuCountCommonBell,
                        bigNumber: $garei.gameNumberPlay,
                        setting1Denominate: garei.ratioCommonBell[0],
                        setting2Denominate: garei.ratioCommonBell[1],
                        setting3Denominate: garei.ratioCommonBell[2],
                        setting4Denominate: garei.ratioCommonBell[3],
                        setting5Denominate: garei.ratioCommonBell[4],
                        setting6Denominate: garei.ratioCommonBell[5]
                    )
                )
            )
            .tag(1)

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
            .tag(2)

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
            .tag(3)

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
            .tag(4)

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
            .tag(5)

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
            .tag(6)

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
            .tag(7)

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
            .tag(8)

            // CZ初当り回数
            unitListSection95Ci(
                grafTitle: "CZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $garei.firstHitCountCz,
                        bigNumber: $garei.normalGame,
                        setting1Denominate: garei.ratioFirstHitCz[0],
                        setting2Denominate: garei.ratioFirstHitCz[1],
                        setting3Denominate: garei.ratioFirstHitCz[2],
                        setting4Denominate: garei.ratioFirstHitCz[3],
                        setting5Denominate: garei.ratioFirstHitCz[4],
                        setting6Denominate: garei.ratioFirstHitCz[5]
                    )
                )
            )
            .tag(9)

            // BIG初当り回数
            unitListSection95Ci(
                grafTitle: "BIG初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $garei.firstHitCountBig,
                        bigNumber: $garei.normalGame,
                        setting1Denominate: garei.ratioFirstHitBig[0],
                        setting2Denominate: garei.ratioFirstHitBig[1],
                        setting3Denominate: garei.ratioFirstHitBig[2],
                        setting4Denominate: garei.ratioFirstHitBig[3],
                        setting5Denominate: garei.ratioFirstHitBig[4],
                        setting6Denominate: garei.ratioFirstHitBig[5]
                    )
                )
            )
            .tag(10)

            // REG初当り回数
            unitListSection95Ci(
                grafTitle: "REG初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $garei.firstHitCountReg,
                        bigNumber: $garei.normalGame,
                        setting1Denominate: garei.ratioFirstHitReg[0],
                        setting2Denominate: garei.ratioFirstHitReg[1],
                        setting3Denominate: garei.ratioFirstHitReg[2],
                        setting4Denominate: garei.ratioFirstHitReg[3],
                        setting5Denominate: garei.ratioFirstHitReg[4],
                        setting6Denominate: garei.ratioFirstHitReg[5]
                    )
                )
            )
            .tag(11)

            // ART初当り回数
            unitListSection95Ci(
                grafTitle: "ART初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $garei.firstHitCountArt,
                        bigNumber: $garei.normalGame,
                        setting1Denominate: garei.ratioFirstHitArt[0],
                        setting2Denominate: garei.ratioFirstHitArt[1],
                        setting3Denominate: garei.ratioFirstHitArt[2],
                        setting4Denominate: garei.ratioFirstHitArt[3],
                        setting5Denominate: garei.ratioFirstHitArt[4],
                        setting6Denominate: garei.ratioFirstHitArt[5]
                    )
                )
            )
            .tag(12)

            // 乱撃突入率
            unitListSection95Ci(
                grafTitle: "乱撃突入率",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $garei.czRangekiCountHit,
                        bigNumber: $garei.czRangekiCountSum,
                        setting1Percent: garei.ratioCzRangeki[0],
                        setting2Percent: garei.ratioCzRangeki[1],
                        setting3Percent: garei.ratioCzRangeki[2],
                        setting4Percent: garei.ratioCzRangeki[3],
                        setting5Percent: garei.ratioCzRangeki[4],
                        setting6Percent: garei.ratioCzRangeki[5]
                    )
                )
            )
            .tag(13)

            // 高確スタート
            unitListSection95Ci(
                grafTitle: "ART終了後\n高確スタート",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $garei.startStatusCountHigh,
                        bigNumber: $garei.startStatusCountSum,
                        setting1Percent: garei.ratioStartStatusHigh[0],
                        setting2Percent: garei.ratioStartStatusHigh[1],
                        setting3Percent: garei.ratioStartStatusHigh[2],
                        setting4Percent: garei.ratioStartStatusHigh[3],
                        setting5Percent: garei.ratioStartStatusHigh[4],
                        setting6Percent: garei.ratioStartStatusHigh[5]
                    )
                )
            )
            .tag(14)

            // 超高確スタート
            unitListSection95Ci(
                grafTitle: "ART終了後\n超高確スタート",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $garei.startStatusCountSuperHigh,
                        bigNumber: $garei.startStatusCountSum,
                        setting1Percent: garei.ratioStartStatusSuperHigh[0],
                        setting2Percent: garei.ratioStartStatusSuperHigh[1],
                        setting3Percent: garei.ratioStartStatusSuperHigh[2],
                        setting4Percent: garei.ratioStartStatusSuperHigh[3],
                        setting5Percent: garei.ratioStartStatusSuperHigh[4],
                        setting6Percent: garei.ratioStartStatusSuperHigh[5]
                    )
                )
            )
            .tag(15)
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
