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
