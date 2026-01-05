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
