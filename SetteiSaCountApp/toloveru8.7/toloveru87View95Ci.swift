//
//  toloveru87View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/21.
//

import SwiftUI

struct toloveru87View95Ci: View {
    @ObservedObject var toloveru87: Toloveru87
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // ウィスパー回数
            unitListSection95Ci(
                grafTitle: "ウィスパー回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $toloveru87.harlemWhisperCount,
                        bigNumber: $toloveru87.harlemCountSum,
                        setting1Enable: false,
                        setting1Percent: -100,
                        setting2Percent: 3.1,
                        setting3Percent: 3.6,
                        setting4Percent: 6.0,
                        setting5Percent: 7.1,
                        setting6Percent: 11.9
                    )
                )
            )
            .tag(1)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ToLOVEるver8.7",
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
    toloveru87View95Ci(
        toloveru87: Toloveru87()
    )
}
