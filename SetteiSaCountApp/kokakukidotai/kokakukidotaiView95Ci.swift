//
//  kokakukidotaiView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/12.
//

import SwiftUI

struct kokakukidotaiView95Ci: View {
    @ObservedObject var kokakukidotai: Kokakukidotai
    @State var selection = 1
    @State var isShow95CiExplain = false
    var body: some View {
        TabView(selection: self.$selection) {
            // 引き戻し成功ストック回数
            unitListSection95Ci(
                grafTitle: "AT終了時200or400G\nCZ合算回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kokakukidotai.iedeCountSuccess,
                        bigNumber: $kokakukidotai.iedeCountSum,
                        setting1Percent: kokakukidotai.ratioIede[0],
                        setting2Percent: kokakukidotai.ratioIede[1],
                        setting3Percent: kokakukidotai.ratioIede[2],
                        setting4Percent: kokakukidotai.ratioIede[3],
                        setting5Percent: kokakukidotai.ratioIede[4],
                        setting6Percent: kokakukidotai.ratioIede[5]
                    )
                )
            )
            .tag(3)
            
            // 殲滅ゾーン　青発展での成功回数
            unitListSection95Ci(
                grafTitle: "殲滅ゾーン\n青発展での成功回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kokakukidotai.czColorCountBlueHit,
                        bigNumber: $kokakukidotai.czColorCountBlueSum,
                        setting1Percent: kokakukidotai.ratioCzColorBlue[0],
                        setting2Percent: kokakukidotai.ratioCzColorBlue[1],
                        setting3Percent: kokakukidotai.ratioCzColorBlue[2],
                        setting4Percent: kokakukidotai.ratioCzColorBlue[3],
                        setting5Percent: kokakukidotai.ratioCzColorBlue[4],
                        setting6Percent: kokakukidotai.ratioCzColorBlue[5]
                    )
                )
            )
            .tag(6)
            
            // 殲滅ゾーン　緑発展での成功回数
            unitListSection95Ci(
                grafTitle: "殲滅ゾーン\n緑発展での成功回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kokakukidotai.czColorCountGreenHit,
                        bigNumber: $kokakukidotai.czColorCountGreenSum,
                        setting1Percent: kokakukidotai.ratioCzColorGreen[0],
                        setting2Percent: kokakukidotai.ratioCzColorGreen[1],
                        setting3Percent: kokakukidotai.ratioCzColorGreen[2],
                        setting4Percent: kokakukidotai.ratioCzColorGreen[3],
                        setting5Percent: kokakukidotai.ratioCzColorGreen[4],
                        setting6Percent: kokakukidotai.ratioCzColorGreen[5]
                    )
                )
            )
            .tag(7)
            
            // CZ失敗後のモード移行　通常A回数
            unitListSection95Ci(
                grafTitle: "CZ失敗後のモード移行\n通常A回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kokakukidotai.modeCountA,
                        bigNumber: $kokakukidotai.modeCountSum,
                        setting1Percent: kokakukidotai.ratioModeA[0],
                        setting2Percent: kokakukidotai.ratioModeA[1],
                        setting3Percent: kokakukidotai.ratioModeA[2],
                        setting4Percent: kokakukidotai.ratioModeA[3],
                        setting5Percent: kokakukidotai.ratioModeA[4],
                        setting6Percent: kokakukidotai.ratioModeA[5]
                    )
                )
            )
            .tag(8)
            
            // CZ失敗後のモード移行　通常B回数
            unitListSection95Ci(
                grafTitle: "CZ失敗後のモード移行\n通常B回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kokakukidotai.modeCountB,
                        bigNumber: $kokakukidotai.modeCountSum,
                        setting1Percent: kokakukidotai.ratioModeB[0],
                        setting2Percent: kokakukidotai.ratioModeB[1],
                        setting3Percent: kokakukidotai.ratioModeB[2],
                        setting4Percent: kokakukidotai.ratioModeB[3],
                        setting5Percent: kokakukidotai.ratioModeB[4],
                        setting6Percent: kokakukidotai.ratioModeB[5]
                    )
                )
            )
            .tag(9)
            
            // CZ失敗後のモード移行　通常C回数
            unitListSection95Ci(
                grafTitle: "CZ失敗後のモード移行\n通常C回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kokakukidotai.modeCountC,
                        bigNumber: $kokakukidotai.modeCountSum,
                        setting1Percent: kokakukidotai.ratioModeC[0],
                        setting2Percent: kokakukidotai.ratioModeC[1],
                        setting3Percent: kokakukidotai.ratioModeC[2],
                        setting4Percent: kokakukidotai.ratioModeC[3],
                        setting5Percent: kokakukidotai.ratioModeC[4],
                        setting6Percent: kokakukidotai.ratioModeC[5]
                    )
                )
            )
            .tag(10)
            
            // CZ失敗後のモード移行　通常D回数
            unitListSection95Ci(
                grafTitle: "CZ失敗後のモード移行\n通常D回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kokakukidotai.modeCountD,
                        bigNumber: $kokakukidotai.modeCountSum,
                        setting1Percent: kokakukidotai.ratioModeD[0],
                        setting2Percent: kokakukidotai.ratioModeD[1],
                        setting3Percent: kokakukidotai.ratioModeD[2],
                        setting4Percent: kokakukidotai.ratioModeD[3],
                        setting5Percent: kokakukidotai.ratioModeD[4],
                        setting6Percent: kokakukidotai.ratioModeD[5]
                    )
                )
            )
            .tag(11)
            
            // CZ初当り回数
            unitListSection95Ci(
                grafTitle: "CZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kokakukidotai.firstHitCountCz,
                        bigNumber: $kokakukidotai.normalGame,
                        setting1Denominate: kokakukidotai.ratioFirstHitCz[0],
                        setting2Denominate: kokakukidotai.ratioFirstHitCz[1],
                        setting3Denominate: kokakukidotai.ratioFirstHitCz[2],
                        setting4Denominate: kokakukidotai.ratioFirstHitCz[3],
                        setting5Denominate: kokakukidotai.ratioFirstHitCz[4],
                        setting6Denominate: kokakukidotai.ratioFirstHitCz[5]
                    )
                )
            )
            .tag(1)
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kokakukidotai.firstHitCountAt,
                        bigNumber: $kokakukidotai.normalGame,
                        setting1Denominate: kokakukidotai.ratioFirstHitAt[0],
                        setting2Denominate: kokakukidotai.ratioFirstHitAt[1],
                        setting3Denominate: kokakukidotai.ratioFirstHitAt[2],
                        setting4Denominate: kokakukidotai.ratioFirstHitAt[3],
                        setting5Denominate: kokakukidotai.ratioFirstHitAt[4],
                        setting6Denominate: kokakukidotai.ratioFirstHitAt[5]
                    )
                )
            )
            .tag(4)
            
            // 引き戻し成功ストック回数
            unitListSection95Ci(
                grafTitle: "REBOOTCHANCE\n成功ストック回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kokakukidotai.rebootCountSuccess,
                        bigNumber: $kokakukidotai.rebootCountSum,
                        setting1Percent: kokakukidotai.ratioReboot[0],
                        setting2Percent: kokakukidotai.ratioReboot[1],
                        setting3Percent: kokakukidotai.ratioReboot[2],
                        setting4Percent: kokakukidotai.ratioReboot[3],
                        setting5Percent: kokakukidotai.ratioReboot[4],
                        setting6Percent: kokakukidotai.ratioReboot[5]
                    )
                )
            )
            .tag(2)
            
            // 視覚HACK発生回数
            unitListSection95Ci(
                grafTitle: "視覚HACK発生回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kokakukidotai.sikakuHackCountHit,
                        bigNumber: $kokakukidotai.sikakuHackCountSum,
                        setting1Percent: kokakukidotai.ratioSikakuHack[0],
                        setting2Percent: kokakukidotai.ratioSikakuHack[1],
                        setting3Percent: kokakukidotai.ratioSikakuHack[2],
                        setting4Percent: kokakukidotai.ratioSikakuHack[3],
                        setting5Percent: kokakukidotai.ratioSikakuHack[4],
                        setting6Percent: kokakukidotai.ratioSikakuHack[5]
                    )
                )
            )
            .tag(5)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kokakukidotai.machineName,
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
    kokakukidotaiView95Ci(
        kokakukidotai: Kokakukidotai(),
    )
}
