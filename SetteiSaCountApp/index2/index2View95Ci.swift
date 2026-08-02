//
//  index2View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct index2View95Ci: View {
    @ObservedObject var index2: Index2
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // 🍉→高確移行回数
            unitListSection95Ci(
                grafTitle: "🍉→高確移行回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $index2.suikaCountKokaku,
                        bigNumber: $index2.suikaCountKoyaku,
                        setting1Percent: index2.ratioSuikaKokaku[0],
                        setting2Percent: index2.ratioSuikaKokaku[1],
                        setting3Percent: index2.ratioSuikaKokaku[2],
                        setting4Percent: index2.ratioSuikaKokaku[3],
                        setting5Percent: index2.ratioSuikaKokaku[4],
                        setting6Percent: index2.ratioSuikaKokaku[5]
                    )
                )
            )
            .tag(1)
            
            // 🍉→美琴高確移行回数
            unitListSection95Ci(
                grafTitle: "🍉→美琴高確移行回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $index2.suikaCountMikoto,
                        bigNumber: $index2.suikaCountKoyaku,
                        setting1Percent: index2.ratioSuikaMikotoKokaku[0],
                        setting2Percent: index2.ratioSuikaMikotoKokaku[1],
                        setting3Percent: index2.ratioSuikaMikotoKokaku[2],
                        setting4Percent: index2.ratioSuikaMikotoKokaku[3],
                        setting5Percent: index2.ratioSuikaMikotoKokaku[4],
                        setting6Percent: index2.ratioSuikaMikotoKokaku[5]
                    )
                )
            )
            .tag(2)
//
//            // CZ初当り回数
//            unitListSection95Ci(
//                grafTitle: "CZ初当り回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $index2.firstHitCountCz,
//                        bigNumber: $index2.normalGame,
//                        setting1Denominate: index2.ratioFirstHitCz[0],
//                        setting2Denominate: index2.ratioFirstHitCz[1],
//                        setting3Denominate: index2.ratioFirstHitCz[2],
//                        setting4Denominate: index2.ratioFirstHitCz[3],
//                        setting5Denominate: index2.ratioFirstHitCz[4],
//                        setting6Denominate: index2.ratioFirstHitCz[5]
//                    )
//                )
//            )
//            .tag(2)
//
//            // AT初当り回数
//            unitListSection95Ci(
//                grafTitle: "AT初当り回数",
//                grafView: AnyView(
//                    unitChart95CiDenominate(
//                        currentCount: $index2.firstHitCountAt,
//                        bigNumber: $index2.normalGame,
//                        setting1Denominate: index2.ratioFirstHitAt[0],
//                        setting2Denominate: index2.ratioFirstHitAt[1],
//                        setting3Denominate: index2.ratioFirstHitAt[2],
//                        setting4Denominate: index2.ratioFirstHitAt[3],
//                        setting5Denominate: index2.ratioFirstHitAt[4],
//                        setting6Denominate: index2.ratioFirstHitAt[5]
//                    )
//                )
//            )
//            .tag(3)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: index2.machineName,
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
    index2View95Ci(
        index2: Index2(),
    )
}
