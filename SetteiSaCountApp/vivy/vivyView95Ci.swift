//
//  vivyView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct vivyView95Ci: View {
    @ObservedObject var vivy: Vivy
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // アクセルチャンス昇格 1回目
            unitListSection95Ci(
                grafTitle: "アクセルチャンス昇格\n1回目",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $vivy.accelPromoteCountHit1,
                        bigNumber: $vivy.accelPromoteCountSum1,
                        setting1Percent: vivy.ratioAccelPromote[0][0],
                        setting2Percent: vivy.ratioAccelPromote[0][1],
                        setting3Percent: vivy.ratioAccelPromote[0][2],
                        setting4Percent: vivy.ratioAccelPromote[0][3],
                        setting5Percent: vivy.ratioAccelPromote[0][4],
                        setting6Percent: vivy.ratioAccelPromote[0][5]
                    )
                )
            )
            .tag(1)

            // アクセルチャンス昇格 2回目
            unitListSection95Ci(
                grafTitle: "アクセルチャンス昇格\n2回目",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $vivy.accelPromoteCountHit2,
                        bigNumber: $vivy.accelPromoteCountSum2,
                        setting1Percent: vivy.ratioAccelPromote[1][0],
                        setting2Percent: vivy.ratioAccelPromote[1][1],
                        setting3Percent: vivy.ratioAccelPromote[1][2],
                        setting4Percent: vivy.ratioAccelPromote[1][3],
                        setting5Percent: vivy.ratioAccelPromote[1][4],
                        setting6Percent: vivy.ratioAccelPromote[1][5]
                    )
                )
            )
            .tag(2)

            // アクセルチャンス昇格 3回目
            unitListSection95Ci(
                grafTitle: "アクセルチャンス昇格\n3回目",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $vivy.accelPromoteCountHit3,
                        bigNumber: $vivy.accelPromoteCountSum3,
                        setting1Percent: vivy.ratioAccelPromote[2][0],
                        setting2Percent: vivy.ratioAccelPromote[2][1],
                        setting3Percent: vivy.ratioAccelPromote[2][2],
                        setting4Percent: vivy.ratioAccelPromote[2][3],
                        setting5Percent: vivy.ratioAccelPromote[2][4],
                        setting6Percent: vivy.ratioAccelPromote[2][5]
                    )
                )
            )
            .tag(3)

            // アクセルチャンス昇格 4回目
            unitListSection95Ci(
                grafTitle: "アクセルチャンス昇格\n4回目",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $vivy.accelPromoteCountHit4,
                        bigNumber: $vivy.accelPromoteCountSum4,
                        setting1Percent: vivy.ratioAccelPromote[3][0],
                        setting2Percent: vivy.ratioAccelPromote[3][1],
                        setting3Percent: vivy.ratioAccelPromote[3][2],
                        setting4Percent: vivy.ratioAccelPromote[3][3],
                        setting5Percent: vivy.ratioAccelPromote[3][4],
                        setting6Percent: vivy.ratioAccelPromote[3][5]
                    )
                )
            )
            .tag(4)

            // 回数
//            unitListSection95Ci(
//                grafTitle: "回数",
//                titleFont: .title2,
//                grafView: AnyView(
//                    unitChart95CiPercent(
//                        currentCount: $vivy.otomeAttackHit,
//                        bigNumber: $vivy.otomeAttackSum,
//                        setting1Percent: vivy.ratioOtomeAttack[0],
//                        setting2Percent: vivy.ratioOtomeAttack[1],
//                        setting3Percent: vivy.ratioOtomeAttack[2],
//                        setting4Percent: vivy.ratioOtomeAttack[3],
//                        setting5Percent: vivy.ratioOtomeAttack[4],
//                        setting6Percent: vivy.ratioOtomeAttack[5]
//                    )
//                )
//            )
//            .tag(1)
//
//            // CZ初当り回数
//            unitListSection95Ci(
//                grafTitle: "CZ初当り回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $vivy.firstHitCountCz,
//                        bigNumber: $vivy.normalGame,
//                        setting1Denominate: vivy.ratioFirstHitCz[0],
//                        setting2Denominate: vivy.ratioFirstHitCz[1],
//                        setting3Denominate: vivy.ratioFirstHitCz[2],
//                        setting4Denominate: vivy.ratioFirstHitCz[3],
//                        setting5Denominate: vivy.ratioFirstHitCz[4],
//                        setting6Denominate: vivy.ratioFirstHitCz[5]
//                    )
//                )
//            )
//            .tag(2)
//
//            // AT初当り回数
//            unitListSection95Ci(
//                grafTitle: "AT初当り回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $vivy.firstHitCountAt,
//                        bigNumber: $vivy.normalGame,
//                        setting1Denominate: vivy.ratioFirstHitAt[0],
//                        setting2Denominate: vivy.ratioFirstHitAt[1],
//                        setting3Denominate: vivy.ratioFirstHitAt[2],
//                        setting4Denominate: vivy.ratioFirstHitAt[3],
//                        setting5Denominate: vivy.ratioFirstHitAt[4],
//                        setting6Denominate: vivy.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: vivy.machineName,
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
    vivyView95Ci(
        vivy: Vivy(),
    )
}
