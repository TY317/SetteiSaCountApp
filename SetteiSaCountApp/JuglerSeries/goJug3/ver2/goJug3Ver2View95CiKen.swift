//
//  goJug3Ver2View95CiKen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/23.
//

import SwiftUI

struct goJug3Ver2View95CiKen: View {
    @ObservedObject var goJug3 = GoJug3()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            if goJug3.kenBackCalculationEnable {
                // ぶどう回数
                unitListSection95Ci(
                    grafTitle: "見\nぶどう回数",
                    grafView: AnyView(
                        unitChart95CiDenominate(
                            currentCount: $goJug3.kenBellBackCalculationCount,
                            bigNumber: $goJug3.kenGameIput,
                            setting1Denominate: 6.25,
                            setting2Denominate: 6.20,
                            setting3Denominate: 6.15,
                            setting4Denominate: 6.07,
                            setting5Denominate: 6.00,
                            setting6Denominate: 5.92,
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
                        currentCount: $goJug3.kenBigCountInput,
                        bigNumber: $goJug3.kenGameIput,
                        setting1Denominate: 259,
                        setting2Denominate: 258,
                        setting3Denominate: 257,
                        setting4Denominate: 254,
                        setting5Denominate: 247,
                        setting6Denominate: 235
                    )
                )
            )
            .tag(2)
            // REG回数
            unitListSection95Ci(
                grafTitle: "見\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $goJug3.kenRegCountInput,
                        bigNumber: $goJug3.kenGameIput,
                        setting1Denominate: 354,
                        setting2Denominate: 333,
                        setting3Denominate: 306,
                        setting4Denominate: 269,
                        setting5Denominate: 247,
                        setting6Denominate: 235
                    )
                )
            )
            .tag(3)
            // REG回数
            unitListSection95Ci(
                grafTitle: "見\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $goJug3.kenBonusCountSum,
                        bigNumber: $goJug3.kenGameIput,
                        setting1Denominate: 150,
                        setting2Denominate: 145,
                        setting3Denominate: 140,
                        setting4Denominate: 131,
                        setting5Denominate: 124,
                        setting6Denominate: 117
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
    goJug3Ver2View95CiKen()
}
