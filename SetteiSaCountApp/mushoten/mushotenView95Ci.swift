//
//  mushotenView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/03.
//

import SwiftUI

struct mushotenView95Ci: View {
    @ObservedObject var mushoten: Mushoten
    @State var selection = 1
    @State var isShow95CiExplain = false
    var body: some View {
        TabView(selection: self.$selection) {
            // ヒトガミの空間 当選回数
            unitListSection95Ci(
                grafTitle: "ヒトガミの空間 当選回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $mushoten.hitogamiCountHit,
                        bigNumber: $mushoten.hitogamiCountMove,
                        setting1Percent: mushoten.ratioHitogamiHit[0],
                        setting2Percent: mushoten.ratioHitogamiHit[1],
                        setting3Percent: mushoten.ratioHitogamiHit[2],
                        setting4Percent: mushoten.ratioHitogamiHit[3],
                        setting5Percent: mushoten.ratioHitogamiHit[4],
                        setting6Percent: mushoten.ratioHitogamiHit[5]
                    )
                )
            )
            .tag(1)
            
            // CZ回数
            unitListSection95Ci(
                grafTitle: "CZ回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $mushoten.czCount,
                        bigNumber: $mushoten.gameNumberPlay,
                        setting1Denominate: mushoten.ratioCz[0],
                        setting2Denominate: mushoten.ratioCz[1],
                        setting3Denominate: mushoten.ratioCz[2],
                        setting4Denominate: mushoten.ratioCz[3],
                        setting5Denominate: mushoten.ratioCz[4],
                        setting6Denominate: mushoten.ratioCz[5]
                    )
                )
            )
            .tag(2)
            
            // ボーナス回数
            unitListSection95Ci(
                grafTitle: "ボーナス初当り回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $mushoten.firstHitCountBonusSum,
                        bigNumber: $mushoten.normalGame,
                        setting1Denominate: mushoten.ratioFirstHitBonusSum[0],
                        setting2Denominate: mushoten.ratioFirstHitBonusSum[1],
                        setting3Denominate: mushoten.ratioFirstHitBonusSum[2],
                        setting4Denominate: mushoten.ratioFirstHitBonusSum[3],
                        setting5Denominate: mushoten.ratioFirstHitBonusSum[4],
                        setting6Denominate: mushoten.ratioFirstHitBonusSum[5]
                    )
                )
            )
            .tag(3)
            
            // AT回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $mushoten.firstHitCountAt,
                        bigNumber: $mushoten.normalGame,
                        setting1Denominate: mushoten.ratioFirstHitAt[0],
                        setting2Denominate: mushoten.ratioFirstHitAt[1],
                        setting3Denominate: mushoten.ratioFirstHitAt[2],
                        setting4Denominate: mushoten.ratioFirstHitAt[3],
                        setting5Denominate: mushoten.ratioFirstHitAt[4],
                        setting6Denominate: mushoten.ratioFirstHitAt[5]
                    )
                )
            )
            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: mushoten.machineName,
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
    mushotenView95Ci(
        mushoten: Mushoten(),
    )
}
