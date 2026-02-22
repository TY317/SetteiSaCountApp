//
//  newKingHanaView95CiTotal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/22.
//

import SwiftUI

struct newKingHanaView95CiTotal: View {
    @ObservedObject var newKingHana: NewKingHana
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // ぶどう回数
            unitListSection95Ci(
                grafTitle: "\(selectTitle(enable: newKingHana.startBackCalculationEnable))\nベル回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: selectBinding(enable: newKingHana.startBackCalculationEnable),
                        bigNumber: selectBindingBig(enable: newKingHana.startBackCalculationEnable),
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
            // BIG回数
            unitListSection95Ci(
                grafTitle: "総合結果\n BIG回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $newKingHana.totalBigCount,
                        bigNumber: $newKingHana.currentGames,
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
                grafTitle: "総合結果\n REG回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $newKingHana.totalRegCount,
                        bigNumber: $newKingHana.currentGames,
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
                grafTitle: "総合結果\n ボーナス合算回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $newKingHana.totalBonusCountSum,
                        bigNumber: $newKingHana.currentGames,
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
            
            // BIG中🍉回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nBIG前半 🍉回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $newKingHana.bbSuikaCount,
                        bigNumber: $newKingHana.bigPlayGames,
                        setting1Denominate: newKingHana.ratioBigSuika[0],
                        setting2Denominate: newKingHana.ratioBigSuika[1],
                        setting3Denominate: newKingHana.ratioBigSuika[2],
                        setting4Denominate: newKingHana.ratioBigSuika[3],
                        setting5Enable: false,
                        setting5Denominate: -1,
                        setting6Denominate: newKingHana.ratioBigSuika[4]
                    )
                )
            )
            .tag(5)
            
            // サイドランプ 奇数示唆回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nサイドランプ 奇数示唆回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $newKingHana.sideLampCountKisu,
                        bigNumber: $newKingHana.sideLampCountSum,
                        setting1Percent: newKingHana.ratioSideLampKisu[0],
                        setting2Percent: newKingHana.ratioSideLampKisu[1],
                        setting3Percent: newKingHana.ratioSideLampKisu[2],
                        setting4Percent: newKingHana.ratioSideLampKisu[3],
                        setting5Enable: false,
                        setting5Percent: -1,
                        setting6Percent: newKingHana.ratioSideLampKisu[4]
                    )
                )
            )
            .tag(6)
            
            // BIG後ランプ合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nBIG後ランプ合算回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $newKingHana.bigTopLampCountSum,
                        bigNumber: $newKingHana.bigCount,
                        setting1Percent: newKingHana.ratioBigTopLampSum[0],
                        setting2Percent: newKingHana.ratioBigTopLampSum[1],
                        setting3Percent: newKingHana.ratioBigTopLampSum[2],
                        setting4Percent: newKingHana.ratioBigTopLampSum[3],
                        setting5Enable: false,
                        setting5Percent: -1,
                        setting6Percent: newKingHana.ratioBigTopLampSum[4]
                    )
                )
            )
            .tag(7)
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
    
    private func selectTitle(enable: Bool) -> String {
        switch enable {
        case true: return "総合結果"
        default: return "自分のプレイデータ"
        }
    }
    
    private func selectBinding(enable: Bool) -> Binding<Int> {
        switch enable {
        case true: return $newKingHana.totalBellCount
        default: return $newKingHana.bellCount
        }
    }
    
    private func selectBindingBig(enable: Bool) -> Binding<Int> {
        switch enable {
        case true: return $newKingHana.currentGames
        default: return $newKingHana.playGames
        }
    }
}

#Preview {
    newKingHanaView95CiTotal(
        newKingHana: NewKingHana(),
    )
}
