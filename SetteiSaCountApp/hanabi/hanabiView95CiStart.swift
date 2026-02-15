//
//  hanabiView95CiStart.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/07.
//

import SwiftUI

struct hanabiView95CiStart: View {
    @ObservedObject var hanabi: Hanabi
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
                        currentCount: $hanabi.startBig,
                        bigNumber: $hanabi.startGame,
                        setting1Denominate: hanabi.ratioBig[0],
                        setting2Denominate: hanabi.ratioBig[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: hanabi.ratioBig[2],
                        setting6Denominate: hanabi.ratioBig[3]
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
                        currentCount: $hanabi.startReg,
                        bigNumber: $hanabi.startGame,
                        setting1Denominate: hanabi.ratioReg[0],
                        setting2Denominate: hanabi.ratioReg[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: hanabi.ratioReg[2],
                        setting6Denominate: hanabi.ratioReg[3]
                    )
                )
            )
            .tag(2)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hanabi.machineName,
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
    hanabiView95CiStart(
        hanabi: Hanabi(),
    )
}
