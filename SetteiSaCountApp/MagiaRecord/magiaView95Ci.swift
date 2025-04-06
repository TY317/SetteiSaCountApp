//
//  magiaView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct magiaView95Ci: View {
    @ObservedObject var magia = Magia()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // スイカからのCZ当選回数
            unitListSection95Ci(
                grafTitle: "スイカからのCZ当選回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $magia.suikaCzCountCz,
                        bigNumber: $magia.suikaCzCountSuika,
                        setting1Percent: magia.ratioSuikaCz[0],
                        setting2Percent: magia.ratioSuikaCz[1],
                        setting3Percent: magia.ratioSuikaCz[2],
                        setting4Percent: magia.ratioSuikaCz[3],
                        setting5Percent: magia.ratioSuikaCz[4],
                        setting6Percent: magia.ratioSuikaCz[5]
                    )
                )
            )
            .tag(1)
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
    magiaView95Ci()
}
