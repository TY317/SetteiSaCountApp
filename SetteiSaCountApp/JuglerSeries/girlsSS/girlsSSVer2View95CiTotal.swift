//
//  girlsSSVer2View95CiTotal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/09.
//

import SwiftUI

struct girlsSSVer2View95CiTotal: View {
//    @ObservedObject var girlsSS = GirlsSS()
    @ObservedObject var girlsSS: GirlsSS
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // //// ぶどう 逆算有効状態に合わせて
            if girlsSS.startBackCalculationEnable {
                // ぶどう 逆算分含む
                unitListSection95Ci(
                    grafTitle: "総合結果\nぶどう回数",
                    grafView: AnyView(
                        unitChart95CiDenominate(
                            currentCount: $girlsSS.totalBellCount,
                            bigNumber: $girlsSS.currentGames,
                            setting1Denominate: girlsSS.denominateListBell[0],
                            setting2Denominate: girlsSS.denominateListBell[1],
                            setting3Denominate: girlsSS.denominateListBell[2],
                            setting4Denominate: girlsSS.denominateListBell[3],
                            setting5Denominate: girlsSS.denominateListBell[4],
                            setting6Denominate: girlsSS.denominateListBell[5],
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
                            currentCount: $girlsSS.personalBellCount,
                            bigNumber: $girlsSS.playGame,
                            setting1Denominate: girlsSS.denominateListBell[0],
                            setting2Denominate: girlsSS.denominateListBell[1],
                            setting3Denominate: girlsSS.denominateListBell[2],
                            setting4Denominate: girlsSS.denominateListBell[3],
                            setting5Denominate: girlsSS.denominateListBell[4],
                            setting6Denominate: girlsSS.denominateListBell[5],
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
                        currentCount: $girlsSS.totalBigCount,
                        bigNumber: $girlsSS.currentGames,
                        setting1Denominate: girlsSS.denominateListBigSum[0],
                        setting2Denominate: girlsSS.denominateListBigSum[1],
                        setting3Denominate: girlsSS.denominateListBigSum[2],
                        setting4Denominate: girlsSS.denominateListBigSum[3],
                        setting5Denominate: girlsSS.denominateListBigSum[4],
                        setting6Denominate: girlsSS.denominateListBigSum[5]
                    )
                )
            )
            .tag(2)
            // REG合算回数
            unitListSection95Ci(
                grafTitle: "総合結果\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $girlsSS.totalRegCount,
                        bigNumber: $girlsSS.currentGames,
                        setting1Denominate: girlsSS.denominateListRegSum[0],
                        setting2Denominate: girlsSS.denominateListRegSum[1],
                        setting3Denominate: girlsSS.denominateListRegSum[2],
                        setting4Denominate: girlsSS.denominateListRegSum[3],
                        setting5Denominate: girlsSS.denominateListRegSum[4],
                        setting6Denominate: girlsSS.denominateListRegSum[5]
                    )
                )
            )
            .tag(3)
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "総合結果\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $girlsSS.totalBonusCountSum,
                        bigNumber: $girlsSS.currentGames,
                        setting1Denominate: girlsSS.denominateListBonusSum[0],
                        setting2Denominate: girlsSS.denominateListBonusSum[1],
                        setting3Denominate: girlsSS.denominateListBonusSum[2],
                        setting4Denominate: girlsSS.denominateListBonusSum[3],
                        setting5Denominate: girlsSS.denominateListBonusSum[4],
                        setting6Denominate: girlsSS.denominateListBonusSum[5]
                    )
                )
            )
            .tag(4)
//            // 単独BIG回数
//            unitListSection95Ci(
//                grafTitle: "自分のプレイデータ\n 単独BIG回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $girlsSS.personalAloneBigCount,
//                        bigNumber: $girlsSS.playGame,
//                        setting1Denominate: girlsSS.denominateListBigAlone[0],
//                        setting2Denominate: girlsSS.denominateListBigAlone[1],
//                        setting3Denominate: girlsSS.denominateListBigAlone[2],
//                        setting4Denominate: girlsSS.denominateListBigAlone[3],
//                        setting5Denominate: girlsSS.denominateListBigAlone[4],
//                        setting6Denominate: girlsSS.denominateListBigAlone[5]
//                    )
//                )
//            )
//            .tag(7)
//            // 🍒BIG回数
//            unitListSection95Ci(
//                grafTitle: "自分のプレイデータ\n 🍒BIG回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $girlsSS.personalCherryBigCount,
//                        bigNumber: $girlsSS.playGame,
//                        setting1Denominate: girlsSS.denominateListBigCherry[0],
//                        setting2Denominate: girlsSS.denominateListBigCherry[1],
//                        setting3Denominate: girlsSS.denominateListBigCherry[2],
//                        setting4Denominate: girlsSS.denominateListBigCherry[3],
//                        setting5Denominate: girlsSS.denominateListBigCherry[4],
//                        setting6Denominate: girlsSS.denominateListBigCherry[5]
//                    )
//                )
//            )
//            .tag(8)
//            // 単独REG回数
//            unitListSection95Ci(
//                grafTitle: "自分のプレイデータ\n 単独REG回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $girlsSS.personalAloneRegCount,
//                        bigNumber: $girlsSS.playGame,
//                        setting1Denominate: girlsSS.denominateListRegAlone[0],
//                        setting2Denominate: girlsSS.denominateListRegAlone[1],
//                        setting3Denominate: girlsSS.denominateListRegAlone[2],
//                        setting4Denominate: girlsSS.denominateListRegAlone[3],
//                        setting5Denominate: girlsSS.denominateListRegAlone[4],
//                        setting6Denominate: girlsSS.denominateListRegAlone[5]
//                    )
//                )
//            )
//            .tag(5)
//            // 🍒REG回数
//            unitListSection95Ci(
//                grafTitle: "自分のプレイデータ\n 🍒REG回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $girlsSS.personalCherryRegCount,
//                        bigNumber: $girlsSS.playGame,
//                        setting1Denominate: girlsSS.denominateListRegCherry[0],
//                        setting2Denominate: girlsSS.denominateListRegCherry[1],
//                        setting3Denominate: girlsSS.denominateListRegCherry[2],
//                        setting4Denominate: girlsSS.denominateListRegCherry[3],
//                        setting5Denominate: girlsSS.denominateListRegCherry[4],
//                        setting6Denominate: girlsSS.denominateListRegCherry[5]
//                    )
//                )
//            )
//            .tag(6)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ジャグラーガールズSS",
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
    girlsSSVer2View95CiTotal(girlsSS: GirlsSS())
}
