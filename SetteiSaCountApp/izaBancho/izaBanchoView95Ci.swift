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
            // 刺客ゾーン　青成功回数
            unitListSection95Ci(
                grafTitle: "刺客ゾーン 成功回数\n青",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $izaBancho.czResultCountBlueHit,
                        bigNumber: $izaBancho.czResultCountBlueSum,
                        setting1Percent: izaBancho.ratioCzEffectBlue[0],
                        setting2Percent: izaBancho.ratioCzEffectBlue[1],
                        setting3Percent: izaBancho.ratioCzEffectBlue[2],
                        setting4Percent: izaBancho.ratioCzEffectBlue[3],
                        setting5Percent: izaBancho.ratioCzEffectBlue[4],
                        setting6Percent: izaBancho.ratioCzEffectBlue[5]
                    )
                )
            )
            .tag(2)
            // 刺客ゾーン　黄成功回数
            unitListSection95Ci(
                grafTitle: "刺客ゾーン 成功回数\n黄",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $izaBancho.czResultCountYellowHit,
                        bigNumber: $izaBancho.czResultCountYellowSum,
                        setting1Percent: izaBancho.ratioCzEffectYellow[0],
                        setting2Percent: izaBancho.ratioCzEffectYellow[1],
                        setting3Percent: izaBancho.ratioCzEffectYellow[2],
                        setting4Percent: izaBancho.ratioCzEffectYellow[3],
                        setting5Percent: izaBancho.ratioCzEffectYellow[4],
                        setting6Percent: izaBancho.ratioCzEffectYellow[5]
                    )
                )
            )
            .tag(3)
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
            // 直撃回数
            unitListSection95Ci(
                grafTitle: "ボーナス直撃回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $izaBancho.chokugekiCount,
                        bigNumber: $izaBancho.playGameSum,
                        setting1Denominate: izaBancho.ratioBBChokugeki[0],
                        setting2Denominate: izaBancho.ratioBBChokugeki[1],
                        setting3Denominate: izaBancho.ratioBBChokugeki[2],
                        setting4Denominate: izaBancho.ratioBBChokugeki[3],
                        setting5Denominate: izaBancho.ratioBBChokugeki[4],
                        setting6Denominate: izaBancho.ratioBBChokugeki[5]
                    )
                )
            )
            .tag(4)
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
//                    .popoverTip(tipUnitButton95CiExplain())
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
