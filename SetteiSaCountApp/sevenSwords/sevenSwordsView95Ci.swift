//
//  sevenSwordsView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/14.
//

import SwiftUI

struct sevenSwordsView95Ci: View {
//    @ObservedObject var sevenSwords = SevenSwords()
    @ObservedObject var sevenSwords: SevenSwords
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // ボーナス初当り回数
            unitListSection95Ci(
                grafTitle: "ボーナス合算初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $sevenSwords.inputBonusCountSum,
                        bigNumber: $sevenSwords.inputNormalGame,
                        setting1Denominate: 228.0,
                        setting2Denominate: 222.0,
                        setting3Denominate: 209.7,
                        setting4Denominate: 185.6,
                        setting5Denominate: 173.5,
                        setting6Denominate: 164.7
                    )
                )
            )
            .tag(1)
            // ST初当り回数
            unitListSection95Ci(
                grafTitle: "ST初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $sevenSwords.inputStCount,
                        bigNumber: $sevenSwords.inputNormalGame,
                        setting1Denominate: 408.3,
                        setting2Denominate: 394.9,
                        setting3Denominate: 366.4,
                        setting4Denominate: 314.0,
                        setting5Denominate: 289.2,
                        setting6Denominate: 272.3
                    )
                )
            )
            .tag(2)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "七つの魔剣が支配する",
                screenClass: screenClass
            )
        }
        .navigationTitle("95%信頼区間グラフ")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButton95CiExplain(isShow95CiExplain: isShow95CiExplain)
//                    .popoverTip(tipUnitButton95CiExplain())
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    sevenSwordsView95Ci(sevenSwords: SevenSwords())
}
