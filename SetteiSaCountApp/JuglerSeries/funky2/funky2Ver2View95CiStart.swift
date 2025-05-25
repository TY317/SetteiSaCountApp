//
//  funky2Ver2View95CiStart.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/09.
//

import SwiftUI

struct funky2Ver2View95CiStart: View {
//    @ObservedObject var funky2 = Funky2()
    @ObservedObject var funky2: Funky2
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            if funky2.startBackCalculationEnable {
                // ぶどう回数
                unitListSection95Ci(
                    grafTitle: "打ち始め\nぶどう回数",
                    grafView: AnyView(
                        unitChart95CiDenominate(
                            currentCount: $funky2.startBellBackCalculationCount,
                            bigNumber: $funky2.startGameInput,
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
            }
            // BIG回数
            unitListSection95Ci(
                grafTitle: "打ち始め\n BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $funky2.startBigCountInput,
                        bigNumber: $funky2.startGameInput,
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
            // REG回数
            unitListSection95Ci(
                grafTitle: "打ち始め\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $funky2.startRegCountInput,
                        bigNumber: $funky2.startGameInput,
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
                grafTitle: "打ち始め\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $funky2.startBonusCountSum,
                        bigNumber: $funky2.startGameInput,
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
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ファンキージャグラー2",
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
    funky2Ver2View95CiStart(funky2: Funky2())
}
