//
//  takosloView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct takosloView95Ci: View {
    @ObservedObject var takoslo: Takoslo
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // プラム回数
            unitListSection95Ci(
                grafTitle: "プラム回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $takoslo.koyakuCountPlum,
                        bigNumber: $takoslo.gameNumberPlay,
                        setting1Denominate: takoslo.ratioKoyakuPlum[0],
                        setting2Denominate: takoslo.ratioKoyakuPlum[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: takoslo.ratioKoyakuPlum[2],
                        setting6Denominate: takoslo.ratioKoyakuPlum[3]
                    )
                )
            )
            .tag(1)

            // スイカ回数
            unitListSection95Ci(
                grafTitle: "スイカ回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $takoslo.koyakuCountSuika,
                        bigNumber: $takoslo.gameNumberPlay,
                        setting1Denominate: takoslo.ratioKoyakuSuika[0],
                        setting2Denominate: takoslo.ratioKoyakuSuika[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: takoslo.ratioKoyakuSuika[2],
                        setting6Denominate: takoslo.ratioKoyakuSuika[3]
                    )
                )
            )
            .tag(2)

            // チェリー回数
            unitListSection95Ci(
                grafTitle: "チェリー回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $takoslo.koyakuCountCherry,
                        bigNumber: $takoslo.gameNumberPlay,
                        setting1Denominate: takoslo.ratioKoyakuCherry[0],
                        setting2Denominate: takoslo.ratioKoyakuCherry[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: takoslo.ratioKoyakuCherry[2],
                        setting6Denominate: takoslo.ratioKoyakuCherry[3]
                    )
                )
            )
            .tag(3)

            // スイカA回数
            unitListSection95Ci(
                grafTitle: "スイカA回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $takoslo.koyakuDetailCountSuikaA,
                        bigNumber: $takoslo.gameNumberPlay,
                        setting1Denominate: takoslo.ratioKoyakuDetailSuikaA[0],
                        setting2Denominate: takoslo.ratioKoyakuDetailSuikaA[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: takoslo.ratioKoyakuDetailSuikaA[2],
                        setting6Denominate: takoslo.ratioKoyakuDetailSuikaA[3]
                    )
                )
            )
            .tag(4)

            // スイカB回数
            unitListSection95Ci(
                grafTitle: "スイカB回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $takoslo.koyakuDetailCountSuikaB,
                        bigNumber: $takoslo.gameNumberPlay,
                        setting1Denominate: takoslo.ratioKoyakuDetailSuikaB[0],
                        setting2Denominate: takoslo.ratioKoyakuDetailSuikaB[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: takoslo.ratioKoyakuDetailSuikaB[2],
                        setting6Denominate: takoslo.ratioKoyakuDetailSuikaB[3]
                    )
                )
            )
            .tag(5)

            // チェリーB回数
            unitListSection95Ci(
                grafTitle: "チェリーB回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $takoslo.koyakuDetailCountCherryB,
                        bigNumber: $takoslo.gameNumberPlay,
                        setting1Denominate: takoslo.ratioKoyakuDetailCherryB[0],
                        setting2Denominate: takoslo.ratioKoyakuDetailCherryB[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: takoslo.ratioKoyakuDetailCherryB[2],
                        setting6Denominate: takoslo.ratioKoyakuDetailCherryB[3]
                    )
                )
            )
            .tag(6)

            // チェリーC回数
            unitListSection95Ci(
                grafTitle: "チェリーC回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $takoslo.koyakuDetailCountCherryC,
                        bigNumber: $takoslo.gameNumberPlay,
                        setting1Denominate: takoslo.ratioKoyakuDetailCherryC[0],
                        setting2Denominate: takoslo.ratioKoyakuDetailCherryC[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: takoslo.ratioKoyakuDetailCherryC[2],
                        setting6Denominate: takoslo.ratioKoyakuDetailCherryC[3]
                    )
                )
            )
            .tag(7)

            // BIG初当り回数
            unitListSection95Ci(
                grafTitle: "BIG初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $takoslo.firstHitCountBig,
                        bigNumber: $takoslo.normalGame,
                        setting1Denominate: takoslo.ratioFirstHitBig[0],
                        setting2Denominate: takoslo.ratioFirstHitBig[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: takoslo.ratioFirstHitBig[2],
                        setting6Denominate: takoslo.ratioFirstHitBig[3]
                    )
                )
            )
            .tag(8)

            // REG初当り回数
            unitListSection95Ci(
                grafTitle: "REG初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $takoslo.firstHitCountReg,
                        bigNumber: $takoslo.normalGame,
                        setting1Denominate: takoslo.ratioFirstHitReg[0],
                        setting2Denominate: takoslo.ratioFirstHitReg[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: takoslo.ratioFirstHitReg[2],
                        setting6Denominate: takoslo.ratioFirstHitReg[3]
                    )
                )
            )
            .tag(9)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: takoslo.machineName,
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
    takosloView95Ci(
        takoslo: Takoslo(),
    )
}
