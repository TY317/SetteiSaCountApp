//
//  kanokariView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct kanokariView95Ci: View {
    @ObservedObject var kanokari: Kanokari
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // CZ回数
            unitListSection95Ci(
                grafTitle: "CZ回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kanokari.firstHitCountCz,
                        bigNumber: $kanokari.normalGame,
                        setting1Denominate: kanokari.ratioFirstHitCz[0],
                        setting2Denominate: kanokari.ratioFirstHitCz[1],
                        setting3Denominate: kanokari.ratioFirstHitCz[2],
                        setting4Denominate: kanokari.ratioFirstHitCz[3],
                        setting5Denominate: kanokari.ratioFirstHitCz[4],
                        setting6Denominate: kanokari.ratioFirstHitCz[5]
                    )
                )
            )
            .tag(2)

            // 初当り回数
            unitListSection95Ci(
                grafTitle: "初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kanokari.firstHitCountBonus,
                        bigNumber: $kanokari.normalGame,
                        setting1Denominate: kanokari.ratioFirstHitBonus[0],
                        setting2Denominate: kanokari.ratioFirstHitBonus[1],
                        setting3Denominate: kanokari.ratioFirstHitBonus[2],
                        setting4Denominate: kanokari.ratioFirstHitBonus[3],
                        setting5Denominate: kanokari.ratioFirstHitBonus[4],
                        setting6Denominate: kanokari.ratioFirstHitBonus[5]
                    )
                )
            )
            .tag(3)

            // 終了画面 枠なし
            unitListSection95Ci(
                grafTitle: "終了画面 枠なし",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kanokari.screenCount1,
                        bigNumber: $kanokari.screenCountSum,
                        setting1Percent: kanokari.ratioScreen1[0],
                        setting2Percent: kanokari.ratioScreen1[1],
                        setting3Percent: kanokari.ratioScreen1[2],
                        setting4Percent: kanokari.ratioScreen1[3],
                        setting5Percent: kanokari.ratioScreen1[4],
                        setting6Percent: kanokari.ratioScreen1[5]
                    )
                )
            )
            .tag(4)

            // キャラ紹介シナリオ①
            unitListSection95Ci(
                grafTitle: "キャラ紹介シナリオ①",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kanokari.rbCharaCountDefault,
                        bigNumber: $kanokari.rbCharaCountSum,
                        setting1Percent: kanokari.ratioRbCharaDefault[0],
                        setting2Percent: kanokari.ratioRbCharaDefault[1],
                        setting3Percent: kanokari.ratioRbCharaDefault[2],
                        setting4Percent: kanokari.ratioRbCharaDefault[3],
                        setting5Percent: kanokari.ratioRbCharaDefault[4],
                        setting6Percent: kanokari.ratioRbCharaDefault[5]
                    )
                )
            )
            .tag(5)

            // キャラ紹介シナリオ⑤
            unitListSection95Ci(
                grafTitle: "キャラ紹介シナリオ⑤",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kanokari.rbCharaCountHighKyo,
                        bigNumber: $kanokari.rbCharaCountSum,
                        setting1Percent: kanokari.ratioRbCharaHighKyo[0],
                        setting2Percent: kanokari.ratioRbCharaHighKyo[1],
                        setting3Percent: kanokari.ratioRbCharaHighKyo[2],
                        setting4Percent: kanokari.ratioRbCharaHighKyo[3],
                        setting5Percent: kanokari.ratioRbCharaHighKyo[4],
                        setting6Percent: kanokari.ratioRbCharaHighKyo[5]
                    )
                )
            )
            .tag(6)

            // 1Gレンチャンス 偶数示唆
            unitListSection95Ci(
                grafTitle: "1Gレンチャンス 偶数示唆",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kanokari.koryakuCharaCount1,
                        bigNumber: $kanokari.koryakuCharaCountSum,
                        setting1Percent: kanokari.ratioKoryakuCharaGusu[0],
                        setting2Percent: kanokari.ratioKoryakuCharaGusu[1],
                        setting3Percent: kanokari.ratioKoryakuCharaGusu[2],
                        setting4Percent: kanokari.ratioKoryakuCharaGusu[3],
                        setting5Percent: kanokari.ratioKoryakuCharaGusu[4],
                        setting6Percent: kanokari.ratioKoryakuCharaGusu[5]
                    )
                )
            )
            .tag(7)

            // 引き戻し期待度（ユメカノ）
            unitListSection95Ci(
                grafTitle: "引き戻し期待度（ユメカノ）",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kanokari.comebackYumekanoCountHit,
                        bigNumber: $kanokari.comebackYumekanoCountSum,
                        setting1Percent: kanokari.ratioComebackYumekano[0],
                        setting2Percent: kanokari.ratioComebackYumekano[1],
                        setting3Percent: kanokari.ratioComebackYumekano[2],
                        setting4Percent: kanokari.ratioComebackYumekano[3],
                        setting5Percent: kanokari.ratioComebackYumekano[4],
                        setting6Percent: kanokari.ratioComebackYumekano[5]
                    )
                )
            )
            .tag(8)

            // ななかりDREAM当選率（非ユメカノ）
            unitListSection95Ci(
                grafTitle: "ななかりDREAM当選率（非ユメカノ）",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kanokari.dreamNormalCountHit,
                        bigNumber: $kanokari.dreamNormalCountSum,
                        setting1Percent: kanokari.ratioDreamNormal[0],
                        setting2Percent: kanokari.ratioDreamNormal[1],
                        setting3Percent: kanokari.ratioDreamNormal[2],
                        setting4Percent: kanokari.ratioDreamNormal[3],
                        setting5Percent: kanokari.ratioDreamNormal[4],
                        setting6Percent: kanokari.ratioDreamNormal[5]
                    )
                )
            )
            .tag(9)

            // ななかりDREAM当選率（ユメカノ）
            unitListSection95Ci(
                grafTitle: "ななかりDREAM当選率（ユメカノ）",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kanokari.dreamYumekanoCountHit,
                        bigNumber: $kanokari.dreamYumekanoCountSum,
                        setting1Percent: kanokari.ratioDreamYumekano[0],
                        setting2Percent: kanokari.ratioDreamYumekano[1],
                        setting3Percent: kanokari.ratioDreamYumekano[2],
                        setting4Percent: kanokari.ratioDreamYumekano[3],
                        setting5Percent: kanokari.ratioDreamYumekano[4],
                        setting6Percent: kanokari.ratioDreamYumekano[5]
                    )
                )
            )
            .tag(10)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kanokari.machineName,
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
    kanokariView95Ci(
        kanokari: Kanokari(),
    )
}
