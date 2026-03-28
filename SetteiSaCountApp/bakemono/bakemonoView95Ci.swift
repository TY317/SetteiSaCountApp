//
//  bakemonoView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/30.
//

import SwiftUI

struct bakemonoView95Ci: View {
    @ObservedObject var bakemono: Bakemono
    @State var selection = 1
    @State var isShow95CiExplain = false
    var body: some View {
        TabView(selection: self.$selection) {
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "🍉回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $bakemono.koyakuCountSuika,
                        bigNumber: $bakemono.totalGame,
                        setting1Denominate: bakemono.ratioSuika[0],
                        setting2Denominate: bakemono.ratioSuika[1],
                        setting3Denominate: bakemono.ratioSuika[2],
                        setting4Denominate: bakemono.ratioSuika[3],
                        setting5Denominate: bakemono.ratioSuika[4],
                        setting6Denominate: bakemono.ratioSuika[5]
                    )
                )
            )
            .tag(2)
            
            // 通常滞在時　スイカからのCZ当選
            unitListSection95Ci(
                grafTitle: "通常滞在時\n🍉からのCZ当選回数",
                titleFont: .title3,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $bakemono.rareCzCountSuikaHit,
                        bigNumber: $bakemono.rareCzCountSuika,
                        setting1Percent: bakemono.ratioNormalCzSuika[0],
                        setting2Percent: bakemono.ratioNormalCzSuika[1],
                        setting3Percent: bakemono.ratioNormalCzSuika[2],
                        setting4Percent: bakemono.ratioNormalCzSuika[3],
                        setting5Percent: bakemono.ratioNormalCzSuika[4],
                        setting6Percent: bakemono.ratioNormalCzSuika[5]
                    )
                )
            )
            .tag(3)
            
            // 通常滞在時　強🍒・チャンス目からのCZ当選
            unitListSection95Ci(
                grafTitle: "通常滞在時\n強🍒・チャンス目からのCZ当選回数",
                titleFont: .title3,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $bakemono.rareCzCountKyoRareHit,
                        bigNumber: $bakemono.rareCzCountKyoRareSum,
                        setting1Percent: bakemono.ratioNormalCzKyoCerryChance[0],
                        setting2Percent: bakemono.ratioNormalCzKyoCerryChance[1],
                        setting3Percent: bakemono.ratioNormalCzKyoCerryChance[2],
                        setting4Percent: bakemono.ratioNormalCzKyoCerryChance[3],
                        setting5Percent: bakemono.ratioNormalCzKyoCerryChance[4],
                        setting6Percent: bakemono.ratioNormalCzKyoCerryChance[5]
                    )
                )
            )
            .tag(4)
            
            // ゲーム数 解ジュのぎ　200G当選
            unitListSection95Ci(
                grafTitle: "ゲーム数での解呪ノ儀\n200G当選回数",
                titleFont: .title3,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $bakemono.kiteiCount200Hit,
                        bigNumber: $bakemono.kiteiCount200Sum,
                        setting1Percent: bakemono.ratioKitei200[0],
                        setting2Percent: bakemono.ratioKitei200[1],
                        setting3Percent: bakemono.ratioKitei200[2],
                        setting4Percent: bakemono.ratioKitei200[3],
                        setting5Percent: bakemono.ratioKitei200[4],
                        setting6Percent: bakemono.ratioKitei200[5]
                    )
                )
            )
            .tag(5)
            
            // ゲーム数 解ジュのぎ　300G当選
            unitListSection95Ci(
                grafTitle: "ゲーム数での解呪ノ儀\n300G当選回数",
                titleFont: .title3,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $bakemono.kiteiCount300Hit,
                        bigNumber: $bakemono.kiteiCount300Sum,
                        setting1Percent: bakemono.ratioKitei300[0],
                        setting2Percent: bakemono.ratioKitei300[1],
                        setting3Percent: bakemono.ratioKitei300[2],
                        setting4Percent: bakemono.ratioKitei300[3],
                        setting5Percent: bakemono.ratioKitei300[4],
                        setting6Percent: bakemono.ratioKitei300[5]
                    )
                )
            )
            .tag(6)
            
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $bakemono.firstHitCountAt,
                        bigNumber: $bakemono.normalGame,
                        setting1Denominate: bakemono.ratioAtFirstHit[0],
                        setting2Denominate: bakemono.ratioAtFirstHit[1],
                        setting3Denominate: bakemono.ratioAtFirstHit[2],
                        setting4Denominate: bakemono.ratioAtFirstHit[3],
                        setting5Denominate: bakemono.ratioAtFirstHit[4],
                        setting6Denominate: bakemono.ratioAtFirstHit[5]
                    )
                )
            )
            .tag(1)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: bakemono.machineName,
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
    bakemonoView95Ci(
        bakemono: Bakemono(),
    )
}
