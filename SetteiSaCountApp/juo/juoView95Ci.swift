//
//  juoView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct juoView95Ci: View {
    @ObservedObject var juo: Juo
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // サバンナチャンス初当り回数
            unitListSection95Ci(
                grafTitle: "サバンナチャンス初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $juo.firstHitCountSc,
                        bigNumber: $juo.normalGame,
                        setting1Denominate: juo.ratioFirstHitSc[0],
                        setting2Denominate: juo.ratioFirstHitSc[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Denominate: juo.ratioFirstHitSc[2],
                        setting5Denominate: juo.ratioFirstHitSc[3],
                        setting6Denominate: juo.ratioFirstHitSc[4]
                    )
                )
            )
            .tag(2)

            // チェリー成立時のSC高確移行率
            unitListSection95Ci(
                grafTitle: "チェリー成立時\nSC高確移行率",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $juo.cherryCountScHigh,
                        bigNumber: $juo.cherryCount,
                        setting1Percent: juo.ratioCherryScHigh[0],
                        setting2Percent: juo.ratioCherryScHigh[1],
                        setting3Enable: false,
                        setting3Percent: -1,
                        setting4Percent: juo.ratioCherryScHigh[2],
                        setting5Percent: juo.ratioCherryScHigh[3],
                        setting6Percent: juo.ratioCherryScHigh[4]
                    )
                )
            )
            .tag(3)

            // レアリプレイ成立時のSC高確移行率
            unitListSection95Ci(
                grafTitle: "レアリプレイ成立時\nSC高確移行率",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $juo.rareReplayCountScHigh,
                        bigNumber: $juo.rareReplayCount,
                        setting1Percent: juo.ratioRareReplayScHigh[0],
                        setting2Percent: juo.ratioRareReplayScHigh[1],
                        setting3Enable: false,
                        setting3Percent: -1,
                        setting4Percent: juo.ratioRareReplayScHigh[2],
                        setting5Percent: juo.ratioRareReplayScHigh[3],
                        setting6Percent: juo.ratioRareReplayScHigh[4]
                    )
                )
            )
            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: juo.machineName,
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
    juoView95Ci(
        juo: Juo(),
    )
}
