//
//  seiyaView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct seiyaView95Ci: View {
    @ObservedObject var seiya: Seiya
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // CZ初当り回数
            unitListSection95Ci(
                grafTitle: "CZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $seiya.firstHitCountCz,
                        bigNumber: $seiya.playGameSum,
                        setting1Denominate: seiya.ratioFirstHitCz[0],
                        setting2Denominate: seiya.ratioFirstHitCz[1],
                        setting3Denominate: seiya.ratioFirstHitCz[2],
                        setting4Denominate: seiya.ratioFirstHitCz[3],
                        setting5Denominate: seiya.ratioFirstHitCz[4],
                        setting6Denominate: seiya.ratioFirstHitCz[5]
                    )
                )
            )
            .tag(2)

            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $seiya.firstHitCountAt,
                        bigNumber: $seiya.playGameSum,
                        setting1Denominate: seiya.ratioFirstHitAt[0],
                        setting2Denominate: seiya.ratioFirstHitAt[1],
                        setting3Denominate: seiya.ratioFirstHitAt[2],
                        setting4Denominate: seiya.ratioFirstHitAt[3],
                        setting5Denominate: seiya.ratioFirstHitAt[4],
                        setting6Denominate: seiya.ratioFirstHitAt[5]
                    )
                )
            )
            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: seiya.machineName,
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
    seiyaView95Ci(
        seiya: Seiya(),
    )
}
