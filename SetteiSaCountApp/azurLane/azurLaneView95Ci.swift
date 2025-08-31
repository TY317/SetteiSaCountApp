//
//  azurLaneView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/24.
//

import SwiftUI

struct azurLaneView95Ci: View {
    @ObservedObject var azurLane: AzurLane
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // 弱チェリー回数
            unitListSection95Ci(
                grafTitle: "弱🍒回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $azurLane.koyakuCountJakuCherry,
                        bigNumber: $azurLane.gameNumberPlay,
                        setting1Denominate: azurLane.ratioJakuCherry[0],
                        setting2Denominate: azurLane.ratioJakuCherry[1],
                        setting3Denominate: azurLane.ratioJakuCherry[2],
                        setting4Denominate: azurLane.ratioJakuCherry[3],
                        setting5Denominate: azurLane.ratioJakuCherry[4],
                        setting6Denominate: azurLane.ratioJakuCherry[5]
                    )
                )
            )
            .tag(1)
            // 弱スイカ回数
            unitListSection95Ci(
                grafTitle: "弱🍉回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $azurLane.koyakuCountJakuSuika,
                        bigNumber: $azurLane.gameNumberPlay,
                        setting1Denominate: azurLane.ratioJakuSuika[0],
                        setting2Denominate: azurLane.ratioJakuSuika[1],
                        setting3Denominate: azurLane.ratioJakuSuika[2],
                        setting4Denominate: azurLane.ratioJakuSuika[3],
                        setting5Denominate: azurLane.ratioJakuSuika[4],
                        setting6Denominate: azurLane.ratioJakuSuika[5]
                    )
                )
            )
            .tag(2)
            // 弱レア役合算回数
            unitListSection95Ci(
                grafTitle: "弱🍒・🍉合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $azurLane.koyakuCountSum,
                        bigNumber: $azurLane.gameNumberPlay,
                        setting1Denominate: azurLane.ratioJakuRareSum[0],
                        setting2Denominate: azurLane.ratioJakuRareSum[1],
                        setting3Denominate: azurLane.ratioJakuRareSum[2],
                        setting4Denominate: azurLane.ratioJakuRareSum[3],
                        setting5Denominate: azurLane.ratioJakuRareSum[4],
                        setting6Denominate: azurLane.ratioJakuRareSum[5]
                    )
                )
            )
            .tag(3)
            // ボーナス回数
            unitListSection95Ci(
                grafTitle: "ボーナス回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $azurLane.bonusCount,
                        bigNumber: $azurLane.gameNormalNumberPlay,
                        setting1Denominate: azurLane.ratioBonus[0],
                        setting2Denominate: azurLane.ratioBonus[1],
                        setting3Denominate: azurLane.ratioBonus[2],
                        setting4Denominate: azurLane.ratioBonus[3],
                        setting5Denominate: azurLane.ratioBonus[4],
                        setting6Denominate: azurLane.ratioBonus[5]
                    )
                )
            )
            .tag(4)
            // AT回数
            unitListSection95Ci(
                grafTitle: "AT回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $azurLane.atCount,
                        bigNumber: $azurLane.gameNormalNumberPlay,
                        setting1Denominate: azurLane.ratioAt[0],
                        setting2Denominate: azurLane.ratioAt[1],
                        setting3Denominate: azurLane.ratioAt[2],
                        setting4Denominate: azurLane.ratioAt[3],
                        setting5Denominate: azurLane.ratioAt[4],
                        setting6Denominate: azurLane.ratioAt[5]
                    )
                )
            )
            .tag(5)
            // AT後の高確スタート回数
            unitListSection95Ci(
                grafTitle: "AT後の高確スタート回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $azurLane.startModeCountHigh,
                        bigNumber: $azurLane.startModeCountSum,
                        setting1Percent: azurLane.ratioStartHigh[0],
                        setting2Percent: azurLane.ratioStartHigh[1],
                        setting3Percent: azurLane.ratioStartHigh[2],
                        setting4Percent: azurLane.ratioStartHigh[3],
                        setting5Percent: azurLane.ratioStartHigh[4],
                        setting6Percent: azurLane.ratioStartHigh[5]
                    )
                )
            )
            .tag(6)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: azurLane.machineName,
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
    azurLaneView95Ci(
        azurLane: AzurLane(),
    )
}
