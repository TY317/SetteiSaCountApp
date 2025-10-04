//
//  urmiraView95CiStart.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/01.
//

import SwiftUI

struct urmiraView95CiStart: View {
    @ObservedObject var urmira: Urmira
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            if urmira.startBackCalculationEnable {
                // ぶどう回数
                unitListSection95Ci(
                    grafTitle: "打ち始め\nぶどう回数",
                    grafView: AnyView(
                        unitChart95CiDenominate(
                            currentCount: $urmira.startBellBackCalculationCount,
                            bigNumber: $urmira.startGameInput,
                            setting1Denominate: urmira.denominateListBell[0],
                            setting2Denominate: urmira.denominateListBell[1],
                            setting3Denominate: urmira.denominateListBell[2],
                            setting4Denominate: urmira.denominateListBell[3],
                            setting5Denominate: urmira.denominateListBell[4],
                            setting6Denominate: urmira.denominateListBell[5],
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
                        currentCount: $urmira.startBigCountInput,
                        bigNumber: $urmira.startGameInput,
                        setting1Denominate: urmira.denominateListBigSum[0],
                        setting2Denominate: urmira.denominateListBigSum[1],
                        setting3Denominate: urmira.denominateListBigSum[2],
                        setting4Denominate: urmira.denominateListBigSum[3],
                        setting5Denominate: urmira.denominateListBigSum[4],
                        setting6Denominate: urmira.denominateListBigSum[5]
                    )
                )
            )
            .tag(2)
            // REG回数
            unitListSection95Ci(
                grafTitle: "打ち始め\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $urmira.startRegCountInput,
                        bigNumber: $urmira.startGameInput,
                        setting1Denominate: urmira.denominateListRegSum[0],
                        setting2Denominate: urmira.denominateListRegSum[1],
                        setting3Denominate: urmira.denominateListRegSum[2],
                        setting4Denominate: urmira.denominateListRegSum[3],
                        setting5Denominate: urmira.denominateListRegSum[4],
                        setting6Denominate: urmira.denominateListRegSum[5]
                    )
                )
            )
            .tag(3)
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "打ち始め\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $urmira.startBonusCountSum,
                        bigNumber: $urmira.startGameInput,
                        setting1Denominate: urmira.denominateListBonusSum[0],
                        setting2Denominate: urmira.denominateListBonusSum[1],
                        setting3Denominate: urmira.denominateListBonusSum[2],
                        setting4Denominate: urmira.denominateListBonusSum[3],
                        setting5Denominate: urmira.denominateListBonusSum[4],
                        setting6Denominate: urmira.denominateListBonusSum[5]
                    )
                )
            )
            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: urmira.machineName,
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
    urmiraView95CiStart(
        urmira: Urmira(),
    )
}
