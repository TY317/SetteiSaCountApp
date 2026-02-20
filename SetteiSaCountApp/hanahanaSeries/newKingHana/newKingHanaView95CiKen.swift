//
//  newKingHanaView95CiKen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/21.
//

import SwiftUI

struct newKingHanaView95CiKen: View {
    @ObservedObject var newKingHana: NewKingHana
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            if newKingHana.kenBackCalculationEnable {
                // ぶどう回数
                unitListSection95Ci(
                    grafTitle: "見\nベル回数",
                    grafView: AnyView(
                        unitChart95CiDenominate(
                            currentCount: $newKingHana.kenBellBackCalculationCount,
                            bigNumber: $newKingHana.kenGameIput,
                            setting1Denominate: newKingHana.ratioBell[0],
                            setting2Denominate: newKingHana.ratioBell[1],
                            setting3Denominate: newKingHana.ratioBell[2],
                            setting4Denominate: newKingHana.ratioBell[3],
                            setting5Enable: false,
                            setting5Denominate: -1,
                            setting6Denominate: newKingHana.ratioBell[4],
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
                        currentCount: $newKingHana.kenBigCountInput,
                        bigNumber: $newKingHana.kenGameIput,
                        setting1Denominate: newKingHana.ratioFirstHitBig[0],
                        setting2Denominate: newKingHana.ratioFirstHitBig[1],
                        setting3Denominate: newKingHana.ratioFirstHitBig[2],
                        setting4Denominate: newKingHana.ratioFirstHitBig[3],
                        setting5Enable: false,
                        setting5Denominate: -1,
                        setting6Denominate: newKingHana.ratioFirstHitBig[4]
                    )
                )
            )
            .tag(2)
            // REG回数
            unitListSection95Ci(
                grafTitle: "見\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $newKingHana.kenRegCountInput,
                        bigNumber: $newKingHana.kenGameIput,
                        setting1Denominate: newKingHana.ratioFirstHitReg[0],
                        setting2Denominate: newKingHana.ratioFirstHitReg[1],
                        setting3Denominate: newKingHana.ratioFirstHitReg[2],
                        setting4Denominate: newKingHana.ratioFirstHitReg[3],
                        setting5Enable: false,
                        setting5Denominate: -1,
                        setting6Denominate: newKingHana.ratioFirstHitReg[4]
                    )
                )
            )
            .tag(3)
            // REG回数
            unitListSection95Ci(
                grafTitle: "見\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $newKingHana.kenBonusCountSum,
                        bigNumber: $newKingHana.kenGameIput,
                        setting1Denominate: newKingHana.ratioFirstHitSum[0],
                        setting2Denominate: newKingHana.ratioFirstHitSum[1],
                        setting3Denominate: newKingHana.ratioFirstHitSum[2],
                        setting4Denominate: newKingHana.ratioFirstHitSum[3],
                        setting5Enable: false,
                        setting5Denominate: -1,
                        setting6Denominate: newKingHana.ratioFirstHitSum[4]
                    )
                )
            )
            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: newKingHana.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("95%信頼区間グラフ")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButton95CiExplain(isShow95CiExplain: isShow95CiExplain)
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    newKingHanaView95CiKen(
        newKingHana: NewKingHana(),
    )
}
