//
//  hanabiView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/02.
//

import SwiftUI

struct hanabiView95Ci: View {
    @ObservedObject var hanabi: Hanabi
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // BIG回数
            unitListSection95Ci(
                grafTitle: "BIG回数",
//                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hanabi.totalBig,
                        bigNumber: $hanabi.totalGame,
                        setting1Denominate: hanabi.ratioBig[0],
                        setting2Denominate: hanabi.ratioBig[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: hanabi.ratioBig[2],
                        setting6Denominate: hanabi.ratioBig[3]
                    )
                )
            )
            .tag(1)
            // REG回数
            unitListSection95Ci(
                grafTitle: "REG回数",
//                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hanabi.totalReg,
                        bigNumber: $hanabi.totalGame,
                        setting1Denominate: hanabi.ratioReg[0],
                        setting2Denominate: hanabi.ratioReg[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: hanabi.ratioReg[2],
                        setting6Denominate: hanabi.ratioReg[3]
                    )
                )
            )
            .tag(2)
            
            // 風鈴合算回数
            unitListSection95Ci(
                grafTitle: "風鈴合算回数",
//                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hanabi.normalKoyakuCountBellSum,
                        bigNumber: $hanabi.playGame,
                        setting1Denominate: hanabi.ratioBellSum[0],
                        setting2Denominate: hanabi.ratioBellSum[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: hanabi.ratioBellSum[2],
                        setting6Denominate: hanabi.ratioBellSum[3]
                    )
                )
            )
            .tag(3)
            
            // 氷A回数
            unitListSection95Ci(
                grafTitle: "氷A回数",
//                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hanabi.normalKoyakuCountKohriA,
                        bigNumber: $hanabi.playGame,
                        setting1Denominate: hanabi.ratioKohriA[0],
                        setting2Denominate: hanabi.ratioKohriA[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: hanabi.ratioKohriA[2],
                        setting6Denominate: hanabi.ratioKohriA[3]
                    )
                )
            )
            .tag(4)
            
            // チェリーA2回数
            unitListSection95Ci(
                grafTitle: "チェリーA2回数",
//                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hanabi.normalKoyakuCountCherryA2,
                        bigNumber: $hanabi.playGame,
                        setting1Denominate: hanabi.ratioCherryA2[0],
                        setting2Denominate: hanabi.ratioCherryA2[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: hanabi.ratioCherryA2[2],
                        setting6Denominate: hanabi.ratioCherryA2[3]
                    )
                )
            )
            .tag(5)
            
            // 花火チャレンジハズレ回数
            unitListSection95Ci(
                grafTitle: "花火チャレンジ中\nハズレ回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hanabi.hazureCountChallenge,
                        bigNumber: $hanabi.challengeGame,
                        setting1Denominate: hanabi.ratioHazureChallenge[0],
                        setting2Denominate: hanabi.ratioHazureChallenge[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: hanabi.ratioHazureChallenge[2],
                        setting6Denominate: hanabi.ratioHazureChallenge[3]
                    )
                )
            )
            .tag(6)
            
            // 花火GAMEハズレ回数
            unitListSection95Ci(
                grafTitle: "花火GAME中\nハズレ回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hanabi.hazureCountGame,
                        bigNumber: $hanabi.hanabiGame,
                        setting1Denominate: hanabi.ratioHazureGame[0],
                        setting2Denominate: hanabi.ratioHazureGame[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: hanabi.ratioHazureGame[2],
                        setting6Denominate: hanabi.ratioHazureGame[3]
                    )
                )
            )
            .tag(7)
            
            // BB中風鈴A回数
            unitListSection95Ci(
                grafTitle: "BB中\n風鈴A回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hanabi.bbCountBellA,
                        bigNumber: $hanabi.bbCountGame,
                        setting1Denominate: hanabi.ratioBbBellA[0],
                        setting2Denominate: hanabi.ratioBbBellA[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: hanabi.ratioBbBellA[2],
                        setting6Denominate: hanabi.ratioBbBellA[3]
                    )
                )
            )
            .tag(8)
            
            // BB中風鈴B回数
            unitListSection95Ci(
                grafTitle: "BB中\n風鈴B回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hanabi.bbCountBellB,
                        bigNumber: $hanabi.bbCountGame,
                        setting1Denominate: hanabi.ratioBbBellB[0],
                        setting2Denominate: hanabi.ratioBbBellB[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: hanabi.ratioBbBellB[2],
                        setting6Denominate: hanabi.ratioBbBellB[3]
                    )
                )
            )
            .tag(9)
            
            // RB中1枚役回数
            unitListSection95Ci(
                grafTitle: "RB中\n1枚役回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hanabi.rbCount1Mai,
                        bigNumber: $hanabi.rbCountGame,
                        setting1Denominate: hanabi.ratioRb1Mai[0],
                        setting2Denominate: hanabi.ratioRb1Mai[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: hanabi.ratioRb1Mai[2],
                        setting6Denominate: hanabi.ratioRb1Mai[3]
                    )
                )
            )
            .tag(10)
            
            // 花火チャレンジ中 通常リプレイ
            unitListSection95Ci(
                grafTitle: "花火チャレンジ中\n通常リプレイ回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hanabi.replayCountChallenge,
                        bigNumber: $hanabi.challengeGame,
                        setting1Denominate: hanabi.ratioChallengeReplayNormal[0],
                        setting2Denominate: hanabi.ratioChallengeReplayNormal[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: hanabi.ratioChallengeReplayNormal[2],
                        setting6Denominate: hanabi.ratioChallengeReplayNormal[3]
                    )
                )
            )
            .tag(11)
            
            // 花火GAME中 通常リプレイ
            unitListSection95Ci(
                grafTitle: "花火GAME中\nRTリプレイ回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hanabi.replayCountGame,
                        bigNumber: $hanabi.hanabiGame,
                        setting1Denominate: hanabi.ratioGameReplayRt[0],
                        setting2Denominate: hanabi.ratioGameReplayRt[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Enable: false,
                        setting4Denominate: -1,
                        setting5Denominate: hanabi.ratioGameReplayRt[2],
                        setting6Denominate: hanabi.ratioGameReplayRt[3]
                    )
                )
            )
            .tag(12)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hanabi.machineName,
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
    hanabiView95Ci(
        hanabi: Hanabi(),
    )
}
