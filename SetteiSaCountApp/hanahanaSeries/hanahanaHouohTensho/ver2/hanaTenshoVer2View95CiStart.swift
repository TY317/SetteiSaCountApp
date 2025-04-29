//
//  hanaTenshoVer2View95CiStart.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/26.
//

import SwiftUI

struct hanaTenshoVer2View95CiStart: View {
//    @ObservedObject var hanaTensho = HanaTensho()
    @ObservedObject var hanaTensho: HanaTensho
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            if hanaTensho.startBackCalculationEnable {
                // ぶどう回数
                unitListSection95Ci(
                    grafTitle: "打ち始め\nベル回数",
                    grafView: AnyView(
                        unitChart95CiDenominate(
                            currentCount: $hanaTensho.startBellBackCalculationCount,
                            bigNumber: $hanaTensho.startGameInput,
                            setting1Denominate: hanaTensho.denominateListBell[0],
                            setting2Denominate: hanaTensho.denominateListBell[1],
                            setting3Denominate: hanaTensho.denominateListBell[2],
                            setting4Denominate: hanaTensho.denominateListBell[3],
                            setting5Denominate: hanaTensho.denominateListBell[4],
                            setting6Denominate: hanaTensho.denominateListBell[5],
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
                        currentCount: $hanaTensho.startBigCountInput,
                        bigNumber: $hanaTensho.startGameInput,
                        setting1Denominate: hanaTensho.denominateListBig[0],
                        setting2Denominate: hanaTensho.denominateListBig[1],
                        setting3Denominate: hanaTensho.denominateListBig[2],
                        setting4Denominate: hanaTensho.denominateListBig[3],
                        setting5Denominate: hanaTensho.denominateListBig[4],
                        setting6Denominate: hanaTensho.denominateListBig[5]
                    )
                )
            )
            .tag(2)
            // REG回数
            unitListSection95Ci(
                grafTitle: "打ち始め\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hanaTensho.startRegCountInput,
                        bigNumber: $hanaTensho.startGameInput,
                        setting1Denominate: hanaTensho.denominateListReg[0],
                        setting2Denominate: hanaTensho.denominateListReg[1],
                        setting3Denominate: hanaTensho.denominateListReg[2],
                        setting4Denominate: hanaTensho.denominateListReg[3],
                        setting5Denominate: hanaTensho.denominateListReg[4],
                        setting6Denominate: hanaTensho.denominateListReg[5]
                    )
                )
            )
            .tag(3)
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "打ち始め\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hanaTensho.startBonusCountSum,
                        bigNumber: $hanaTensho.startGameInput,
                        setting1Denominate: hanaTensho.denominateListBonusSum[0],
                        setting2Denominate: hanaTensho.denominateListBonusSum[1],
                        setting3Denominate: hanaTensho.denominateListBonusSum[2],
                        setting4Denominate: hanaTensho.denominateListBonusSum[3],
                        setting5Denominate: hanaTensho.denominateListBonusSum[4],
                        setting6Denominate: hanaTensho.denominateListBonusSum[5]
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
    hanaTenshoVer2View95CiStart(hanaTensho: HanaTensho())
}
