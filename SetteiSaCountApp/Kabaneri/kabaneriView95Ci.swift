//
//  kabaneriView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/27.
//

import SwiftUI

struct kabaneriView95Ci: View {
//    @ObservedObject var kabaneri = Kabaneri()
    @ObservedObject var kabaneri: Kabaneri
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // 発光回数
            unitListSection95Ci(
                grafTitle: "1個チャンス目 発光回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kabaneri.chanceWithFlushCount,
                        bigNumber: $kabaneri.chanceCountSum,
                        setting1Percent: 10,
                        setting2Percent: -100,
                        setting3Percent: -100,
                        setting4Percent: -100,
                        setting5Percent: -100,
                        setting6Percent: 17
                    )
                )
            )
            .tag(1)
            // 共通ベル回数
            unitListSection95Ci(
                grafTitle: "共通ベル回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kabaneri.bellCount,
                        bigNumber: $kabaneri.playGame,
                        setting1Denominate: 26.6,
                        setting2Denominate: 26.6,
                        setting3Denominate: 25.9,
                        setting4Denominate: 25.4,
                        setting5Denominate: 24.9,
                        setting6Denominate: 24.2
                    )
                )
            )
            .tag(2)
            // CZ回数
            unitListSection95Ci(
                grafTitle: "CZ回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kabaneri.czHitCount,
                        bigNumber: $kabaneri.historyPlayGame,
                        setting1Denominate: 179.3,
                        setting2Denominate: 177.9,
                        setting3Denominate: 169.3,
                        setting4Denominate: 158.4,
                        setting5Denominate: 145.6,
                        setting6Denominate: 136.8
                    )
                )
            )
            .tag(3)
            // 無名CZ ナビ発生回数
            unitListSection95Ci(
                grafTitle: "無名CZ ナビ発生回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kabaneri.mumeiNaviCount,
                        bigNumber: $kabaneri.mumeiNaviCountSum,
                        setting1Percent: 48.1,
                        setting2Percent: 48.1,
                        setting3Percent: 50.3,
                        setting4Percent: 53.9,
                        setting5Percent: 56.2,
                        setting6Percent: 62.8
                    )
                )
            )
            .tag(4)
            // 無名CZ 3連撃時の当選回数
            unitListSection95Ci(
                grafTitle: "無名CZ 3連撃時の当選回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kabaneri.mumei3renWinCount,
                        bigNumber: $kabaneri.mumei3renCountSum,
                        setting1Percent: 18.7,
                        setting2Percent: 18.8,
                        setting3Percent: 23.5,
                        setting4Percent: 28.3,
                        setting5Percent: 30.6,
                        setting6Percent: 40.7
                    )
                )
            )
            .tag(5)
            // 生駒CZ ライフ1 ハズレでの減少回数
            unitListSection95Ci(
                grafTitle: "生駒CZ ライフ3\nハズレでの減少回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kabaneri.icomaLife3DamageCount,
                        bigNumber: $kabaneri.icomaLife3CountSum,
                        setting1Percent: 66.8,
                        setting2Percent: 66.8,
                        setting3Percent: 65.1,
                        setting4Percent: 62.2,
                        setting5Percent: 60.8,
                        setting6Percent: 55.0
                    )
                )
            )
            .tag(6)
            // 生駒CZ ライフ2 ハズレでの減少回数
            unitListSection95Ci(
                grafTitle: "生駒CZ ライフ2\nハズレでの減少回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kabaneri.icomaLife2DamageCount,
                        bigNumber: $kabaneri.icomaLife2CountSum,
                        setting1Percent: 44.2,
                        setting2Percent: 44.2,
                        setting3Percent: 42.4,
                        setting4Percent: 40.3,
                        setting5Percent: 38.8,
                        setting6Percent: 34.5
                    )
                )
            )
            .tag(7)
            // 生駒CZ ライフ3 ハズレでの減少回数
            unitListSection95Ci(
                grafTitle: "生駒CZ ライフ1\nハズレでの減少回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kabaneri.icomaLife1DamageCount,
                        bigNumber: $kabaneri.icomaLife1CountSum,
                        setting1Percent: 39.8,
                        setting2Percent: 39.8,
                        setting3Percent: 38.0,
                        setting4Percent: 35.9,
                        setting5Percent: 34.4,
                        setting6Percent: 30.8
                    )
                )
            )
            .tag(8)
            // カバネリボーナス中　キャラ紹介 奇数示唆回数
            unitListSection95Ci(
                grafTitle: "カバネリボーナス中\nキャラ紹介 奇数示唆回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kabaneri.sexMaleCount,
                        bigNumber: $kabaneri.sexCountSum,
                        setting1Percent: 60,
                        setting2Percent: 40,
                        setting3Percent: 60,
                        setting4Percent: 40,
                        setting5Percent: 60,
                        setting6Percent: 40
                    )
                )
            )
            .tag(9)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "甲鉄城のカバネリ",
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
    kabaneriView95Ci(kabaneri: Kabaneri())
}
