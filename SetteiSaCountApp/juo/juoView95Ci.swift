//
//  juoView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct juoView95Ci: View {
    @ObservedObject var juo: Juo
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // サバンナチャンス初当り回数
            unitListSection95Ci(
                grafTitle: "サバンナチャンス初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $juo.firstHitCountSc,
                        bigNumber: $juo.normalGame,
                        setting1Denominate: juo.ratioFirstHitSc[0],
                        setting2Denominate: juo.ratioFirstHitSc[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Denominate: juo.ratioFirstHitSc[2],
                        setting5Denominate: juo.ratioFirstHitSc[3],
                        setting6Denominate: juo.ratioFirstHitSc[4]
                    )
                )
            )
            .tag(2)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: juo.machineName,
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
    juoView95Ci(
        juo: Juo(),
    )
}
