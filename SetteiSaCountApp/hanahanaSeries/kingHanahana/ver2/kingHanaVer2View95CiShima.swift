//
//  kingHanaVer2View95CiShima.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/19.
//

import SwiftUI

struct kingHanaVer2View95CiShima: View {
    @ObservedObject var kingHana: KingHana
    @State var selection = 2
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // BIG回数
            unitListSection95Ci(
                grafTitle: "島データ\n BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kingHana.shimaBigs,
                        bigNumber: $kingHana.shimaGames,
                        setting1Denominate: kingHana.denominateListBig[0],
                        setting2Denominate: kingHana.denominateListBig[1],
                        setting3Denominate: kingHana.denominateListBig[2],
                        setting4Denominate: kingHana.denominateListBig[3],
                        setting5Denominate: kingHana.denominateListBig[4],
                        setting6Denominate: kingHana.denominateListBig[5]
                    )
                )
            )
            .tag(2)
            // REG回数
            unitListSection95Ci(
                grafTitle: "島データ\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kingHana.shimaRegs,
                        bigNumber: $kingHana.shimaGames,
                        setting1Denominate: kingHana.denominateListReg[0],
                        setting2Denominate: kingHana.denominateListReg[1],
                        setting3Denominate: kingHana.denominateListReg[2],
                        setting4Denominate: kingHana.denominateListReg[3],
                        setting5Denominate: kingHana.denominateListReg[4],
                        setting6Denominate: kingHana.denominateListReg[5]
                    )
                )
            )
            .tag(3)
            // REG回数
            unitListSection95Ci(
                grafTitle: "島データ\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kingHana.shimaBonusSum,
                        bigNumber: $kingHana.shimaGames,
                        setting1Denominate: kingHana.denominateListBonusSum[0],
                        setting2Denominate: kingHana.denominateListBonusSum[1],
                        setting3Denominate: kingHana.denominateListBonusSum[2],
                        setting4Denominate: kingHana.denominateListBonusSum[3],
                        setting5Denominate: kingHana.denominateListBonusSum[4],
                        setting6Denominate: kingHana.denominateListBonusSum[5]
                    )
                )
            )
            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kingHana.machineName,
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
    kingHanaVer2View95CiShima(
        kingHana: KingHana(),
    )
}
