//
//  imJugExVer2View95CiPersonal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/23.
//

import SwiftUI

struct imJugExVer2View95CiPersonal: View {
    @ObservedObject var imJugEx = ImJugEx()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // ぶどう回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nぶどう回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $imJugEx.personalBellCount,
                        bigNumber: $imJugEx.playGame,
                        setting1Denominate: 6.02,
                        setting2Denominate: 6.02,
                        setting3Denominate: 6.02,
                        setting4Denominate: 6.02,
                        setting5Denominate: 6.02,
                        setting6Denominate: 5.78,
                        yScaleKeisu: 0.05
                    )
                )
            )
            .tag(1)
            // BIG回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $imJugEx.personalBigCount,
                        bigNumber: $imJugEx.playGame,
                        setting1Denominate: 273,
                        setting2Denominate: 270,
                        setting3Denominate: 270,
                        setting4Denominate: 259,
                        setting5Denominate: 259,
                        setting6Denominate: 255
                    )
                )
            )
            .tag(2)
            // REG合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n REG合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $imJugEx.personalRegCountSum,
                        bigNumber: $imJugEx.playGame,
                        setting1Denominate: 440,
                        setting2Denominate: 400,
                        setting3Denominate: 331,
                        setting4Denominate: 315,
                        setting5Denominate: 255,
                        setting6Denominate: 255
                    )
                )
            )
            .tag(3)
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $imJugEx.personalBonusCountSum,
                        bigNumber: $imJugEx.playGame,
                        setting1Denominate: 169,
                        setting2Denominate: 161,
                        setting3Denominate: 149,
                        setting4Denominate: 142,
                        setting5Denominate: 129,
                        setting6Denominate: 128
                    )
                )
            )
            .tag(4)
            // 単独REG回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n 単独REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $imJugEx.personalAloneRegCount,
                        bigNumber: $imJugEx.playGame,
                        setting1Denominate: 630,
                        setting2Denominate: 575,
                        setting3Denominate: 475,
                        setting4Denominate: 449,
                        setting5Denominate: 364,
                        setting6Denominate: 364
                    )
                )
            )
            .tag(5)
            // 🍒REG回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n 🍒REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $imJugEx.personalCherryRegCount,
                        bigNumber: $imJugEx.playGame,
                        setting1Denominate: 1456,
                        setting2Denominate: 1311,
                        setting3Denominate: 1092,
                        setting4Denominate: 1057,
                        setting5Denominate: 851,
                        setting6Denominate: 851
                    )
                )
            )
            .tag(6)
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
    imJugExVer2View95CiPersonal()
}
