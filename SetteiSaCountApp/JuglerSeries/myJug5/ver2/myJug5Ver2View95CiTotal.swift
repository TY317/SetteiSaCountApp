//
//  myJug5Ver2View95CiTotal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/20.
//

import SwiftUI

struct myJug5Ver2View95CiTotal: View {
//    @ObservedObject var myJug5 = MyJug5()
    @ObservedObject var myJug5: MyJug5
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // //// ぶどう 逆算有効状態に合わせて
            if myJug5.startBackCalculationEnable {
                // ぶどう 逆算分含む
                unitListSection95Ci(
                    grafTitle: "総合結果\nぶどう回数",
                    grafView: AnyView(
                        unitChart95CiDenominate(
                            currentCount: $myJug5.totalBellCount,
                            bigNumber: $myJug5.currentGames,
                            setting1Denominate: myJug5.denominateListBell[0],
                            setting2Denominate: myJug5.denominateListBell[1],
                            setting3Denominate: myJug5.denominateListBell[2],
                            setting4Denominate: myJug5.denominateListBell[3],
                            setting5Denominate: myJug5.denominateListBell[4],
                            setting6Denominate: myJug5.denominateListBell[5],
                            yScaleKeisu: 0.05
                        )
                    )
                )
                .tag(1)
            } else {
                // ぶどう 自分の分のみ
                unitListSection95Ci(
                    grafTitle: "自分のプレイデータ\nぶどう回数",
                    grafView: AnyView(
                        unitChart95CiDenominate(
                            currentCount: $myJug5.personalBellCount,
                            bigNumber: $myJug5.playGame,
                            setting1Denominate: myJug5.denominateListBell[0],
                            setting2Denominate: myJug5.denominateListBell[1],
                            setting3Denominate: myJug5.denominateListBell[2],
                            setting4Denominate: myJug5.denominateListBell[3],
                            setting5Denominate: myJug5.denominateListBell[4],
                            setting6Denominate: myJug5.denominateListBell[5],
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
                        currentCount: $myJug5.totalBigCount,
                        bigNumber: $myJug5.currentGames,
                        setting1Denominate: myJug5.denominateListBigSum[0],
                        setting2Denominate: myJug5.denominateListBigSum[1],
                        setting3Denominate: myJug5.denominateListBigSum[2],
                        setting4Denominate: myJug5.denominateListBigSum[3],
                        setting5Denominate: myJug5.denominateListBigSum[4],
                        setting6Denominate: myJug5.denominateListBigSum[5]
                    )
                )
            )
            .tag(2)
            // REG合算回数
            unitListSection95Ci(
                grafTitle: "総合結果\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $myJug5.totalRegCount,
                        bigNumber: $myJug5.currentGames,
                        setting1Denominate: myJug5.denominateListRegSum[0],
                        setting2Denominate: myJug5.denominateListRegSum[1],
                        setting3Denominate: myJug5.denominateListRegSum[2],
                        setting4Denominate: myJug5.denominateListRegSum[3],
                        setting5Denominate: myJug5.denominateListRegSum[4],
                        setting6Denominate: myJug5.denominateListRegSum[5]
                    )
                )
            )
            .tag(3)
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "総合結果\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $myJug5.totalBonusCountSum,
                        bigNumber: $myJug5.currentGames,
                        setting1Denominate: myJug5.denominateListBonusSum[0],
                        setting2Denominate: myJug5.denominateListBonusSum[1],
                        setting3Denominate: myJug5.denominateListBonusSum[2],
                        setting4Denominate: myJug5.denominateListBonusSum[3],
                        setting5Denominate: myJug5.denominateListBonusSum[4],
                        setting6Denominate: myJug5.denominateListBonusSum[5]
                    )
                )
            )
            .tag(4)
            // 単独REG回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n 単独REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $myJug5.personalAloneRegCount,
                        bigNumber: $myJug5.playGame,
                        setting1Denominate: myJug5.denominateListRegAlone[0],
                        setting2Denominate: myJug5.denominateListRegAlone[1],
                        setting3Denominate: myJug5.denominateListRegAlone[2],
                        setting4Denominate: myJug5.denominateListRegAlone[3],
                        setting5Denominate: myJug5.denominateListRegAlone[4],
                        setting6Denominate: myJug5.denominateListRegAlone[5]
                    )
                )
            )
            .tag(5)
            // 🍒REG回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n 🍒REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $myJug5.personalCherryRegCount,
                        bigNumber: $myJug5.playGame,
                        setting1Denominate: myJug5.denominateListRegCherry[0],
                        setting2Denominate: myJug5.denominateListRegCherry[1],
                        setting3Denominate: myJug5.denominateListRegCherry[2],
                        setting4Denominate: myJug5.denominateListRegCherry[3],
                        setting5Denominate: myJug5.denominateListRegCherry[4],
                        setting6Denominate: myJug5.denominateListRegCherry[5]
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
    myJug5Ver2View95CiTotal(myJug5: MyJug5())
}
