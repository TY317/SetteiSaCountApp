//
//  yajikitaView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct yajikitaView95Ci: View {
    @ObservedObject var yajikita: Yajikita
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $yajikita.firstHitCountAt,
                        bigNumber: $yajikita.normalGame,
                        setting1Denominate: yajikita.ratioFirstHitAt[0],
                        setting2Denominate: yajikita.ratioFirstHitAt[1],
                        setting3Denominate: yajikita.ratioFirstHitAt[2],
                        setting4Denominate: yajikita.ratioFirstHitAt[3],
                        setting5Denominate: yajikita.ratioFirstHitAt[4],
                        setting6Denominate: yajikita.ratioFirstHitAt[5]
                    )
                )
            )
            .tag(2)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: yajikita.machineName,
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
    yajikitaView95Ci(
        yajikita: Yajikita(),
    )
}
