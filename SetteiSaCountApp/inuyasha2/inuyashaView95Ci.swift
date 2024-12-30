//
//  inuyashaView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/22.
//

import SwiftUI

struct inuyashaView95Ci: View {
    @ObservedObject var inuyasha = Inuyasha()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // 小役合算回数
            unitListSection95Ci(
                grafTitle: "小役合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $inuyasha.koyakuCountSum,
                        bigNumber: $inuyasha.koyakuCountPlayGame,
                        setting1Denominate: 35.1,
                        setting2Denominate: 34.6,
                        setting3Denominate: 33.8,
                        setting4Denominate: 32.7,
                        setting5Denominate: 31.5,
                        setting6Denominate: 31.1
                    )
                )
            )
            .tag(4)
            // 弱チェリー回数
            unitListSection95Ci(
                grafTitle: "弱🍒回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $inuyasha.koyakuCountJakuCherry,
                        bigNumber: $inuyasha.koyakuCountPlayGame,
                        setting1Denominate: 69.3,
                        setting2Denominate: 68.7,
                        setting3Denominate: 67.3,
                        setting4Denominate: 65.9,
                        setting5Denominate: 64.6,
                        setting6Denominate: 64.0
                    )
                )
            )
            .tag(5)
            // 強チェリー回数
            unitListSection95Ci(
                grafTitle: "強🍒回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $inuyasha.koyakuCountKyoCherry,
                        bigNumber: $inuyasha.koyakuCountPlayGame,
                        setting1Denominate: 819,
                        setting2Denominate: 762,
                        setting3Denominate: 728,
                        setting4Denominate: 683,
                        setting5Denominate: 655,
                        setting6Denominate: 630
                    )
                )
            )
            .tag(6)
            // スイカ回数
            unitListSection95Ci(
                grafTitle: "スイカ回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $inuyasha.koyakuCountSuika,
                        bigNumber: $inuyasha.koyakuCountPlayGame,
                        setting1Denominate: 100,
                        setting2Denominate: 98.6,
                        setting3Denominate: 96.4,
                        setting4Denominate: 92.3,
                        setting5Denominate: 88.0,
                        setting6Denominate: 87.4
                    )
                )
            )
            .tag(7)
            // チャンス目A回数
            unitListSection95Ci(
                grafTitle: "チャンス目A回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $inuyasha.koyakuCountChanceA,
                        bigNumber: $inuyasha.koyakuCountPlayGame,
                        setting1Denominate: 655,
                        setting2Denominate: 655,
                        setting3Denominate: 630,
                        setting4Denominate: 607,
                        setting5Denominate: 565,
                        setting6Denominate: 546
                    )
                )
            )
            .tag(8)
            // チャンス目B回数
            unitListSection95Ci(
                grafTitle: "チャンス目B回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $inuyasha.koyakuCountChanceB,
                        bigNumber: $inuyasha.koyakuCountPlayGame,
                        setting1Denominate: 780,
                        setting2Denominate: 745,
                        setting3Denominate: 728,
                        setting4Denominate: 697,
                        setting5Denominate: 630,
                        setting6Denominate: 618
                    )
                )
            )
            .tag(9)
            // CZ初当り回数
            unitListSection95Ci(
                grafTitle: "CZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $inuyasha.czCount,
                        bigNumber: $inuyasha.playGameSum,
                        setting1Denominate: 249,
                        setting2Denominate: 244,
                        setting3Denominate: 240,
                        setting4Denominate: 234,
                        setting5Denominate: 217,
                        setting6Denominate: 210
                    )
                )
            )
            .tag(1)
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $inuyasha.atHitCount,
                        bigNumber: $inuyasha.playGameSum,
                        setting1Denominate: 435,
                        setting2Denominate: 420,
                        setting3Denominate: 402,
                        setting4Denominate: 366,
                        setting5Denominate: 336,
                        setting6Denominate: 313
                    )
                )
            )
            .tag(2)
            // 333天井越え回数
            unitListSection95Ci(
                grafTitle: "333G天井越えCZ回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $inuyasha.over333CzCount,
                        bigNumber: $inuyasha.czCount,
                        setting1Percent: 17.7,
                        setting2Percent: 17.2,
                        setting3Percent: 16.8,
                        setting4Percent: 13.8,
                        setting5Percent: 8.1,
                        setting6Percent: 5.1
                    )
                )
            )
            .tag(3)
        }
        .navigationTitle("95%信頼区間グラフ")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButton95CiExplain(isShow95CiExplain: isShow95CiExplain)
                    .popoverTip(tipUnitButton95CiExplain())
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    inuyashaView95Ci()
}
