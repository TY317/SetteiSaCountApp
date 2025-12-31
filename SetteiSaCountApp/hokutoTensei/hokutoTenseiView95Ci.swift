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
                        currentCount: $hokutoTensei.firstHitCountAt,
                        bigNumber: $hokutoTensei.normalGame,
                        setting1Denominate: hokutoTensei.ratioAtFirstHitAt[0],
                        setting2Denominate: hokutoTensei.ratioAtFirstHitAt[1],
                        setting3Denominate: hokutoTensei.ratioAtFirstHitAt[2],
                        setting4Denominate: hokutoTensei.ratioAtFirstHitAt[3],
                        setting5Denominate: hokutoTensei.ratioAtFirstHitAt[4],
                        setting6Denominate: hokutoTensei.ratioAtFirstHitAt[5]
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
