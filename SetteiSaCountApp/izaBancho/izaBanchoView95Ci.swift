//
//  izaBanchoView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/31.
//

import SwiftUI

struct izaBanchoView95Ci: View {
    @ObservedObject var izaBancho: IzaBancho
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            // 初当り回数
            unitListSection95Ci(
                grafTitle: "初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $izaBancho.firstHitCount,
                        bigNumber: $izaBancho.playGameSum,
                        setting1Denominate: izaBancho.ratioFirstHit[0],
                        setting2Denominate: izaBancho.ratioFirstHit[1],
                        setting3Denominate: izaBancho.ratioFirstHit[2],
                        setting4Denominate: izaBancho.ratioFirstHit[3],
                        setting5Denominate: izaBancho.ratioFirstHit[4],
                        setting6Denominate: izaBancho.ratioFirstHit[5]
                    )
                )
            )
            .tag(1)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: izaBancho.machineName,
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
    izaBanchoView95Ci(
        izaBancho: IzaBancho(),
    )
}
