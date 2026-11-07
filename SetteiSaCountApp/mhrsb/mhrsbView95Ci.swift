//
//  mhrsbView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct mhrsbView95Ci: View {
    @ObservedObject var mhrsb: Mhrsb
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // BZ初当り回数
            unitListSection95Ci(
                grafTitle: "BZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $mhrsb.firstHitCountBz,
                        bigNumber: $mhrsb.normalGame,
                        setting1Denominate: mhrsb.ratioFirstHitBz[0],
                        setting2Denominate: mhrsb.ratioFirstHitBz[1],
                        setting3Denominate: mhrsb.ratioFirstHitBz[2],
                        setting4Denominate: mhrsb.ratioFirstHitBz[3],
                        setting5Denominate: mhrsb.ratioFirstHitBz[4],
                        setting6Denominate: mhrsb.ratioFirstHitBz[5]
                    )
                )
            )
            .tag(2)

            // アイルー福引初当り回数
            unitListSection95Ci(
                grafTitle: "アイルー福引初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $mhrsb.firstHitCountFukubiki,
                        bigNumber: $mhrsb.normalGame,
                        setting1Denominate: mhrsb.ratioFirstHitFukubiki[0],
                        setting2Denominate: mhrsb.ratioFirstHitFukubiki[1],
                        setting3Denominate: mhrsb.ratioFirstHitFukubiki[2],
                        setting4Denominate: mhrsb.ratioFirstHitFukubiki[3],
                        setting5Denominate: mhrsb.ratioFirstHitFukubiki[4],
                        setting6Denominate: mhrsb.ratioFirstHitFukubiki[5]
                    )
                )
            )
            .tag(3)

            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $mhrsb.firstHitCountAt,
                        bigNumber: $mhrsb.normalGame,
                        setting1Denominate: mhrsb.ratioFirstHitAt[0],
                        setting2Denominate: mhrsb.ratioFirstHitAt[1],
                        setting3Denominate: mhrsb.ratioFirstHitAt[2],
                        setting4Denominate: mhrsb.ratioFirstHitAt[3],
                        setting5Denominate: mhrsb.ratioFirstHitAt[4],
                        setting6Denominate: mhrsb.ratioFirstHitAt[5]
                    )
                )
            )
            .tag(4)

            // クエスト成功期待度 QUEST(青)
            unitListSection95Ci(
                grafTitle: "クエスト QUEST(青)",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $mhrsb.quest1CountHit,
                        bigNumber: $mhrsb.quest1CountSum,
                        setting1Percent: mhrsb.ratioQuestList[0][0],
                        setting2Percent: mhrsb.ratioQuestList[0][1],
                        setting3Percent: mhrsb.ratioQuestList[0][2],
                        setting4Percent: mhrsb.ratioQuestList[0][3],
                        setting5Percent: mhrsb.ratioQuestList[0][4],
                        setting6Percent: mhrsb.ratioQuestList[0][5]
                    )
                )
            )
            .tag(5)

            // クエスト成功期待度 QUEST(黄)
            unitListSection95Ci(
                grafTitle: "クエスト QUEST(黄)",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $mhrsb.quest2CountHit,
                        bigNumber: $mhrsb.quest2CountSum,
                        setting1Percent: mhrsb.ratioQuestList[1][0],
                        setting2Percent: mhrsb.ratioQuestList[1][1],
                        setting3Percent: mhrsb.ratioQuestList[1][2],
                        setting4Percent: mhrsb.ratioQuestList[1][3],
                        setting5Percent: mhrsb.ratioQuestList[1][4],
                        setting6Percent: mhrsb.ratioQuestList[1][5]
                    )
                )
            )
            .tag(6)

            // クエスト成功期待度 ライゼクス
            unitListSection95Ci(
                grafTitle: "クエスト ライゼクス",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $mhrsb.quest3CountHit,
                        bigNumber: $mhrsb.quest3CountSum,
                        setting1Percent: mhrsb.ratioQuestList[2][0],
                        setting2Percent: mhrsb.ratioQuestList[2][1],
                        setting3Percent: mhrsb.ratioQuestList[2][2],
                        setting4Percent: mhrsb.ratioQuestList[2][3],
                        setting5Percent: mhrsb.ratioQuestList[2][4],
                        setting6Percent: mhrsb.ratioQuestList[2][5]
                    )
                )
            )
            .tag(7)

            // クエスト成功期待度 セルレギオス
            unitListSection95Ci(
                grafTitle: "クエスト セルレギオス",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $mhrsb.quest4CountHit,
                        bigNumber: $mhrsb.quest4CountSum,
                        setting1Percent: mhrsb.ratioQuestList[3][0],
                        setting2Percent: mhrsb.ratioQuestList[3][1],
                        setting3Percent: mhrsb.ratioQuestList[3][2],
                        setting4Percent: mhrsb.ratioQuestList[3][3],
                        setting5Percent: mhrsb.ratioQuestList[3][4],
                        setting6Percent: mhrsb.ratioQuestList[3][5]
                    )
                )
            )
            .tag(8)

            // クエスト成功期待度 オロミドロ亜種
            unitListSection95Ci(
                grafTitle: "クエスト オロミドロ亜種",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $mhrsb.quest5CountHit,
                        bigNumber: $mhrsb.quest5CountSum,
                        setting1Percent: mhrsb.ratioQuestList[4][0],
                        setting2Percent: mhrsb.ratioQuestList[4][1],
                        setting3Percent: mhrsb.ratioQuestList[4][2],
                        setting4Percent: mhrsb.ratioQuestList[4][3],
                        setting5Percent: mhrsb.ratioQuestList[4][4],
                        setting6Percent: mhrsb.ratioQuestList[4][5]
                    )
                )
            )
            .tag(9)

            // クエスト成功期待度 テオ・テスカトル
            unitListSection95Ci(
                grafTitle: "クエスト テオ・テスカトル",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $mhrsb.quest6CountHit,
                        bigNumber: $mhrsb.quest6CountSum,
                        setting1Percent: mhrsb.ratioQuestList[5][0],
                        setting2Percent: mhrsb.ratioQuestList[5][1],
                        setting3Percent: mhrsb.ratioQuestList[5][2],
                        setting4Percent: mhrsb.ratioQuestList[5][3],
                        setting5Percent: mhrsb.ratioQuestList[5][4],
                        setting6Percent: mhrsb.ratioQuestList[5][5]
                    )
                )
            )
            .tag(10)

            // 通常 弱レア役からのBZ当選率
            unitListSection95Ci(
                grafTitle: "通常 弱レア役→BZ",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $mhrsb.rareBzNormalWeakCountHit,
                        bigNumber: $mhrsb.rareBzNormalWeakCount,
                        setting1Percent: mhrsb.ratioRareBzNormalWeak[0],
                        setting2Percent: mhrsb.ratioRareBzNormalWeak[1],
                        setting3Percent: mhrsb.ratioRareBzNormalWeak[2],
                        setting4Percent: mhrsb.ratioRareBzNormalWeak[3],
                        setting5Percent: mhrsb.ratioRareBzNormalWeak[4],
                        setting6Percent: mhrsb.ratioRareBzNormalWeak[5]
                    )
                )
            )
            .tag(11)

            // 通常 強レア役からのBZ当選率
            unitListSection95Ci(
                grafTitle: "通常 強レア役→BZ",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $mhrsb.rareBzNormalStrongCountHit,
                        bigNumber: $mhrsb.rareBzNormalStrongCount,
                        setting1Percent: mhrsb.ratioRareBzNormalStrong[0],
                        setting2Percent: mhrsb.ratioRareBzNormalStrong[1],
                        setting3Percent: mhrsb.ratioRareBzNormalStrong[2],
                        setting4Percent: mhrsb.ratioRareBzNormalStrong[3],
                        setting5Percent: mhrsb.ratioRareBzNormalStrong[4],
                        setting6Percent: mhrsb.ratioRareBzNormalStrong[5]
                    )
                )
            )
            .tag(12)

            // 高確 弱レア役からのBZ当選率
            unitListSection95Ci(
                grafTitle: "高確 弱レア役→BZ",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $mhrsb.rareBzHighWeakCountHit,
                        bigNumber: $mhrsb.rareBzHighWeakCount,
                        setting1Percent: mhrsb.ratioRareBzHighWeak[0],
                        setting2Percent: mhrsb.ratioRareBzHighWeak[1],
                        setting3Percent: mhrsb.ratioRareBzHighWeak[2],
                        setting4Percent: mhrsb.ratioRareBzHighWeak[3],
                        setting5Percent: mhrsb.ratioRareBzHighWeak[4],
                        setting6Percent: mhrsb.ratioRareBzHighWeak[5]
                    )
                )
            )
            .tag(13)

            // 高確 強レア役からのBZ当選率
            unitListSection95Ci(
                grafTitle: "高確 強レア役→BZ",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $mhrsb.rareBzHighStrongCountHit,
                        bigNumber: $mhrsb.rareBzHighStrongCount,
                        setting1Percent: mhrsb.ratioRareBzHighStrong[0],
                        setting2Percent: mhrsb.ratioRareBzHighStrong[1],
                        setting3Percent: mhrsb.ratioRareBzHighStrong[2],
                        setting4Percent: mhrsb.ratioRareBzHighStrong[3],
                        setting5Percent: mhrsb.ratioRareBzHighStrong[4],
                        setting6Percent: mhrsb.ratioRareBzHighStrong[5]
                    )
                )
            )
            .tag(14)

            // 超高確 弱レア役からのBZ当選率
            unitListSection95Ci(
                grafTitle: "超高確 弱レア役→BZ",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $mhrsb.rareBzSuperWeakCountHit,
                        bigNumber: $mhrsb.rareBzSuperWeakCount,
                        setting1Percent: mhrsb.ratioRareBzSuperWeak[0],
                        setting2Percent: mhrsb.ratioRareBzSuperWeak[1],
                        setting3Percent: mhrsb.ratioRareBzSuperWeak[2],
                        setting4Percent: mhrsb.ratioRareBzSuperWeak[3],
                        setting5Percent: mhrsb.ratioRareBzSuperWeak[4],
                        setting6Percent: mhrsb.ratioRareBzSuperWeak[5]
                    )
                )
            )
            .tag(15)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: mhrsb.machineName,
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
    mhrsbView95Ci(
        mhrsb: Mhrsb(),
    )
}
