//
//  funky2Ver2View95CiShima.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/18.
//

import SwiftUI

struct funky2Ver2View95CiShima: View {
    @ObservedObject var funky2: Funky2
    @State var selection = 2
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // BIG回数
            unitListSection95Ci(
                grafTitle: "島データ\n BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $funky2.shimaBigs,
                        bigNumber: $funky2.shimaGames,
                        setting1Denominate: funky2.denominateListBigSum[0],
                        setting2Denominate: funky2.denominateListBigSum[1],
                        setting3Denominate: funky2.denominateListBigSum[2],
                        setting4Denominate: funky2.denominateListBigSum[3],
                        setting5Denominate: funky2.denominateListBigSum[4],
                        setting6Denominate: funky2.denominateListBigSum[5]
                    )
                )
            )
            .tag(2)
            // REG回数
            unitListSection95Ci(
                grafTitle: "島データ\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $funky2.shimaRegs,
                        bigNumber: $funky2.shimaGames,
                        setting1Denominate: funky2.denominateListRegSum[0],
                        setting2Denominate: funky2.denominateListRegSum[1],
                        setting3Denominate: funky2.denominateListRegSum[2],
                        setting4Denominate: funky2.denominateListRegSum[3],
                        setting5Denominate: funky2.denominateListRegSum[4],
                        setting6Denominate: funky2.denominateListRegSum[5]
                    )
                )
            )
            .tag(3)
            // REG回数
            unitListSection95Ci(
                grafTitle: "島データ\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $funky2.shimaBonusSum,
                        bigNumber: $funky2.shimaGames,
                        setting1Denominate: funky2.denominateListBonusSum[0],
                        setting2Denominate: funky2.denominateListBonusSum[1],
                        setting3Denominate: funky2.denominateListBonusSum[2],
                        setting4Denominate: funky2.denominateListBonusSum[3],
                        setting5Denominate: funky2.denominateListBonusSum[4],
                        setting6Denominate: funky2.denominateListBonusSum[5]
                    )
                )
            )
            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: funky2.machineName,
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
    funky2Ver2View95CiShima(
        funky2: Funky2(),
    )
}
