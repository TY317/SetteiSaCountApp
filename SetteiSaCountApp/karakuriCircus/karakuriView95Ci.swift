//
//  karakuriView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/25.
//

import SwiftUI

struct karakuriView95Ci: View {
    @ObservedObject var karakuri = Karakuri()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // 通常幕間回数
            unitListSection95Ci(
                grafTitle: "通常幕間回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $karakuri.makuaiCount,
                        bigNumber: $karakuri.makuaiPlayGame,
                        setting1Denominate: 3000,
                        setting2Denominate: -100,
                        setting3Enable: false,
                        setting3Denominate: -100,
                        setting4Denominate: -100,
                        setting5Denominate: -100,
                        setting6Denominate: 1000
                    )
                )
            )
            .tag(1)
            // AT開始時のステージ　鳴海スタート回数
            unitListSection95Ci(
                grafTitle: "AT開始時のステージ\n鳴海スタート回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $karakuri.stageCountNarumi,
                        bigNumber: $karakuri.stageCountFirstSum,
                        setting1Percent: 53,
                        setting2Percent: 40,
                        setting3Enable: false,
                        setting3Percent: -100,
                        setting4Percent: 40,
                        setting5Percent: 60,
                        setting6Percent: 50
                    )
                )
            )
            .tag(2)
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
    karakuriView95Ci()
}
