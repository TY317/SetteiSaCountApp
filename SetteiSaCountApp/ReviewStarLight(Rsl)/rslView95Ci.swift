//
//  rslView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/24.
//

import SwiftUI

struct rslView95Ci: View {
//    @ObservedObject var rsl = Rsl()
    @ObservedObject var rsl: Rsl
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // BIG回数
            unitListSection95Ci(
                grafTitle: "BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $rsl.bigCount,
                        bigNumber: $rsl.totalGame,
                        setting1Denominate: rsl.ratioBigSum[0],
                        setting2Denominate: rsl.ratioBigSum[1],
                        setting3Enable: false,
                        setting3Denominate: 0,
                        setting4Denominate: rsl.ratioBigSum[2],
                        setting5Denominate: rsl.ratioBigSum[3],
                        setting6Denominate: rsl.ratioBigSum[4]
                    )
                )
            )
            .tag(1)
            // REG回数
            unitListSection95Ci(
                grafTitle: "REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $rsl.regCount,
                        bigNumber: $rsl.totalGame,
                        setting1Denominate: rsl.ratioReg[0],
                        setting2Denominate: rsl.ratioReg[1],
                        setting3Enable: false,
                        setting3Denominate: 0,
                        setting4Denominate: rsl.ratioReg[2],
                        setting5Denominate: rsl.ratioReg[3],
                        setting6Denominate: rsl.ratioReg[4]
                    )
                )
            )
            .tag(2)
            // CZ回数
            unitListSection95Ci(
                grafTitle: "CZ回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $rsl.czCount,
                        bigNumber: $rsl.normalGame,
                        setting1Denominate: rsl.ratioCz[0],
                        setting2Denominate: rsl.ratioCz[1],
                        setting3Enable: false,
                        setting3Denominate: 0,
                        setting4Denominate: rsl.ratioCz[2],
                        setting5Denominate: rsl.ratioCz[3],
                        setting6Denominate: rsl.ratioCz[4]
                    )
                )
            )
            .tag(3)
            // AT回数
            unitListSection95Ci(
                grafTitle: "AT回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $rsl.atCount,
                        bigNumber: $rsl.normalGame,
                        setting1Denominate: rsl.ratioAt[0],
                        setting2Denominate: rsl.ratioAt[1],
                        setting3Enable: false,
                        setting3Denominate: 0,
                        setting4Denominate: rsl.ratioAt[2],
                        setting5Denominate: rsl.ratioAt[3],
                        setting6Denominate: rsl.ratioAt[4]
                    )
                )
            )
            .tag(4)
            // 設定差の大きいREG回数
            unitListSection95Ci(
                grafTitle: "設定差の大きいREG\n合算回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $rsl.regCount3YakuSum,
                        bigNumber: $rsl.totalGame,
                        setting1Denominate: rsl.ratioReg3YakuSum[0],
                        setting2Denominate: rsl.ratioReg3YakuSum[1],
                        setting3Enable: false,
                        setting3Denominate: 0,
                        setting4Denominate: rsl.ratioReg3YakuSum[2],
                        setting5Denominate: rsl.ratioReg3YakuSum[3],
                        setting6Denominate: rsl.ratioReg3YakuSum[4]
                    )
                )
            )
            .tag(5)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "レビュースタァライト",
                screenClass: screenClass
            )
        }
        .navigationTitle("95%信頼区間グラフ")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButton95CiExplain(isShow95CiExplain: isShow95CiExplain)
                    .popoverTip(tipUnitButton95CiExplain())
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    rslView95Ci(rsl: Rsl())
}
