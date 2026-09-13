//
//  aobutaView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct aobutaView95Ci: View {
    @ObservedObject var aobuta: Aobuta
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // 初当り回数
            unitListSection95Ci(
                grafTitle: "初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $aobuta.firstHitCountSt,
                        bigNumber: $aobuta.normalGame,
                        setting1Enable: false,
                        setting1Denominate: -1,
                        setting2Denominate: aobuta.ratioFirstHitSt[0],
                        setting3Denominate: aobuta.ratioFirstHitSt[1],
                        setting4Denominate: aobuta.ratioFirstHitSt[2],
                        setting5Denominate: aobuta.ratioFirstHitSt[3],
                        setting6Denominate: aobuta.ratioFirstHitSt[4]
                    )
                )
            )
            .tag(2)

            // 開始時の思春期症候群
            unitListSection95Ci(
                grafTitle: "開始時の思春期症候群 回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $aobuta.syndromeCountHit,
                        bigNumber: $aobuta.syndromeCountSum,
                        setting1Enable: false,
                        setting1Percent: -1,
                        setting2Percent: aobuta.ratioSyndrome[0],
                        setting3Percent: aobuta.ratioSyndrome[1],
                        setting4Percent: aobuta.ratioSyndrome[2],
                        setting5Percent: aobuta.ratioSyndrome[3],
                        setting6Percent: aobuta.ratioSyndrome[4]
                    )
                )
            )
            .tag(3)

            // アオハルチャンス当選率 🍒
            unitListSection95Ci(
                grafTitle: "アオハル当選率\n通常滞在時 🍒",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $aobuta.aoharuCherryCountHit,
                        bigNumber: $aobuta.aoharuCherryCount,
                        setting1Enable: false,
                        setting1Percent: -1,
                        setting2Percent: aobuta.ratioAoharuCherry[0],
                        setting3Percent: aobuta.ratioAoharuCherry[1],
                        setting4Percent: aobuta.ratioAoharuCherry[2],
                        setting5Percent: aobuta.ratioAoharuCherry[3],
                        setting6Percent: aobuta.ratioAoharuCherry[4]
                    )
                )
            )
            .tag(4)

            // アオハルチャンス当選率 ﾁｬﾝｽ目
            unitListSection95Ci(
                grafTitle: "アオハル当選率\n通常滞在時 ﾁｬﾝｽ目",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $aobuta.aoharuChanceCountHit,
                        bigNumber: $aobuta.aoharuChanceCount,
                        setting1Enable: false,
                        setting1Percent: -1,
                        setting2Percent: aobuta.ratioAoharuChance[0],
                        setting3Percent: aobuta.ratioAoharuChance[1],
                        setting4Percent: aobuta.ratioAoharuChance[2],
                        setting5Percent: aobuta.ratioAoharuChance[3],
                        setting6Percent: aobuta.ratioAoharuChance[4]
                    )
                )
            )
            .tag(5)

            // アオハルチャンス確率
            unitListSection95Ci(
                grafTitle: "アオハルチャンス確率",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $aobuta.aoharuCount,
                        bigNumber: $aobuta.aoharuGame,
                        setting1Enable: false,
                        setting1Denominate: -1,
                        setting2Denominate: aobuta.ratioAoharu[0],
                        setting3Denominate: aobuta.ratioAoharu[1],
                        setting4Denominate: aobuta.ratioAoharu[2],
                        setting5Denominate: aobuta.ratioAoharu[3],
                        setting6Denominate: aobuta.ratioAoharu[4]
                    )
                )
            )
            .tag(6)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: aobuta.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("95%信頼区間グラフ")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButton95CiExplain(isShow95CiExplain: isShow95CiExplain)
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    aobutaView95Ci(
        aobuta: Aobuta(),
    )
}
