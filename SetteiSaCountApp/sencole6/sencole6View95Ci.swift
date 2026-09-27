//
//  sencole6View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct sencole6View95Ci: View {
    @ObservedObject var sencole6: Sencole6
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // 回数
//            unitListSection95Ci(
//                grafTitle: "回数",
//                titleFont: .title2,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $sencole6.otomeAttackHit,
//                        bigNumber: $sencole6.otomeAttackSum,
//                        setting1Percent: sencole6.ratioOtomeAttack[0],
//                        setting2Percent: sencole6.ratioOtomeAttack[1],
//                        setting3Percent: sencole6.ratioOtomeAttack[2],
//                        setting4Percent: sencole6.ratioOtomeAttack[3],
//                        setting5Percent: sencole6.ratioOtomeAttack[4],
//                        setting6Percent: sencole6.ratioOtomeAttack[5]
//                    )
//                )
//            )
//            .tag(1)
//
//            // CZ初当り回数
//            unitListSection95Ci(
//                grafTitle: "CZ初当り回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $sencole6.firstHitCountCz,
//                        bigNumber: $sencole6.normalGame,
//                        setting1Denominate: sencole6.ratioFirstHitCz[0],
//                        setting2Denominate: sencole6.ratioFirstHitCz[1],
//                        setting3Denominate: sencole6.ratioFirstHitCz[2],
//                        setting4Denominate: sencole6.ratioFirstHitCz[3],
//                        setting5Denominate: sencole6.ratioFirstHitCz[4],
//                        setting6Denominate: sencole6.ratioFirstHitCz[5]
//                    )
//                )
//            )
//            .tag(2)
//
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $sencole6.firstHitCountAt,
                        bigNumber: $sencole6.normalGame,
                        setting1Denominate: sencole6.ratioFirstHitAt[0],
                        setting2Denominate: sencole6.ratioFirstHitAt[1],
                        setting3Denominate: sencole6.ratioFirstHitAt[2],
                        setting4Denominate: sencole6.ratioFirstHitAt[3],
                        setting5Denominate: sencole6.ratioFirstHitAt[4],
                        setting6Denominate: sencole6.ratioFirstHitAt[5]
                    )
                )
            )
            .tag(2)

            // 天魔一閃 300枚
            unitListSection95Ci(
                grafTitle: "天魔一閃\n300枚",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $sencole6.tenmaIssenCount300,
                        bigNumber: $sencole6.tenmaIssenCountSum,
                        setting1Percent: sencole6.ratioTenmaIssen300[0],
                        setting2Percent: sencole6.ratioTenmaIssen300[1],
                        setting3Percent: sencole6.ratioTenmaIssen300[2],
                        setting4Percent: sencole6.ratioTenmaIssen300[3],
                        setting5Percent: sencole6.ratioTenmaIssen300[4],
                        setting6Percent: sencole6.ratioTenmaIssen300[5]
                    )
                )
            )
            .tag(3)

            // 天魔一閃 550枚
            unitListSection95Ci(
                grafTitle: "天魔一閃\n550枚",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $sencole6.tenmaIssenCount550,
                        bigNumber: $sencole6.tenmaIssenCountSum,
                        setting1Percent: sencole6.ratioTenmaIssen550[0],
                        setting2Percent: sencole6.ratioTenmaIssen550[1],
                        setting3Percent: sencole6.ratioTenmaIssen550[2],
                        setting4Percent: sencole6.ratioTenmaIssen550[3],
                        setting5Percent: sencole6.ratioTenmaIssen550[4],
                        setting6Percent: sencole6.ratioTenmaIssen550[5]
                    )
                )
            )
            .tag(4)

            // 天魔一閃 800枚
            unitListSection95Ci(
                grafTitle: "天魔一閃\n800枚",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $sencole6.tenmaIssenCount800,
                        bigNumber: $sencole6.tenmaIssenCountSum,
                        setting1Percent: sencole6.ratioTenmaIssen800[0],
                        setting2Percent: sencole6.ratioTenmaIssen800[1],
                        setting3Percent: sencole6.ratioTenmaIssen800[2],
                        setting4Percent: sencole6.ratioTenmaIssen800[3],
                        setting5Percent: sencole6.ratioTenmaIssen800[4],
                        setting6Percent: sencole6.ratioTenmaIssen800[5]
                    )
                )
            )
            .tag(5)

            // 天魔一閃 1050枚
            unitListSection95Ci(
                grafTitle: "天魔一閃\n1050枚",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $sencole6.tenmaIssenCount1050,
                        bigNumber: $sencole6.tenmaIssenCountSum,
                        setting1Percent: sencole6.ratioTenmaIssen1050[0],
                        setting2Percent: sencole6.ratioTenmaIssen1050[1],
                        setting3Percent: sencole6.ratioTenmaIssen1050[2],
                        setting4Percent: sencole6.ratioTenmaIssen1050[3],
                        setting5Percent: sencole6.ratioTenmaIssen1050[4],
                        setting6Percent: sencole6.ratioTenmaIssen1050[5]
                    )
                )
            )
            .tag(6)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: sencole6.machineName,
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
    sencole6View95Ci(
        sencole6: Sencole6(),
    )
}
