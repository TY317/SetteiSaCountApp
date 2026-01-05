//
//  shakeView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/05.
//

import SwiftUI

struct shakeView95Ci: View {
    @ObservedObject var shake: Shake
    @State var selection = 1
    @State var isShow95CiExplain = false
    var body: some View {
        TabView(selection: self.$selection) {
            // ベル回数
            unitListSection95Ci(
                grafTitle: "🔔回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $shake.koyakuCountBell,
                        bigNumber: $shake.gameNumberPlay,
                        setting1Denominate: shake.ratioKoyakuBell[0],
                        setting2Denominate: shake.ratioKoyakuBell[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: shake.ratioKoyakuBell[2],
                        setting6Denominate: shake.ratioKoyakuBell[3]
                    )
                )
            )
            .tag(1)
            
            // チェリー回数
            unitListSection95Ci(
                grafTitle: "🍒回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $shake.koyakuCountCherry,
                        bigNumber: $shake.gameNumberPlay,
                        setting1Denominate: shake.ratioKoyakuCherry[0],
                        setting2Denominate: shake.ratioKoyakuCherry[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: shake.ratioKoyakuCherry[2],
                        setting6Denominate: shake.ratioKoyakuCherry[3]
                    )
                )
            )
            .tag(2)
            
            // スイカ回数
            unitListSection95Ci(
                grafTitle: "🍉回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $shake.koyakuCountSuika,
                        bigNumber: $shake.gameNumberPlay,
                        setting1Denominate: shake.ratioKoyakuSuika[0],
                        setting2Denominate: shake.ratioKoyakuSuika[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: shake.ratioKoyakuSuika[2],
                        setting6Denominate: shake.ratioKoyakuSuika[3]
                    )
                )
            )
            .tag(3)
            
            // BIG回数
            unitListSection95Ci(
                grafTitle: "BIG回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $shake.bonusCountBig,
                        bigNumber: $shake.normalGame,
                        setting1Denominate: shake.ratioBonusBig[0],
                        setting2Denominate: shake.ratioBonusBig[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: shake.ratioBonusBig[2],
                        setting6Denominate: shake.ratioBonusBig[3]
                    )
                )
            )
            .tag(4)
            
            // REG回数
            unitListSection95Ci(
                grafTitle: "REG回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $shake.bonusCountReg,
                        bigNumber: $shake.normalGame,
                        setting1Denominate: shake.ratioBonusReg[0],
                        setting2Denominate: shake.ratioBonusReg[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: shake.ratioBonusReg[2],
                        setting6Denominate: shake.ratioBonusReg[3]
                    )
                )
            )
            .tag(5)
            
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "ボーナス合算回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $shake.bonusCountSum,
                        bigNumber: $shake.normalGame,
                        setting1Denominate: shake.ratioBonusSum[0],
                        setting2Denominate: shake.ratioBonusSum[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: shake.ratioBonusSum[2],
                        setting6Denominate: shake.ratioBonusSum[3]
                    )
                )
            )
            .tag(6)
            
            // スイカ＋ナディア回数
            unitListSection95Ci(
                grafTitle: "🍉＋ナディアBIG回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $shake.idenBonusCountSuika,
                        bigNumber: $shake.gameNumberPlay,
                        setting1Denominate: shake.ratioIdenBonusSuika[0],
                        setting2Denominate: shake.ratioIdenBonusSuika[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: shake.ratioIdenBonusSuika[2],
                        setting6Denominate: shake.ratioIdenBonusSuika[3]
                    )
                )
            )
            .tag(7)
            
            // ベル＋REG回数
            unitListSection95Ci(
                grafTitle: "🔔＋REG回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $shake.idenBonusCountBell,
                        bigNumber: $shake.gameNumberPlay,
                        setting1Denominate: shake.ratioIdenBonusBell[0],
                        setting2Denominate: shake.ratioIdenBonusBell[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: shake.ratioIdenBonusBell[2],
                        setting6Denominate: shake.ratioIdenBonusBell[3]
                    )
                )
            )
            .tag(8)
            
            // 特殊役I＋ボーナス回数
            unitListSection95Ci(
                grafTitle: "特殊役I＋ボーナス回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $shake.idenBonusCountSpecialI,
                        bigNumber: $shake.gameNumberPlay,
                        setting1Denominate: shake.ratioIdenBonusSpecialI[0],
                        setting2Denominate: shake.ratioIdenBonusSpecialI[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: shake.ratioIdenBonusSpecialI[2],
                        setting6Denominate: shake.ratioIdenBonusSpecialI[3]
                    )
                )
            )
            .tag(9)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: shake.machineName,
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
    shakeView95Ci(
        shake: Shake(),
    )
}
