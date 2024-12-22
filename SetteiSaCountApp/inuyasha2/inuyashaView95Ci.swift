//
//  inuyashaView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/22.
//

import SwiftUI

struct inuyashaView95Ci: View {
    @ObservedObject var inuyasha = Inuyasha()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // CZ初当り回数
            unitListSection95Ci(
                grafTitle: "CZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $inuyasha.cycleSum,
                        bigNumber: $inuyasha.playGameSum,
                        setting1Denominate: 249,
                        setting2Denominate: 244,
                        setting3Denominate: 240,
                        setting4Denominate: 234,
                        setting5Denominate: 217,
                        setting6Denominate: 210
                    )
                )
            )
            .tag(1)
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $inuyasha.atHitCount,
                        bigNumber: $inuyasha.playGameSum,
                        setting1Denominate: 435,
                        setting2Denominate: 420,
                        setting3Denominate: 402,
                        setting4Denominate: 366,
                        setting5Denominate: 336,
                        setting6Denominate: 313
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
    inuyashaView95Ci()
}
