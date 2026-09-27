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
