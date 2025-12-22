//
//  hihodenView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/13.
//

import SwiftUI

struct hihodenView95Ci: View {
    @ObservedObject var hihoden: Hihoden
    @State var selection = 1
    @State var isShow95CiExplain = false
    var body: some View {
        TabView(selection: self.$selection) {
            // スイカ回数
            unitListSection95Ci(
                grafTitle: "🍒回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hihoden.koyakuCountCherry,
                        bigNumber: $hihoden.totalGame,
                        setting1Denominate: hihoden.ratioKoyakuCherry[0],
                        setting2Denominate: hihoden.ratioKoyakuCherry[1],
                        setting3Denominate: hihoden.ratioKoyakuCherry[2],
                        setting4Denominate: hihoden.ratioKoyakuCherry[3],
                        setting5Denominate: hihoden.ratioKoyakuCherry[4],
                        setting6Denominate: hihoden.ratioKoyakuCherry[5]
                    )
                )
            )
            .tag(1)
            
            // チャンス目からの高確率回数
            unitListSection95Ci(
                grafTitle: "チャンス目からの高確率回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $hihoden.chanceKokakuCount,
                        bigNumber: $hihoden.koyakuCountChance,
                        setting1Percent: hihoden.ratioChanceKokaku[0],
                        setting2Percent: hihoden.ratioChanceKokaku[1],
                        setting3Percent: hihoden.ratioChanceKokaku[2],
                        setting4Percent: hihoden.ratioChanceKokaku[3],
                        setting5Percent: hihoden.ratioChanceKokaku[4],
                        setting6Percent: hihoden.ratioChanceKokaku[5]
                    )
                )
            )
            .tag(4)
            
            // 初当り回数
            unitListSection95Ci(
                grafTitle: "初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hihoden.firstHitCount,
                        bigNumber: $hihoden.normalGame,
                        setting1Denominate: hihoden.ratioFirstHit[0],
                        setting2Denominate: hihoden.ratioFirstHit[1],
                        setting3Denominate: hihoden.ratioFirstHit[2],
                        setting4Denominate: hihoden.ratioFirstHit[3],
                        setting5Denominate: hihoden.ratioFirstHit[4],
                        setting6Denominate: hihoden.ratioFirstHit[5]
                    )
                )
            )
            .tag(2)
            
            // ボーナス中ハズレ回数
            unitListSection95Ci(
                grafTitle: "ボーナス中ハズレ回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hihoden.bonusHazureCount,
                        bigNumber: $hihoden.bonusGame,
                        setting1Denominate: hihoden.ratioBonusHazure[0],
                        setting2Denominate: hihoden.ratioBonusHazure[1],
                        setting3Denominate: hihoden.ratioBonusHazure[2],
                        setting4Denominate: hihoden.ratioBonusHazure[3],
                        setting5Denominate: hihoden.ratioBonusHazure[4],
                        setting6Denominate: hihoden.ratioBonusHazure[5]
                    )
                )
            )
            .tag(3)
            
            // 伝説回数 BIG後
            unitListSection95Ci(
                grafTitle: "伝説モード移行回数\nBIG後",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $hihoden.legendCountBigHit,
                        bigNumber: $hihoden.legendCountBigSum,
                        setting1Percent: hihoden.ratioLegendAfterBig[0],
                        setting2Percent: hihoden.ratioLegendAfterBig[1],
                        setting3Percent: hihoden.ratioLegendAfterBig[2],
                        setting4Percent: hihoden.ratioLegendAfterBig[3],
                        setting5Percent: hihoden.ratioLegendAfterBig[4],
                        setting6Percent: hihoden.ratioLegendAfterBig[5]
                    )
                )
            )
            .tag(5)
            
            // 伝説回数 REG後
            unitListSection95Ci(
                grafTitle: "伝説モード移行回数\nREG後",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $hihoden.legendCountRegHit,
                        bigNumber: $hihoden.legendCountRegSum,
                        setting1Percent: hihoden.ratioLegendAfterReg[0],
                        setting2Percent: hihoden.ratioLegendAfterReg[1],
                        setting3Percent: hihoden.ratioLegendAfterReg[2],
                        setting4Percent: hihoden.ratioLegendAfterReg[3],
                        setting5Percent: hihoden.ratioLegendAfterReg[4],
                        setting6Percent: hihoden.ratioLegendAfterReg[5]
                    )
                )
            )
            .tag(6)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hihoden.machineName,
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
    hihodenView95Ci(
        hihoden: Hihoden(),
    )
}
