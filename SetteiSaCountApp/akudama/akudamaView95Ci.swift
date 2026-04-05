//
//  akudamaView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/05.
//

import SwiftUI

struct akudamaView95Ci: View {
    @ObservedObject var akudama: Akudama
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // ptからのCZ当選回数
            unitListSection95Ci(
                grafTitle: "ptからのCZ当選回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $akudama.ptCountCzHit,
                        bigNumber: $akudama.ptCountFull,
                        setting1Percent: akudama.ratioPtCzHit[0],
                        setting2Percent: akudama.ratioPtCzHit[1],
                        setting3Percent: akudama.ratioPtCzHit[2],
                        setting4Percent: akudama.ratioPtCzHit[3],
                        setting5Percent: akudama.ratioPtCzHit[4],
                        setting6Percent: akudama.ratioPtCzHit[5]
                    )
                )
            )
            .tag(1)
            
            // CZ初当り回数
//            unitListSection95Ci(
//                grafTitle: "CZ初当り回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $akudama.firstHitCountCz,
//                        bigNumber: $akudama.normalGame,
//                        setting1Denominate: akudama.ratioFirstHitCz[0],
//                        setting2Denominate: akudama.ratioFirstHitCz[1],
//                        setting3Denominate: akudama.ratioFirstHitCz[2],
//                        setting4Denominate: akudama.ratioFirstHitCz[3],
//                        setting5Denominate: akudama.ratioFirstHitCz[4],
//                        setting6Denominate: akudama.ratioFirstHitCz[5]
//                    )
//                )
//            )
//            .tag(1)
            
            // AT初当り回数
//            unitListSection95Ci(
//                grafTitle: "AT初当り回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $akudama.firstHitCountAt,
//                        bigNumber: $akudama.normalGame,
//                        setting1Denominate: akudama.ratioFirstHitAt[0],
//                        setting2Denominate: akudama.ratioFirstHitAt[1],
//                        setting3Denominate: akudama.ratioFirstHitAt[2],
//                        setting4Denominate: akudama.ratioFirstHitAt[3],
//                        setting5Denominate: akudama.ratioFirstHitAt[4],
//                        setting6Denominate: akudama.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(2)
            
//            // 炎炎ループ初当り回数
//            unitListSection95Ci(
//                grafTitle: "炎炎ループ初当り回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $akudama.firstHitCountLoop,
//                        bigNumber: $akudama.normalGame,
//                        setting1Denominate: akudama.ratioFirstHitLoop[0],
//                        setting2Denominate: akudama.ratioFirstHitLoop[1],
//                        setting3Denominate: akudama.ratioFirstHitLoop[2],
//                        setting4Denominate: akudama.ratioFirstHitLoop[3],
//                        setting5Denominate: akudama.ratioFirstHitLoop[4],
//                        setting6Denominate: akudama.ratioFirstHitLoop[5]
//                    )
//                )
//            )
//            .tag(2)
//
//            // REG,後終了画面デフォルト回数
//            unitListSection95Ci(
//                grafTitle: "REG,アクセルボーナス,灰焔ボーナス後\n終了画面 デフォルト回数",
//                titleFont: .body,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $akudama.screenCount1,
//                        bigNumber: $akudama.screenCountSum,
//                        setting1Percent: akudama.ratioScreen1[0],
//                        setting2Percent: akudama.ratioScreen1[1],
//                        setting3Percent: akudama.ratioScreen1[2],
//                        setting4Percent: akudama.ratioScreen1[3],
//                        setting5Percent: akudama.ratioScreen1[4],
//                        setting6Percent: akudama.ratioScreen1[5]
//                    )
//                )
//            )
//            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: akudama.machineName,
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
    akudamaView95Ci(
        akudama: Akudama(),
    )
}
