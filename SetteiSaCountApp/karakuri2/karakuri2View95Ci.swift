//
//  karakuri2View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/27.
//

import SwiftUI

struct karakuri2View95Ci: View {
    @ObservedObject var karakuri2: Karakuri2
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // 強チェリーからの当選
            unitListSection95Ci(
                grafTitle: "通常時 強🍒\nCZ・AT当選回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $karakuri2.kyoCherryCountHit,
                        bigNumber: $karakuri2.kyoCherryCount,
                        setting1Percent: karakuri2.ratioKyoCherryHit[0],
                        setting2Percent: karakuri2.ratioKyoCherryHit[1],
                        setting3Percent: karakuri2.ratioKyoCherryHit[2],
                        setting4Percent: karakuri2.ratioKyoCherryHit[3],
                        setting5Percent: karakuri2.ratioKyoCherryHit[4],
                        setting6Percent: karakuri2.ratioKyoCherryHit[5]
                    )
                )
            )
            .tag(1)
            
            // CZ初当り回数
            unitListSection95Ci(
                grafTitle: "CZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $karakuri2.firstHitCountCz,
                        bigNumber: $karakuri2.normalGame,
                        setting1Denominate: karakuri2.ratioFirstHitCz[0],
                        setting2Denominate: karakuri2.ratioFirstHitCz[1],
                        setting3Denominate: karakuri2.ratioFirstHitCz[2],
                        setting4Denominate: karakuri2.ratioFirstHitCz[3],
                        setting5Denominate: karakuri2.ratioFirstHitCz[4],
                        setting6Denominate: karakuri2.ratioFirstHitCz[5]
                    )
                )
            )
            .tag(2)

            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $karakuri2.firstHitCountAt,
                        bigNumber: $karakuri2.normalGame,
                        setting1Denominate: karakuri2.ratioFirstHitAt[0],
                        setting2Denominate: karakuri2.ratioFirstHitAt[1],
                        setting3Denominate: karakuri2.ratioFirstHitAt[2],
                        setting4Denominate: karakuri2.ratioFirstHitAt[3],
                        setting5Denominate: karakuri2.ratioFirstHitAt[4],
                        setting6Denominate: karakuri2.ratioFirstHitAt[5]
                    )
                )
            )
            .tag(3)

            // 激情ジャッジ 奇数示唆合算
            unitListSection95Ci(
                grafTitle: "激情ジャッジ\n奇数示唆合算の回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $karakuri2.charaCountKisuSum,
                        bigNumber: $karakuri2.charaCountSum,
                        setting1Percent: karakuri2.ratioCharaKisu[0],
                        setting2Percent: karakuri2.ratioCharaKisu[1],
                        setting3Percent: karakuri2.ratioCharaKisu[2],
                        setting4Percent: karakuri2.ratioCharaKisu[3],
                        setting5Percent: karakuri2.ratioCharaKisu[4],
                        setting6Percent: karakuri2.ratioCharaKisu[5]
                    )
                )
            )
            .tag(4)

            // AT開始時のステージ
            unitListSection95Ci(
                grafTitle: "AT開始時\n鳴海ステージの回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $karakuri2.startStageCountHit,
                        bigNumber: $karakuri2.startStageCountSum,
                        setting1Percent: karakuri2.ratioStartStageNarumi[0],
                        setting2Percent: karakuri2.ratioStartStageNarumi[1],
                        setting3Percent: karakuri2.ratioStartStageNarumi[2],
                        setting4Percent: karakuri2.ratioStartStageNarumi[3],
                        setting5Percent: karakuri2.ratioStartStageNarumi[4],
                        setting6Percent: karakuri2.ratioStartStageNarumi[5]
                    )
                )
            )
            .tag(5)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: karakuri2.machineName,
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
    karakuri2View95Ci(
        karakuri2: Karakuri2(),
    )
}
