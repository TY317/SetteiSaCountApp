//
//  guiltyCrown2View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/05.
//

import SwiftUI

struct guiltyCrown2View95Ci: View {
    @ObservedObject var guiltyCrown2: GuiltyCrown2
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // 弱スイカ当選回数
            unitListSection95Ci(
                grafTitle: "弱🍉での当選回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $guiltyCrown2.suikaBonusCountJakuBonus,
                        bigNumber: $guiltyCrown2.suikaBonusCountJaku,
                        setting1Percent: guiltyCrown2.ratioSuikaBonusJaku[0],
                        setting2Percent: guiltyCrown2.ratioSuikaBonusJaku[1],
                        setting3Percent: guiltyCrown2.ratioSuikaBonusJaku[2],
                        setting4Percent: guiltyCrown2.ratioSuikaBonusJaku[3],
                        setting5Percent: guiltyCrown2.ratioSuikaBonusJaku[4],
                        setting6Percent: guiltyCrown2.ratioSuikaBonusJaku[5]
                    )
                )
            )
            .tag(1)
            // 強スイカ当選回数
            unitListSection95Ci(
                grafTitle: "強🍉での当選回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $guiltyCrown2.suikaBonusCountKyoBonus,
                        bigNumber: $guiltyCrown2.suikaBonusCountKyo,
                        setting1Percent: guiltyCrown2.ratioSuikaBonusKyo[0],
                        setting2Percent: guiltyCrown2.ratioSuikaBonusKyo[1],
                        setting3Percent: guiltyCrown2.ratioSuikaBonusKyo[2],
                        setting4Percent: guiltyCrown2.ratioSuikaBonusKyo[3],
                        setting5Percent: guiltyCrown2.ratioSuikaBonusKyo[4],
                        setting6Percent: guiltyCrown2.ratioSuikaBonusKyo[5]
                    )
                )
            )
            .tag(2)
            // スイカ契機ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "🍉契機 設定差のあるボーナス合算回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $guiltyCrown2.bonusDetailCountSum,
                        bigNumber: $guiltyCrown2.normalGame,
                        setting1Denominate: guiltyCrown2.ratioDetailSum[0],
                        setting2Denominate: guiltyCrown2.ratioDetailSum[1],
                        setting3Denominate: guiltyCrown2.ratioDetailSum[2],
                        setting4Denominate: guiltyCrown2.ratioDetailSum[3],
                        setting5Denominate: guiltyCrown2.ratioDetailSum[4],
                        setting6Denominate: guiltyCrown2.ratioDetailSum[5]
                    )
                )
            )
            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: guiltyCrown2.machineName,
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
    guiltyCrown2View95Ci(
        guiltyCrown2: GuiltyCrown2()
    )
}
