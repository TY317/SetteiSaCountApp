//
//  rezero2View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/25.
//

import SwiftUI

struct rezero2View95Ci: View {
//    @ObservedObject var rezero2 = Rezero2()
    @ObservedObject var rezero2: Rezero2
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $rezero2.atHitCount,
                        bigNumber: $rezero2.playGameSum,
                        setting1Denominate: 417.2,
                        setting2Denominate: 408.5,
                        setting3Denominate: 387.1,
                        setting4Denominate: 354.3,
                        setting5Denominate: 332.9,
                        setting6Denominate: 305.4
                    )
                )
            )
            .tag(1)
            // 内部規定Pt抽選　百の位 偶数当選回数
            unitListSection95Ci(
                grafTitle: "内部規定Pt抽選\n百の位 偶数当選回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $rezero2.ptDrawGusuWinCount,
                        bigNumber: $rezero2.ptDrawGusuCount,
                        setting1Percent: 25.0,
                        setting2Percent: 25.4,
                        setting3Percent: 25.8,
                        setting4Percent: 28.5,
                        setting5Percent: 29.7,
                        setting6Percent: 31.3
                    )
                )
            )
            .tag(3)
            // 内部規定Pt抽選　百の位 奇数当選回数
            unitListSection95Ci(
                grafTitle: "内部規定Pt抽選\n百の位 奇数当選回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $rezero2.ptDrawKisuWinCount,
                        bigNumber: $rezero2.ptDrawKisuCount,
                        setting1Percent: 1.2,
                        setting2Percent: 1.6,
                        setting3Percent: 2.0,
                        setting4Percent: 2.3,
                        setting5Percent: 2.7,
                        setting6Percent: 3.1
                    )
                )
            )
            .tag(4)
            // 引き戻し回数
            unitListSection95Ci(
                grafTitle: "引き戻し回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $rezero2.comebackCount,
                        bigNumber: $rezero2.atHitCount,
                        setting1Percent: 10.2,
                        setting2Percent: 10.4,
                        setting3Percent: 13.9,
                        setting4Percent: 16.0,
                        setting5Percent: 18.0,
                        setting6Percent: 20.0
                    )
                )
            )
            .tag(2)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "Re:ゼロ season2",
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
    rezero2View95Ci(rezero2: Rezero2())
}
