//
//  mrJugVer2View95CiStart.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/08.
//

import SwiftUI

struct mrJugVer2View95CiStart: View {
//    @ObservedObject var mrJug = MrJug()
    @ObservedObject var mrJug: MrJug
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            if mrJug.startBackCalculationEnable {
                // ぶどう回数
                unitListSection95Ci(
                    grafTitle: "打ち始め\nぶどう回数",
                    grafView: AnyView(
                        unitChart95CiDenominate(
                            currentCount: $mrJug.startBellBackCalculationCount,
                            bigNumber: $mrJug.startGameInput,
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
            }
            // BIG回数
            unitListSection95Ci(
                grafTitle: "打ち始め\n BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $mrJug.startBigCountInput,
                        bigNumber: $mrJug.startGameInput,
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
            // REG回数
            unitListSection95Ci(
                grafTitle: "打ち始め\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $mrJug.startRegCountInput,
                        bigNumber: $mrJug.startGameInput,
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
                grafTitle: "打ち始め\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $mrJug.startBonusCountSum,
                        bigNumber: $mrJug.startGameInput,
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
    mrJugVer2View95CiStart(mrJug: MrJug())
}
