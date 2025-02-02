//
//  imJugExVer2View95CiStart.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/23.
//

import SwiftUI

struct imJugExVer2View95CiStart: View {
    @ObservedObject var imJugEx = ImJugEx()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            if imJugEx.startBackCalculationEnable {
                // ぶどう回数
                unitListSection95Ci(
                    grafTitle: "打ち始め\nぶどう回数",
                    grafView: AnyView(
                        unitChart95CiDenominate(
                            currentCount: $imJugEx.startBellBackCalculationCount,
                            bigNumber: $imJugEx.startGameInput,
                            setting1Denominate: 6.02,
                            setting2Denominate: 6.02,
                            setting3Denominate: 6.02,
                            setting4Denominate: 6.02,
                            setting5Denominate: 6.02,
                            setting6Denominate: 5.78,
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
                        currentCount: $imJugEx.startBigCountInput,
                        bigNumber: $imJugEx.startGameInput,
                        setting1Denominate: 273,
                        setting2Denominate: 270,
                        setting3Denominate: 270,
                        setting4Denominate: 259,
                        setting5Denominate: 259,
                        setting6Denominate: 255
                    )
                )
            )
            .tag(2)
            // REG回数
            unitListSection95Ci(
                grafTitle: "打ち始め\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $imJugEx.startRegCountInput,
                        bigNumber: $imJugEx.startGameInput,
                        setting1Denominate: 440,
                        setting2Denominate: 400,
                        setting3Denominate: 331,
                        setting4Denominate: 315,
                        setting5Denominate: 255,
                        setting6Denominate: 255
                    )
                )
            )
            .tag(3)
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "打ち始め\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $imJugEx.startBonusCountSum,
                        bigNumber: $imJugEx.startGameInput,
                        setting1Denominate: 169,
                        setting2Denominate: 161,
                        setting3Denominate: 149,
                        setting4Denominate: 142,
                        setting5Denominate: 129,
                        setting6Denominate: 128
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
    imJugExVer2View95CiStart()
}
