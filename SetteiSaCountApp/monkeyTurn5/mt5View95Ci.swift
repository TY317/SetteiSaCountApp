//
//  mt5View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/20.
//

import SwiftUI

struct mt5View95Ci: View {
//    @ObservedObject var mt5 = Mt5()
    @ObservedObject var mt5: Mt5
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // 5枚役
            List {
                Section {
                    unitChart95CiDenominate(
                        currentCount: $mt5.coin5Count,
                        bigNumber: $mt5.playGame,
                        setting1Denominate: 38,
                        setting2Denominate: 36,
                        setting3Enable: false,
                        setting3Denominate: -100,
                        setting4Denominate: 30,
                        setting5Denominate: 24,
                        setting6Denominate: 22
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "5枚役回数")
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(1)
            // 激走チャージ 波多野A
            List {
                Section {
                    unitChart95CiPercent(
                        currentCount: $mt5.hatanoACount,
                        bigNumber: $mt5.hatanoCountSum,
                        setting1Percent: 50.0,
                        setting2Percent: 40.0,
                        setting3Enable: false,
                        setting3Percent: -100.0,
                        setting4Percent: 40.0,
                        setting5Percent: 70.0,
                        setting6Percent: 40.0
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "波多野A 回数")
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(2)
            // ライバルモード蒲生
            List {
                Section {
                    unitChart95CiPercent(
                        currentCount: $mt5.rivalGamoCount,
                        bigNumber: $mt5.atCountPlus1,
                        setting1Percent: 7.8,
                        setting2Percent: 8.6,
                        setting3Enable: false,
                        setting3Percent: -100.0,
                        setting4Percent: 10.9,
                        setting5Percent: 14.1,
                        setting6Percent: 15.6
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "ライバルモード 蒲生 回数", titleFont: .title2)
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(3)
            // ライバルモード浜岡
            List {
                Section {
                    unitChart95CiPercent(
                        currentCount: $mt5.rivalHamaokaCount,
                        bigNumber: $mt5.atCountPlus1,
                        setting1Percent: 7.8,
                        setting2Percent: 8.2,
                        setting3Enable: false,
                        setting3Percent: -100.0,
                        setting4Percent: 9.4,
                        setting5Percent: 10.5,
                        setting6Percent: 10.9
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "ライバルモード 浜岡 回数", titleFont: .title2)
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(4)
            // ライバルモード榎木
            List {
                Section {
                    unitChart95CiPercent(
                        currentCount: $mt5.rivalEnokiCount,
                        bigNumber: $mt5.atCountPlus1,
                        setting1Percent: 7.8,
                        setting2Percent: 8.2,
                        setting3Enable: false,
                        setting3Percent: -100.0,
                        setting4Percent: 9.4,
                        setting5Percent: 10.5,
                        setting6Percent: 10.9
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "ライバルモード 榎木 回数", titleFont: .title2)
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(5)
            // 黒メダル回数
            List {
                Section {
                    unitChart95CiPercent(
                        currentCount: $mt5.blackMedalCount,
                        bigNumber: $mt5.atCount,
                        setting1Percent: 1.25,
                        setting2Percent: 1.5,
                        setting3Enable: false,
                        setting3Percent: -100.0,
                        setting4Percent: 4.0,
                        setting5Percent: 4.5,
                        setting6Percent: 4.5
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "黒メダル 回数")
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(6)
            // 青島SG ドレス回数
            List {
                Section {
                    unitChart95CiPercent(
                        currentCount: $mt5.AoshimaSGDressCount,
                        bigNumber: $mt5.AoshimaSGCountSum,
                        setting1Percent: 20.0,
                        setting2Percent: 25.0,
                        setting3Enable: false,
                        setting3Percent: -100.0,
                        setting4Percent: 35.0,
                        setting5Percent: 38.0,
                        setting6Percent: 38.0
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "青島SG画面 ドレス回数", titleFont: .title2)
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(7)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "モンキーターン5",
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
    mt5View95Ci(mt5: Mt5())
}
