//
//  lupinView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/12.
//

import SwiftUI

struct lupinView95Ci: View {
    @ObservedObject var lupin = Lupin()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // ボーナス初当り回数
            unitListSection95Ci(
                grafTitle: "ボーナス初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $lupin.bonusCount,
                        bigNumber: $lupin.playGameSum,
                        setting1Denominate: 289.1,
                        setting2Denominate: 275.6,
                        setting3Denominate: 262.6,
                        setting4Denominate: 233.9,
                        setting5Denominate: 223.6,
                        setting6Denominate: 216.3
                    )
                )
            )
            .tag(1)
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $lupin.atCount,
                        bigNumber: $lupin.playGameSum,
                        setting1Denominate: 371.4,
                        setting2Denominate: 353.8,
                        setting3Denominate: 330.2,
                        setting4Denominate: 300.3,
                        setting5Denominate: 289.9,
                        setting6Denominate: 274.9
                    )
                )
            )
            .tag(2)
            // CZ確率
            unitListSection95Ci(
                grafTitle: "CZ回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $lupin.czCountAll,
                        bigNumber: $lupin.playGameSum,
                        setting1Denominate: 211.5,
                        setting2Denominate: 210.0,
                        setting3Denominate: 204.9,
                        setting4Denominate: 199.7,
                        setting5Denominate: 199.0,
                        setting6Denominate: 198.0
                    )
                )
            )
            .tag(3)
            // CZ成功回数
            unitListSection95Ci(
                grafTitle: "CZ成功回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $lupin.czCountHit,
                        bigNumber: $lupin.czCountAll,
                        setting1Percent: 43.4,
                        setting2Percent: 44.6,
                        setting3Percent: 46.1,
                        setting4Percent: 48.9,
                        setting5Percent: 51.5,
                        setting6Percent: 51.8
                    )
                )
            )
            .tag(4)
            // 強チェリー直撃回数
            unitListSection95Ci(
                grafTitle: "強🍒直撃回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $lupin.cherryCountHit,
                        bigNumber: $lupin.cherryCountAll,
                        setting1Percent: 25.0,
                        setting2Percent: 25.0,
                        setting3Percent: 25.0,
                        setting4Percent: 30.1,
                        setting5Percent: 30.1,
                        setting6Percent: 30.1
                    )
                )
            )
            .tag(5)
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
    lupinView95Ci()
}
