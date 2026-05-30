//
//  godKisekiView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/13.
//

import SwiftUI

struct godKisekiView95Ci: View {
    @ObservedObject var godKiseki: GodKiseki
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // リプ3連からのAT当選回数
            unitListSection95Ci(
                grafTitle: "リプ3連からのAT当選回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $godKiseki.ren3CountBlueHit,
                        bigNumber: $godKiseki.ren3CountBlue,
                        setting1Percent: godKiseki.ratioReplay3Hit[0],
                        setting2Percent: godKiseki.ratioReplay3Hit[1],
                        setting3Percent: godKiseki.ratioReplay3Hit[2],
                        setting4Percent: godKiseki.ratioReplay3Hit[3],
                        setting5Percent: godKiseki.ratioReplay3Hit[4],
                        setting6Percent: godKiseki.ratioReplay3Hit[5]
                    )
                )
            )
            .tag(2)
            
            // リプ4連からのAT当選回数
            unitListSection95Ci(
                grafTitle: "リプ4連からのAT当選回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $godKiseki.ren4CountBlueHit,
                        bigNumber: $godKiseki.ren4CountBlue,
                        setting1Percent: godKiseki.ratioReplay4Hit[0],
                        setting2Percent: godKiseki.ratioReplay4Hit[1],
                        setting3Percent: godKiseki.ratioReplay4Hit[2],
                        setting4Percent: godKiseki.ratioReplay4Hit[3],
                        setting5Percent: godKiseki.ratioReplay4Hit[4],
                        setting6Percent: godKiseki.ratioReplay4Hit[5]
                    )
                )
            )
            .tag(3)
            
//            // 通常時　強チェリーからのCZ当選回数
//            unitListSection95Ci(
//                grafTitle: "通常時\n強🍒からのCZ当選回数",
//                titleFont: .title3,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $godKiseki.rareCzCountKyoCherryHit,
//                        bigNumber: $godKiseki.rareCzCountKyoCherry,
//                        setting1Percent: godKiseki.ratioRareCzNormalKyoCherry[0],
//                        setting2Percent: godKiseki.ratioRareCzNormalKyoCherry[1],
//                        setting3Percent: godKiseki.ratioRareCzNormalKyoCherry[2],
//                        setting4Percent: godKiseki.ratioRareCzNormalKyoCherry[3],
//                        setting5Percent: godKiseki.ratioRareCzNormalKyoCherry[4],
//                        setting6Percent: godKiseki.ratioRareCzNormalKyoCherry[5]
//                    )
//                )
//            )
//            .tag(4)
//            
//            // 天井短縮回数
//            unitListSection95Ci(
//                grafTitle: "天井短縮回数",
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $godKiseki.tenjoCountHit,
//                        bigNumber: $godKiseki.tenjoCountSum,
//                        setting1Percent: godKiseki.ratioTenjoCut[0],
//                        setting2Percent: godKiseki.ratioTenjoCut[1],
//                        setting3Percent: godKiseki.ratioTenjoCut[2],
//                        setting4Percent: godKiseki.ratioTenjoCut[3],
//                        setting5Percent: godKiseki.ratioTenjoCut[4],
//                        setting6Percent: godKiseki.ratioTenjoCut[5]
//                    )
//                )
//            )
//            .tag(5)
//            
//            // CZ初当り回数
//            unitListSection95Ci(
//                grafTitle: "CZ初当り回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $godKiseki.firstHitCountCz,
//                        bigNumber: $godKiseki.normalGame,
//                        setting1Denominate: godKiseki.ratioFirstHitCz[0],
//                        setting2Denominate: godKiseki.ratioFirstHitCz[1],
//                        setting3Denominate: godKiseki.ratioFirstHitCz[2],
//                        setting4Denominate: godKiseki.ratioFirstHitCz[3],
//                        setting5Denominate: godKiseki.ratioFirstHitCz[4],
//                        setting6Denominate: godKiseki.ratioFirstHitCz[5]
//                    )
//                )
//            )
//            .tag(1)
            
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $godKiseki.firstHitCountAt,
                        bigNumber: $godKiseki.normalGame,
                        setting1Denominate: godKiseki.ratioFirstHitAt[0],
                        setting2Denominate: godKiseki.ratioFirstHitAt[1],
                        setting3Denominate: godKiseki.ratioFirstHitAt[2],
                        setting4Denominate: godKiseki.ratioFirstHitAt[3],
                        setting5Denominate: godKiseki.ratioFirstHitAt[4],
                        setting6Denominate: godKiseki.ratioFirstHitAt[5]
                    )
                )
            )
            .tag(1)
            
//            // 炎炎ループ初当り回数
//            unitListSection95Ci(
//                grafTitle: "炎炎ループ初当り回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $godKiseki.firstHitCountLoop,
//                        bigNumber: $godKiseki.normalGame,
//                        setting1Denominate: godKiseki.ratioFirstHitLoop[0],
//                        setting2Denominate: godKiseki.ratioFirstHitLoop[1],
//                        setting3Denominate: godKiseki.ratioFirstHitLoop[2],
//                        setting4Denominate: godKiseki.ratioFirstHitLoop[3],
//                        setting5Denominate: godKiseki.ratioFirstHitLoop[4],
//                        setting6Denominate: godKiseki.ratioFirstHitLoop[5]
//                    )
//                )
//            )
//            .tag(2)
//
//
            // Z-ZONE昇格回数
            unitListSection95Ci(
                grafTitle: "Z-ZONE昇格回数",
//                titleFont: .body,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $godKiseki.riseZzoneCount,
                        bigNumber: $godKiseki.firstHitCountAt,
                        setting1Percent: godKiseki.ratioRiseZzone[0],
                        setting2Percent: godKiseki.ratioRiseZzone[1],
                        setting3Percent: godKiseki.ratioRiseZzone[2],
                        setting4Percent: godKiseki.ratioRiseZzone[3],
                        setting5Percent: godKiseki.ratioRiseZzone[4],
                        setting6Percent: godKiseki.ratioRiseZzone[5]
                    )
                )
            )
            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: godKiseki.machineName,
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
    godKisekiView95Ci(
        godKiseki: GodKiseki(),
    )
}
