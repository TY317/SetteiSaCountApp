//
//  evaYakusokuView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/29.
//

import SwiftUI

struct evaYakusokuView95Ci: View {
    @ObservedObject var evaYakusoku: EvaYakusoku
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // //// ビッグ合算回数
            unitListSection95Ci(
                grafTitle: "BIG合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $evaYakusoku.bonusCountBigSum,
                        bigNumber: $evaYakusoku.gameNumberPlay,
                        setting1Denominate: evaYakusoku.ratioBigSum[0],
                        setting2Denominate: evaYakusoku.ratioBigSum[1],
                        setting3Denominate: evaYakusoku.ratioBigSum[2],
                        setting4Denominate: evaYakusoku.ratioBigSum[3],
                        setting5Denominate: evaYakusoku.ratioBigSum[4],
                        setting6Denominate: evaYakusoku.ratioBigSum[5]
                    )
                )
            )
            .tag(1)
            // //// REG合算回数
            unitListSection95Ci(
                grafTitle: "REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $evaYakusoku.bonusCountReg,
                        bigNumber: $evaYakusoku.gameNumberPlay,
                        setting1Denominate: evaYakusoku.ratioReg[0],
                        setting2Denominate: evaYakusoku.ratioReg[1],
                        setting3Denominate: evaYakusoku.ratioReg[2],
                        setting4Denominate: evaYakusoku.ratioReg[3],
                        setting5Denominate: evaYakusoku.ratioReg[4],
                        setting6Denominate: evaYakusoku.ratioReg[5]
                    )
                )
            )
            .tag(2)
            // //// ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $evaYakusoku.bonusCountAllSum,
                        bigNumber: $evaYakusoku.gameNumberPlay,
                        setting1Denominate: evaYakusoku.ratioBonusSum[0],
                        setting2Denominate: evaYakusoku.ratioBonusSum[1],
                        setting3Denominate: evaYakusoku.ratioBonusSum[2],
                        setting4Denominate: evaYakusoku.ratioBonusSum[3],
                        setting5Denominate: evaYakusoku.ratioBonusSum[4],
                        setting6Denominate: evaYakusoku.ratioBonusSum[5]
                    )
                )
            )
            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: evaYakusoku.machineName,
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
    evaYakusokuView95Ci(
        evaYakusoku: EvaYakusoku(),
    )
}
