//
//  bioRe3View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/03.
//

import SwiftUI

struct bioRe3View95Ci: View {
    @ObservedObject var bioRe3: BioRe3
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
//            // 規定リプレイ到達からのハワードゲーム当選
//            unitListSection95Ci(
//                grafTitle: "規定リプレイ到達\nハワードゲーム当選回数",
//                titleFont: .title3,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $bioRe3.kiteiReplayHit,
//                        bigNumber: $bioRe3.kiteiReplay,
//                        setting1Percent: bioRe3.ratioKiteiReplayHit[0],
//                        setting2Percent: bioRe3.ratioKiteiReplayHit[1],
//                        setting3Percent: bioRe3.ratioKiteiReplayHit[2],
//                        setting4Percent: bioRe3.ratioKiteiReplayHit[3],
//                        setting5Percent: bioRe3.ratioKiteiReplayHit[4],
//                        setting6Percent: bioRe3.ratioKiteiReplayHit[5]
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
//                        currentCount: $bioRe3.tenjoCountHit,
//                        bigNumber: $bioRe3.tenjoCountSum,
//                        setting1Percent: bioRe3.ratioTenjoCut[0],
//                        setting2Percent: bioRe3.ratioTenjoCut[1],
//                        setting3Percent: bioRe3.ratioTenjoCut[2],
//                        setting4Percent: bioRe3.ratioTenjoCut[3],
//                        setting5Percent: bioRe3.ratioTenjoCut[4],
//                        setting6Percent: bioRe3.ratioTenjoCut[5]
//                    )
//                )
//            )
//            .tag(5)
//
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
//                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $bioRe3.firstHitCountAt,
                        bigNumber: $bioRe3.normalGame,
                        setting1Denominate: bioRe3.ratioFirstHitAt[0],
                        setting2Denominate: bioRe3.ratioFirstHitAt[1],
                        setting3Denominate: bioRe3.ratioFirstHitAt[2],
                        setting4Denominate: bioRe3.ratioFirstHitAt[3],
                        setting5Denominate: bioRe3.ratioFirstHitAt[4],
                        setting6Denominate: bioRe3.ratioFirstHitAt[5]
                    )
                )
            )
            .tag(1)
            
//            // 直撃ボーナス以外 初当り回数
//            unitListSection95Ci(
//                grafTitle: "直撃ボーナス以外 初当り回数",
//                titleFont: .title2,
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $bioRe3.firstHitCountWithoutDirect,
//                        bigNumber: $bioRe3.normalGame,
//                        setting1Denominate: bioRe3.ratioFirstHitWithoutDirect[0],
//                        setting2Denominate: bioRe3.ratioFirstHitWithoutDirect[1],
//                        setting3Denominate: bioRe3.ratioFirstHitWithoutDirect[2],
//                        setting4Denominate: bioRe3.ratioFirstHitWithoutDirect[3],
//                        setting5Denominate: bioRe3.ratioFirstHitWithoutDirect[4],
//                        setting6Denominate: bioRe3.ratioFirstHitWithoutDirect[5]
//                    )
//                )
//            )
//            .tag(2)
//            
//            // 直撃ボーナス初当り回数
//            unitListSection95Ci(
//                grafTitle: "直撃ボーナス初当り回数",
//                titleFont: .title2,
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $bioRe3.firstHitCountDirectBonus,
//                        bigNumber: $bioRe3.normalGame,
//                        setting1Denominate: bioRe3.ratioFirstHitDirectBonus[0],
//                        setting2Denominate: bioRe3.ratioFirstHitDirectBonus[1],
//                        setting3Denominate: bioRe3.ratioFirstHitDirectBonus[2],
//                        setting4Denominate: bioRe3.ratioFirstHitDirectBonus[3],
//                        setting5Denominate: bioRe3.ratioFirstHitDirectBonus[4],
//                        setting6Denominate: bioRe3.ratioFirstHitDirectBonus[5]
//                    )
//                )
//            )
//            .tag(3)
//
//
//            // REG,後終了画面デフォルト回数
//            unitListSection95Ci(
//                grafTitle: "REG,アクセルボーナス,灰焔ボーナス後\n終了画面 デフォルト回数",
//                titleFont: .body,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $bioRe3.screenCount1,
//                        bigNumber: $bioRe3.screenCountSum,
//                        setting1Percent: bioRe3.ratioScreen1[0],
//                        setting2Percent: bioRe3.ratioScreen1[1],
//                        setting3Percent: bioRe3.ratioScreen1[2],
//                        setting4Percent: bioRe3.ratioScreen1[3],
//                        setting5Percent: bioRe3.ratioScreen1[4],
//                        setting6Percent: bioRe3.ratioScreen1[5]
//                    )
//                )
//            )
//            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: bioRe3.machineName,
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
    bioRe3View95Ci(
        bioRe3: BioRe3(),
    )
}
