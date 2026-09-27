//
//  ricoricoView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ricoricoView95Ci: View {
    @ObservedObject var ricorico: Ricorico
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // CZ初当り回数
            unitListSection95Ci(
                grafTitle: "CZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $ricorico.firstHitCountCz,
                        bigNumber: $ricorico.normalGame,
                        setting1Denominate: ricorico.ratioFirstHitCz[0],
                        setting2Denominate: ricorico.ratioFirstHitCz[1],
                        setting3Denominate: ricorico.ratioFirstHitCz[2],
                        setting4Denominate: ricorico.ratioFirstHitCz[3],
                        setting5Denominate: ricorico.ratioFirstHitCz[4],
                        setting6Denominate: ricorico.ratioFirstHitCz[5]
                    )
                )
            )
            .tag(2)

            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $ricorico.firstHitCountAt,
                        bigNumber: $ricorico.normalGame,
                        setting1Denominate: ricorico.ratioFirstHitAt[0],
                        setting2Denominate: ricorico.ratioFirstHitAt[1],
                        setting3Denominate: ricorico.ratioFirstHitAt[2],
                        setting4Denominate: ricorico.ratioFirstHitAt[3],
                        setting5Denominate: ricorico.ratioFirstHitAt[4],
                        setting6Denominate: ricorico.ratioFirstHitAt[5]
                    )
                )
            )
            .tag(3)

            // 共通ベル
            unitListSection95Ci(
                grafTitle: "共通ベル",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $ricorico.commonBellCount,
                        bigNumber: $ricorico.gameNumberPlay,
                        setting1Denominate: ricorico.ratioCommonBell[0],
                        setting2Denominate: ricorico.ratioCommonBell[1],
                        setting3Denominate: ricorico.ratioCommonBell[2],
                        setting4Denominate: ricorico.ratioCommonBell[3],
                        setting5Denominate: ricorico.ratioCommonBell[4],
                        setting6Denominate: ricorico.ratioCommonBell[5]
                    )
                )
            )
            .tag(4)

            // 150G 変換高確移行
            unitListSection95Ci(
                grafTitle: "150G 変換高確移行",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $ricorico.henkan150GCountHit,
                        bigNumber: $ricorico.henkan150GCountSum,
                        setting1Percent: ricorico.ratioHenkan150G[0],
                        setting2Percent: ricorico.ratioHenkan150G[1],
                        setting3Percent: ricorico.ratioHenkan150G[2],
                        setting4Percent: ricorico.ratioHenkan150G[3],
                        setting5Percent: ricorico.ratioHenkan150G[4],
                        setting6Percent: ricorico.ratioHenkan150G[5]
                    )
                )
            )
            .tag(5)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ricorico.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("95%信頼区間グラフ")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButton95CiExplain(isShow95CiExplain: isShow95CiExplain)
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    ricoricoView95Ci(
        ricorico: Ricorico(),
    )
}
