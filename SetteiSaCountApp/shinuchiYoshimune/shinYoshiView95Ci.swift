//
//  shinYoshiView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/29.
//

import SwiftUI

struct shinYoshiView95Ci: View {
    @ObservedObject var shinYoshi: ShinYoshi
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // ボーナス初当り回数
            unitListSection95Ci(
                grafTitle: "ボーナス初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $shinYoshi.firstHitCountAt,
                        bigNumber: $shinYoshi.normalGame,
                        setting1Denominate: shinYoshi.ratioFirstHitAt[0],
                        setting2Denominate: shinYoshi.ratioFirstHitAt[1],
                        setting3Denominate: shinYoshi.ratioFirstHitAt[2],
                        setting4Denominate: shinYoshi.ratioFirstHitAt[3],
                        setting5Denominate: shinYoshi.ratioFirstHitAt[4],
                        setting6Denominate: shinYoshi.ratioFirstHitAt[5]
                    )
                )
            )
            .tag(1)
            
//            // 炎炎ループ初当り回数
//            unitListSection95Ci(
//                grafTitle: "炎炎ループ初当り回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $shinYoshi.firstHitCountLoop,
//                        bigNumber: $shinYoshi.normalGame,
//                        setting1Denominate: shinYoshi.ratioFirstHitLoop[0],
//                        setting2Denominate: shinYoshi.ratioFirstHitLoop[1],
//                        setting3Denominate: shinYoshi.ratioFirstHitLoop[2],
//                        setting4Denominate: shinYoshi.ratioFirstHitLoop[3],
//                        setting5Denominate: shinYoshi.ratioFirstHitLoop[4],
//                        setting6Denominate: shinYoshi.ratioFirstHitLoop[5]
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
//                        currentCount: $shinYoshi.screenCountBig1,
//                        bigNumber: $shinYoshi.screenCountBigSum,
//                        setting1Percent: shinYoshi.ratioScreenBig1[0],
//                        setting2Percent: shinYoshi.ratioScreenBig1[1],
//                        setting3Percent: shinYoshi.ratioScreenBig1[2],
//                        setting4Percent: shinYoshi.ratioScreenBig1[3],
//                        setting5Percent: shinYoshi.ratioScreenBig1[4],
//                        setting6Percent: shinYoshi.ratioScreenBig1[5]
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
//                        currentCount: $shinYoshi.screenCount1,
//                        bigNumber: $shinYoshi.screenCountSum,
//                        setting1Percent: shinYoshi.ratioScreen1[0],
//                        setting2Percent: shinYoshi.ratioScreen1[1],
//                        setting3Percent: shinYoshi.ratioScreen1[2],
//                        setting4Percent: shinYoshi.ratioScreen1[3],
//                        setting5Percent: shinYoshi.ratioScreen1[4],
//                        setting6Percent: shinYoshi.ratioScreen1[5]
//                    )
//                )
//            )
//            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: shinYoshi.machineName,
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
    shinYoshiView95Ci(
        shinYoshi: ShinYoshi(),
    )
}
