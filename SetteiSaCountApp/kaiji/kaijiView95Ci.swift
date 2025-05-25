//
//  kaijiView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/23.
//

import SwiftUI

struct kaijiView95Ci: View {
//    @ObservedObject var kaiji = Kaiji()
    @ObservedObject var kaiji: Kaiji
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // 小役合算回数
            unitListSection95Ci(
                grafTitle: "小役合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kaiji.koyakuCountSum,
                        bigNumber: $kaiji.totalGame,
                        setting1Denominate: kaiji.ratioKoyakuSum[0],
                        setting2Denominate: kaiji.ratioKoyakuSum[1],
                        setting3Denominate: kaiji.ratioKoyakuSum[2],
                        setting4Denominate: kaiji.ratioKoyakuSum[3],
                        setting5Denominate: kaiji.ratioKoyakuSum[4],
                        setting6Denominate: kaiji.ratioKoyakuSum[5]
                    )
                )
            )
            .tag(4)
            // ざわ高確移行
            unitListSection95Ci(
                grafTitle: "弱レア役からのざわ高確移行回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kaiji.zawaKokakuCountMove,
                        bigNumber: $kaiji.zawaKokakuCountJakuRare,
                        setting1Percent: kaiji.zawaKokakuRatio[0],
                        setting2Percent: kaiji.zawaKokakuRatio[1],
                        setting3Percent: kaiji.zawaKokakuRatio[2],
                        setting4Percent: kaiji.zawaKokakuRatio[3],
                        setting5Percent: kaiji.zawaKokakuRatio[4],
                        setting6Percent: kaiji.zawaKokakuRatio[5]
                    )
                )
            )
            .tag(1)
            // CZ回数
            unitListSection95Ci(
                grafTitle: "CZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kaiji.czCount,
                        bigNumber: $kaiji.playNormalGame,
                        setting1Denominate: kaiji.ratioCz[0],
                        setting2Denominate: kaiji.ratioCz[1],
                        setting3Denominate: kaiji.ratioCz[2],
                        setting4Denominate: kaiji.ratioCz[3],
                        setting5Denominate: kaiji.ratioCz[4],
                        setting6Denominate: kaiji.ratioCz[5]
                    )
                )
            )
            .tag(2)
            // ボーナス初当り回数
            unitListSection95Ci(
                grafTitle: "ボーナス初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kaiji.atCount,
                        bigNumber: $kaiji.playNormalGame,
                        setting1Denominate: kaiji.ratioBonus[0],
                        setting2Denominate: kaiji.ratioBonus[1],
                        setting3Denominate: kaiji.ratioBonus[2],
                        setting4Denominate: kaiji.ratioBonus[3],
                        setting5Denominate: kaiji.ratioBonus[4],
                        setting6Denominate: kaiji.ratioBonus[5]
                    )
                )
            )
            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "回胴黙示録カイジ 狂宴",
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
    kaijiView95Ci(kaiji: Kaiji())
}
