//
//  happyJugV3Ver2View95CiPersonal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/25.
//

import SwiftUI

struct happyJugV3Ver2View95CiPersonal: View {
    @ObservedObject var happyJugV3 = HappyJugV3()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // ぶどう回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nぶどう回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $happyJugV3.personalBellCount,
                        bigNumber: $happyJugV3.playGame,
                        setting1Denominate: happyJugV3.denominateListBell[0],
                        setting2Denominate: happyJugV3.denominateListBell[1],
                        setting3Denominate: happyJugV3.denominateListBell[2],
                        setting4Denominate: happyJugV3.denominateListBell[3],
                        setting5Denominate: happyJugV3.denominateListBell[4],
                        setting6Denominate: happyJugV3.denominateListBell[5],
                        yScaleKeisu: 0.05
                    )
                )
            )
            .tag(1)
            // BIG合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n BIG合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $happyJugV3.personalBigCountSum,
                        bigNumber: $happyJugV3.playGame,
                        setting1Denominate: happyJugV3.denominateListBigSum[0],
                        setting2Denominate: happyJugV3.denominateListBigSum[1],
                        setting3Denominate: happyJugV3.denominateListBigSum[2],
                        setting4Denominate: happyJugV3.denominateListBigSum[3],
                        setting5Denominate: happyJugV3.denominateListBigSum[4],
                        setting6Denominate: happyJugV3.denominateListBigSum[5]
                    )
                )
            )
            .tag(2)
            // REG合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n REG合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $happyJugV3.personalRegCountSum,
                        bigNumber: $happyJugV3.playGame,
                        setting1Denominate: happyJugV3.denominateListRegSum[0],
                        setting2Denominate: happyJugV3.denominateListRegSum[1],
                        setting3Denominate: happyJugV3.denominateListRegSum[2],
                        setting4Denominate: happyJugV3.denominateListRegSum[3],
                        setting5Denominate: happyJugV3.denominateListRegSum[4],
                        setting6Denominate: happyJugV3.denominateListRegSum[5]
                    )
                )
            )
            .tag(3)
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $happyJugV3.personalBonusCountSum,
                        bigNumber: $happyJugV3.playGame,
                        setting1Denominate: happyJugV3.denominateListBonusSum[0],
                        setting2Denominate: happyJugV3.denominateListBonusSum[1],
                        setting3Denominate: happyJugV3.denominateListBonusSum[2],
                        setting4Denominate: happyJugV3.denominateListBonusSum[3],
                        setting5Denominate: happyJugV3.denominateListBonusSum[4],
                        setting6Denominate: happyJugV3.denominateListBonusSum[5]
                    )
                )
            )
            .tag(4)
            // 単独BIG合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n 単独BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $happyJugV3.personalAloneBigCount,
                        bigNumber: $happyJugV3.playGame,
                        setting1Denominate: happyJugV3.denominateListBigAlone[0],
                        setting2Denominate: happyJugV3.denominateListBigAlone[1],
                        setting3Denominate: happyJugV3.denominateListBigAlone[2],
                        setting4Denominate: happyJugV3.denominateListBigAlone[3],
                        setting5Denominate: happyJugV3.denominateListBigAlone[4],
                        setting6Denominate: happyJugV3.denominateListBigAlone[5]
                    )
                )
            )
            .tag(5)
            // チェリーBIG合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n 🍒BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $happyJugV3.personalCherryBigCount,
                        bigNumber: $happyJugV3.playGame,
                        setting1Denominate: happyJugV3.denominateListBigCherry[0],
                        setting2Denominate: happyJugV3.denominateListBigCherry[1],
                        setting3Denominate: happyJugV3.denominateListBigCherry[2],
                        setting4Denominate: happyJugV3.denominateListBigCherry[3],
                        setting5Denominate: happyJugV3.denominateListBigCherry[4],
                        setting6Denominate: happyJugV3.denominateListBigCherry[5]
                    )
                )
            )
            .tag(6)
            // 単独REG回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n 単独REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $happyJugV3.personalAloneRegCount,
                        bigNumber: $happyJugV3.playGame,
                        setting1Denominate: happyJugV3.denominateListRegAlone[0],
                        setting2Denominate: happyJugV3.denominateListRegAlone[1],
                        setting3Denominate: happyJugV3.denominateListRegAlone[2],
                        setting4Denominate: happyJugV3.denominateListRegAlone[3],
                        setting5Denominate: happyJugV3.denominateListRegAlone[4],
                        setting6Denominate: happyJugV3.denominateListRegAlone[5]
                    )
                )
            )
            .tag(7)
            // 🍒REG回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n 🍒REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $happyJugV3.personalCherryRegCount,
                        bigNumber: $happyJugV3.playGame,
                        setting1Denominate: happyJugV3.denominateListRegCherry[0],
                        setting2Denominate: happyJugV3.denominateListRegCherry[1],
                        setting3Denominate: happyJugV3.denominateListRegCherry[2],
                        setting4Denominate: happyJugV3.denominateListRegCherry[3],
                        setting5Denominate: happyJugV3.denominateListRegCherry[4],
                        setting6Denominate: happyJugV3.denominateListRegCherry[5]
                    )
                )
            )
            .tag(8)
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
    happyJugV3Ver2View95CiPersonal()
}
