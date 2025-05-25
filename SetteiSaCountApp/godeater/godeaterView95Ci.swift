//
//  godeaterView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/24.
//

import SwiftUI

struct godeaterView95Ci: View {
    //    @ObservedObject var godeater = Godeater()
    @ObservedObject var godeater: Godeater
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // CZ当選率 チャンス目
            unitListSection95Ci(
                grafTitle: "CZ当選回数\nチャンス目",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $godeater.normalChanceCountCzHit,
                        bigNumber: $godeater.normalChanceCountSeiritu,
                        setting1Percent: godeater.ratioChanceCzHit[0],
                        setting2Percent: godeater.ratioChanceCzHit[1],
                        setting3Percent: godeater.ratioChanceCzHit[2],
                        setting4Percent: godeater.ratioChanceCzHit[3],
                        setting5Percent: godeater.ratioChanceCzHit[4],
                        setting6Percent: godeater.ratioChanceCzHit[5]
                    )
                )
            )
            .tag(3)
            // CZ当選率 弱チェリー＆スイカ
            unitListSection95Ci(
                grafTitle: "CZ当選回数\n弱チェリー＆スイカ",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $godeater.normalCountCzHit,
                        bigNumber: $godeater.normalCountCherrySuikaSum,
                        setting1Percent: godeater.ratioCherrySuikaCzHit[0],
                        setting2Percent: godeater.ratioCherrySuikaCzHit[1],
                        setting3Percent: godeater.ratioCherrySuikaCzHit[2],
                        setting4Percent: godeater.ratioCherrySuikaCzHit[3],
                        setting5Percent: godeater.ratioCherrySuikaCzHit[4],
                        setting6Percent: godeater.ratioCherrySuikaCzHit[5]
                    )
                )
            )
            .tag(4)
            // AT初当たり回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $godeater.atHitCount,
                        bigNumber: $godeater.playGame,
                        setting1Denominate: 351.9,
                        setting2Denominate: 344.5,
                        setting3Denominate: 330.1,
                        setting4Denominate: 317.0,
                        setting5Denominate: 302.2,
                        setting6Denominate: 290.3
                    )
                )
            )
            .tag(1)
            // CZ初当り回数
            unitListSection95Ci(
                grafTitle: "CZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $godeater.czHitCount,
                        bigNumber: $godeater.playGame,
                        setting1Denominate: 392.0,
                        setting2Denominate: 378.3,
                        setting3Denominate: 359.1,
                        setting4Denominate: 343.4,
                        setting5Denominate: 324.3,
                        setting6Denominate: 310.6
                    )
                )
            )
            .tag(2)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ゴッドイーター リザレクション",
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
    godeaterView95Ci(godeater: Godeater())
}
