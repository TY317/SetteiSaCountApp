//
//  mhrView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/28.
//

import SwiftUI

struct mhrView95Ci: View {
//    @ObservedObject var mhr = Mhr()
    @ObservedObject var mhr: Mhr
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $mhr.atHitCount,
                        bigNumber: $mhr.playGameSum,
                        setting1Denominate: 309.5,
                        setting2Denominate: 301.4,
                        setting3Denominate: 290.8,
                        setting4Denominate: 256.4,
                        setting5Denominate: 237.1,
                        setting6Denominate: 230.8
                    )
                )
            )
            .tag(1)
            // ライズゾーン初当り回数
            unitListSection95Ci(
                grafTitle: "ライズゾーン初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $mhr.riseZoneCount,
                        bigNumber: $mhr.playGameSum,
                        setting1Denominate: 75.6,
                        setting2Denominate: 75.2,
                        setting3Denominate: 72.9,
                        setting4Denominate: 71.8,
                        setting5Denominate: 68.9,
                        setting6Denominate: 68.2
                    )
                )
            )
            .tag(2)
            // アイルーだるま落とし80回以下回数
            unitListSection95Ci(
                grafTitle: "アイルーだるま落とし\n80回以下回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercentNotBinding(
                        currentCount: mhr.airuCountUnder80,
                        bigNumber: mhr.airuCountSum,
                        setting1Percent: 25.0,
                        setting2Percent: 26.6,
                        setting3Percent: 31.2,
                        setting4Percent: 39.0,
                        setting5Percent: 43.8,
                        setting6Percent: 45.4
                    )
                )
            )
            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "モンスターハンター ライズ",
                screenClass: screenClass
            )
        }
        .navigationTitle("95%信頼区間グラフ")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButton95CiExplain(isShow95CiExplain: isShow95CiExplain)
//                    .popoverTip(tipUnitButton95CiExplain())
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    mhrView95Ci(mhr: Mhr())
}
