//
//  vvv2View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/16.
//

import SwiftUI

struct vvv2View95Ci: View {
    @ObservedObject var vvv2: Vvv2
    @State var selection = 1
    @State var isShow95CiExplain = false
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        TabView(selection: self.$selection) {
            // ドライブ発生率
            unitListSection95Ci(
                grafTitle: "ドライブ発生回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $vvv2.roundCountDrive,
                        bigNumber: $vvv2.roundCountSum,
                        setting1Denominate: vvv2.ratioDrive[0],
                        setting2Denominate: vvv2.ratioDrive[1],
                        setting3Enable: false,
                        setting3Denominate: -1,
                        setting4Denominate: vvv2.ratioDrive[2],
                        setting5Denominate: vvv2.ratioDrive[3],
                        setting6Denominate: vvv2.ratioDrive[4]
                    )
                )
            )
            .tag(1)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.vvv2Menu95CiBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: vvv2.machineName,
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
    vvv2View95Ci(
        vvv2: Vvv2(),
    )
    .environmentObject(commonVar())
}
