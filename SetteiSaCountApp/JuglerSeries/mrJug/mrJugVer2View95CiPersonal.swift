//
//  mrJugVer2View95CiPersonal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/08.
//

import SwiftUI

struct mrJugVer2View95CiPersonal: View {
//    @ObservedObject var mrJug = MrJug()
    @ObservedObject var mrJug: MrJug
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // ぶどう回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nぶどう回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $mrJug.personalBellCount,
                        bigNumber: $mrJug.playGame,
                        setting1Denominate: mrJug.denominateListBell[0],
                        setting2Denominate: mrJug.denominateListBell[1],
                        setting3Denominate: mrJug.denominateListBell[2],
                        setting4Denominate: mrJug.denominateListBell[3],
                        setting5Denominate: mrJug.denominateListBell[4],
                        setting6Denominate: mrJug.denominateListBell[5],
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
                        currentCount: $mrJug.personalBigCountSum,
                        bigNumber: $mrJug.playGame,
                        setting1Denominate: mrJug.denominateListBigSum[0],
                        setting2Denominate: mrJug.denominateListBigSum[1],
                        setting3Denominate: mrJug.denominateListBigSum[2],
                        setting4Denominate: mrJug.denominateListBigSum[3],
                        setting5Denominate: mrJug.denominateListBigSum[4],
                        setting6Denominate: mrJug.denominateListBigSum[5]
                    )
                )
            )
            .tag(2)
            // REG合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $mrJug.personalRegCountSum,
                        bigNumber: $mrJug.playGame,
                        setting1Denominate: mrJug.denominateListRegSum[0],
                        setting2Denominate: mrJug.denominateListRegSum[1],
                        setting3Denominate: mrJug.denominateListRegSum[2],
                        setting4Denominate: mrJug.denominateListRegSum[3],
                        setting5Denominate: mrJug.denominateListRegSum[4],
                        setting6Denominate: mrJug.denominateListRegSum[5]
                    )
                )
            )
            .tag(3)
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $mrJug.personalBonusCountSum,
                        bigNumber: $mrJug.playGame,
                        setting1Denominate: mrJug.denominateListBonusSum[0],
                        setting2Denominate: mrJug.denominateListBonusSum[1],
                        setting3Denominate: mrJug.denominateListBonusSum[2],
                        setting4Denominate: mrJug.denominateListBonusSum[3],
                        setting5Denominate: mrJug.denominateListBonusSum[4],
                        setting6Denominate: mrJug.denominateListBonusSum[5]
                    )
                )
            )
            .tag(4)
//            // 単独BIG合算回数
//            unitListSection95Ci(
//                grafTitle: "自分のプレイデータ\n 単独BIG回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $mrJug.personalAloneBigCount,
//                        bigNumber: $mrJug.playGame,
//                        setting1Denominate: mrJug.denominateListBigAlone[0],
//                        setting2Denominate: mrJug.denominateListBigAlone[1],
//                        setting3Denominate: mrJug.denominateListBigAlone[2],
//                        setting4Denominate: mrJug.denominateListBigAlone[3],
//                        setting5Denominate: mrJug.denominateListBigAlone[4],
//                        setting6Denominate: mrJug.denominateListBigAlone[5]
//                    )
//                )
//            )
//            .tag(5)
//            // チェリーBIG合算回数
//            unitListSection95Ci(
//                grafTitle: "自分のプレイデータ\n 🍒BIG回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $mrJug.personalCherryBigCount,
//                        bigNumber: $mrJug.playGame,
//                        setting1Denominate: mrJug.denominateListBigCherry[0],
//                        setting2Denominate: mrJug.denominateListBigCherry[1],
//                        setting3Denominate: mrJug.denominateListBigCherry[2],
//                        setting4Denominate: mrJug.denominateListBigCherry[3],
//                        setting5Denominate: mrJug.denominateListBigCherry[4],
//                        setting6Denominate: mrJug.denominateListBigCherry[5]
//                    )
//                )
//            )
//            .tag(6)
//            // 単独REG回数
//            unitListSection95Ci(
//                grafTitle: "自分のプレイデータ\n 単独REG回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $mrJug.personalAloneRegCount,
//                        bigNumber: $mrJug.playGame,
//                        setting1Denominate: mrJug.denominateListRegAlone[0],
//                        setting2Denominate: mrJug.denominateListRegAlone[1],
//                        setting3Denominate: mrJug.denominateListRegAlone[2],
//                        setting4Denominate: mrJug.denominateListRegAlone[3],
//                        setting5Denominate: mrJug.denominateListRegAlone[4],
//                        setting6Denominate: mrJug.denominateListRegAlone[5]
//                    )
//                )
//            )
//            .tag(7)
//            // 🍒REG回数
//            unitListSection95Ci(
//                grafTitle: "自分のプレイデータ\n 🍒REG回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $mrJug.personalCherryRegCount,
//                        bigNumber: $mrJug.playGame,
//                        setting1Denominate: mrJug.denominateListRegCherry[0],
//                        setting2Denominate: mrJug.denominateListRegCherry[1],
//                        setting3Denominate: mrJug.denominateListRegCherry[2],
//                        setting4Denominate: mrJug.denominateListRegCherry[3],
//                        setting5Denominate: mrJug.denominateListRegCherry[4],
//                        setting6Denominate: mrJug.denominateListRegCherry[5]
//                    )
//                )
//            )
//            .tag(8)
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
    mrJugVer2View95CiPersonal(mrJug: MrJug())
}
