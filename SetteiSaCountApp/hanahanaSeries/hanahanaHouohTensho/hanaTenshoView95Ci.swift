//
//  hanaTenshoView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/24.
//

import SwiftUI

struct hanaTenshoView95Ci: View {
    @ObservedObject var hana = hanaTensho()
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
                        setting1Denominate: 7.50,
                        setting2Denominate: 7.45,
                        setting3Denominate: 7.39,
                        setting4Denominate: 7.32,
                        setting5Denominate: 7.26,
                        setting6Denominate: 7.25,
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
                        setting1Denominate: 297,
                        setting2Denominate: 284,
                        setting3Denominate: 273,
                        setting4Denominate: 262,
                        setting5Denominate: 249,
                        setting6Denominate: 236
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
                        setting1Denominate: 496,
                        setting2Denominate: 458,
                        setting3Denominate: 425,
                        setting4Denominate: 397,
                        setting5Denominate: 366,
                        setting6Denominate: 337
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
                        setting1Denominate: 186,
                        setting2Denominate: 175,
                        setting3Denominate: 166,
                        setting4Denominate: 157,
                        setting5Denominate: 148,
                        setting6Denominate: 139
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
                        setting1Percent: 10.9,
                        setting2Percent: 12.8,
                        setting3Percent: 13.3,
                        setting4Percent: 15.1,
                        setting5Percent: 15.4,
                        setting6Percent: 16.9
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
                    .popoverTip(tipUnitButton95CiExplain())
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    hanaTenshoView95Ci()
}
