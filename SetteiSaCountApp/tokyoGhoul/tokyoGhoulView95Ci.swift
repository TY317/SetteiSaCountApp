//
//  tokyoGhoulView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/22.
//

import SwiftUI

struct tokyoGhoulView95Ci: View {
//    @ObservedObject var tokyoGhoul = TokyoGhoul()
    @ObservedObject var tokyoGhoul: TokyoGhoul
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // レミニセンス回数
            unitListSection95Ci(
                grafTitle: "CZ \(tokyoGhoul.selectListCzKind[0]) 回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $tokyoGhoul.czCountRemini,
                        bigNumber: $tokyoGhoul.playGameSum,
                        setting1Denominate: 300.5,
                        setting2Denominate: 295.1,
                        setting3Denominate: 287.6,
                        setting4Denominate: 276.7,
                        setting5Denominate: 262.7,
                        setting6Denominate: 251.2
                    )
                )
            )
            .tag(3)
            // 利世回数
            unitListSection95Ci(
                grafTitle: "CZ \(tokyoGhoul.selectListCzKind[1]) 回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $tokyoGhoul.czCountRise,
                        bigNumber: $tokyoGhoul.playGameSum,
                        setting1Denominate: 2079.1,
                        setting2Denominate: 1906.5,
                        setting3Denominate: 1722.8,
                        setting4Denominate: 1478.9,
                        setting5Denominate: 1226.6,
                        setting6Denominate: 1074.9
                    )
                )
            )
            .tag(4)
            // CZ回数
            unitListSection95Ci(
                grafTitle: "CZ合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $tokyoGhoul.czCountSum,
                        bigNumber: $tokyoGhoul.playGameSum,
                        setting1Denominate: 262.6,
                        setting2Denominate: 255.6,
                        setting3Denominate: 246.5,
                        setting4Denominate: 233.1,
                        setting5Denominate: 216.4,
                        setting6Denominate: 203.7
                    )
                )
            )
            .tag(1)
            // エピソード回数
            unitListSection95Ci(
                grafTitle: "\(tokyoGhoul.selectListCzKind[2])回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $tokyoGhoul.czCountEpisode,
                        bigNumber: $tokyoGhoul.playGameSum,
                        setting1Denominate: 6620.2,
                        setting2Denominate: 5879.7,
                        setting3Denominate: 5114.5,
                        setting4Denominate: 4062.5,
                        setting5Denominate: 3166.7,
                        setting6Denominate: 2639.5
                    )
                )
            )
            .tag(5)
            // AT回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $tokyoGhoul.atCount,
                        bigNumber: $tokyoGhoul.playGameSum,
                        setting1Denominate: 394.4,
                        setting2Denominate: 380.5,
                        setting3Denominate: 357.0,
                        setting4Denominate: 325.9,
                        setting5Denominate: 291.2,
                        setting6Denominate: 261.3
                    )
                )
            )
            .tag(2)
            // 100G以内当選回数
            unitListSection95Ci(
                grafTitle: "100G以内当選回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $tokyoGhoul.under100CountHit,
                        bigNumber: $tokyoGhoul.firstHitCountSum,
                        setting1Percent: 19.58,
                        setting2Percent: 21.04,
                        setting3Percent: 23.15,
                        setting4Percent: 26.37,
                        setting5Percent: 31.96,
                        setting6Percent: 36.01
                    )
                )
            )
            .tag(6)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "東京喰種",
                screenClass: screenClass
            )
        }
        .navigationTitle("95%信頼区間グラフ")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButton95CiExplain(isShow95CiExplain: isShow95CiExplain)
//                    .popoverTip(tipUnitButton95CiExplain())
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    tokyoGhoulView95Ci(tokyoGhoul: TokyoGhoul())
}
