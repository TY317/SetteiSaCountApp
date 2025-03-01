//
//  shamanKingView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/23.
//

import SwiftUI

struct shamanKingView95Ci: View {
    @ObservedObject var shamanKing = ShamanKing()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // 弱レア役からのボーナス高確移行回数
            unitListSection95Ci(
                grafTitle: "弱レア役からのボーナス高確移行回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $shamanKing.bonusKokakuCount,
                        bigNumber: $shamanKing.jakuRareCount,
                        setting1Percent: 3.9,
                        setting2Percent: 4.3,
                        setting3Percent: 5.1,
                        setting4Percent: 6.6,
                        setting5Percent: 8.2,
                        setting6Percent: 10.2
                    )
                )
            )
            .tag(7)
            // リプレイカウンタ10選択回数
            unitListSection95Ci(
                grafTitle: "リプレイカウンタ10選択回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $shamanKing.replayCounterCountSuccesss,
                        bigNumber: $shamanKing.replayCounterReplayCount,
                        setting1Percent: 6.3,
                        setting2Percent: 6.6,
                        setting3Percent: 7.4,
                        setting4Percent: 8.2,
                        setting5Percent: 9.4,
                        setting6Percent: 10.2
                    )
                )
            )
            .tag(8)
            // 残HP7−8での勝利回数
            unitListSection95Ci(
                grafTitle: "憑依合体バトル\n残HP7−8での勝利回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $shamanKing.hyoiCount78Win,
                        bigNumber: $shamanKing.hyoiCount78Sum,
                        setting1Percent: 3.1,
                        setting2Percent: 3.5,
                        setting3Percent: 4.3,
                        setting4Percent: 5.5,
                        setting5Percent: 7.0,
                        setting6Percent: 8.6
                    )
                )
            )
            .tag(1)
            // 残HP5−6での勝利回数
            unitListSection95Ci(
                grafTitle: "憑依合体バトル\n残HP5−6での勝利回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $shamanKing.hyoiCount56Win,
                        bigNumber: $shamanKing.hyoiCount56Sum,
                        setting1Percent: 6.6,
                        setting2Percent: 7.4,
                        setting3Percent: 8.2,
                        setting4Percent: 9.8,
                        setting5Percent: 11.3,
                        setting6Percent: 13.3
                    )
                )
            )
            .tag(2)
            // 残HP4での勝利回数
            unitListSection95Ci(
                grafTitle: "憑依合体バトル\n残HP4での勝利回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $shamanKing.hyoiCount4Win,
                        bigNumber: $shamanKing.hyoiCount4Sum,
                        setting1Percent: 25.0,
                        setting2Percent: 25.4,
                        setting3Percent: 25.8,
                        setting4Percent: 27.0,
                        setting5Percent: 28.1,
                        setting6Percent: 29.7
                    )
                )
            )
            .tag(3)
            // 残HP3での勝利回数
            unitListSection95Ci(
                grafTitle: "憑依合体バトル\n残HP3での勝利回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $shamanKing.hyoiCount3Win,
                        bigNumber: $shamanKing.hyoiCount3Sum,
                        setting1Percent: 40.2,
                        setting2Percent: 40.6,
                        setting3Percent: 41.0,
                        setting4Percent: 42.2,
                        setting5Percent: 43.8,
                        setting6Percent: 45.3
                    )
                )
            )
            .tag(4)
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $shamanKing.bonusCountSum,
                        bigNumber: $shamanKing.inputGame,
                        setting1Denominate: 288.8,
                        setting2Denominate: 280.0,
                        setting3Denominate: 268.4,
                        setting4Denominate: 248.1,
                        setting5Denominate: 227.6,
                        setting6Denominate: 207.1
                    )
                )
            )
            .tag(5)
            // AT回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $shamanKing.inputShamanFightCount,
                        bigNumber: $shamanKing.inputGame,
                        setting1Denominate: 573.6,
                        setting2Denominate: 553.2,
                        setting3Denominate: 523.0,
                        setting4Denominate: 461.2,
                        setting5Denominate: 412.8,
                        setting6Denominate: 367.3
                    )
                )
            )
            .tag(6)
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
    shamanKingView95Ci()
}
