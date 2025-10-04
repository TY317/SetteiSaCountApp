//
//  creaView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/24.
//

import SwiftUI

struct creaView95Ci: View {
    @ObservedObject var crea: Crea
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // ベル回数
            unitListSection95Ci(
                grafTitle: "🔔回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $crea.koyakuCountBell,
                        bigNumber: $crea.gameNumberPlay,
                        setting1Denominate: crea.ratioKoyakuBell[0],
                        setting2Denominate: crea.ratioKoyakuBell[1],
                        setting3Denominate: crea.ratioKoyakuBell[2],
                        setting4Denominate: crea.ratioKoyakuBell[3],
                        setting5Denominate: crea.ratioKoyakuBell[4],
                        setting6Denominate: crea.ratioKoyakuBell[5]
                    )
                )
            )
            .tag(1)
            // チェリー回数
            unitListSection95Ci(
                grafTitle: "🍒回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $crea.koyakuCountCherry,
                        bigNumber: $crea.gameNumberPlay,
                        setting1Denominate: crea.ratioKoyakuCherry[0],
                        setting2Denominate: crea.ratioKoyakuCherry[1],
                        setting3Denominate: crea.ratioKoyakuCherry[2],
                        setting4Denominate: crea.ratioKoyakuCherry[3],
                        setting5Denominate: crea.ratioKoyakuCherry[4],
                        setting6Denominate: crea.ratioKoyakuCherry[5]
                    )
                )
            )
            .tag(2)
            // スイカ回数
            unitListSection95Ci(
                grafTitle: "🍉回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $crea.koyakuCountSuika,
                        bigNumber: $crea.gameNumberPlay,
                        setting1Denominate: crea.ratioKoyakuSuika[0],
                        setting2Denominate: crea.ratioKoyakuSuika[1],
                        setting3Denominate: crea.ratioKoyakuSuika[2],
                        setting4Denominate: crea.ratioKoyakuSuika[3],
                        setting5Denominate: crea.ratioKoyakuSuika[4],
                        setting6Denominate: crea.ratioKoyakuSuika[5]
                    )
                )
            )
            .tag(3)
            // チャンス目回数
            unitListSection95Ci(
                grafTitle: "チャンス目回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $crea.koyakuCountChance,
                        bigNumber: $crea.gameNumberPlay,
                        setting1Denominate: crea.ratioKoyakuChance[0],
                        setting2Denominate: crea.ratioKoyakuChance[1],
                        setting3Denominate: crea.ratioKoyakuChance[2],
                        setting4Denominate: crea.ratioKoyakuChance[3],
                        setting5Denominate: crea.ratioKoyakuChance[4],
                        setting6Denominate: crea.ratioKoyakuChance[5]
                    )
                )
            )
            .tag(4)
            // BIG回数
            unitListSection95Ci(
                grafTitle: "BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $crea.bonusCountBig,
                        bigNumber: $crea.gameNumberCurrent,
                        setting1Denominate: crea.ratioBonusBig[0],
                        setting2Denominate: crea.ratioBonusBig[1],
                        setting3Denominate: crea.ratioBonusBig[2],
                        setting4Denominate: crea.ratioBonusBig[3],
                        setting5Denominate: crea.ratioBonusBig[4],
                        setting6Denominate: crea.ratioBonusBig[5]
                    )
                )
            )
            .tag(5)
            // REG回数
            unitListSection95Ci(
                grafTitle: "REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $crea.bonusCountReg,
                        bigNumber: $crea.gameNumberCurrent,
                        setting1Denominate: crea.ratioBonusReg[0],
                        setting2Denominate: crea.ratioBonusReg[1],
                        setting3Denominate: crea.ratioBonusReg[2],
                        setting4Denominate: crea.ratioBonusReg[3],
                        setting5Denominate: crea.ratioBonusReg[4],
                        setting6Denominate: crea.ratioBonusReg[5]
                    )
                )
            )
            .tag(6)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: crea.machineName,
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
    creaView95Ci(
        crea: Crea(),
    )
}
