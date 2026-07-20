//
//  kerottoView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct kerottoView95Ci: View {
    @ObservedObject var kerotto: Kerotto
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // SBB初当り回数
            unitListSection95Ci(
                grafTitle: "SBB初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kerotto.firstHitCountSBBSum,
                        bigNumber: $kerotto.gameNumberPlay,
                        setting1Denominate: kerotto.ratioFirstHitSbb[0],
                        setting2Denominate: kerotto.ratioFirstHitSbb[1],
                        setting3Denominate: kerotto.ratioFirstHitSbb[2],
                        setting4Denominate: kerotto.ratioFirstHitSbb[3],
                        setting5Denominate: kerotto.ratioFirstHitSbb[4],
                        setting6Denominate: kerotto.ratioFirstHitSbb[5]
                    )
                )
            )
            .tag(1)
            
            // BB初当り回数
            unitListSection95Ci(
                grafTitle: "BB初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kerotto.firstHitCountBBSum,
                        bigNumber: $kerotto.gameNumberPlay,
                        setting1Denominate: kerotto.ratioFirstHitBb[0],
                        setting2Denominate: kerotto.ratioFirstHitBb[1],
                        setting3Denominate: kerotto.ratioFirstHitBb[2],
                        setting4Denominate: kerotto.ratioFirstHitBb[3],
                        setting5Denominate: kerotto.ratioFirstHitBb[4],
                        setting6Denominate: kerotto.ratioFirstHitBb[5]
                    )
                )
            )
            .tag(2)
            
            // REG初当り回数
            unitListSection95Ci(
                grafTitle: "REG初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kerotto.firstHitCountREGSum,
                        bigNumber: $kerotto.gameNumberPlay,
                        setting1Denominate: kerotto.ratioFirstHitReg[0],
                        setting2Denominate: kerotto.ratioFirstHitReg[1],
                        setting3Denominate: kerotto.ratioFirstHitReg[2],
                        setting4Denominate: kerotto.ratioFirstHitReg[3],
                        setting5Denominate: kerotto.ratioFirstHitReg[4],
                        setting6Denominate: kerotto.ratioFirstHitReg[5]
                    )
                )
            )
            .tag(3)
            
            // 赤頭回数
            unitListSection95Ci(
                grafTitle: "赤頭回数",
//                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kerotto.firstHitCountRSum,
                        bigNumber: $kerotto.firstHitCountAllSum,
                        setting1Percent: kerotto.ratioFirstHitRed[0],
                        setting2Percent: kerotto.ratioFirstHitRed[1],
                        setting3Percent: kerotto.ratioFirstHitRed[2],
                        setting4Percent: kerotto.ratioFirstHitRed[3],
                        setting5Percent: kerotto.ratioFirstHitRed[4],
                        setting6Percent: kerotto.ratioFirstHitRed[5]
                    )
                )
            )
            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kerotto.machineName,
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
    kerottoView95Ci(
        kerotto: Kerotto(),
    )
}
