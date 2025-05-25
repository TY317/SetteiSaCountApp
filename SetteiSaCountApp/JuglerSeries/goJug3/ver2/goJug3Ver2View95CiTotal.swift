//
//  goJug3Ver2View95CiTotal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/23.
//

import SwiftUI

struct goJug3Ver2View95CiTotal: View {
//    @ObservedObject var goJug3 = GoJug3()
    @ObservedObject var goJug3: GoJug3
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // //// ぶどう 逆算有効状態に合わせて
            if goJug3.startBackCalculationEnable {
                // ぶどう 逆算分含む
                unitListSection95Ci(
                    grafTitle: "総合結果\nぶどう回数",
                    grafView: AnyView(
                        unitChart95CiDenominate(
                            currentCount: $goJug3.totalBellCount,
                            bigNumber: $goJug3.currentGames,
                            setting1Denominate: goJug3.denominateListBell[0],
                            setting2Denominate: goJug3.denominateListBell[1],
                            setting3Denominate: goJug3.denominateListBell[2],
                            setting4Denominate: goJug3.denominateListBell[3],
                            setting5Denominate: goJug3.denominateListBell[4],
                            setting6Denominate: goJug3.denominateListBell[5],
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
                            currentCount: $goJug3.personalBellCount,
                            bigNumber: $goJug3.playGame,
                            setting1Denominate: goJug3.denominateListBell[0],
                            setting2Denominate: goJug3.denominateListBell[1],
                            setting3Denominate: goJug3.denominateListBell[2],
                            setting4Denominate: goJug3.denominateListBell[3],
                            setting5Denominate: goJug3.denominateListBell[4],
                            setting6Denominate: goJug3.denominateListBell[5],
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
                        currentCount: $goJug3.totalBigCount,
                        bigNumber: $goJug3.currentGames,
                        setting1Denominate: goJug3.denominateListBigSum[0],
                        setting2Denominate: goJug3.denominateListBigSum[1],
                        setting3Denominate: goJug3.denominateListBigSum[2],
                        setting4Denominate: goJug3.denominateListBigSum[3],
                        setting5Denominate: goJug3.denominateListBigSum[4],
                        setting6Denominate: goJug3.denominateListBigSum[5]
                    )
                )
            )
            .tag(2)
            // REG合算回数
            unitListSection95Ci(
                grafTitle: "総合結果\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $goJug3.totalRegCount,
                        bigNumber: $goJug3.currentGames,
                        setting1Denominate: goJug3.denominateListRegSum[0],
                        setting2Denominate: goJug3.denominateListRegSum[1],
                        setting3Denominate: goJug3.denominateListRegSum[2],
                        setting4Denominate: goJug3.denominateListRegSum[3],
                        setting5Denominate: goJug3.denominateListRegSum[4],
                        setting6Denominate: goJug3.denominateListRegSum[5]
                    )
                )
            )
            .tag(5)
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "総合結果\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $goJug3.totalBonusCountSum,
                        bigNumber: $goJug3.currentGames,
                        setting1Denominate: goJug3.denominateListBonusSum[0],
                        setting2Denominate: goJug3.denominateListBonusSum[1],
                        setting3Denominate: goJug3.denominateListBonusSum[2],
                        setting4Denominate: goJug3.denominateListBonusSum[3],
                        setting5Denominate: goJug3.denominateListBonusSum[4],
                        setting6Denominate: goJug3.denominateListBonusSum[5]
                    )
                )
            )
            .tag(6)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ゴーゴージャグラー3",
                screenClass: screenClass
            )
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
    goJug3Ver2View95CiTotal(goJug3: GoJug3())
}
