//
//  dumbbellView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/04.
//

import SwiftUI

struct dumbbellView95Ci: View {
    @ObservedObject var dumbbell = Dumbbell()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // CZ後半パート成功回数
            unitListSection95Ci(
                grafTitle: "CZ後半パート成功回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $dumbbell.czSecondSuccessCount,
                        bigNumber: $dumbbell.czFirstSuccessCount,
                        setting1Percent: 52,
                        setting2Percent: 53,
                        setting3Percent: 56,
                        setting4Percent: 57,
                        setting5Percent: 59,
                        setting6Percent: 59
                    )
                )
            )
            .tag(2)
            // ボーナス初当り回数
            unitListSection95Ci(
                grafTitle: "ボーナス初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $dumbbell.bonusCountSum,
                        bigNumber: $dumbbell.playGameSum,
                        setting1Denominate: 591,
                        setting2Denominate: 576,
                        setting3Denominate: 546,
                        setting4Denominate: 532,
                        setting5Denominate: 512,
                        setting6Denominate: 504
                    )
                )
            )
            .tag(1)
            // ボーナス初当り回数
            unitListSection95Ci(
                grafTitle: "ゴールデンチャレンジ当選回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $dumbbell.goldenChallengeCountSum,
                        bigNumber: $dumbbell.bonusCountSum,
                        setting1Percent: 17,
                        setting2Percent: 17,
                        setting3Percent: 17,
                        setting4Percent: 17,
                        setting5Percent: 18,
                        setting6Percent: 20
                    )
                )
            )
            .tag(3)
            // CZ,ボーナス終了画面 設定2以上示唆
            unitListSection95Ci(
                grafTitle: "CZ,ボーナス終了画面\n設定2以上示唆",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $dumbbell.czBonusScreenCountOver2Sisa,
                        bigNumber: $dumbbell.czBonusScreenCountSum,
                        setting1Percent: 5,
                        setting2Percent: 10,
                        setting3Percent: 10,
                        setting4Percent: 10,
                        setting5Percent: 10,
                        setting6Percent: 10
                    )
                )
            )
            .tag(4)
            // CZ,ボーナス終了画面 偶数示唆
            unitListSection95Ci(
                grafTitle: "CZ,ボーナス終了画面\n偶数示唆",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $dumbbell.czBonusScreenCountGusuSisa,
                        bigNumber: $dumbbell.czBonusScreenCountSum,
                        setting1Percent: 15,
                        setting2Percent: 29,
                        setting3Percent: 14,
                        setting4Percent: 27,
                        setting5Percent: 13,
                        setting6Percent: 19
                    )
                )
            )
            .tag(5)
            // CZ,ボーナス終了画面 奇数示唆
            unitListSection95Ci(
                grafTitle: "CZ,ボーナス終了画面\n奇数示唆",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $dumbbell.czBonusScreenCountKisuSisa,
                        bigNumber: $dumbbell.czBonusScreenCountSum,
                        setting1Percent: 30,
                        setting2Percent: 15,
                        setting3Percent: 28,
                        setting4Percent: 13,
                        setting5Percent: 26,
                        setting6Percent: 19
                    )
                )
            )
            .tag(6)
            // CZ,ボーナス終了画面 設定3以上示唆
            unitListSection95Ci(
                grafTitle: "CZ,ボーナス終了画面\n設定3以上示唆",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $dumbbell.czBonusScreenCountOver3Sisa,
                        bigNumber: $dumbbell.czBonusScreenCountSum,
                        setting1Percent: 5,
                        setting2Percent: 5,
                        setting3Percent: 10,
                        setting4Percent: 10,
                        setting5Percent: 10,
                        setting6Percent: 10
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
    dumbbellView95Ci()
}
