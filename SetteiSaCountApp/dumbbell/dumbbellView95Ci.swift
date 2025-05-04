//
//  dumbbellView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/04.
//

import SwiftUI

struct dumbbellView95Ci: View {
//    @ObservedObject var dumbbell = Dumbbell()
    @ObservedObject var dumbbell: Dumbbell
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
//            // ボーナス初当り回数
//            unitListSection95Ci(
//                grafTitle: "ゴールデンチャレンジ当選回数",
//                titleFont: .title2,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $dumbbell.goldenChallengeCountSum,
//                        bigNumber: $dumbbell.bonusCountSum,
//                        setting1Percent: 17,
//                        setting2Percent: 17,
//                        setting3Percent: 17,
//                        setting4Percent: 17,
//                        setting5Percent: 18,
//                        setting6Percent: 20
//                    )
//                )
//            )
//            .tag(3)
            // CZ,ボーナス終了画面 デフォルト・モード示唆合算
            unitListSection95Ci(
                grafTitle: "CZ,ボーナス終了画面\nデフォルト・モード示唆 合算",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercentNotBinding(
                        currentCount: defaultModeSum(),
                        bigNumber: dumbbell.czBonusScreenCountSum,
                        setting1Percent: 44,
                        setting2Percent: 34,
                        setting3Percent: 34,
                        setting4Percent: 29,
                        setting5Percent: 29,
                        setting6Percent: 28
                    )
                )
            )
            .tag(8)
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
            // ゴールデンチャレンジ当選回数
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
            // ゴールデンチャレンジ成功回数
            unitListSection95Ci(
                grafTitle: "ゴールデンチャレンジ成功回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $dumbbell.goldenChallengeCountSuccess,
                        bigNumber: $dumbbell.goldenChallengeCountSum,
                        setting1Percent: 56,
                        setting2Percent: 57,
                        setting3Percent: 57,
                        setting4Percent: 58,
                        setting5Percent: 59,
                        setting6Percent: 64
                    )
                )
            )
            .tag(13)
            // 合いの手 デフォルト回数
            unitListSection95Ci(
                grafTitle: "合いの手 デフォルト回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercentNotBinding(
                        currentCount: dumbbell.ainoteCount1Person,
                        bigNumber: dumbbell.ainoteCountSum,
                        setting1Percent: 97,
                        setting2Percent: 97,
                        setting3Percent: 97,
                        setting4Percent: 94,
                        setting5Percent: 94,
                        setting6Percent: 94
                    )
                )
            )
            .tag(9)
            // 合いの手 デフォルト回数
            unitListSection95Ci(
                grafTitle: "合いの手 高設定示唆合算回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercentNotBinding(
                        currentCount: ainoteHighSum(),
                        bigNumber: dumbbell.ainoteCountSum,
                        setting1Percent: 2,
                        setting2Percent: 2,
                        setting3Percent: 2,
                        setting4Percent: 6,
                        setting5Percent: 6,
                        setting6Percent: 6
                    )
                )
            )
            .tag(10)
            // 上位AT終了画面 奇数示唆回数
            unitListSection95Ci(
                grafTitle: "金肉ボーナス終了画面\n奇数示唆回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercentNotBinding(
                        currentCount: dumbbell.kinnikuScreenCountDefault,
                        bigNumber: dumbbell.kinnikuScreenCountSum,
                        setting1Percent: 65,
                        setting2Percent: 35,
                        setting3Percent: 65,
                        setting4Percent: 35,
                        setting5Percent: 63,
                        setting6Percent: 48
                    )
                )
            )
            .tag(11)
            // 上位AT終了画面 偶数示唆回数
            unitListSection95Ci(
                grafTitle: "金肉ボーナス終了画面\n偶数示唆回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercentNotBinding(
                        currentCount: dumbbell.kinnikuScreenCountGusu,
                        bigNumber: dumbbell.kinnikuScreenCountSum,
                        setting1Percent: 35,
                        setting2Percent: 65,
                        setting3Percent: 35,
                        setting4Percent: 63,
                        setting5Percent: 35,
                        setting6Percent: 48
                    )
                )
            )
            .tag(12)
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
    private func defaultModeSum() -> Int {
        let czBonusScreenCountDefaultModeSum = countSum(dumbbell.czBonusScreenCountDefault, dumbbell.czBonusScreenCountMode)
        return czBonusScreenCountDefaultModeSum
    }
    
    private func ainoteHighSum() -> Int {
        let ainoteHighSum = countSum(dumbbell.ainoteCount2Person, dumbbell.ainoteCount5Person)
        return ainoteHighSum
    }
}

#Preview {
    dumbbellView95Ci(dumbbell: Dumbbell())
}
