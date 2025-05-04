//
//  midoriDonView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/04.
//

import SwiftUI

struct midoriDonView95Ci: View {
    @ObservedObject var midoriDon: MidoriDon
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // 弱チェリー回数
            unitListSection95Ci(
                grafTitle: "弱🍒回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $midoriDon.jakuRareCountCherry,
                        bigNumber: $midoriDon.totalGame,
                        setting1Denominate: midoriDon.ratioJakuCherry[0],
                        setting2Denominate: midoriDon.ratioJakuCherry[1],
                        setting3Denominate: midoriDon.ratioJakuCherry[2],
                        setting4Denominate: midoriDon.ratioJakuCherry[3],
                        setting5Denominate: midoriDon.ratioJakuCherry[4],
                        setting6Denominate: midoriDon.ratioJakuCherry[5]
                    )
                )
            )
            .tag(1)
            // 弱スイカ回数
            unitListSection95Ci(
                grafTitle: "弱🍉回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $midoriDon.jakuRareCountSuika,
                        bigNumber: $midoriDon.totalGame,
                        setting1Denominate: midoriDon.ratioJakuSuika[0],
                        setting2Denominate: midoriDon.ratioJakuSuika[1],
                        setting3Denominate: midoriDon.ratioJakuSuika[2],
                        setting4Denominate: midoriDon.ratioJakuSuika[3],
                        setting5Denominate: midoriDon.ratioJakuSuika[4],
                        setting6Denominate: midoriDon.ratioJakuSuika[5]
                    )
                )
            )
            .tag(2)
            // 弱レア役合算回数
            unitListSection95Ci(
                grafTitle: "弱🍒＆🍉 合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $midoriDon.jakuRareCountSum,
                        bigNumber: $midoriDon.totalGame,
                        setting1Denominate: midoriDon.ratioJakuSum[0],
                        setting2Denominate: midoriDon.ratioJakuSum[1],
                        setting3Denominate: midoriDon.ratioJakuSum[2],
                        setting4Denominate: midoriDon.ratioJakuSum[3],
                        setting5Denominate: midoriDon.ratioJakuSum[4],
                        setting6Denominate: midoriDon.ratioJakuSum[5]
                    )
                )
            )
            .tag(3)
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
    midoriDonView95Ci(
        midoriDon: MidoriDon()
    )
}
