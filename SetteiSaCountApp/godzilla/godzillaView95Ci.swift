//
//  godzillaView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/13.
//

import SwiftUI

struct godzillaView95Ci: View {
    @ObservedObject var godzilla: Godzilla
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // 探索ゾーン初当り回数
            unitListSection95Ci(
                grafTitle: "探索ゾーン初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $godzilla.tansakuCount,
                        bigNumber: $godzilla.normalGame,
                        setting1Denominate: godzilla.ratioTansakuZone[0],
                        setting2Denominate: godzilla.ratioTansakuZone[1],
                        setting3Denominate: godzilla.ratioTansakuZone[2],
                        setting4Denominate: godzilla.ratioTansakuZone[3],
                        setting5Denominate: godzilla.ratioTansakuZone[4],
                        setting6Denominate: godzilla.ratioTansakuZone[5]
                    )
                )
            )
            .tag(5)
            // CZ ラドン
            unitListSection95Ci(
                grafTitle: "襲来ゾーン\nラドン 回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $godzilla.czCharaCountRadon,
                        bigNumber: $godzilla.czCharaCountSum,
                        setting1Percent: godzilla.ratioCzCharaRadon[0],
                        setting2Percent: godzilla.ratioCzCharaRadon[1],
                        setting3Percent: godzilla.ratioCzCharaRadon[2],
                        setting4Percent: godzilla.ratioCzCharaRadon[3],
                        setting5Percent: godzilla.ratioCzCharaRadon[4],
                        setting6Percent: godzilla.ratioCzCharaRadon[5]
                    )
                )
            )
            .tag(1)
            // CZ ガイガン
            unitListSection95Ci(
                grafTitle: "襲来ゾーン\nガイガン 回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $godzilla.czCharaCountGaigan,
                        bigNumber: $godzilla.czCharaCountSum,
                        setting1Percent: godzilla.ratioCzCharaGaigan[0],
                        setting2Percent: godzilla.ratioCzCharaGaigan[1],
                        setting3Percent: godzilla.ratioCzCharaGaigan[2],
                        setting4Percent: godzilla.ratioCzCharaGaigan[3],
                        setting5Percent: godzilla.ratioCzCharaGaigan[4],
                        setting6Percent: godzilla.ratioCzCharaGaigan[5]
                    )
                )
            )
            .tag(2)
            // CZ ビオランテ
            unitListSection95Ci(
                grafTitle: "襲来ゾーン\nビオランテ 回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $godzilla.czCharaCountBiorante,
                        bigNumber: $godzilla.czCharaCountSum,
                        setting1Percent: godzilla.ratioCzCharaBiorante[0],
                        setting2Percent: godzilla.ratioCzCharaBiorante[1],
                        setting3Percent: godzilla.ratioCzCharaBiorante[2],
                        setting4Percent: godzilla.ratioCzCharaBiorante[3],
                        setting5Percent: godzilla.ratioCzCharaBiorante[4],
                        setting6Percent: godzilla.ratioCzCharaBiorante[5]
                    )
                )
            )
            .tag(3)
            // CZ デストロイア
            unitListSection95Ci(
                grafTitle: "襲来ゾーン\nデストロイア 回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $godzilla.czCharaCountDestoroia,
                        bigNumber: $godzilla.czCharaCountSum,
                        setting1Percent: godzilla.ratioCzCharaDestoroia[0],
                        setting2Percent: godzilla.ratioCzCharaDestoroia[1],
                        setting3Percent: godzilla.ratioCzCharaDestoroia[2],
                        setting4Percent: godzilla.ratioCzCharaDestoroia[3],
                        setting5Percent: godzilla.ratioCzCharaDestoroia[4],
                        setting6Percent: godzilla.ratioCzCharaDestoroia[5]
                    )
                )
            )
            .tag(4)
            // CZ回数
            unitListSection95Ci(
                grafTitle: "CZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $godzilla.czCountSum,
                        bigNumber: $godzilla.normalGame,
                        setting1Denominate: godzilla.ratioCz[0],
                        setting2Denominate: godzilla.ratioCz[1],
                        setting3Denominate: godzilla.ratioCz[2],
                        setting4Denominate: godzilla.ratioCz[3],
                        setting5Denominate: godzilla.ratioCz[4],
                        setting6Denominate: godzilla.ratioCz[5]
                    )
                )
            )
            .tag(6)
            // AT回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $godzilla.atCount,
                        bigNumber: $godzilla.normalGame,
                        setting1Denominate: godzilla.ratioAt[0],
                        setting2Denominate: godzilla.ratioAt[1],
                        setting3Denominate: godzilla.ratioAt[2],
                        setting4Denominate: godzilla.ratioAt[3],
                        setting5Denominate: godzilla.ratioAt[4],
                        setting6Denominate: godzilla.ratioAt[5]
                    )
                )
            )
            .tag(7)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ゴジラ",
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
    godzillaView95Ci(godzilla: Godzilla())
}
