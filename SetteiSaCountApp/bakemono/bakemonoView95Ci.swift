//
//  bakemonoView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/30.
//

import SwiftUI

struct bakemonoView95Ci: View {
    @ObservedObject var bakemono: Bakemono
    @State var selection = 1
    @State var isShow95CiExplain = false
    var body: some View {
        TabView(selection: self.$selection) {
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "🍉回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $bakemono.koyakuCountSuika,
                        bigNumber: $bakemono.totalGame,
                        setting1Denominate: bakemono.ratioSuika[0],
                        setting2Denominate: bakemono.ratioSuika[1],
                        setting3Denominate: bakemono.ratioSuika[2],
                        setting4Denominate: bakemono.ratioSuika[3],
                        setting5Denominate: bakemono.ratioSuika[4],
                        setting6Denominate: bakemono.ratioSuika[5]
                    )
                )
            )
            .tag(2)
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $bakemono.firstHitCountAt,
                        bigNumber: $bakemono.normalGame,
                        setting1Denominate: bakemono.ratioAtFirstHit[0],
                        setting2Denominate: bakemono.ratioAtFirstHit[1],
                        setting3Denominate: bakemono.ratioAtFirstHit[2],
                        setting4Denominate: bakemono.ratioAtFirstHit[3],
                        setting5Denominate: bakemono.ratioAtFirstHit[4],
                        setting6Denominate: bakemono.ratioAtFirstHit[5]
                    )
                )
            )
            .tag(1)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: bakemono.machineName,
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
    bakemonoView95Ci(
        bakemono: Bakemono(),
    )
}
