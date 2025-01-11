//
//  danvineView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/27.
//

import SwiftUI

struct danvineView95Ci: View {
    @ObservedObject var danvine = Danvine()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // 規定Pt11回数
            unitListSection95Ci(
                grafTitle: "規定ポイント11 選択回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $danvine.ptCount11,
                        bigNumber: $danvine.ptCountSum,
                        setting1Percent: 2.0,
                        setting2Percent: 2.0,
                        setting3Percent: 2.7,
                        setting4Percent: 3.5,
                        setting5Percent: 4.3,
                        setting6Percent: 5.1
                    )
                )
            )
            .tag(3)
            // ハズレ3連時の高確当選回数
            unitListSection95Ci(
                grafTitle: "ハズレ3連時の高確当選回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $danvine.hazure3CountWin,
                        bigNumber: $danvine.hazure3CountAll,
                        setting1Percent: 19.9,
                        setting2Percent: 20.3,
                        setting3Percent: 20.7,
                        setting4Percent: 24.6,
                        setting5Percent: 27.3,
                        setting6Percent: 30.1
                    )
                )
            )
            .tag(4)
            // ボーナス初当り回数
            unitListSection95Ci(
                grafTitle: "ボーナス初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $danvine.bonusCount,
                        bigNumber: $danvine.playGameSum,
                        setting1Denominate: 355.8,
                        setting2Denominate: 351.6,
                        setting3Denominate: 342.7,
                        setting4Denominate: 332.9,
                        setting5Denominate: 319.7,
                        setting6Denominate: 307.7
                    )
                )
            )
            .tag(1)
            // ST初当り回数
            unitListSection95Ci(
                grafTitle: "ST初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $danvine.stCount,
                        bigNumber: $danvine.playGameSum,
                        setting1Denominate: 597.7,
                        setting2Denominate: 588.4,
                        setting3Denominate: 572.5,
                        setting4Denominate: 552.5,
                        setting5Denominate: 528.0,
                        setting6Denominate: 505.6
                    )
                )
            )
            .tag(2)
            // チャムランプ 緑回数
            unitListSection95Ci(
                grafTitle: "チャムランプ 緑回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $danvine.chamLampCountGreen,
                        bigNumber: $danvine.chamLampCountSum,
                        setting1Percent: 3.1,
                        setting2Percent: 3.3,
                        setting3Percent: 3.6,
                        setting4Percent: 3.9,
                        setting5Percent: 4.3,
                        setting6Percent: 4.8
                    )
                )
            )
            .tag(5)
            // チャムランプ 赤回数
            unitListSection95Ci(
                grafTitle: "チャムランプ 赤回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $danvine.chamLampCountRed,
                        bigNumber: $danvine.chamLampCountSum,
                        setting1Percent: 0.8,
                        setting2Percent: 0.9,
                        setting3Percent: 1.0,
                        setting4Percent: 1.1,
                        setting5Percent: 1.3,
                        setting6Percent: 1.4
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
    danvineView95Ci()
}
