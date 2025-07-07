//
//  kaguyaView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/25.
//

import SwiftUI

struct kaguyaView95Ci: View {
//    @ObservedObject var kaguya = KaguyaSama()
    @ObservedObject var kaguya: KaguyaSama
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // REG中のキャラ紹介デフォルト回数
            unitListSection95Ci(
                grafTitle: "REG中のキャラ紹介\nデフォルト回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kaguya.regCharaCountDefault,
                        bigNumber: $kaguya.regCharaCountSum,
                        setting1Percent: 61,
                        setting2Percent: 56,
                        setting3Percent: 56,
                        setting4Percent: 46,
                        setting5Percent: 46,
                        setting6Percent: 46
                    )
                )
            )
            .tag(1)
            // ボーナス終了画面デフォルト回数
            unitListSection95Ci(
                grafTitle: "ボーナス終了画面\nデフォルト回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kaguya.screenCountDefault,
                        bigNumber: $kaguya.screenCountSum,
                        setting1Percent: 96,
                        setting2Percent: 92,
                        setting3Percent: 92,
                        setting4Percent: 90,
                        setting5Percent: 90,
                        setting6Percent: 89
                    )
                )
            )
            .tag(2)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "かぐや様は告らせたい",
                screenClass: screenClass
            )
        }
        .navigationTitle("95%信頼区間グラフ")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButton95CiExplain(isShow95CiExplain: isShow95CiExplain)
//                    .popoverTip(tipUnitButton95CiExplain())
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    kaguyaView95Ci(kaguya: KaguyaSama())
}
