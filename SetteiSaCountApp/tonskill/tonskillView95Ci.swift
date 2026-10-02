//
//  tonskillView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct tonskillView95Ci: View {
    @ObservedObject var tonskill: Tonskill
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // CZ初当り回数
            unitListSection95Ci(
                grafTitle: "CZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $tonskill.firstHitCountCz,
                        bigNumber: $tonskill.normalGame,
                        setting1Denominate: tonskill.ratioFirstHitCz[0],
                        setting2Denominate: tonskill.ratioFirstHitCz[1],
                        setting3Denominate: tonskill.ratioFirstHitCz[2],
                        setting4Denominate: tonskill.ratioFirstHitCz[3],
                        setting5Denominate: tonskill.ratioFirstHitCz[4],
                        setting6Denominate: tonskill.ratioFirstHitCz[5]
                    )
                )
            )
            .tag(2)

            // ボーナス初当り回数
            unitListSection95Ci(
                grafTitle: "ボーナス初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $tonskill.firstHitCountBonus,
                        bigNumber: $tonskill.normalGame,
                        setting1Denominate: tonskill.ratioFirstHitBonus[0],
                        setting2Denominate: tonskill.ratioFirstHitBonus[1],
                        setting3Denominate: tonskill.ratioFirstHitBonus[2],
                        setting4Denominate: tonskill.ratioFirstHitBonus[3],
                        setting5Denominate: tonskill.ratioFirstHitBonus[4],
                        setting6Denominate: tonskill.ratioFirstHitBonus[5]
                    )
                )
            )
            .tag(3)

            // 333G 女神の舞移行率
            unitListSection95Ci(
                grafTitle: "333G 女神の舞移行率",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $tonskill.megami333GCountHit,
                        bigNumber: $tonskill.megami333GCountSum,
                        setting1Percent: tonskill.ratioMegami333G[0],
                        setting2Percent: tonskill.ratioMegami333G[1],
                        setting3Percent: tonskill.ratioMegami333G[2],
                        setting4Percent: tonskill.ratioMegami333G[3],
                        setting5Percent: tonskill.ratioMegami333G[4],
                        setting6Percent: tonskill.ratioMegami333G[5]
                    )
                )
            )
            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: tonskill.machineName,
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
    tonskillView95Ci(
        tonskill: Tonskill(),
    )
}
