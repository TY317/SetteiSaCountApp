//
//  goevaView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/24.
//

import SwiftUI

struct goevaView95Ci: View {
//    @ObservedObject var goeva = Goeva()
    @ObservedObject var goeva: Goeva
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // 通常時のCZ当選率
            unitListSection95Ci(
                grafTitle: "通常時のCZ当選回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $goeva.normalCzCount,
                        bigNumber: $goeva.normalSuikaCount,
                        setting1Percent: 20.3,
                        setting2Percent: 21.1,
                        setting3Enable: false,
                        setting3Percent: -100,
                        setting4Percent: 25.0,
                        setting5Percent: 27.7,
                        setting6Percent: 30.5
                    )
                )
            )
            .tag(1)
            // 通常時の子役変異回数
            unitListSection95Ci(
                grafTitle: "通常時の子役変異回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $goeva.normalHenniKoyakuCount,
                        bigNumber: $goeva.normalHenniCountSum,
                        setting1Percent: 79.7,
                        setting2Percent: -100,
                        setting3Enable: false,
                        setting3Percent: -100,
                        setting4Percent: -100,
                        setting5Percent: -100,
                        setting6Percent: -100
                    )
                )
            )
            .tag(4)
            // AT中のCZ当選回数
            unitListSection95Ci(
                grafTitle: "AT中のCZ当選回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $goeva.atCzCount,
                        bigNumber: $goeva.atSuikaCount,
                        setting1Percent: 30.1,
                        setting2Percent: 30.1,
                        setting3Enable: false,
                        setting3Percent: -100,
                        setting4Percent: 37.5,
                        setting5Percent: 37.5,
                        setting6Percent: 39.1
                    )
                )
            )
            .tag(2)
            // AT中のCZ成功回数
            unitListSection95Ci(
                grafTitle: "AT中のCZ成功回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $goeva.atCzWinCount,
                        bigNumber: $goeva.atCzCount,
                        setting1Percent: 49.3,
                        setting2Percent: 50.4,
                        setting3Enable: false,
                        setting3Percent: -100,
                        setting4Percent: 51.7,
                        setting5Percent: 52.9,
                        setting6Percent: 65.3
                    )
                )
            )
            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ゴジラvsエヴァンゲリオン",
                screenClass: screenClass
            )
        }
        .navigationTitle("95%信頼区間グラフ")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButton95CiExplain(isShow95CiExplain: isShow95CiExplain)
                    .popoverTip(tipUnitButton95CiExplain())
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    goevaView95Ci(goeva: Goeva())
}
