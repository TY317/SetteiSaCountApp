//
//  thunderView95CiStart.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/11.
//

import SwiftUI

struct thunderView95CiStart: View {
    @ObservedObject var thunder: Thunder
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // BIG回数
            unitListSection95Ci(
                grafTitle: "打ち始め\nBIG回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $thunder.startBig,
                        bigNumber: $thunder.startGame,
                        setting1Denominate: thunder.ratioBig[0],
                        setting2Denominate: thunder.ratioBig[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: thunder.ratioBig[2],
                        setting6Denominate: thunder.ratioBig[3]
                    )
                )
            )
            .tag(1)
            // REG回数
            unitListSection95Ci(
                grafTitle: "打ち始め\nREG回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $thunder.startReg,
                        bigNumber: $thunder.startGame,
                        setting1Denominate: thunder.ratioReg[0],
                        setting2Denominate: thunder.ratioReg[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: thunder.ratioReg[2],
                        setting6Denominate: thunder.ratioReg[3]
                    )
                )
            )
            .tag(2)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: thunder.machineName,
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
    thunderView95CiStart(
        thunder: Thunder(),
    )
}
