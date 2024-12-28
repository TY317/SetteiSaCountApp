//
//  danvineView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/27.
//

import SwiftUI

struct danvineView95Ci: View {
    @ObservedObject var danvine = Danvine()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // ボーナス初当り回数
            unitListSection95Ci(
                grafTitle: "ボーナス初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $danvine.bonusCount,
                        bigNumber: $danvine.playGameSum,
                        setting1Denominate: 355.8,
                        setting2Denominate: 351.6,
                        setting3Denominate: 342.7,
                        setting4Denominate: 332.9,
                        setting5Denominate: 319.7,
                        setting6Denominate: 307.7
                    )
                )
            )
            .tag(1)
            // ST初当り回数
            unitListSection95Ci(
                grafTitle: "ST初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $danvine.stCount,
                        bigNumber: $danvine.playGameSum,
                        setting1Denominate: 597.7,
                        setting2Denominate: 588.4,
                        setting3Denominate: 572.5,
                        setting4Denominate: 552.5,
                        setting5Denominate: 528.0,
                        setting6Denominate: 505.6
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
    danvineView95Ci()
}
