//
//  starHanaVer2View95CiKen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/15.
//

import SwiftUI

struct starHanaVer2View95CiKen: View {
//    @ObservedObject var starHana = StarHana()
    @ObservedObject var starHana: StarHana
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            if starHana.kenBackCalculationEnable {
                // ぶどう回数
                unitListSection95Ci(
                    grafTitle: "見\nベル回数",
                    grafView: AnyView(
                        unitChart95CiDenominate(
                            currentCount: $starHana.kenBellBackCalculationCount,
                            bigNumber: $starHana.kenGameIput,
                            setting1Denominate: starHana.denominateListBell[0],
                            setting2Denominate: starHana.denominateListBell[1],
                            setting3Denominate: starHana.denominateListBell[2],
                            setting4Denominate: starHana.denominateListBell[3],
                            setting5Denominate: starHana.denominateListBell[4],
                            setting6Denominate: starHana.denominateListBell[5],
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
                        currentCount: $starHana.kenBigCountInput,
                        bigNumber: $starHana.kenGameIput,
                        setting1Denominate: starHana.denominateListBig[0],
                        setting2Denominate: starHana.denominateListBig[1],
                        setting3Denominate: starHana.denominateListBig[2],
                        setting4Denominate: starHana.denominateListBig[3],
                        setting5Denominate: starHana.denominateListBig[4],
                        setting6Denominate: starHana.denominateListBig[5]
                    )
                )
            )
            .tag(2)
            // REG回数
            unitListSection95Ci(
                grafTitle: "見\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $starHana.kenRegCountInput,
                        bigNumber: $starHana.kenGameIput,
                        setting1Denominate: starHana.denominateListReg[0],
                        setting2Denominate: starHana.denominateListReg[1],
                        setting3Denominate: starHana.denominateListReg[2],
                        setting4Denominate: starHana.denominateListReg[3],
                        setting5Denominate: starHana.denominateListReg[4],
                        setting6Denominate: starHana.denominateListReg[5]
                    )
                )
            )
            .tag(3)
            // REG回数
            unitListSection95Ci(
                grafTitle: "見\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $starHana.kenBonusCountSum,
                        bigNumber: $starHana.kenGameIput,
                        setting1Denominate: starHana.denominateListBonusSum[0],
                        setting2Denominate: starHana.denominateListBonusSum[1],
                        setting3Denominate: starHana.denominateListBonusSum[2],
                        setting4Denominate: starHana.denominateListBonusSum[3],
                        setting5Denominate: starHana.denominateListBonusSum[4],
                        setting6Denominate: starHana.denominateListBonusSum[5]
                    )
                )
            )
            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "スターハナハナ",
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
    starHanaVer2View95CiKen(starHana: StarHana())
}
