//
//  imJugExVer2View95CiTotal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/22.
//

import SwiftUI

struct imJugExVer2View95CiTotal: View {
//    @ObservedObject var imJugEx = ImJugEx()
    @ObservedObject var imJugEx: ImJugEx
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // //// ぶどう 逆算有効状態に合わせて
            if imJugEx.startBackCalculationEnable {
                // ぶどう 逆算分含む
                unitListSection95Ci(
                    grafTitle: "総合結果\nぶどう回数",
                    grafView: AnyView(
                        unitChart95CiDenominate(
                            currentCount: $imJugEx.totalBellCount,
                            bigNumber: $imJugEx.currentGames,
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
            } else {
                // ぶどう 自分の分のみ
                unitListSection95Ci(
                    grafTitle: "総合結果\nぶどう回数",
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
            }
            // BIG回数
            unitListSection95Ci(
                grafTitle: "総合結果\n BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $imJugEx.totalBigCount,
                        bigNumber: $imJugEx.currentGames,
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
                grafTitle: "総合結果\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $imJugEx.totalRegCount,
                        bigNumber: $imJugEx.currentGames,
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
                grafTitle: "総合結果\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $imJugEx.totalBonusCountSum,
                        bigNumber: $imJugEx.currentGames,
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
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "アイムジャグラーEX",
                screenClass: screenClass
            )
        }
        .navigationTitle("95%信頼区間グラフ")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButton95CiExplain(isShow95CiExplain: isShow95CiExplain)
//                    .popoverTip(tipUnitButton95CiExplain())
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    imJugExVer2View95CiTotal(imJugEx: ImJugEx())
}
