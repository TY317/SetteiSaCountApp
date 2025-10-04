//
//  urmiraView95CiPersonal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/01.
//

import SwiftUI

struct urmiraView95CiPersonal: View {
    @ObservedObject var urmira: Urmira
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // ぶどう回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nぶどう回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $urmira.personalBellCount,
                        bigNumber: $urmira.playGame,
                        setting1Denominate: urmira.denominateListBell[0],
                        setting2Denominate: urmira.denominateListBell[1],
                        setting3Denominate: urmira.denominateListBell[2],
                        setting4Denominate: urmira.denominateListBell[3],
                        setting5Denominate: urmira.denominateListBell[4],
                        setting6Denominate: urmira.denominateListBell[5],
                        yScaleKeisu: 0.05
                    )
                )
            )
            .tag(1)
            // チェリー回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n🍒回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $urmira.personalCherryCount,
                        bigNumber: $urmira.playGame,
                        setting1Denominate: urmira.denominateListCherry[0],
                        setting2Denominate: urmira.denominateListCherry[1],
                        setting3Denominate: urmira.denominateListCherry[2],
                        setting4Denominate: urmira.denominateListCherry[3],
                        setting5Denominate: urmira.denominateListCherry[4],
                        setting6Denominate: urmira.denominateListCherry[5]
                    )
                )
            )
            .tag(9)
            // BIG合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $urmira.personalBigCountSum,
                        bigNumber: $urmira.playGame,
                        setting1Denominate: urmira.denominateListBigSum[0],
                        setting2Denominate: urmira.denominateListBigSum[1],
                        setting3Denominate: urmira.denominateListBigSum[2],
                        setting4Denominate: urmira.denominateListBigSum[3],
                        setting5Denominate: urmira.denominateListBigSum[4],
                        setting6Denominate: urmira.denominateListBigSum[5]
                    )
                )
            )
            .tag(2)
            // REG合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $urmira.personalRegCountSum,
                        bigNumber: $urmira.playGame,
                        setting1Denominate: urmira.denominateListRegSum[0],
                        setting2Denominate: urmira.denominateListRegSum[1],
                        setting3Denominate: urmira.denominateListRegSum[2],
                        setting4Denominate: urmira.denominateListRegSum[3],
                        setting5Denominate: urmira.denominateListRegSum[4],
                        setting6Denominate: urmira.denominateListRegSum[5]
                    )
                )
            )
            .tag(3)
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $urmira.personalBonusCountSum,
                        bigNumber: $urmira.playGame,
                        setting1Denominate: urmira.denominateListBonusSum[0],
                        setting2Denominate: urmira.denominateListBonusSum[1],
                        setting3Denominate: urmira.denominateListBonusSum[2],
                        setting4Denominate: urmira.denominateListBonusSum[3],
                        setting5Denominate: urmira.denominateListBonusSum[4],
                        setting6Denominate: urmira.denominateListBonusSum[5]
                    )
                )
            )
            .tag(4)
//            // 単独BIG合算回数
//            unitListSection95Ci(
//                grafTitle: "自分のプレイデータ\n 単独BIG回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $urmira.personalAloneBigCount,
//                        bigNumber: $urmira.playGame,
//                        setting1Denominate: urmira.denominateListBigAlone[0],
//                        setting2Denominate: urmira.denominateListBigAlone[1],
//                        setting3Denominate: urmira.denominateListBigAlone[2],
//                        setting4Denominate: urmira.denominateListBigAlone[3],
//                        setting5Denominate: urmira.denominateListBigAlone[4],
//                        setting6Denominate: urmira.denominateListBigAlone[5]
//                    )
//                )
//            )
//            .tag(5)
//            // チェリーBIG合算回数
//            unitListSection95Ci(
//                grafTitle: "自分のプレイデータ\n 🍒BIG回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $urmira.personalCherryBigCount,
//                        bigNumber: $urmira.playGame,
//                        setting1Denominate: urmira.denominateListBigCherry[0],
//                        setting2Denominate: urmira.denominateListBigCherry[1],
//                        setting3Denominate: urmira.denominateListBigCherry[2],
//                        setting4Denominate: urmira.denominateListBigCherry[3],
//                        setting5Denominate: urmira.denominateListBigCherry[4],
//                        setting6Denominate: urmira.denominateListBigCherry[5]
//                    )
//                )
//            )
//            .tag(6)
//            // 単独REG回数
//            unitListSection95Ci(
//                grafTitle: "自分のプレイデータ\n 単独REG回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $urmira.personalAloneRegCount,
//                        bigNumber: $urmira.playGame,
//                        setting1Denominate: urmira.denominateListRegAlone[0],
//                        setting2Denominate: urmira.denominateListRegAlone[1],
//                        setting3Denominate: urmira.denominateListRegAlone[2],
//                        setting4Denominate: urmira.denominateListRegAlone[3],
//                        setting5Denominate: urmira.denominateListRegAlone[4],
//                        setting6Denominate: urmira.denominateListRegAlone[5]
//                    )
//                )
//            )
//            .tag(7)
//            // 🍒REG回数
//            unitListSection95Ci(
//                grafTitle: "自分のプレイデータ\n 🍒REG回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $urmira.personalCherryRegCount,
//                        bigNumber: $urmira.playGame,
//                        setting1Denominate: urmira.denominateListRegCherry[0],
//                        setting2Denominate: urmira.denominateListRegCherry[1],
//                        setting3Denominate: urmira.denominateListRegCherry[2],
//                        setting4Denominate: urmira.denominateListRegCherry[3],
//                        setting5Denominate: urmira.denominateListRegCherry[4],
//                        setting6Denominate: urmira.denominateListRegCherry[5]
//                    )
//                )
//            )
//            .tag(8)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: urmira.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("95%信頼区間グラフ")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButton95CiExplain(isShow95CiExplain: isShow95CiExplain)
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    urmiraView95CiPersonal(
        urmira: Urmira(),
    )
}
