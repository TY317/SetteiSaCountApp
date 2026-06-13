//
//  rioAceView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/03.
//

import SwiftUI

struct rioAceView95Ci: View {
    @ObservedObject var rioAce: RioAce
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // 規定リプレイ到達からのハワードゲーム当選
            unitListSection95Ci(
                grafTitle: "規定リプレイ到達\nハワードゲーム当選回数",
                titleFont: .title3,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $rioAce.kiteiReplayHit,
                        bigNumber: $rioAce.kiteiReplay,
                        setting1Percent: rioAce.ratioKiteiReplayHit[0],
                        setting2Percent: rioAce.ratioKiteiReplayHit[1],
                        setting3Percent: rioAce.ratioKiteiReplayHit[2],
                        setting4Percent: rioAce.ratioKiteiReplayHit[3],
                        setting5Percent: rioAce.ratioKiteiReplayHit[4],
                        setting6Percent: rioAce.ratioKiteiReplayHit[5]
                    )
                )
            )
            .tag(4)

            // エースモード突入回数
            unitListSection95Ci(
                grafTitle: "エースモード突入回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $rioAce.aceModeCountHit,
                        bigNumber: $rioAce.aceModeCountSum,
                        setting1Percent: rioAce.ratioAceMode[0],
                        setting2Percent: rioAce.ratioAceMode[1],
                        setting3Percent: rioAce.ratioAceMode[2],
                        setting4Percent: rioAce.ratioAceMode[3],
                        setting5Percent: rioAce.ratioAceMode[4],
                        setting6Percent: rioAce.ratioAceMode[5]
                    )
                )
            )
            .tag(5)

            // ノワールルーム初当り回数
            unitListSection95Ci(
                grafTitle: "ノワールルーム初当り回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $rioAce.firstHitCountNoirRoom,
                        bigNumber: $rioAce.normalGame,
                        setting1Denominate: rioAce.ratioFirstHitNoirRoom[0],
                        setting2Denominate: rioAce.ratioFirstHitNoirRoom[1],
                        setting3Denominate: rioAce.ratioFirstHitNoirRoom[2],
                        setting4Denominate: rioAce.ratioFirstHitNoirRoom[3],
                        setting5Denominate: rioAce.ratioFirstHitNoirRoom[4],
                        setting6Denominate: rioAce.ratioFirstHitNoirRoom[5]
                    )
                )
            )
            .tag(1)
            
            // 直撃ボーナス以外 初当り回数
            unitListSection95Ci(
                grafTitle: "直撃ボーナス以外 初当り回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $rioAce.firstHitCountWithoutDirect,
                        bigNumber: $rioAce.normalGame,
                        setting1Denominate: rioAce.ratioFirstHitWithoutDirect[0],
                        setting2Denominate: rioAce.ratioFirstHitWithoutDirect[1],
                        setting3Denominate: rioAce.ratioFirstHitWithoutDirect[2],
                        setting4Denominate: rioAce.ratioFirstHitWithoutDirect[3],
                        setting5Denominate: rioAce.ratioFirstHitWithoutDirect[4],
                        setting6Denominate: rioAce.ratioFirstHitWithoutDirect[5]
                    )
                )
            )
            .tag(2)
            
            // 直撃ボーナス初当り回数
            unitListSection95Ci(
                grafTitle: "直撃ボーナス初当り回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $rioAce.firstHitCountDirectBonus,
                        bigNumber: $rioAce.normalGame,
                        setting1Denominate: rioAce.ratioFirstHitDirectBonus[0],
                        setting2Denominate: rioAce.ratioFirstHitDirectBonus[1],
                        setting3Denominate: rioAce.ratioFirstHitDirectBonus[2],
                        setting4Denominate: rioAce.ratioFirstHitDirectBonus[3],
                        setting5Denominate: rioAce.ratioFirstHitDirectBonus[4],
                        setting6Denominate: rioAce.ratioFirstHitDirectBonus[5]
                    )
                )
            )
            .tag(3)
//
//
//            // REG,後終了画面デフォルト回数
//            unitListSection95Ci(
//                grafTitle: "REG,アクセルボーナス,灰焔ボーナス後\n終了画面 デフォルト回数",
//                titleFont: .body,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $rioAce.screenCount1,
//                        bigNumber: $rioAce.screenCountSum,
//                        setting1Percent: rioAce.ratioScreen1[0],
//                        setting2Percent: rioAce.ratioScreen1[1],
//                        setting3Percent: rioAce.ratioScreen1[2],
//                        setting4Percent: rioAce.ratioScreen1[3],
//                        setting5Percent: rioAce.ratioScreen1[4],
//                        setting6Percent: rioAce.ratioScreen1[5]
//                    )
//                )
//            )
//            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: rioAce.machineName,
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
    rioAceView95Ci(
        rioAce: RioAce(),
    )
}
