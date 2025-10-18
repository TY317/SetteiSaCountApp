//
//  mrJugVer2View95CiShima.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/18.
//

import SwiftUI

struct mrJugVer2View95CiShima: View {
    @ObservedObject var mrJug: MrJug
    @State var selection = 2
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // BIG回数
            unitListSection95Ci(
                grafTitle: "島データ\n BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $mrJug.shimaBigs,
                        bigNumber: $mrJug.shimaGames,
                        setting1Denominate: mrJug.denominateListBigSum[0],
                        setting2Denominate: mrJug.denominateListBigSum[1],
                        setting3Denominate: mrJug.denominateListBigSum[2],
                        setting4Denominate: mrJug.denominateListBigSum[3],
                        setting5Denominate: mrJug.denominateListBigSum[4],
                        setting6Denominate: mrJug.denominateListBigSum[5]
                    )
                )
            )
            .tag(2)
            // REG回数
            unitListSection95Ci(
                grafTitle: "島データ\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $mrJug.shimaRegs,
                        bigNumber: $mrJug.shimaGames,
                        setting1Denominate: mrJug.denominateListRegSum[0],
                        setting2Denominate: mrJug.denominateListRegSum[1],
                        setting3Denominate: mrJug.denominateListRegSum[2],
                        setting4Denominate: mrJug.denominateListRegSum[3],
                        setting5Denominate: mrJug.denominateListRegSum[4],
                        setting6Denominate: mrJug.denominateListRegSum[5]
                    )
                )
            )
            .tag(3)
            // REG回数
            unitListSection95Ci(
                grafTitle: "島データ\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $mrJug.shimaBonusSum,
                        bigNumber: $mrJug.shimaGames,
                        setting1Denominate: mrJug.denominateListBonusSum[0],
                        setting2Denominate: mrJug.denominateListBonusSum[1],
                        setting3Denominate: mrJug.denominateListBonusSum[2],
                        setting4Denominate: mrJug.denominateListBonusSum[3],
                        setting5Denominate: mrJug.denominateListBonusSum[4],
                        setting6Denominate: mrJug.denominateListBonusSum[5]
                    )
                )
            )
            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: mrJug.machineName,
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
    mrJugVer2View95CiShima(
        mrJug: MrJug(),
    )
}
