//
//  magiaView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct magiaView95Ci: View {
//    @ObservedObject var magia = Magia()
    @ObservedObject var magia: Magia
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // スイカからのCZ当選回数
            unitListSection95Ci(
                grafTitle: "スイカからのCZ当選回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $magia.suikaCzCountCz,
                        bigNumber: $magia.suikaCzCountSuika,
                        setting1Percent: magia.ratioCzNegateSanaSum[0],
                        setting2Percent: magia.ratioCzNegateSanaSum[1],
                        setting3Percent: magia.ratioCzNegateSanaSum[2],
                        setting4Percent: magia.ratioCzNegateSanaSum[3],
                        setting5Percent: magia.ratioCzNegateSanaSum[4],
                        setting6Percent: magia.ratioCzNegateSanaSum[5]
                    )
                )
            )
            .tag(1)
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $magia.bonusCountSum,
                        bigNumber: $magia.normalPlayGame,
                        setting1Denominate: magia.ratioBonus[0],
                        setting2Denominate: magia.ratioBonus[1],
                        setting3Denominate: magia.ratioBonus[2],
                        setting4Denominate: magia.ratioBonus[3],
                        setting5Denominate: magia.ratioBonus[4],
                        setting6Denominate: magia.ratioBonus[5]
                    )
                )
            )
            .tag(2)
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $magia.atCount,
                        bigNumber: $magia.normalPlayGame,
                        setting1Denominate: magia.ratioAt[0],
                        setting2Denominate: magia.ratioAt[1],
                        setting3Denominate: magia.ratioAt[2],
                        setting4Denominate: magia.ratioAt[3],
                        setting5Denominate: magia.ratioAt[4],
                        setting6Denominate: magia.ratioAt[5]
                    )
                )
            )
            .tag(3)
            // ビッグ後の高確スタート回数
            unitListSection95Ci(
                grafTitle: "高確スタート回数\nビッグ後",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $magia.kokakuStartAfterBonusCountHit,
                        bigNumber: $magia.kokakuStartAfterBonusCountSum,
                        setting1Percent: magia.ratioKokakuStartAfterBonusTotal[0],
                        setting2Percent: magia.ratioKokakuStartAfterBonusTotal[1],
                        setting3Percent: magia.ratioKokakuStartAfterBonusTotal[2],
                        setting4Percent: magia.ratioKokakuStartAfterBonusTotal[3],
                        setting5Percent: magia.ratioKokakuStartAfterBonusTotal[4],
                        setting6Percent: magia.ratioKokakuStartAfterBonusTotal[5]
                    )
                )
            )
            .tag(4)
            // AT後の高確スタート回数
            unitListSection95Ci(
                grafTitle: "高確スタート回数\nAT後",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $magia.kokakuStartAfterAtCountHit,
                        bigNumber: $magia.kokakuStartAfterAtCountSum,
                        setting1Percent: magia.ratioKokakuStartAfterAtTotal[0],
                        setting2Percent: magia.ratioKokakuStartAfterAtTotal[1],
                        setting3Percent: magia.ratioKokakuStartAfterAtTotal[2],
                        setting4Percent: magia.ratioKokakuStartAfterAtTotal[3],
                        setting5Percent: magia.ratioKokakuStartAfterAtTotal[4],
                        setting6Percent: magia.ratioKokakuStartAfterAtTotal[5]
                    )
                )
            )
            .tag(5)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "マギアレコード",
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
    magiaView95Ci(magia: Magia())
}
