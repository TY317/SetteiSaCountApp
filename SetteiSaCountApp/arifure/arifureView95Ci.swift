//
//  arifureView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/02.
//

import SwiftUI

struct arifureView95Ci: View {
//    @ObservedObject var arifure = Arifure()
    @ObservedObject var arifure: Arifure
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // 弱🍒での引鉄高確移行回数
            unitListSection95Ci(
                grafTitle: "弱🍒\n引鉄高確移行回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $arifure.jakuCherryKokakuCount,
                        bigNumber: $arifure.jakuCherryCount,
                        setting1Percent: 21,
                        setting2Percent: 22,
                        setting3Percent: 22,
                        setting4Percent: 24,
                        setting5Percent: 25,
                        setting6Percent: 28
                    )
                )
            )
            .tag(1)
            // 弱チャンス目での引鉄高確移行回数
            unitListSection95Ci(
                grafTitle: "弱チャンス目\n引鉄高確移行回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $arifure.jakuChanceKokakuCount,
                        bigNumber: $arifure.jakuChanceCount,
                        setting1Percent: 40,
                        setting2Percent: 41,
                        setting3Percent: 42,
                        setting4Percent: 45,
                        setting5Percent: 47,
                        setting6Percent: 50
                    )
                )
            )
            .tag(2)
            // 高確スイカでの引鉄高確移行回数
            unitListSection95Ci(
                grafTitle: "高確スイカ\n引鉄高確移行回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $arifure.kokakuSuikaKokakuCount,
                        bigNumber: $arifure.kokakuSuikaCount,
                        setting1Percent: 55,
                        setting2Percent: 60,
                        setting3Percent: 65,
                        setting4Percent: 70,
                        setting5Percent: 73,
                        setting6Percent: 85
                    )
                )
            )
            .tag(3)
            // 規定ゲーム100GでのCZ当選回数
            unitListSection95Ci(
                grafTitle: "規定ゲーム100G\nCZ当選回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $arifure.cz100GCountHit,
                        bigNumber: $arifure.cz100GCountSum,
                        setting1Percent: 21,
                        setting2Percent: 21,
                        setting3Percent: 23,
                        setting4Percent: 29,
                        setting5Percent: 33,
                        setting6Percent: 40
                    )
                )
            )
            .tag(8)
            // ミュウボーナス回数
            unitListSection95Ci(
                grafTitle: "ミュウボーナス回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $arifure.myuBonusCountAll,
                        bigNumber: $arifure.playGameSum,
                        setting1Denominate: 523,
                        setting2Denominate: 513,
                        setting3Denominate: 497,
                        setting4Denominate: 471,
                        setting5Denominate: 455,
                        setting6Denominate: 420
                    )
                )
            )
            .tag(4)
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $arifure.atCount,
                        bigNumber: $arifure.playGameSum,
                        setting1Denominate: 395,
                        setting2Denominate: 382,
                        setting3Denominate: 360,
                        setting4Denominate: 323,
                        setting5Denominate: 301,
                        setting6Denominate: 268
                    )
                )
            )
            .tag(5)
            // ミュウボーナスからのAT回数
            unitListSection95Ci(
                grafTitle: "ミュウボーナスからのAT回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $arifure.myuBonusCountAtHit,
                        bigNumber: $arifure.myuBonusCountAll,
                        setting1Percent: 5,
                        setting2Percent: 6,
                        setting3Percent: 9,
                        setting4Percent: 15,
                        setting5Percent: 20,
                        setting6Percent: 27
                    )
                )
            )
            .tag(6)
            // 100G＋α以内の当選率
            unitListSection95Ci(
                grafTitle: "100G＋α以内の当選率",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $arifure.hitUnder100gCount,
                        bigNumber: $arifure.hitCountAll,
                        setting1Percent: 15,
                        setting2Percent: 16,
                        setting3Percent: 19,
                        setting4Percent: 20,
                        setting5Percent: 21,
                        setting6Percent: 22
                    )
                )
            )
            .tag(7)
            // ミュウボーナス キャラ紹介　奇数示唆回数
            unitListSection95Ci(
                grafTitle: "ミュウボーナス キャラ紹介\n奇数示唆回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $arifure.charaCountKisu,
                        bigNumber: $arifure.charaCountSum,
                        setting1Percent: arifure.ratioCharaSetting1[1],
                        setting2Percent: arifure.ratioCharaSetting2[1],
                        setting3Percent: arifure.ratioCharaSetting3[1],
                        setting4Percent: arifure.ratioCharaSetting4[1],
                        setting5Percent: arifure.ratioCharaSetting5[1],
                        setting6Percent: arifure.ratioCharaSetting6[1]
                    )
                )
            )
            .tag(13)
            // AT終了画面　高設定示唆 出現回数
            unitListSection95Ci(
                grafTitle: "AT終了画面\n高設定示唆 出現回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $arifure.endScreenCountHigh,
                        bigNumber: $arifure.endScreenCountSum,
                        setting1Percent: arifure.ratioAtEndScreenSetting1[1],
                        setting2Percent: arifure.ratioAtEndScreenSetting2[1],
                        setting3Percent: arifure.ratioAtEndScreenSetting3[1],
                        setting4Percent: arifure.ratioAtEndScreenSetting4[1],
                        setting5Percent: arifure.ratioAtEndScreenSetting5[1],
                        setting6Percent: arifure.ratioAtEndScreenSetting6[1]
                    )
                )
            )
            .tag(14)
            // AT終了後の高確移行回数
            unitListSection95Ci(
                grafTitle: "AT終了後の高確移行回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $arifure.afterKokakuCountHit,
                        bigNumber: $arifure.afterKokakuCountSum,
                        setting1Percent: 13,
                        setting2Percent: 14,
                        setting3Percent: 16,
                        setting4Percent: 18,
                        setting5Percent: 21,
                        setting6Percent: 23
                    )
                )
            )
            .tag(9)
            // ビッグトリガーアタック2G継続回数
            unitListSection95Ci(
                grafTitle: "ビッグトリガーアタック\n継続2G 回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $arifure.btaGameCount2G,
                        bigNumber: $arifure.btaGameCountSum,
                        setting1Percent: arifure.ratioBigTriggerContinuous2G[0],
                        setting2Percent: arifure.ratioBigTriggerContinuous2G[1],
                        setting3Percent: arifure.ratioBigTriggerContinuous2G[2],
                        setting4Percent: arifure.ratioBigTriggerContinuous2G[3],
                        setting5Percent: arifure.ratioBigTriggerContinuous2G[4],
                        setting6Percent: arifure.ratioBigTriggerContinuous2G[5]
                    )
                )
            )
            .tag(10)
            // ビッグトリガーアタック3G継続回数
            unitListSection95Ci(
                grafTitle: "ビッグトリガーアタック\n継続3G 回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $arifure.btaGameCount3G,
                        bigNumber: $arifure.btaGameCountSum,
                        setting1Percent: arifure.ratioBigTriggerContinuous3G[0],
                        setting2Percent: arifure.ratioBigTriggerContinuous3G[1],
                        setting3Percent: arifure.ratioBigTriggerContinuous3G[2],
                        setting4Percent: arifure.ratioBigTriggerContinuous3G[3],
                        setting5Percent: arifure.ratioBigTriggerContinuous3G[4],
                        setting6Percent: arifure.ratioBigTriggerContinuous3G[5]
                    )
                )
            )
            .tag(11)
            // ビッグトリガーアタック4G継続回数
            unitListSection95Ci(
                grafTitle: "ビッグトリガーアタック\n継続4G以上 回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $arifure.btaGameCount4GOver,
                        bigNumber: $arifure.btaGameCountSum,
                        setting1Percent: arifure.ratioBigTriggerContinuous4GOver[0],
                        setting2Percent: arifure.ratioBigTriggerContinuous4GOver[1],
                        setting3Percent: arifure.ratioBigTriggerContinuous4GOver[2],
                        setting4Percent: arifure.ratioBigTriggerContinuous4GOver[3],
                        setting5Percent: arifure.ratioBigTriggerContinuous4GOver[4],
                        setting6Percent: arifure.ratioBigTriggerContinuous4GOver[5]
                    )
                )
            )
            .tag(12)
            // エンディング奇数示唆回数
            unitListSection95Ci(
                grafTitle: "エンディング レア役時の画面\n奇数示唆回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $arifure.endingCountKisu,
                        bigNumber: $arifure.endingCountSum,
                        setting1Percent: arifure.ratioEndingSetting1[0],
                        setting2Percent: arifure.ratioEndingSetting2[0],
                        setting3Percent: arifure.ratioEndingSetting3[0],
                        setting4Percent: arifure.ratioEndingSetting4[0],
                        setting5Percent: arifure.ratioEndingSetting5[0],
                        setting6Percent: arifure.ratioEndingSetting6[0]
                    )
                )
            )
            .tag(15)
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
    arifureView95Ci(arifure: Arifure())
}
