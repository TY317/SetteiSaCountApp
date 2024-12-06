//
//  vvvView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/26.
//

import SwiftUI

struct vvvView95Ci: View {
    @ObservedObject var VVVendScreen = VVVendScreenVar()
    @ObservedObject var VVVmarie = VVVmarieVar()
    @ObservedObject var VVVharakiri = VVVharakiriVar()
    @ObservedObject var vvv = vvvCzHistory()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // 革命ボーナス回数
            unitListSection95Ci(
                grafTitle: "革命ボーナス回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $vvv.kakumeiCount,
                        bigNumber: $vvv.bonusCountSum,
                        setting1Percent: -100,
                        setting2Percent: -100,
                        setting3Percent: -100,
                        setting4Percent: -100,
                        setting5Percent: -100,
                        setting6Percent: 65
                    )
                )
            )
            .tag(1)
            // ボーナス終了画面デフォルト回数
            unitListSection95Ci(
                grafTitle: "CZ,ボーナス終了画面\nデフォルト回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $VVVendScreen.w2Count,
                        bigNumber: $VVVendScreen.screenCountSum,
                        setting1Percent: 79,
                        setting2Percent: 77,
                        setting3Percent: 75,
                        setting4Percent: 75,
                        setting5Percent: 75,
                        setting6Percent: 74
                    )
                )
            )
            .tag(2)
            // 終了画面　奇数示唆回数
            unitListSection95Ci(
                grafTitle: "CZ,ボーナス終了画面\n奇数示唆回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $VVVendScreen.w3Count,
                        bigNumber: $VVVendScreen.screenCountSum,
                        setting1Percent: 10,
                        setting2Percent: 8,
                        setting3Percent: 10,
                        setting4Percent: 5,
                        setting5Percent: 10,
                        setting6Percent: 5
                    )
                )
            )
            .tag(3)
            // 終了画面　偶数示唆回数
            unitListSection95Ci(
                grafTitle: "CZ,ボーナス終了画面\n偶数示唆回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $VVVendScreen.w4Count,
                        bigNumber: $VVVendScreen.screenCountSum,
                        setting1Percent: 8,
                        setting2Percent: 10,
                        setting3Percent: 7,
                        setting4Percent: 10,
                        setting5Percent: 5,
                        setting6Percent: 10
                    )
                )
            )
            .tag(4)
            // マリエ覚醒回数
            unitListSection95Ci(
                grafTitle: "マリエ覚醒回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $VVVmarie.marieCount,
                        bigNumber: $vvv.kakumeiCount,
                        setting1Percent: 5,
                        setting2Percent: 6,
                        setting3Percent: 7,
                        setting4Percent: 9,
                        setting5Percent: 10,
                        setting6Percent: 13)
                )
            )
            .tag(5)
            // ドライブ回数（有利区間切断後）
            unitListSection95Ci(
                grafTitle: "ハラキリドライブ回数\n（有利区間切断後）",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $VVVharakiri.afterDriveCount,
                        bigNumber: $VVVharakiri.afterSetCountSum,
                        setting1Denominate: 15,
                        setting2Denominate: -100,
                        setting3Denominate: -100,
                        setting4Denominate: -100,
                        setting5Denominate: -100,
                        setting6Denominate: 4
                    )
                )
            )
            .tag(6)
            // ドライブ回数（トータル）
            unitListSection95Ci(
                grafTitle: "ハラキリドライブ回数\n（トータル）",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $VVVharakiri.allDriveCountSum,
                        bigNumber: $VVVharakiri.allSetCountSum,
                        setting1Denominate: 15,
                        setting2Denominate: -100,
                        setting3Denominate: -100,
                        setting4Denominate: -100,
                        setting5Denominate: -100,
                        setting6Denominate: 4
                    )
                )
            )
            .tag(7)
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
    vvvView95Ci()
}
