//
//  neoplaView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/09.
//

import SwiftUI

struct neoplaView95Ci: View {
    @ObservedObject var neopla: Neopla
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // ビッグ合算回数
            unitListSection95Ci(
                grafTitle: "BIG合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $neopla.bonusCountBigSum,
                        bigNumber: $neopla.normalGame,
                        setting1Denominate: neopla.ratioBigSum[0],
                        setting2Denominate: neopla.ratioBigSum[1],
                        setting3Enable: false,
                        setting3Denominate: 0,
                        setting4Denominate: neopla.ratioBigSum[2],
                        setting5Denominate: neopla.ratioBigSum[3],
                        setting6Denominate: neopla.ratioBigSum[4]
                    )
                )
            )
            .tag(1)
            // REG回数
            unitListSection95Ci(
                grafTitle: "REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $neopla.bonusCountReg,
                        bigNumber: $neopla.normalGame,
                        setting1Denominate: neopla.ratioReg[0],
                        setting2Denominate: neopla.ratioReg[1],
                        setting3Enable: false,
                        setting3Denominate: 0,
                        setting4Denominate: neopla.ratioReg[2],
                        setting5Denominate: neopla.ratioReg[3],
                        setting6Denominate: neopla.ratioReg[4]
                    )
                )
            )
            .tag(2)
            
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $neopla.bonusCountSum,
                        bigNumber: $neopla.normalGame,
                        setting1Denominate: neopla.ratioBonusSum[0],
                        setting2Denominate: neopla.ratioBonusSum[1],
                        setting3Enable: false,
                        setting3Denominate: 0,
                        setting4Denominate: neopla.ratioBonusSum[2],
                        setting5Denominate: neopla.ratioBonusSum[3],
                        setting6Denominate: neopla.ratioBonusSum[4]
                    )
                )
            )
            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: neopla.machineName,
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
    neoplaView95Ci(
        neopla: Neopla(),
    )
}
