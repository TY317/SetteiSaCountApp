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
