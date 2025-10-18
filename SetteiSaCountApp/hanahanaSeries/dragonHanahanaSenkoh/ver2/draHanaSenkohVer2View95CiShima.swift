//
//  draHanaSenkohVer2View95CiShima.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/19.
//

import SwiftUI

struct draHanaSenkohVer2View95CiShima: View {
    @ObservedObject var draHanaSenkoh: DraHanaSenkoh
    @State var selection = 2
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // BIG回数
            unitListSection95Ci(
                grafTitle: "島データ\n BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $draHanaSenkoh.shimaBigs,
                        bigNumber: $draHanaSenkoh.shimaGames,
                        setting1Denominate: draHanaSenkoh.denominateListBig[0],
                        setting2Denominate: draHanaSenkoh.denominateListBig[1],
                        setting3Denominate: draHanaSenkoh.denominateListBig[2],
                        setting4Denominate: draHanaSenkoh.denominateListBig[3],
                        setting5Denominate: draHanaSenkoh.denominateListBig[4],
                        setting6Denominate: draHanaSenkoh.denominateListBig[5]
                    )
                )
            )
            .tag(2)
            // REG回数
            unitListSection95Ci(
                grafTitle: "島データ\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $draHanaSenkoh.shimaRegs,
                        bigNumber: $draHanaSenkoh.shimaGames,
                        setting1Denominate: draHanaSenkoh.denominateListReg[0],
                        setting2Denominate: draHanaSenkoh.denominateListReg[1],
                        setting3Denominate: draHanaSenkoh.denominateListReg[2],
                        setting4Denominate: draHanaSenkoh.denominateListReg[3],
                        setting5Denominate: draHanaSenkoh.denominateListReg[4],
                        setting6Denominate: draHanaSenkoh.denominateListReg[5]
                    )
                )
            )
            .tag(3)
            // REG回数
            unitListSection95Ci(
                grafTitle: "島データ\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $draHanaSenkoh.shimaBonusSum,
                        bigNumber: $draHanaSenkoh.shimaGames,
                        setting1Denominate: draHanaSenkoh.denominateListBonusSum[0],
                        setting2Denominate: draHanaSenkoh.denominateListBonusSum[1],
                        setting3Denominate: draHanaSenkoh.denominateListBonusSum[2],
                        setting4Denominate: draHanaSenkoh.denominateListBonusSum[3],
                        setting5Denominate: draHanaSenkoh.denominateListBonusSum[4],
                        setting6Denominate: draHanaSenkoh.denominateListBonusSum[5]
                    )
                )
            )
            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: draHanaSenkoh.machineName,
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
    draHanaSenkohVer2View95CiShima(
        draHanaSenkoh: DraHanaSenkoh(),
    )
}
