//
//  acceleratorView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/05.
//

import SwiftUI

struct acceleratorView95Ci: View {
    @ObservedObject var accelerator = Accelerator()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // 対応チャンス目からの一方通行CZ回数
            unitListSection95Ci(
                grafTitle: "対応チャンス目からの\n一方通行CZ回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $accelerator.chanceCountWinAccelerator,
                        bigNumber: $accelerator.chanceCountSum,
                        setting1Percent: 38.7,
                        setting2Percent: 39.5,
                        setting3Percent: 41.4,
                        setting4Percent: 43.4,
                        setting5Percent: 46.1,
                        setting6Percent: 51.6
                    )
                )
            )
            .tag(1)
            // 対応チャンス目からの打ち止めCZ回数
            unitListSection95Ci(
                grafTitle: "対応チャンス目からの\n打ち止めCZ回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $accelerator.chanceCountWinLastorder,
                        bigNumber: $accelerator.chanceCountSum,
                        setting1Percent: 1.2,
                        setting2Percent: 1.2,
                        setting3Percent: 1.6,
                        setting4Percent: 2.3,
                        setting5Percent: 3.1,
                        setting6Percent: 3.9
                    )
                )
            )
            .tag(2)
            // 対応チャンス目からの打ち止めCZ回数
            unitListSection95Ci(
                grafTitle: "対応チャンス目からの\nCZ合算回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $accelerator.chanceCountWinSum,
                        bigNumber: $accelerator.chanceCountSum,
                        setting1Percent: 39.9,
                        setting2Percent: 40.7,
                        setting3Percent: 43.0,
                        setting4Percent: 45.7,
                        setting5Percent: 49.2,
                        setting6Percent: 55.5
                    )
                )
            )
            .tag(3)
            // CZ初当り回数
            unitListSection95Ci(
                grafTitle: "CZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $accelerator.czCount,
                        bigNumber: $accelerator.playGameSum,
                        setting1Denominate: 142.6,
                        setting2Denominate: 139.7,
                        setting3Denominate: 134.1,
                        setting4Denominate: 124.6,
                        setting5Denominate: 115.3,
                        setting6Denominate: 105.9
                    )
                )
            )
            .tag(4)
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $accelerator.atCount,
                        bigNumber: $accelerator.playGameSum,
                        setting1Denominate: 320.7,
                        setting2Denominate: 313.8,
                        setting3Denominate: 300.9,
                        setting4Denominate: 275.2,
                        setting5Denominate: 251.9,
                        setting6Denominate: 231.9
                    )
                )
            )
            .tag(5)
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
    acceleratorView95Ci()
}
