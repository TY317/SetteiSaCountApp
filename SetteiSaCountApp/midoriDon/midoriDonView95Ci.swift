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
            // 通常時レア役からのボーナス当選回数　弱チェリー
            unitListSection95Ci(
                grafTitle: "通常時レア役からの当選回数\n弱🍒",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $midoriDon.normalRareHitCountJakuCherry,
                        bigNumber: $midoriDon.normalRareCountJakuCherry,
                        setting1Percent: midoriDon.ratioKoyakuBonusJakuCherry[0],
                        setting2Percent: midoriDon.ratioKoyakuBonusJakuCherry[1],
                        setting3Percent: midoriDon.ratioKoyakuBonusJakuCherry[2],
                        setting4Percent: midoriDon.ratioKoyakuBonusJakuCherry[3],
                        setting5Percent: midoriDon.ratioKoyakuBonusJakuCherry[4],
                        setting6Percent: midoriDon.ratioKoyakuBonusJakuCherry[5]
                    )
                )
            )
            .tag(4)
            // 通常時レア役からのボーナス当選回数　弱スイカ
            unitListSection95Ci(
                grafTitle: "通常時レア役からの当選回数\n弱🍉",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $midoriDon.normalRareHitCountJakuSuika,
                        bigNumber: $midoriDon.normalRareCountJakuSuika,
                        setting1Percent: midoriDon.ratioKoyakuBonusJakuSuika[0],
                        setting2Percent: midoriDon.ratioKoyakuBonusJakuSuika[1],
                        setting3Percent: midoriDon.ratioKoyakuBonusJakuSuika[2],
                        setting4Percent: midoriDon.ratioKoyakuBonusJakuSuika[3],
                        setting5Percent: midoriDon.ratioKoyakuBonusJakuSuika[4],
                        setting6Percent: midoriDon.ratioKoyakuBonusJakuSuika[5]
                    )
                )
            )
            .tag(5)
            // 通常時レア役からのボーナス当選回数　チャンス目
            unitListSection95Ci(
                grafTitle: "通常時レア役からの当選回数\nチャンス目",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $midoriDon.normalRareHitCountChance,
                        bigNumber: $midoriDon.normalRareCountChance,
                        setting1Percent: midoriDon.ratioKoyakuBonusChance[0],
                        setting2Percent: midoriDon.ratioKoyakuBonusChance[1],
                        setting3Percent: midoriDon.ratioKoyakuBonusChance[2],
                        setting4Percent: midoriDon.ratioKoyakuBonusChance[3],
                        setting5Percent: midoriDon.ratioKoyakuBonusChance[4],
                        setting6Percent: midoriDon.ratioKoyakuBonusChance[5]
                    )
                )
            )
            .tag(6)
            // 通常時レア役からのボーナス当選回数　強チェリー
            unitListSection95Ci(
                grafTitle: "通常時レア役からの当選回数\n強🍒",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $midoriDon.normalRareHitCountKyoCherry,
                        bigNumber: $midoriDon.normalRareCountKyoCherry,
                        setting1Percent: midoriDon.ratioKoyakuBonusKyoCherry[0],
                        setting2Percent: midoriDon.ratioKoyakuBonusKyoCherry[1],
                        setting3Percent: midoriDon.ratioKoyakuBonusKyoCherry[2],
                        setting4Percent: midoriDon.ratioKoyakuBonusKyoCherry[3],
                        setting5Percent: midoriDon.ratioKoyakuBonusKyoCherry[4],
                        setting6Percent: midoriDon.ratioKoyakuBonusKyoCherry[5]
                    )
                )
            )
            .tag(7)
            // 通常時レア役からのボーナス当選回数　強スイカ
            unitListSection95Ci(
                grafTitle: "通常時レア役からの当選回数\n強🍉",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $midoriDon.normalRareHitCountKyoSuika,
                        bigNumber: $midoriDon.normalRareCountKyoSuika,
                        setting1Percent: midoriDon.ratioKoyakuBonusKyoSuika[0],
                        setting2Percent: midoriDon.ratioKoyakuBonusKyoSuika[1],
                        setting3Percent: midoriDon.ratioKoyakuBonusKyoSuika[2],
                        setting4Percent: midoriDon.ratioKoyakuBonusKyoSuika[3],
                        setting5Percent: midoriDon.ratioKoyakuBonusKyoSuika[4],
                        setting6Percent: midoriDon.ratioKoyakuBonusKyoSuika[5]
                    )
                )
            )
            .tag(8)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "緑ドン",
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
    midoriDonView95Ci(
        midoriDon: MidoriDon()
    )
}
