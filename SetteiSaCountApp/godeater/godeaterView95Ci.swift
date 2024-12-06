//
//  godeaterView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/24.
//

import SwiftUI

struct godeaterView95Ci: View {
    @ObservedObject var godeater = Godeater()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
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
    godeaterView95Ci()
}
