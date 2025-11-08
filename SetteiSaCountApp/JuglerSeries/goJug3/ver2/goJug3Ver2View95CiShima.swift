//
//  goJug3Ver2View95CiShima.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/18.
//

import SwiftUI

struct goJug3Ver2View95CiShima: View {
    @ObservedObject var goJug3: GoJug3
    @State var selection = 2
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // BIG回数
            unitListSection95Ci(
                grafTitle: "島データ\n BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $goJug3.shimaBigs,
                        bigNumber: $goJug3.shimaGames,
                        setting1Denominate: goJug3.denominateListBigSum[0],
                        setting2Denominate: goJug3.denominateListBigSum[1],
                        setting3Denominate: goJug3.denominateListBigSum[2],
                        setting4Denominate: goJug3.denominateListBigSum[3],
                        setting5Denominate: goJug3.denominateListBigSum[4],
                        setting6Denominate: goJug3.denominateListBigSum[5]
                    )
                )
            )
            .tag(2)
            // REG回数
            unitListSection95Ci(
                grafTitle: "島データ\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $goJug3.shimaRegs,
                        bigNumber: $goJug3.shimaGames,
                        setting1Denominate: goJug3.denominateListRegSum[0],
                        setting2Denominate: goJug3.denominateListRegSum[1],
                        setting3Denominate: goJug3.denominateListRegSum[2],
                        setting4Denominate: goJug3.denominateListRegSum[3],
                        setting5Denominate: goJug3.denominateListRegSum[4],
                        setting6Denominate: goJug3.denominateListRegSum[5]
                    )
                )
            )
            .tag(3)
            // REG回数
            unitListSection95Ci(
                grafTitle: "島データ\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $goJug3.shimaBonusSum,
                        bigNumber: $goJug3.shimaGames,
                        setting1Denominate: goJug3.denominateListBonusSum[0],
                        setting2Denominate: goJug3.denominateListBonusSum[1],
                        setting3Denominate: goJug3.denominateListBonusSum[2],
                        setting4Denominate: goJug3.denominateListBonusSum[3],
                        setting5Denominate: goJug3.denominateListBonusSum[4],
                        setting6Denominate: goJug3.denominateListBonusSum[5]
                    )
                )
            )
            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: goJug3.machineName,
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
    goJug3Ver2View95CiShima(
        goJug3: GoJug3(),
    )
}
