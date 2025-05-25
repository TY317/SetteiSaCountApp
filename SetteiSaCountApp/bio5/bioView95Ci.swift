//
//  bioView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/13.
//

import SwiftUI

struct bioView95Ci: View {
//    @ObservedObject var bio = Bio()
    @ObservedObject var bio: Bio
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // CZ合算回数
            unitListSection95Ci(
                grafTitle: "CZ合算初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $bio.czCount,
                        bigNumber: $bio.playGameSum,
                        setting1Denominate: bio.ratioCz[0],
                        setting2Denominate: bio.ratioCz[1],
                        setting3Denominate: bio.ratioCz[2],
                        setting4Denominate: bio.ratioCz[3],
                        setting5Denominate: bio.ratioCz[4],
                        setting6Denominate: bio.ratioCz[5]
                    )
                )
            )
            .tag(1)
            // AT回数
            unitListSection95Ci(
                grafTitle: "AT初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $bio.atCount,
                        bigNumber: $bio.playGameSum,
                        setting1Denominate: bio.ratioAt[0],
                        setting2Denominate: bio.ratioAt[1],
                        setting3Denominate: bio.ratioAt[2],
                        setting4Denominate: bio.ratioAt[3],
                        setting5Denominate: bio.ratioAt[4],
                        setting6Denominate: bio.ratioAt[5]
                    )
                )
            )
            .tag(2)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "バイオハザード5",
                screenClass: screenClass
            )
        }
        .navigationTitle("95%信頼区間グラフ")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButton95CiExplain(isShow95CiExplain: isShow95CiExplain)
                    .popoverTip(tipUnitButton95CiExplain())
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    bioView95Ci(bio: Bio())
}
