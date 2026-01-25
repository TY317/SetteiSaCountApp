//
//  kokakukidotaiView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/12.
//

import SwiftUI

struct kokakukidotaiView95Ci: View {
    @ObservedObject var kokakukidotai: Kokakukidotai
    @State var selection = 1
    @State var isShow95CiExplain = false
    var body: some View {
        TabView(selection: self.$selection) {
            // CZ初当り回数
            unitListSection95Ci(
                grafTitle: "CZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kokakukidotai.firstHitCountCz,
                        bigNumber: $kokakukidotai.normalGame,
                        setting1Denominate: kokakukidotai.ratioFirstHitCz[0],
                        setting2Denominate: kokakukidotai.ratioFirstHitCz[1],
                        setting3Denominate: kokakukidotai.ratioFirstHitCz[2],
                        setting4Denominate: kokakukidotai.ratioFirstHitCz[3],
                        setting5Denominate: kokakukidotai.ratioFirstHitCz[4],
                        setting6Denominate: kokakukidotai.ratioFirstHitCz[5]
                    )
                )
            )
            .tag(1)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kokakukidotai.machineName,
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
    kokakukidotaiView95Ci(
        kokakukidotai: Kokakukidotai(),
    )
}
