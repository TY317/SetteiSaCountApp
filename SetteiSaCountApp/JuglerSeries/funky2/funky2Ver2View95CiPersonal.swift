//
//  funky2Ver2View95CiPersonal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/09.
//

import SwiftUI

struct funky2Ver2View95CiPersonal: View {
    @ObservedObject var funky2 = Funky2()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // ぶどう回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nぶどう回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $funky2.personalBellCount,
                        bigNumber: $funky2.playGame,
                        setting1Denominate: funky2.denominateListBell[0],
                        setting2Denominate: funky2.denominateListBell[1],
                        setting3Denominate: funky2.denominateListBell[2],
                        setting4Denominate: funky2.denominateListBell[3],
                        setting5Denominate: funky2.denominateListBell[4],
                        setting6Denominate: funky2.denominateListBell[5],
                        yScaleKeisu: 0.05
                    )
                )
            )
            .tag(1)
            // BIG合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $funky2.personalBigCountSum,
                        bigNumber: $funky2.playGame,
                        setting1Denominate: funky2.denominateListBigSum[0],
                        setting2Denominate: funky2.denominateListBigSum[1],
                        setting3Denominate: funky2.denominateListBigSum[2],
                        setting4Denominate: funky2.denominateListBigSum[3],
                        setting5Denominate: funky2.denominateListBigSum[4],
                        setting6Denominate: funky2.denominateListBigSum[5]
                    )
                )
            )
            .tag(2)
            // REG合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $funky2.personalRegCountSum,
                        bigNumber: $funky2.playGame,
                        setting1Denominate: funky2.denominateListRegSum[0],
                        setting2Denominate: funky2.denominateListRegSum[1],
                        setting3Denominate: funky2.denominateListRegSum[2],
                        setting4Denominate: funky2.denominateListRegSum[3],
                        setting5Denominate: funky2.denominateListRegSum[4],
                        setting6Denominate: funky2.denominateListRegSum[5]
                    )
                )
            )
            .tag(3)
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $funky2.personalBonusCountSum,
                        bigNumber: $funky2.playGame,
                        setting1Denominate: funky2.denominateListBonusSum[0],
                        setting2Denominate: funky2.denominateListBonusSum[1],
                        setting3Denominate: funky2.denominateListBonusSum[2],
                        setting4Denominate: funky2.denominateListBonusSum[3],
                        setting5Denominate: funky2.denominateListBonusSum[4],
                        setting6Denominate: funky2.denominateListBonusSum[5]
                    )
                )
            )
            .tag(4)
            // 単独BIG合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n 単独BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $funky2.personalAloneBigCount,
                        bigNumber: $funky2.playGame,
                        setting1Denominate: funky2.denominateListBigAlone[0],
                        setting2Denominate: funky2.denominateListBigAlone[1],
                        setting3Denominate: funky2.denominateListBigAlone[2],
                        setting4Denominate: funky2.denominateListBigAlone[3],
                        setting5Denominate: funky2.denominateListBigAlone[4],
                        setting6Denominate: funky2.denominateListBigAlone[5]
                    )
                )
            )
            .tag(5)
            // チェリーBIG合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n 🍒BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $funky2.personalCherryBigCount,
                        bigNumber: $funky2.playGame,
                        setting1Denominate: funky2.denominateListBigCherry[0],
                        setting2Denominate: funky2.denominateListBigCherry[1],
                        setting3Denominate: funky2.denominateListBigCherry[2],
                        setting4Denominate: funky2.denominateListBigCherry[3],
                        setting5Denominate: funky2.denominateListBigCherry[4],
                        setting6Denominate: funky2.denominateListBigCherry[5]
                    )
                )
            )
            .tag(6)
            // 単独REG回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n 単独REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $funky2.personalAloneRegCount,
                        bigNumber: $funky2.playGame,
                        setting1Denominate: funky2.denominateListRegAlone[0],
                        setting2Denominate: funky2.denominateListRegAlone[1],
                        setting3Denominate: funky2.denominateListRegAlone[2],
                        setting4Denominate: funky2.denominateListRegAlone[3],
                        setting5Denominate: funky2.denominateListRegAlone[4],
                        setting6Denominate: funky2.denominateListRegAlone[5]
                    )
                )
            )
            .tag(7)
            // 🍒REG回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n 🍒REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $funky2.personalCherryRegCount,
                        bigNumber: $funky2.playGame,
                        setting1Denominate: funky2.denominateListRegCherry[0],
                        setting2Denominate: funky2.denominateListRegCherry[1],
                        setting3Denominate: funky2.denominateListRegCherry[2],
                        setting4Denominate: funky2.denominateListRegCherry[3],
                        setting5Denominate: funky2.denominateListRegCherry[4],
                        setting6Denominate: funky2.denominateListRegCherry[5]
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
    funky2Ver2View95CiPersonal()
}
