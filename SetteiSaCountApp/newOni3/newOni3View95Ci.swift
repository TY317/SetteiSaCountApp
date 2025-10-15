//
//  newOni3View95Ci.swift
//  SetteiSaCountApp
//
//  newOni3ted by 横田徹 on 2025/10/05.
//

import SwiftUI

struct newOni3View95Ci: View {
    @ObservedObject var newOni3: NewOni3
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // 高確移行回数
            unitListSection95Ci(
                grafTitle: "高確移行回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $newOni3.kokakuCountIkou,
                        bigNumber: $newOni3.kokakuCountJakuSum,
                        setting1Percent: newOni3.ratioKokaku[0],
                        setting2Percent: newOni3.ratioKokaku[1],
                        setting3Percent: newOni3.ratioKokaku[2],
                        setting4Percent: newOni3.ratioKokaku[3],
                        setting5Percent: newOni3.ratioKokaku[4],
                        setting6Percent: newOni3.ratioKokaku[5]
                    )
                )
            )
            .tag(1)
            
            // AT初当り回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $newOni3.firstHitCountAt,
                        bigNumber: $newOni3.normalGame,
                        setting1Denominate: newOni3.ratioFirstHitAt[0],
                        setting2Denominate: newOni3.ratioFirstHitAt[1],
                        setting3Denominate: newOni3.ratioFirstHitAt[2],
                        setting4Denominate: newOni3.ratioFirstHitAt[3],
                        setting5Denominate: newOni3.ratioFirstHitAt[4],
                        setting6Denominate: newOni3.ratioFirstHitAt[5]
                    )
                )
            )
            .tag(2)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: newOni3.machineName,
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
    newOni3View95Ci(
        newOni3: NewOni3(),
    )
}
