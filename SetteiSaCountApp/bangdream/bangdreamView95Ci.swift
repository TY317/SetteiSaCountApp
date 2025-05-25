//
//  bangdreamView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/25.
//

import SwiftUI

struct bangdreamView95Ci: View {
//    @ObservedObject var bangdream = Bangdream()
    @ObservedObject var bangdream: Bangdream
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // 周期当選回数
            unitListSection95Ci(
                grafTitle: "周期当選回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $bangdream.cycleHitCountSum,
                        bigNumber: $bangdream.storyCountSum,
                        setting1Enable: false,
                        setting1Percent: -100,
                        setting2Percent: 27.5,
                        setting3Percent: 27.7,
                        setting4Percent: 30.1,
                        setting5Percent: 31.7,
                        setting6Percent: 34.4
                    )
                )
            )
            .tag(1)
            // ピコアタック回数
            unitListSection95Ci(
                grafTitle: "ピコアタック回数\n（トータル回数）",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $bangdream.picoAttackCountWinSum,
                        bigNumber: $bangdream.picoAttackCountAllSum,
                        setting1Enable: false,
                        setting1Percent: -100,
                        setting2Percent: 7.7,
                        setting3Percent: 8.1,
                        setting4Percent: 13.0,
                        setting5Percent: 14.6,
                        setting6Percent: 14.9
                    )
                )
            )
            .tag(2)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "バンドリ!",
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
    bangdreamView95Ci(bangdream: Bangdream())
}
