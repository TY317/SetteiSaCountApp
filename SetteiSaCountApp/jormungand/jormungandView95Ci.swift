//
//  jormungandView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/04.
//

import SwiftUI

struct jormungandView95Ci: View {
    @ObservedObject var jormungand: Jormungand
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // 通常時　チャンス目からのCZ当選回数
            unitListSection95Ci(
                grafTitle: "通常時\nチャンス目からのCZ当選回数",
                titleFont: .title3,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $jormungand.rareCzCountChanceHit,
                        bigNumber: $jormungand.rareCzCountChance,
                        setting1Percent: jormungand.ratioRareCzNormalChance[0],
                        setting2Percent: jormungand.ratioRareCzNormalChance[1],
                        setting3Percent: jormungand.ratioRareCzNormalChance[2],
                        setting4Percent: jormungand.ratioRareCzNormalChance[3],
                        setting5Percent: jormungand.ratioRareCzNormalChance[4],
                        setting6Percent: jormungand.ratioRareCzNormalChance[5]
                    )
                )
            )
            .tag(3)
            
            // 通常時　強チェリーからのCZ当選回数
            unitListSection95Ci(
                grafTitle: "通常時\n強🍒からのCZ当選回数",
                titleFont: .title3,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $jormungand.rareCzCountKyoCherryHit,
                        bigNumber: $jormungand.rareCzCountKyoCherry,
                        setting1Percent: jormungand.ratioRareCzNormalKyoCherry[0],
                        setting2Percent: jormungand.ratioRareCzNormalKyoCherry[1],
                        setting3Percent: jormungand.ratioRareCzNormalKyoCherry[2],
                        setting4Percent: jormungand.ratioRareCzNormalKyoCherry[3],
                        setting5Percent: jormungand.ratioRareCzNormalKyoCherry[4],
                        setting6Percent: jormungand.ratioRareCzNormalKyoCherry[5]
                    )
                )
            )
            .tag(4)
            
            // CZ初当り回数
            unitListSection95Ci(
                grafTitle: "CZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $jormungand.firstHitCountCz,
                        bigNumber: $jormungand.normalGame,
                        setting1Denominate: jormungand.ratioFirstHitCz[0],
                        setting2Denominate: jormungand.ratioFirstHitCz[1],
                        setting3Denominate: jormungand.ratioFirstHitCz[2],
                        setting4Denominate: jormungand.ratioFirstHitCz[3],
                        setting5Denominate: jormungand.ratioFirstHitCz[4],
                        setting6Denominate: jormungand.ratioFirstHitCz[5]
                    )
                )
            )
            .tag(1)
            
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $jormungand.firstHitCountAt,
                        bigNumber: $jormungand.normalGame,
                        setting1Denominate: jormungand.ratioFirstHitAt[0],
                        setting2Denominate: jormungand.ratioFirstHitAt[1],
                        setting3Denominate: jormungand.ratioFirstHitAt[2],
                        setting4Denominate: jormungand.ratioFirstHitAt[3],
                        setting5Denominate: jormungand.ratioFirstHitAt[4],
                        setting6Denominate: jormungand.ratioFirstHitAt[5]
                    )
                )
            )
            .tag(2)
            
//            // 炎炎ループ初当り回数
//            unitListSection95Ci(
//                grafTitle: "炎炎ループ初当り回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $jormungand.firstHitCountLoop,
//                        bigNumber: $jormungand.normalGame,
//                        setting1Denominate: jormungand.ratioFirstHitLoop[0],
//                        setting2Denominate: jormungand.ratioFirstHitLoop[1],
//                        setting3Denominate: jormungand.ratioFirstHitLoop[2],
//                        setting4Denominate: jormungand.ratioFirstHitLoop[3],
//                        setting5Denominate: jormungand.ratioFirstHitLoop[4],
//                        setting6Denominate: jormungand.ratioFirstHitLoop[5]
//                    )
//                )
//            )
//            .tag(2)
//
//
//            // REG,後終了画面デフォルト回数
//            unitListSection95Ci(
//                grafTitle: "REG,アクセルボーナス,灰焔ボーナス後\n終了画面 デフォルト回数",
//                titleFont: .body,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $jormungand.screenCount1,
//                        bigNumber: $jormungand.screenCountSum,
//                        setting1Percent: jormungand.ratioScreen1[0],
//                        setting2Percent: jormungand.ratioScreen1[1],
//                        setting3Percent: jormungand.ratioScreen1[2],
//                        setting4Percent: jormungand.ratioScreen1[3],
//                        setting5Percent: jormungand.ratioScreen1[4],
//                        setting6Percent: jormungand.ratioScreen1[5]
//                    )
//                )
//            )
//            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: jormungand.machineName,
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
    jormungandView95Ci(
        jormungand: Jormungand(),
    )
}
