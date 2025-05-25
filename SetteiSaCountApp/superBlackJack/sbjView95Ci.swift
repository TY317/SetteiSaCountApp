//
//  sbjView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/08.
//

import SwiftUI

struct sbjView95Ci: View {
//    @ObservedObject var sbj = Sbj()
    @ObservedObject var sbj: Sbj
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // ボーナス高確回数
            unitListSection95Ci(
                grafTitle: "ボーナス高確回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $sbj.kokakuCount,
                        bigNumber: $sbj.normalGame,
                        setting1Denominate: 114.7,
                        setting2Denominate: 112.4,
                        setting3Denominate: 110.5,
                        setting4Denominate: 96.4,
                        setting5Denominate: 92.0,
                        setting6Denominate: 90.3
                    )
                )
            )
            .tag(1)
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $sbj.bonusSum,
                        bigNumber: $sbj.normalGame,
                        setting1Denominate: 241.7,
                        setting2Denominate: 238.8,
                        setting3Denominate: 235.9,
                        setting4Denominate: 201.8,
                        setting5Denominate: 194.9,
                        setting6Denominate: 181.3
                    )
                )
            )
            .tag(2)
            // リオチャンス高確回数
            unitListSection95Ci(
                grafTitle: "リオチャンス高確回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $sbj.rioChanceCount,
                        bigNumber: $sbj.normalGame,
                        setting1Denominate: 417.6,
                        setting2Denominate: 411.7,
                        setting3Denominate: 405.8,
                        setting4Denominate: 350.4,
                        setting5Denominate: 335.9,
                        setting6Denominate: 312.1
                    )
                )
            )
            .tag(3)
            // 規定G数 100Gでの高確移行回数
            unitListSection95Ci(
                grafTitle: "規定G数での移行\n100Gでの高確移行回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $sbj.gameChangeCount100Kokaku,
                        bigNumber: $sbj.gameChangeCount100Sum,
                        setting1Percent: sbj.stageChange100KokakuRatio[0],
                        setting2Percent: sbj.stageChange100KokakuRatio[1],
                        setting3Percent: sbj.stageChange100KokakuRatio[2],
                        setting4Percent: sbj.stageChange100KokakuRatio[3],
                        setting5Percent: sbj.stageChange100KokakuRatio[4],
                        setting6Percent: sbj.stageChange100KokakuRatio[5]
                    )
                )
            )
            .tag(4)
            // 規定G数 百の位偶数での高確移行回数
            unitListSection95Ci(
                grafTitle: "規定G数での移行\n百の位偶数での高確移行回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $sbj.gameChangeCountKisuKokaku,
                        bigNumber: $sbj.gameChangeCountKisuSum,
                        setting1Percent: sbj.stageChangeGusuKokakuRatio[0],
                        setting2Percent: sbj.stageChangeGusuKokakuRatio[1],
                        setting3Percent: sbj.stageChangeGusuKokakuRatio[2],
                        setting4Percent: sbj.stageChangeGusuKokakuRatio[3],
                        setting5Percent: sbj.stageChangeGusuKokakuRatio[4],
                        setting6Percent: sbj.stageChangeGusuKokakuRatio[5]
                    )
                )
            )
            .tag(5)
            // 規定G数 百の位奇数での高確移行回数
            unitListSection95Ci(
                grafTitle: "規定G数での移行\n百の位奇数での高確移行回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $sbj.gameChangeCountKisuKokaku,
                        bigNumber: $sbj.gameChangeCountKisuSum,
                        setting1Percent: sbj.stageChangeKisuKokakuRatio[0],
                        setting2Percent: sbj.stageChangeKisuKokakuRatio[1],
                        setting3Percent: sbj.stageChangeKisuKokakuRatio[2],
                        setting4Percent: sbj.stageChangeKisuKokakuRatio[3],
                        setting5Percent: sbj.stageChangeKisuKokakuRatio[4],
                        setting6Percent: sbj.stageChangeKisuKokakuRatio[5]
                    )
                )
            )
            .tag(6)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "スーパーブラックジャック",
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
    sbjView95Ci(sbj: Sbj())
}
