//
//  hihodenView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/13.
//

import SwiftUI

struct hihodenView95Ci: View {
    @ObservedObject var hihoden: Hihoden
    @State var selection = 1
    @State var isShow95CiExplain = false
    var body: some View {
        TabView(selection: self.$selection) {
            // スイカ回数
            unitListSection95Ci(
                grafTitle: "🍉回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hihoden.koyakuCountCherry,
                        bigNumber: $hihoden.totalGame,
                        setting1Denominate: hihoden.ratioKoyakuCherry[0],
                        setting2Denominate: hihoden.ratioKoyakuCherry[1],
                        setting3Denominate: hihoden.ratioKoyakuCherry[2],
                        setting4Denominate: hihoden.ratioKoyakuCherry[3],
                        setting5Denominate: hihoden.ratioKoyakuCherry[4],
                        setting6Denominate: hihoden.ratioKoyakuCherry[5]
                    )
                )
            )
            .tag(1)
            
            // 初当り回数
            unitListSection95Ci(
                grafTitle: "初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hihoden.firstHitCount,
                        bigNumber: $hihoden.normalGame,
                        setting1Denominate: hihoden.ratioFirstHit[0],
                        setting2Denominate: hihoden.ratioFirstHit[1],
                        setting3Denominate: hihoden.ratioFirstHit[2],
                        setting4Denominate: hihoden.ratioFirstHit[3],
                        setting5Denominate: hihoden.ratioFirstHit[4],
                        setting6Denominate: hihoden.ratioFirstHit[5]
                    )
                )
            )
            .tag(2)
            
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hihoden.machineName,
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
    hihodenView95Ci(
        hihoden: Hihoden(),
    )
}
