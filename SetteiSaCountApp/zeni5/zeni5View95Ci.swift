//
//  zeni5View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/14.
//

import SwiftUI

struct zeni5View95Ci: View {
    @ObservedObject var zeni5: Zeni5
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // 初当り回数
            unitListSection95Ci(
                grafTitle: "初当りボーナス回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $zeni5.firstHitCount,
                        bigNumber: $zeni5.normalGame,
                        setting1Enable: false,
                        setting1Denominate: -1,
                        setting2Denominate: zeni5.ratioFirstHit[0],
                        setting3Denominate: zeni5.ratioFirstHit[1],
                        setting4Denominate: zeni5.ratioFirstHit[2],
                        setting5Denominate: zeni5.ratioFirstHit[3],
                        setting6Denominate: zeni5.ratioFirstHit[4]
                    )
                )
            )
            .tag(1)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: zeni5.machineName,
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
    zeni5View95Ci(
        zeni5: Zeni5(),
    )
}
