//
//  girlsSSVer2View95CiKen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/09.
//

import SwiftUI

struct girlsSSVer2View95CiKen: View {
    @ObservedObject var girlsSS = GirlsSS()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            if girlsSS.kenBackCalculationEnable {
                // ぶどう回数
                unitListSection95Ci(
                    grafTitle: "見\nぶどう回数",
                    grafView: AnyView(
                        unitChart95CiDenominate(
                            currentCount: $girlsSS.kenBellBackCalculationCount,
                            bigNumber: $girlsSS.kenGameIput,
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
                grafTitle: "見\n BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $girlsSS.kenBigCountInput,
                        bigNumber: $girlsSS.kenGameIput,
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
            // REG回数
            unitListSection95Ci(
                grafTitle: "見\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $girlsSS.kenRegCountInput,
                        bigNumber: $girlsSS.kenGameIput,
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
            // REG回数
            unitListSection95Ci(
                grafTitle: "見\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $girlsSS.kenBonusCountSum,
                        bigNumber: $girlsSS.kenGameIput,
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
    girlsSSVer2View95CiKen()
}
