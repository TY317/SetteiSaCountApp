//
//  happyJugV3Ver2View95CiKen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/25.
//

import SwiftUI

struct happyJugV3Ver2View95CiKen: View {
//    @ObservedObject var happyJugV3 = HappyJugV3()
    @ObservedObject var happyJugV3: HappyJugV3
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            if happyJugV3.kenBackCalculationEnable {
                // ぶどう回数
                unitListSection95Ci(
                    grafTitle: "見\nぶどう回数",
                    grafView: AnyView(
                        unitChart95CiDenominate(
                            currentCount: $happyJugV3.kenBellBackCalculationCount,
                            bigNumber: $happyJugV3.kenGameIput,
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
                grafTitle: "見\n BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $happyJugV3.kenBigCountInput,
                        bigNumber: $happyJugV3.kenGameIput,
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
                grafTitle: "見\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $happyJugV3.kenRegCountInput,
                        bigNumber: $happyJugV3.kenGameIput,
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
            // REG回数
            unitListSection95Ci(
                grafTitle: "見\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $happyJugV3.kenBonusCountSum,
                        bigNumber: $happyJugV3.kenGameIput,
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
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ハッピージャグラーV3",
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
    happyJugV3Ver2View95CiKen(happyJugV3: HappyJugV3())
}
