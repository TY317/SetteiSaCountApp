//
//  imJugExVer2View95CiShima.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/18.
//

import SwiftUI

struct imJugExVer2View95CiShima: View {
    @ObservedObject var imJugEx: ImJugEx
    @State var selection = 2
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // BIG回数
            unitListSection95Ci(
                grafTitle: "島データ\n BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $imJugEx.shimaBigs,
                        bigNumber: $imJugEx.shimaGames,
                        setting1Denominate: 273.0,
                        setting2Denominate: 270.0,
                        setting3Denominate: 270.0,
                        setting4Denominate: 259.0,
                        setting5Denominate: 259.0,
                        setting6Denominate: 255.0
                    )
                )
            )
            .tag(2)
            // REG回数
            unitListSection95Ci(
                grafTitle: "島データ\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $imJugEx.shimaRegs,
                        bigNumber: $imJugEx.shimaGames,
                        setting1Denominate: 440,
                        setting2Denominate: 400,
                        setting3Denominate: 331,
                        setting4Denominate: 315,
                        setting5Denominate: 255,
                        setting6Denominate: 255
                    )
                )
            )
            .tag(3)
            // REG回数
            unitListSection95Ci(
                grafTitle: "島データ\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $imJugEx.shimaBonusSum,
                        bigNumber: $imJugEx.shimaGames,
                        setting1Denominate: 169,
                        setting2Denominate: 161,
                        setting3Denominate: 149,
                        setting4Denominate: 142,
                        setting5Denominate: 129,
                        setting6Denominate: 128
                    )
                )
            )
            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: imJugEx.machineName,
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
    imJugExVer2View95CiShima(
        imJugEx: ImJugEx(),
    )
}
