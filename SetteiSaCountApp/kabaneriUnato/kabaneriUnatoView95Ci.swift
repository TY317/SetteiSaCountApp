//
//  kabaneriUnatoView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/02.
//

import SwiftUI

struct kabaneriUnatoView95Ci: View {
    @ObservedObject var kabaneriUnato: KabaneriUnato
    @State var selection = 1
    @State var isShow95CiExplain = false
    var body: some View {
        TabView(selection: self.$selection) {
//            // 300or500G到達時のCZ当選回数
//            unitListSection95Ci(
//                grafTitle: "300・500G到達時\nCZ当選回数",
//                titleFont: .title2,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $kabaneriUnato.game35HitCountHit,
//                        bigNumber: $kabaneriUnato.game35HitCountSum,
//                        setting1Percent: kabaneriUnato.ratio35Hit[0],
//                        setting2Percent: kabaneriUnato.ratio35Hit[1],
//                        setting3Percent: kabaneriUnato.ratio35Hit[2],
//                        setting4Percent: kabaneriUnato.ratio35Hit[3],
//                        setting5Percent: kabaneriUnato.ratio35Hit[4],
//                        setting6Percent: kabaneriUnato.ratio35Hit[5]
//                    )
//                )
//            )
//            .tag(2)
//
            // CZ初当り回数
            unitListSection95Ci(
                grafTitle: "下段ベル回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kabaneriUnato.koyakuCountLowerBell,
                        bigNumber: $kabaneriUnato.normalGame,
                        setting1Denominate: kabaneriUnato.ratioLowerBell[0],
                        setting2Denominate: kabaneriUnato.ratioLowerBell[1],
                        setting3Denominate: kabaneriUnato.ratioLowerBell[2],
                        setting4Denominate: kabaneriUnato.ratioLowerBell[3],
                        setting5Denominate: kabaneriUnato.ratioLowerBell[4],
                        setting6Denominate: kabaneriUnato.ratioLowerBell[5]
                    )
                )
            )
            .tag(1)
//            // AT初当り回数
//            unitListSection95Ci(
//                grafTitle: "AT初当り回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $kabaneriUnato.atCount,
//                        bigNumber: $kabaneriUnato.normalGame,
//                        setting1Denominate: kabaneriUnato.ratioFirstHitAt[0],
//                        setting2Denominate: kabaneriUnato.ratioFirstHitAt[1],
//                        setting3Denominate: kabaneriUnato.ratioFirstHitAt[2],
//                        setting4Denominate: kabaneriUnato.ratioFirstHitAt[3],
//                        setting5Denominate: kabaneriUnato.ratioFirstHitAt[4],
//                        setting6Denominate: kabaneriUnato.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(5)
//
            // 早じろ単チャンス目 3000pt回数
            unitListSection95Ci(
                grafTitle: "駿城ボーナス\n単チャンス目 3000pt回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kabaneriUnato.hayajiroCountHit,
                        bigNumber: $kabaneriUnato.hayajiroCountSum,
                        setting1Percent: kabaneriUnato.ratioHayajiro3000[0],
                        setting2Percent: kabaneriUnato.ratioHayajiro3000[1],
                        setting3Percent: kabaneriUnato.ratioHayajiro3000[2],
                        setting4Percent: kabaneriUnato.ratioHayajiro3000[3],
                        setting5Percent: kabaneriUnato.ratioHayajiro3000[4],
                        setting6Percent: kabaneriUnato.ratioHayajiro3000[5]
                    )
                )
            )
            .tag(2)
            
            // キャラ紹介
            unitListSection95Ci(
                grafTitle: "キャラ紹介\n偶数示唆回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kabaneriUnato.charaCountGusu,
                        bigNumber: $kabaneriUnato.charaCountSum,
                        setting1Percent: kabaneriUnato.ratioCharaWomen[0],
                        setting2Percent: kabaneriUnato.ratioCharaWomen[1],
                        setting3Percent: kabaneriUnato.ratioCharaWomen[2],
                        setting4Percent: kabaneriUnato.ratioCharaWomen[3],
                        setting5Percent: kabaneriUnato.ratioCharaWomen[4],
                        setting6Percent: kabaneriUnato.ratioCharaWomen[5]
                    )
                )
            )
            .tag(3)
            
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kabaneriUnato.machineName,
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
    kabaneriUnatoView95Ci(
        kabaneriUnato: KabaneriUnato(),
    )
}
