//
//  kingHanaView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/24.
//

import SwiftUI

struct kingHanaView95Ci: View {
    @ObservedObject var hana = kingHanaVar()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // ベル回数
            unitListSection95Ci(
                grafTitle: "ベル回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hana.bellCount,
                        bigNumber: $hana.playGames,
                        setting1Denominate: 7.18,
                        setting2Denominate: 7.18,
                        setting3Denominate: 7.18,
                        setting4Denominate: 7.02,
                        setting5Denominate: 6.97,
                        setting6Denominate: 6.92,
                        yScaleKeisu: 0.05
                    )
                )
            )
            .tag(1)
            // BIG回数
            unitListSection95Ci(
                grafTitle: "BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hana.bigCount,
                        bigNumber: $hana.playGames,
                        setting1Denominate: 292,
                        setting2Denominate: 280,
                        setting3Denominate: 268,
                        setting4Denominate: 257,
                        setting5Denominate: 244,
                        setting6Denominate: 232
                    )
                )
            )
            .tag(2)
            // REG回数
            unitListSection95Ci(
                grafTitle: "REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hana.regCount,
                        bigNumber: $hana.playGames,
                        setting1Denominate: 489,
                        setting2Denominate: 452,
                        setting3Denominate: 420,
                        setting4Denominate: 390,
                        setting5Denominate: 360,
                        setting6Denominate: 332
                    )
                )
            )
            .tag(3)
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hana.totalBonus,
                        bigNumber: $hana.playGames,
                        setting1Denominate: 183,
                        setting2Denominate: 172,
                        setting3Denominate: 163,
                        setting4Denominate: 154,
                        setting5Denominate: 145,
                        setting6Denominate: 136
                    )
                )
            )
            .tag(4)
            // BIG中スイカ回数
            unitListSection95Ci(
                grafTitle: "BIG中スイカ回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hana.bbSuikaCount,
                        bigNumber: $hana.bigPlayGames,
                        setting1Denominate: 48,
                        setting2Denominate: 44,
                        setting3Denominate: 42,
                        setting4Denominate: 40,
                        setting5Denominate: 35,
                        setting6Denominate: 32
                    )
                )
            )
            .tag(5)
            // BIG後ランプ合算回数
            unitListSection95Ci(
                grafTitle: "BIG後ランプ合算回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $hana.bbLampCountSum,
                        bigNumber: $hana.bigCount,
                        setting1Percent: 9.7,
                        setting2Percent: 10.6,
                        setting3Percent: 11.7,
                        setting4Percent: 13.0,
                        setting5Percent: 14.2,
                        setting6Percent: 15.8
                    )
                )
            )
            .tag(6)
            // REGサイドランプ 奇数示唆回数
            unitListSection95Ci(
                grafTitle: "REGサイドランプ 奇数示唆回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $hana.rbLampKisuCountSum,
                        bigNumber: $hana.rbLampCountSum,
                        setting1Percent: 60,
                        setting2Percent: 40,
                        setting3Percent: 60,
                        setting4Percent: 40,
                        setting5Percent: 60,
                        setting6Percent: 50
                    )
                )
            )
            .tag(7)
        }
        .navigationTitle("95%信頼区間グラフ")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButton95CiExplain(isShow95CiExplain: isShow95CiExplain)
//                    .popoverTip(tipUnitButton95CiExplain())
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    kingHanaView95Ci()
}
