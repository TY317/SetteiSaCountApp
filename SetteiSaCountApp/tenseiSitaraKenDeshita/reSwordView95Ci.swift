//
//  reSwordView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/31.
//

import SwiftUI

struct reSwordView95Ci: View {
    @ObservedObject var reSword: ReSword
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // フランおやすみ中のAT当選回数
            unitListSection95Ci(
                grafTitle: "フランおやすみ中\nAT当選回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $reSword.franSleepCountHit,
                        bigNumber: $reSword.franSleepCountSum,
                        setting1Percent: reSword.ratioSleepAt[0],
                        setting2Percent: reSword.ratioSleepAt[1],
                        setting3Percent: reSword.ratioSleepAt[2],
                        setting4Percent: reSword.ratioSleepAt[3],
                        setting5Percent: reSword.ratioSleepAt[4],
                        setting6Percent: reSword.ratioSleepAt[5]
                    )
                )
            )
            .tag(1)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: reSword.machineName,
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
    reSwordView95Ci(
        reSword: ReSword(),
    )
}
