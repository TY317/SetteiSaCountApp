//
//  hokutoTenseiView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/26.
//

import SwiftUI

struct hokutoTenseiView95Ci: View {
    @ObservedObject var hokutoTensei: HokutoTensei
    @State var selection = 1
    @State var isShow95CiExplain = false
    var body: some View {
        TabView(selection: self.$selection) {
            // 弱チェリー、スイカからの天破当選回数
            unitListSection95Ci(
                grafTitle: "弱🍒・🍉からの天破当選回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $hokutoTensei.koyakuCountTenhaHit,
                        bigNumber: $hokutoTensei.koyakuCountSum,
                        setting1Percent: hokutoTensei.ratioJakuCherrySuikaTenha[0],
                        setting2Percent: hokutoTensei.ratioJakuCherrySuikaTenha[1],
                        setting3Percent: hokutoTensei.ratioJakuCherrySuikaTenha[2],
                        setting4Percent: hokutoTensei.ratioJakuCherrySuikaTenha[3],
                        setting5Percent: hokutoTensei.ratioJakuCherrySuikaTenha[4],
                        setting6Percent: hokutoTensei.ratioJakuCherrySuikaTenha[5]
                    )
                )
            )
            .tag(4)
            // 台枠ランプ 白点灯回数
            unitListSection95Ci(
                grafTitle: "台枠ランプ\n白点滅回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $hokutoTensei.lampCount35Sisa,
                        bigNumber: $hokutoTensei.lampCountWhiteSum,
                        setting1Percent: hokutoTensei.ratioLamp35Sisa[0],
                        setting2Percent: hokutoTensei.ratioLamp35Sisa[1],
                        setting3Percent: hokutoTensei.ratioLamp35Sisa[2],
                        setting4Percent: hokutoTensei.ratioLamp35Sisa[3],
                        setting5Percent: hokutoTensei.ratioLamp35Sisa[4],
                        setting6Percent: hokutoTensei.ratioLamp35Sisa[5]
                    )
                )
            )
            .tag(2)
            
            // 初当り回数
            unitListSection95Ci(
                grafTitle: "天破の刻 初当り回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hokutoTensei.firstHitCountTenha,
                        bigNumber: $hokutoTensei.normalGame,
                        setting1Denominate: hokutoTensei.ratioAtFirstHitTenha[0],
                        setting2Denominate: hokutoTensei.ratioAtFirstHitTenha[1],
                        setting3Denominate: hokutoTensei.ratioAtFirstHitTenha[2],
                        setting4Denominate: hokutoTensei.ratioAtFirstHitTenha[3],
                        setting5Denominate: hokutoTensei.ratioAtFirstHitTenha[4],
                        setting6Denominate: hokutoTensei.ratioAtFirstHitTenha[5]
                    )
                )
            )
            .tag(3)
            
            // 初当り回数
            unitListSection95Ci(
                grafTitle: "闘神演舞 初当り回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hokutoTensei.firstHitCountAt,
                        bigNumber: $hokutoTensei.normalGame,
                        setting1Denominate: hokutoTensei.ratioAtFirstHitAt[0],
                        setting2Denominate: hokutoTensei.ratioAtFirstHitAt[1],
                        setting3Denominate: hokutoTensei.ratioAtFirstHitAt[2],
                        setting4Denominate: hokutoTensei.ratioAtFirstHitAt[3],
                        setting5Denominate: hokutoTensei.ratioAtFirstHitAt[4],
                        setting6Denominate: hokutoTensei.ratioAtFirstHitAt[5]
                    )
                )
            )
            .tag(1)
            
            
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hokutoTensei.machineName,
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
    hokutoTenseiView95Ci(
        hokutoTensei: HokutoTensei(),
    )
}
