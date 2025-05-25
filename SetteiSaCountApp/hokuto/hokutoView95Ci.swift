//
//  hokutoView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/24.
//

import SwiftUI

struct hokutoView95Ci: View {
//    @ObservedObject var hokuto = Hokuto()
    @ObservedObject var hokuto: Hokuto
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // 通常時の平行ベル回数
            unitListSection95Ci(
                grafTitle: "通常時の平行ベル回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hokuto.normalBellHorizontalCount,
                        bigNumber: $hokuto.normalPlayGame,
                        setting1Denominate: 170,
                        setting2Denominate: -100,
                        setting3Enable: false,
                        setting3Denominate: -100,
                        setting4Denominate: -100,
                        setting5Denominate: -100,
                        setting6Denominate: 100
                    )
                )
            )
            .tag(1)
            // バトルボーナス初当たり回数
            unitListSection95Ci(
                grafTitle: "バトルボーナス初当り回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hokuto.bbHitCount,
                        bigNumber: $hokuto.bbGameSum,
                        setting1Denominate: 383.4,
                        setting2Denominate: 370.5,
                        setting3Enable: false,
                        setting3Denominate: -100,
                        setting4Denominate: 297.8,
                        setting5Denominate: 258.7,
                        setting6Denominate: 235.1
                    )
                )
            )
            .tag(2)
            // バトルボーナス中の平行ベル
            unitListSection95Ci(
                grafTitle: "バトルボーナス中の平行ベル",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hokuto.bbBellHorizontalCount,
                        bigNumber: $hokuto.bbPlayGame,
                        setting1Denominate: 400,
                        setting2Denominate: -100,
                        setting3Enable: false,
                        setting3Denominate: -100,
                        setting4Denominate: -100,
                        setting5Denominate: -100,
                        setting6Denominate: 230
                    )
                )
            )
            .tag(3)
            // ボイス デフォルト回数
            unitListSection95Ci(
                grafTitle: "ボイス デフォルト回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $hokuto.voiceDefaultCount,
                        bigNumber: $hokuto.voiceCountSum,
                        setting1Percent: 84.7,
                        setting2Percent: 83.3,
                        setting3Enable: false,
                        setting3Percent: -100,
                        setting4Percent: 74,
                        setting5Percent: 73,
                        setting6Percent: 71
                    )
                )
            )
            .tag(4)
            // ボイス ジャギ回数
            unitListSection95Ci(
                grafTitle: "ボイス ジャギ回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $hokuto.voiceJagiCount,
                        bigNumber: $hokuto.voiceCountSum,
                        setting1Percent: 3.4,
                        setting2Percent: 3.8,
                        setting3Enable: false,
                        setting3Percent: -100,
                        setting4Percent: 6.3,
                        setting5Percent: 6.7,
                        setting6Percent: 7.2
                    )
                )
            )
            .tag(5)
            // ボイス アミバ回数
            unitListSection95Ci(
                grafTitle: "ボイス アミバ回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $hokuto.voiceAmibaCount,
                        bigNumber: $hokuto.voiceCountSum,
                        setting1Percent: 1.2,
                        setting2Percent: 1.5,
                        setting3Enable: false,
                        setting3Percent: -100,
                        setting4Percent: 6.3,
                        setting5Percent: 6.7,
                        setting6Percent: 7.2
                    )
                )
            )
            .tag(6)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "スマスロ北斗の拳",
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
    hokutoView95Ci(hokuto: Hokuto())
}
