//
//  draHanaSenkohVer2View95CiKen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/27.
//

import SwiftUI

struct draHanaSenkohVer2View95CiKen: View {
    @ObservedObject var draHanaSenkoh = DraHanaSenkoh()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            if draHanaSenkoh.kenBackCalculationEnable {
                // ぶどう回数
                unitListSection95Ci(
                    grafTitle: "見\nぶどう回数",
                    grafView: AnyView(
                        unitChart95CiDenominate(
                            currentCount: $draHanaSenkoh.kenBellBackCalculationCount,
                            bigNumber: $draHanaSenkoh.kenGameIput,
                            setting1Denominate: draHanaSenkoh.denominateListBell[0],
                            setting2Denominate: draHanaSenkoh.denominateListBell[1],
                            setting3Denominate: draHanaSenkoh.denominateListBell[2],
                            setting4Denominate: draHanaSenkoh.denominateListBell[3],
                            setting5Denominate: draHanaSenkoh.denominateListBell[4],
                            setting6Denominate: draHanaSenkoh.denominateListBell[5],
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
                        currentCount: $draHanaSenkoh.kenBigCountInput,
                        bigNumber: $draHanaSenkoh.kenGameIput,
                        setting1Denominate: draHanaSenkoh.denominateListBig[0],
                        setting2Denominate: draHanaSenkoh.denominateListBig[1],
                        setting3Denominate: draHanaSenkoh.denominateListBig[2],
                        setting4Denominate: draHanaSenkoh.denominateListBig[3],
                        setting5Denominate: draHanaSenkoh.denominateListBig[4],
                        setting6Denominate: draHanaSenkoh.denominateListBig[5]
                    )
                )
            )
            .tag(2)
            // REG回数
            unitListSection95Ci(
                grafTitle: "見\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $draHanaSenkoh.kenRegCountInput,
                        bigNumber: $draHanaSenkoh.kenGameIput,
                        setting1Denominate: draHanaSenkoh.denominateListReg[0],
                        setting2Denominate: draHanaSenkoh.denominateListReg[1],
                        setting3Denominate: draHanaSenkoh.denominateListReg[2],
                        setting4Denominate: draHanaSenkoh.denominateListReg[3],
                        setting5Denominate: draHanaSenkoh.denominateListReg[4],
                        setting6Denominate: draHanaSenkoh.denominateListReg[5]
                    )
                )
            )
            .tag(3)
            // REG回数
            unitListSection95Ci(
                grafTitle: "見\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $draHanaSenkoh.kenBonusCountSum,
                        bigNumber: $draHanaSenkoh.kenGameIput,
                        setting1Denominate: draHanaSenkoh.denominateListBonusSum[0],
                        setting2Denominate: draHanaSenkoh.denominateListBonusSum[1],
                        setting3Denominate: draHanaSenkoh.denominateListBonusSum[2],
                        setting4Denominate: draHanaSenkoh.denominateListBonusSum[3],
                        setting5Denominate: draHanaSenkoh.denominateListBonusSum[4],
                        setting6Denominate: draHanaSenkoh.denominateListBonusSum[5]
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
    draHanaSenkohVer2View95CiKen()
}
