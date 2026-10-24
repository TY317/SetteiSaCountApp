//
//  mhrsbView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct mhrsbView95Ci: View {
    @ObservedObject var mhrsb: Mhrsb
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // BZ初当り回数
            unitListSection95Ci(
                grafTitle: "BZ初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $mhrsb.firstHitCountBz,
                        bigNumber: $mhrsb.normalGame,
                        setting1Denominate: mhrsb.ratioFirstHitBz[0],
                        setting2Denominate: mhrsb.ratioFirstHitBz[1],
                        setting3Denominate: mhrsb.ratioFirstHitBz[2],
                        setting4Denominate: mhrsb.ratioFirstHitBz[3],
                        setting5Denominate: mhrsb.ratioFirstHitBz[4],
                        setting6Denominate: mhrsb.ratioFirstHitBz[5]
                    )
                )
            )
            .tag(2)

            // アイルー福引初当り回数
            unitListSection95Ci(
                grafTitle: "アイルー福引初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $mhrsb.firstHitCountFukubiki,
                        bigNumber: $mhrsb.normalGame,
                        setting1Denominate: mhrsb.ratioFirstHitFukubiki[0],
                        setting2Denominate: mhrsb.ratioFirstHitFukubiki[1],
                        setting3Denominate: mhrsb.ratioFirstHitFukubiki[2],
                        setting4Denominate: mhrsb.ratioFirstHitFukubiki[3],
                        setting5Denominate: mhrsb.ratioFirstHitFukubiki[4],
                        setting6Denominate: mhrsb.ratioFirstHitFukubiki[5]
                    )
                )
            )
            .tag(3)

            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $mhrsb.firstHitCountAt,
                        bigNumber: $mhrsb.normalGame,
                        setting1Denominate: mhrsb.ratioFirstHitAt[0],
                        setting2Denominate: mhrsb.ratioFirstHitAt[1],
                        setting3Denominate: mhrsb.ratioFirstHitAt[2],
                        setting4Denominate: mhrsb.ratioFirstHitAt[3],
                        setting5Denominate: mhrsb.ratioFirstHitAt[4],
                        setting6Denominate: mhrsb.ratioFirstHitAt[5]
                    )
                )
            )
            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: mhrsb.machineName,
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
    mhrsbView95Ci(
        mhrsb: Mhrsb(),
    )
}
