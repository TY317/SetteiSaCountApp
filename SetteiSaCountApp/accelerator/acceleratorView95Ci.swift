//
//  acceleratorView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/05.
//

import SwiftUI

struct acceleratorView95Ci: View {
//    @ObservedObject var accelerator = Accelerator()
    @ObservedObject var accelerator: Accelerator
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // シャッター開放回数
            unitListSection95Ci(
                grafTitle: "シャッター開放回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $accelerator.normalChanceCountShutterOpen,
                        bigNumber: $accelerator.normalChanceCount,
                        setting1Percent: 33.2,
                        setting2Percent: 34.8,
                        setting3Percent: 36.7,
                        setting4Percent: 38.7,
                        setting5Percent: 40.6,
                        setting6Percent: 44.9
                    )
                )
            )
            .tag(9)
            // シャッター開放継続18G回数
            unitListSection95Ci(
                grafTitle: "シャッター開放継続 18G回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $accelerator.shutterOpenCount18G,
                        bigNumber: $accelerator.shutterOpenCountSum,
                        setting1Percent: 64.7,
                        setting2Percent: 62.9,
                        setting3Percent: 60.6,
                        setting4Percent: 58.6,
                        setting5Percent: 56.7,
                        setting6Percent: 53.0
                    )
                )
            )
            .tag(10)
            // シャッター開放継続23G回数
            unitListSection95Ci(
                grafTitle: "シャッター開放継続 23G回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $accelerator.shutterOpenCount23G,
                        bigNumber: $accelerator.shutterOpenCountSum,
                        setting1Percent: 32.9,
                        setting2Percent: 33.7,
                        setting3Percent: 35.1,
                        setting4Percent: 36.4,
                        setting5Percent: 36.5,
                        setting6Percent: 38.3
                    )
                )
            )
            .tag(11)
            // シャッター開放継続33G回数
            unitListSection95Ci(
                grafTitle: "シャッター開放継続 33G回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $accelerator.shutterOpenCount33G,
                        bigNumber: $accelerator.shutterOpenCountSum,
                        setting1Percent: 2.4,
                        setting2Percent: 3.4,
                        setting3Percent: 4.3,
                        setting4Percent: 5.1,
                        setting5Percent: 6.7,
                        setting6Percent: 8.7
                    )
                )
            )
            .tag(12)
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
            // 一方通行CZ回数
            unitListSection95Ci(
                grafTitle: "一方通行CZ回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $accelerator.czCountAccelerator,
                        bigNumber: $accelerator.playGameSum,
                        setting1Denominate: 168.7,
                        setting2Denominate: 165.5,
                        setting3Denominate: 159.6,
                        setting4Denominate: 152.9,
                        setting5Denominate: 145.5,
                        setting6Denominate: 134.1
                    )
                )
            )
            .tag(6)
            // 打ち止めCZ回数
            unitListSection95Ci(
                grafTitle: "打ち止めCZ回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $accelerator.czCountLastorder,
                        bigNumber: $accelerator.playGameSum,
                        setting1Denominate: 3244.1,
                        setting2Denominate: 3188.7,
                        setting3Denominate: 2892.9,
                        setting4Denominate: 1838.2,
                        setting5Denominate: 1356.3,
                        setting6Denominate: 1247.1
                    )
                )
            )
            .tag(7)
            // 一通・打止CZ回数
            unitListSection95Ci(
                grafTitle: "一通・打止CZ回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $accelerator.czCountBoth,
                        bigNumber: $accelerator.playGameSum,
                        setting1Denominate: 1290.5,
                        setting2Denominate: 1244.1,
                        setting3Denominate: 1058.9,
                        setting4Denominate: 1058.9,
                        setting5Denominate: 943.6,
                        setting6Denominate: 845.7
                    )
                )
            )
            .tag(8)
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
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "一方通行 とある魔術の禁書目録",
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
    acceleratorView95Ci(accelerator: Accelerator())
}
