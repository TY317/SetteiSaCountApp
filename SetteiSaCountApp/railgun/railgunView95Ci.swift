//
//  railgunView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/19.
//

import SwiftUI

struct railgunView95Ci: View {
    @ObservedObject var railgun: Railgun
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // コイン揃いからのCZ当選回数
            unitListSection95Ci(
                grafTitle: "コイン揃いからのCZ当選回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $railgun.coinCountCzHit,
                        bigNumber: $railgun.coinCount,
                        setting1Percent: railgun.ratioCoinCzHit[0],
                        setting2Percent: railgun.ratioCoinCzHit[1],
                        setting3Percent: railgun.ratioCoinCzHit[2],
                        setting4Percent: railgun.ratioCoinCzHit[3],
                        setting5Percent: railgun.ratioCoinCzHit[4],
                        setting6Percent: railgun.ratioCoinCzHit[5]
                    )
                )
            )
            .tag(1)
            
            // CZ回数
            unitListSection95Ci(
                grafTitle: "CZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $railgun.czCount,
                        bigNumber: $railgun.normalGame,
                        setting1Denominate: railgun.ratioFirstHitCz[0],
                        setting2Denominate: railgun.ratioFirstHitCz[1],
                        setting3Denominate: railgun.ratioFirstHitCz[2],
                        setting4Denominate: railgun.ratioFirstHitCz[3],
                        setting5Denominate: railgun.ratioFirstHitCz[4],
                        setting6Denominate: railgun.ratioFirstHitCz[5]
                    )
                )
            )
            .tag(2)
            // AT回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $railgun.atCount,
                        bigNumber: $railgun.normalGame,
                        setting1Denominate: railgun.ratioFirstHitAt[0],
                        setting2Denominate: railgun.ratioFirstHitAt[1],
                        setting3Denominate: railgun.ratioFirstHitAt[2],
                        setting4Denominate: railgun.ratioFirstHitAt[3],
                        setting5Denominate: railgun.ratioFirstHitAt[4],
                        setting6Denominate: railgun.ratioFirstHitAt[5]
                    )
                )
            )
            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: railgun.machineName,
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
    railgunView95Ci(
        railgun: Railgun(),
    )
}
