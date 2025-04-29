//
//  symphoView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/25.
//

import SwiftUI

struct symphoView95Ci: View {
//    @ObservedObject var sympho = Symphogear()
    @ObservedObject var sympho: Symphogear
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $sympho.atCount,
                        bigNumber: $sympho.playGame,
                        setting1Denominate: 295,
                        setting2Denominate: 285,
                        setting3Enable: false,
                        setting3Denominate: -100,
                        setting4Denominate: 250,
                        setting5Denominate: 227,
                        setting6Denominate: 199
                    )
                )
            )
            .tag(1)
            // CZ 最終決戦回数
            unitListSection95Ci(
                grafTitle: "CZ 最終決戦回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $sympho.czSaishuCount,
                        bigNumber: $sympho.playGame,
                        setting1Denominate: 13000,
                        setting2Denominate: 10900,
                        setting3Enable: false,
                        setting3Denominate: -100,
                        setting4Denominate: 4600,
                        setting5Denominate: 2900,
                        setting6Denominate: 2500
                    )
                )
            )
            .tag(2)
            // AT終了画面 奇数示唆回数
            unitListSection95Ci(
                grafTitle: "AT終了画面 奇数示唆回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $sympho.screenCountWhiteA,
                        bigNumber: $sympho.screenCountSum,
                        setting1Percent: 22,
                        setting2Percent: 14,
                        setting3Enable: false,
                        setting3Percent: -100,
                        setting4Percent: 12,
                        setting5Percent: 17,
                        setting6Percent: 14
                    )
                )
            )
            .tag(3)
            // AT終了画面 偶数示唆回数
            unitListSection95Ci(
                grafTitle: "AT終了画面 偶数示唆回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $sympho.screenCountWhiteB,
                        bigNumber: $sympho.screenCountSum,
                        setting1Percent: 18,
                        setting2Percent: 20,
                        setting3Enable: false,
                        setting3Percent: -100,
                        setting4Percent: 17,
                        setting5Percent: 11,
                        setting6Percent: 17
                    )
                )
            )
            .tag(4)
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
    symphoView95Ci(sympho: Symphogear())
}
