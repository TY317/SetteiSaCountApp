//
//  yoshimuneView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/19.
//

import SwiftUI

struct yoshimuneView95Ci: View {
    @ObservedObject var yoshimune: Yoshimune
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // 初当り回数
            unitListSection95Ci(
                grafTitle: "初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $yoshimune.bonusCountSum,
                        bigNumber: $yoshimune.realGameTotal,
                        setting1Denominate: yoshimune.ratioBonusFirstHit[0],
                        setting2Denominate: yoshimune.ratioBonusFirstHit[1],
                        setting3Denominate: yoshimune.ratioBonusFirstHit[2],
                        setting4Denominate: yoshimune.ratioBonusFirstHit[3],
                        setting5Denominate: yoshimune.ratioBonusFirstHit[4],
                        setting6Denominate: yoshimune.ratioBonusFirstHit[5]
                    )
                )
            )
            .tag(1)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "吉宗",
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
    yoshimuneView95Ci(yoshimune: Yoshimune())
}
