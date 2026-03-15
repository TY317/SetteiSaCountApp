//
//  thunderView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/14.
//

import SwiftUI

struct thunderView95Ci: View {
    @ObservedObject var thunder: Thunder
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // ベル合算回数
            unitListSection95Ci(
                grafTitle: "🔔合算回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $thunder.normalKoyakuCountBellSum,
                        bigNumber: $thunder.playGame,
                        setting1Denominate: thunder.ratioBellSum[0],
                        setting2Denominate: thunder.ratioBellSum[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: thunder.ratioBellSum[2],
                        setting6Denominate: thunder.ratioBellSum[3]
                    )
                )
            )
            .tag(1)
            // スイカ回数
            unitListSection95Ci(
                grafTitle: "🍉回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $thunder.normalKoyakuCountSuika,
                        bigNumber: $thunder.playGame,
                        setting1Denominate: thunder.ratioSuika[0],
                        setting2Denominate: thunder.ratioSuika[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: thunder.ratioSuika[2],
                        setting6Denominate: thunder.ratioSuika[3]
                    )
                )
            )
            .tag(2)
            // チェリーB回数
            unitListSection95Ci(
                grafTitle: "🍒B回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $thunder.normalKoyakuCountCherryB,
                        bigNumber: $thunder.playGame,
                        setting1Denominate: thunder.ratioCherryB[0],
                        setting2Denominate: thunder.ratioCherryB[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: thunder.ratioCherryB[2],
                        setting6Denominate: thunder.ratioCherryB[3]
                    )
                )
            )
            .tag(3)
            // BIG回数
            unitListSection95Ci(
                grafTitle: "BIG回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $thunder.totalBig,
                        bigNumber: $thunder.totalGame,
                        setting1Denominate: thunder.ratioBig[0],
                        setting2Denominate: thunder.ratioBig[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: thunder.ratioBig[2],
                        setting6Denominate: thunder.ratioBig[3]
                    )
                )
            )
            .tag(4)
            // REG回数
            unitListSection95Ci(
                grafTitle: "REG回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $thunder.totalReg,
                        bigNumber: $thunder.totalGame,
                        setting1Denominate: thunder.ratioReg[0],
                        setting2Denominate: thunder.ratioReg[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: thunder.ratioReg[2],
                        setting6Denominate: thunder.ratioReg[3]
                    )
                )
            )
            .tag(5)
            // BTループ回数
            unitListSection95Ci(
                grafTitle: "BTループ回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $thunder.btRedSeven,
                        bigNumber: $thunder.playBig,
                        setting1Percent: thunder.ratioBtLoop[0],
                        setting2Percent: thunder.ratioBtLoop[1],
                        setting3Enable: false,
                        setting3Percent: -1,
                        setting4Enable: false,
                        setting4Percent: -1,
                        setting5Percent: thunder.ratioBtLoop[2],
                        setting6Percent: thunder.ratioBtLoop[3]
                    )
                )
            )
            .tag(6)
            
            // BB中　ベルB回数
            unitListSection95Ci(
                grafTitle: "BB中\n🔔B回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $thunder.bbCountBellB,
                        bigNumber: $thunder.bbGame,
                        setting1Denominate: thunder.ratioBbBellB[0],
                        setting2Denominate: thunder.ratioBbBellB[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: thunder.ratioBbBellB[2],
                        setting6Denominate: thunder.ratioBbBellB[3]
                    )
                )
            )
            .tag(7)
            
            // BB中　ベルC回数
            unitListSection95Ci(
                grafTitle: "BB中\n🔔C回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $thunder.bbCountBellC,
                        bigNumber: $thunder.bbGame,
                        setting1Denominate: thunder.ratioBbBellC[0],
                        setting2Denominate: thunder.ratioBbBellC[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: thunder.ratioBbBellC[2],
                        setting6Denominate: thunder.ratioBbBellC[3]
                    )
                )
            )
            .tag(8)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: thunder.machineName,
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
    thunderView95Ci(
        thunder: Thunder(),
    )
}
