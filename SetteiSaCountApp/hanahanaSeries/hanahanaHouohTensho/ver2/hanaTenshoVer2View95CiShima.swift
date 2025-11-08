//
//  hanaTenshoVer2View95CiShima.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/19.
//

import SwiftUI

struct hanaTenshoVer2View95CiShima: View {
    @ObservedObject var hanaTensho: HanaTensho
    @State var selection = 2
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // BIG回数
            unitListSection95Ci(
                grafTitle: "島データ\n BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hanaTensho.shimaBigs,
                        bigNumber: $hanaTensho.shimaGames,
                        setting1Denominate: hanaTensho.denominateListBig[0],
                        setting2Denominate: hanaTensho.denominateListBig[1],
                        setting3Denominate: hanaTensho.denominateListBig[2],
                        setting4Denominate: hanaTensho.denominateListBig[3],
                        setting5Denominate: hanaTensho.denominateListBig[4],
                        setting6Denominate: hanaTensho.denominateListBig[5]
                    )
                )
            )
            .tag(2)
            // REG回数
            unitListSection95Ci(
                grafTitle: "島データ\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hanaTensho.shimaRegs,
                        bigNumber: $hanaTensho.shimaGames,
                        setting1Denominate: hanaTensho.denominateListReg[0],
                        setting2Denominate: hanaTensho.denominateListReg[1],
                        setting3Denominate: hanaTensho.denominateListReg[2],
                        setting4Denominate: hanaTensho.denominateListReg[3],
                        setting5Denominate: hanaTensho.denominateListReg[4],
                        setting6Denominate: hanaTensho.denominateListReg[5]
                    )
                )
            )
            .tag(3)
            // REG回数
            unitListSection95Ci(
                grafTitle: "島データ\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hanaTensho.shimaBonusSum,
                        bigNumber: $hanaTensho.shimaGames,
                        setting1Denominate: hanaTensho.denominateListBonusSum[0],
                        setting2Denominate: hanaTensho.denominateListBonusSum[1],
                        setting3Denominate: hanaTensho.denominateListBonusSum[2],
                        setting4Denominate: hanaTensho.denominateListBonusSum[3],
                        setting5Denominate: hanaTensho.denominateListBonusSum[4],
                        setting6Denominate: hanaTensho.denominateListBonusSum[5]
                    )
                )
            )
            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hanaTensho.machineName,
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
    hanaTenshoVer2View95CiShima(
        hanaTensho: HanaTensho(),
    )
}
