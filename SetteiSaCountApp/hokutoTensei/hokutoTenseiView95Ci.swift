//
//  hokutoTenseiView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/26.
//

import SwiftUI

struct hokutoTenseiView95Ci: View {
    @ObservedObject var hokutoTensei: HokutoTensei
    @State var selection = 1
    @State var isShow95CiExplain = false
    var body: some View {
        TabView(selection: self.$selection) {
            // 初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hokutoTensei.firstHitCount,
                        bigNumber: $hokutoTensei.normalGame,
                        setting1Denominate: hokutoTensei.ratioAtFirstHit[0],
                        setting2Denominate: hokutoTensei.ratioAtFirstHit[1],
                        setting3Denominate: hokutoTensei.ratioAtFirstHit[2],
                        setting4Denominate: hokutoTensei.ratioAtFirstHit[3],
                        setting5Denominate: hokutoTensei.ratioAtFirstHit[4],
                        setting6Denominate: hokutoTensei.ratioAtFirstHit[5]
                    )
                )
            )
            .tag(1)
            
            
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hokutoTensei.machineName,
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
    hokutoTenseiView95Ci(
        hokutoTensei: HokutoTensei(),
    )
}
