//
//  toreveView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/05.
//

import SwiftUI

struct toreveView95Ci: View {
    @ObservedObject var toreve: Toreve
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // 共通ベル回数
            unitListSection95Ci(
                grafTitle: "共通🔔回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $toreve.bellCount,
                        bigNumber: $toreve.gameNumberPlay,
                        setting1Denominate: toreve.ratioBell[0],
                        setting2Denominate: toreve.ratioBell[1],
                        setting3Denominate: toreve.ratioBell[2],
                        setting4Denominate: toreve.ratioBell[3],
                        setting5Denominate: toreve.ratioBell[4],
                        setting6Denominate: toreve.ratioBell[5]
                    )
                )
            )
            .tag(7)
            // チャンス目からのCZ当選回数
            unitListSection95Ci(
                grafTitle: "通常チャンス目からのCZ当選回数",
                titleFont: .title3,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $toreve.chanceCzCountCzHit,
                        bigNumber: $toreve.chanceCzCountChance,
                        setting1Percent: toreve.ratioNormalChanceMidNight[0],
                        setting2Percent: toreve.ratioNormalChanceMidNight[1],
                        setting3Percent: toreve.ratioNormalChanceMidNight[2],
                        setting4Percent: toreve.ratioNormalChanceMidNight[3],
                        setting5Percent: toreve.ratioNormalChanceMidNight[4],
                        setting6Percent: toreve.ratioNormalChanceMidNight[5]
                    )
                )
            )
            .tag(8)
            // CZ ミッドナイト回数
            unitListSection95Ci(
                grafTitle: "CZ ミッドナイト回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $toreve.czCountMidNight,
                        bigNumber: $toreve.normalGame,
                        setting1Denominate: toreve.ratioCzMidNight[0],
                        setting2Denominate: toreve.ratioCzMidNight[1],
                        setting3Denominate: toreve.ratioCzMidNight[2],
                        setting4Denominate: toreve.ratioCzMidNight[3],
                        setting5Denominate: toreve.ratioCzMidNight[4],
                        setting6Denominate: toreve.ratioCzMidNight[5]
                    )
                )
            )
            .tag(1)
            // CZ 綺咲陰謀
            unitListSection95Ci(
                grafTitle: "CZ 稀咲陰謀回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $toreve.czCountKisaki,
                        bigNumber: $toreve.normalGame,
                        setting1Denominate: toreve.ratioCzKisaki[0],
                        setting2Denominate: toreve.ratioCzKisaki[1],
                        setting3Denominate: toreve.ratioCzKisaki[2],
                        setting4Denominate: toreve.ratioCzKisaki[3],
                        setting5Denominate: toreve.ratioCzKisaki[4],
                        setting6Denominate: toreve.ratioCzKisaki[5]
                    )
                )
            )
            .tag(2)
            // CZ 合算回数
            unitListSection95Ci(
                grafTitle: "CZ 合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $toreve.czCountSum,
                        bigNumber: $toreve.normalGame,
                        setting1Denominate: toreve.ratioCzSum[0],
                        setting2Denominate: toreve.ratioCzSum[1],
                        setting3Denominate: toreve.ratioCzSum[2],
                        setting4Denominate: toreve.ratioCzSum[3],
                        setting5Denominate: toreve.ratioCzSum[4],
                        setting6Denominate: toreve.ratioCzSum[5]
                    )
                )
            )
            .tag(3)
            // 東卍チャンス 回数
            unitListSection95Ci(
                grafTitle: "東卍チャンス回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $toreve.tomanChallengeCount,
                        bigNumber: $toreve.normalGame,
                        setting1Denominate: toreve.ratioTomanChallenge[0],
                        setting2Denominate: toreve.ratioTomanChallenge[1],
                        setting3Denominate: toreve.ratioTomanChallenge[2],
                        setting4Denominate: toreve.ratioTomanChallenge[3],
                        setting5Denominate: toreve.ratioTomanChallenge[4],
                        setting6Denominate: toreve.ratioTomanChallenge[5]
                    )
                )
            )
            .tag(4)
            // 東卍ラッシュ 回数
            unitListSection95Ci(
                grafTitle: "東卍ラッシュ回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $toreve.tomanRushCount,
                        bigNumber: $toreve.normalGame,
                        setting1Denominate: toreve.ratioTomanRush[0],
                        setting2Denominate: toreve.ratioTomanRush[1],
                        setting3Denominate: toreve.ratioTomanRush[2],
                        setting4Denominate: toreve.ratioTomanRush[3],
                        setting5Denominate: toreve.ratioTomanRush[4],
                        setting6Denominate: toreve.ratioTomanRush[5]
                    )
                )
            )
            .tag(5)
            // 初当り 回数
            unitListSection95Ci(
                grafTitle: "初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $toreve.firstHitCount,
                        bigNumber: $toreve.normalGame,
                        setting1Denominate: toreve.ratioFirstHit[0],
                        setting2Denominate: toreve.ratioFirstHit[1],
                        setting3Denominate: toreve.ratioFirstHit[2],
                        setting4Denominate: toreve.ratioFirstHit[3],
                        setting5Denominate: toreve.ratioFirstHit[4],
                        setting6Denominate: toreve.ratioFirstHit[5]
                    )
                )
            )
            .tag(6)
            // 東卍チャンス　AT昇格回数
            unitListSection95Ci(
                grafTitle: "東卍チャンス\n弱🍒・スイカからの昇格回数",
                titleFont: .title3,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $toreve.atRiseCountManjiRise,
                        bigNumber: $toreve.atRiseCountManji,
                        setting1Percent: toreve.ratioAtRiseJakuRare[0],
                        setting2Percent: toreve.ratioAtRiseJakuRare[1],
                        setting3Percent: toreve.ratioAtRiseJakuRare[2],
                        setting4Percent: toreve.ratioAtRiseJakuRare[3],
                        setting5Percent: toreve.ratioAtRiseJakuRare[4],
                        setting6Percent: toreve.ratioAtRiseJakuRare[5]
                    )
                )
            )
            .tag(9)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: toreve.machineName,
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
    toreveView95Ci(
        toreve: Toreve(),
    )
}
