//
//  aobutaView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct aobutaView95Ci: View {
    @ObservedObject var aobuta: Aobuta
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // 初当り回数
            unitListSection95Ci(
                grafTitle: "初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $aobuta.firstHitCountSt,
                        bigNumber: $aobuta.normalGame,
                        setting1Enable: false,
                        setting1Denominate: -1,
                        setting2Denominate: aobuta.ratioFirstHitSt[0],
                        setting3Denominate: aobuta.ratioFirstHitSt[1],
                        setting4Denominate: aobuta.ratioFirstHitSt[2],
                        setting5Denominate: aobuta.ratioFirstHitSt[3],
                        setting6Denominate: aobuta.ratioFirstHitSt[4]
                    )
                )
            )
            .tag(2)

        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: aobuta.machineName,
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
    aobutaView95Ci(
        aobuta: Aobuta(),
    )
}
