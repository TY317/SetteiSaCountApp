//
//  funky2Ver2View95CiKen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/09.
//

import SwiftUI

struct funky2Ver2View95CiKen: View {
    @ObservedObject var funky2 = Funky2()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            if funky2.kenBackCalculationEnable {
                // ぶどう回数
                unitListSection95Ci(
                    grafTitle: "見\nぶどう回数",
                    grafView: AnyView(
                        unitChart95CiDenominate(
                            currentCount: $funky2.kenBellBackCalculationCount,
                            bigNumber: $funky2.kenGameIput,
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
                grafTitle: "見\n BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $funky2.kenBigCountInput,
                        bigNumber: $funky2.kenGameIput,
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
                grafTitle: "見\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $funky2.kenRegCountInput,
                        bigNumber: $funky2.kenGameIput,
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
            // REG回数
            unitListSection95Ci(
                grafTitle: "見\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $funky2.kenBonusCountSum,
                        bigNumber: $funky2.kenGameIput,
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
    funky2Ver2View95CiKen()
}
