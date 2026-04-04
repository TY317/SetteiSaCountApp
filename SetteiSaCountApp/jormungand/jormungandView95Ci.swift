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
            // ボーナス初当り回数
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
//            // 炎炎ボーナス後終了画面デフォルト回数
//            unitListSection95Ci(
//                grafTitle: "炎炎ボーナス後\n終了画面 デフォルト回数",
//                titleFont: .body,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $jormungand.screenCountBig1,
//                        bigNumber: $jormungand.screenCountBigSum,
//                        setting1Percent: jormungand.ratioScreenBig1[0],
//                        setting2Percent: jormungand.ratioScreenBig1[1],
//                        setting3Percent: jormungand.ratioScreenBig1[2],
//                        setting4Percent: jormungand.ratioScreenBig1[3],
//                        setting5Percent: jormungand.ratioScreenBig1[4],
//                        setting6Percent: jormungand.ratioScreenBig1[5]
//                    )
//                )
//            )
//            .tag(3)
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
