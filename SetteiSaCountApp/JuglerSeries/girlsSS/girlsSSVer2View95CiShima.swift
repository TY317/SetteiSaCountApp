//
//  girlsSSVer2View95CiShima.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/18.
//

import SwiftUI

struct girlsSSVer2View95CiShima: View {
    @ObservedObject var girlsSS: GirlsSS
    @State var selection = 2
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // BIG回数
            unitListSection95Ci(
                grafTitle: "島データ\n BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $girlsSS.shimaBigs,
                        bigNumber: $girlsSS.shimaGames,
                        setting1Denominate: girlsSS.denominateListBigSum[0],
                        setting2Denominate: girlsSS.denominateListBigSum[1],
                        setting3Denominate: girlsSS.denominateListBigSum[2],
                        setting4Denominate: girlsSS.denominateListBigSum[3],
                        setting5Denominate: girlsSS.denominateListBigSum[4],
                        setting6Denominate: girlsSS.denominateListBigSum[5]
                    )
                )
            )
            .tag(2)
            // REG回数
            unitListSection95Ci(
                grafTitle: "島データ\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $girlsSS.shimaRegs,
                        bigNumber: $girlsSS.shimaGames,
                        setting1Denominate: girlsSS.denominateListRegSum[0],
                        setting2Denominate: girlsSS.denominateListRegSum[1],
                        setting3Denominate: girlsSS.denominateListRegSum[2],
                        setting4Denominate: girlsSS.denominateListRegSum[3],
                        setting5Denominate: girlsSS.denominateListRegSum[4],
                        setting6Denominate: girlsSS.denominateListRegSum[5]
                    )
                )
            )
            .tag(3)
            // REG回数
            unitListSection95Ci(
                grafTitle: "島データ\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $girlsSS.shimaBonusSum,
                        bigNumber: $girlsSS.shimaGames,
                        setting1Denominate: girlsSS.denominateListBonusSum[0],
                        setting2Denominate: girlsSS.denominateListBonusSum[1],
                        setting3Denominate: girlsSS.denominateListBonusSum[2],
                        setting4Denominate: girlsSS.denominateListBonusSum[3],
                        setting5Denominate: girlsSS.denominateListBonusSum[4],
                        setting6Denominate: girlsSS.denominateListBonusSum[5]
                    )
                )
            )
            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: girlsSS.machineName,
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
    girlsSSVer2View95CiShima(
        girlsSS: GirlsSS(),
    )
}
