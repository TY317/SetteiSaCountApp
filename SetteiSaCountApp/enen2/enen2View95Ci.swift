//
//  enen2View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/11.
//

import SwiftUI

struct enen2View95Ci: View {
    @ObservedObject var enen2: Enen2
    @State var selection = 1
    @State var isShow95CiExplain = false
    var body: some View {
        TabView(selection: self.$selection) {
            // CZ初当り回数
//            unitListSection95Ci(
//                grafTitle: "CZ初当り回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $enen2.firstHitCountCz,
//                        bigNumber: $enen2.normalGame,
//                        setting1Denominate: enen2.ratioFirstHitCz[0],
//                        setting2Denominate: enen2.ratioFirstHitCz[1],
//                        setting3Denominate: enen2.ratioFirstHitCz[2],
//                        setting4Denominate: enen2.ratioFirstHitCz[3],
//                        setting5Denominate: enen2.ratioFirstHitCz[4],
//                        setting6Denominate: enen2.ratioFirstHitCz[5]
//                    )
//                )
//            )
//            .tag(1)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: enen2.machineName,
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
    enen2View95Ci(
        enen2: Enen2(),
    )
}
