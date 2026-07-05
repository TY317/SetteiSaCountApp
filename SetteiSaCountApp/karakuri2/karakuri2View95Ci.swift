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
