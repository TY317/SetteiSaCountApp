//
//  happyJugV3Ver2View95CiStart.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/25.
//

import SwiftUI

struct happyJugV3Ver2View95CiStart: View {
//    @ObservedObject var happyJugV3 = HappyJugV3()
    @ObservedObject var happyJugV3: HappyJugV3
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            if happyJugV3.startBackCalculationEnable {
                // ぶどう回数
                unitListSection95Ci(
                    grafTitle: "打ち始め\nぶどう回数",
                    grafView: AnyView(
                        unitChart95CiDenominate(
                            currentCount: $happyJugV3.startBellBackCalculationCount,
                            bigNumber: $happyJugV3.startGameInput,
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
            }
            // BIG回数
            unitListSection95Ci(
                grafTitle: "打ち始め\n BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $happyJugV3.startBigCountInput,
                        bigNumber: $happyJugV3.startGameInput,
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
            // REG回数
            unitListSection95Ci(
                grafTitle: "打ち始め\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $happyJugV3.startRegCountInput,
                        bigNumber: $happyJugV3.startGameInput,
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
                grafTitle: "打ち始め\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $happyJugV3.startBonusCountSum,
                        bigNumber: $happyJugV3.startGameInput,
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
    happyJugV3Ver2View95CiStart(happyJugV3: HappyJugV3())
}
