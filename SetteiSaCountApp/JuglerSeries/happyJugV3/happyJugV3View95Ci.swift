//
//  happyJugV3View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/24.
//

import SwiftUI

struct happyJugV3View95Ci: View {
    @ObservedObject var jug = happyJugV3Var()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            //ぶどう
            List {
                Section {
                    unitChart95CiDenominate(
                        currentCount: $jug.bellCount,
                        bigNumber: $jug.playgame,
                        setting1Denominate: 6.04,
                        setting2Denominate: 6.01,
                        setting3Denominate: 5.98,
                        setting4Denominate: 5.84,
                        setting5Denominate: 5.81,
                        setting6Denominate: 5.79,
                        yScaleKeisu: 0.05
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "ぶどう回数")
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(1)
            // 単独BIG回数
            List {
                Section {
                    unitChart95CiDenominate(
                        currentCount: $jug.aloneBigCount,
                        bigNumber: $jug.playgame,
                        setting1Denominate: 437,
                        setting2Denominate: 431,
                        setting3Denominate: 412,
                        setting4Denominate: 415,
                        setting5Denominate: 377,
                        setting6Denominate: 345
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "単独BIG回数")
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(2)
            // 🍒BIG回数
            List {
                Section {
                    unitChart95CiDenominate(
                        currentCount: $jug.cherryBigCount,
                        bigNumber: $jug.playgame,
                        setting1Denominate: 1489,
                        setting2Denominate: 1489,
                        setting3Denominate: 1489,
                        setting4Denominate: 1214,
                        setting5Denominate: 1214,
                        setting6Denominate: 1214
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "🍒BIG回数")
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(3)
            // BIG合算
            List {
                Section {
                    unitChart95CiDenominate(
                        currentCount: $jug.bigCountSum,
                        bigNumber: $jug.playgame,
                        setting1Denominate: 273,
                        setting2Denominate: 271,
                        setting3Denominate: 263,
                        setting4Denominate: 254,
                        setting5Denominate: 239,
                        setting6Denominate: 226
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "BIG合算回数")
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(4)
            // 単独REG回数
            List {
                Section {
                    unitChart95CiDenominate(
                        currentCount: $jug.aloneRegCount,
                        bigNumber: $jug.playgame,
                        setting1Denominate: 636,
                        setting2Denominate: 570,
                        setting3Denominate: 533,
                        setting4Denominate: 478,
                        setting5Denominate: 437,
                        setting6Denominate: 426
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "単独REG回数")
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(5)
            // 🍒REG回数
            List {
                Section {
                    unitChart95CiDenominate(
                        currentCount: $jug.cherryRegCount,
                        bigNumber: $jug.playgame,
                        setting1Denominate: 1057,
                        setting2Denominate: 993,
                        setting3Denominate: 886,
                        setting4Denominate: 809,
                        setting5Denominate: 728,
                        setting6Denominate: 643
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "🍒REG回数")
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(6)
            // REG合算
            List {
                Section {
                    unitChart95CiDenominate(
                        currentCount: $jug.regCountSum,
                        bigNumber: $jug.playgame,
                        setting1Denominate: 397,
                        setting2Denominate: 362,
                        setting3Denominate: 333,
                        setting4Denominate: 301,
                        setting5Denominate: 273,
                        setting6Denominate: 256
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "REG合算回数")
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(7)
            // ボーナス合算回数
            List {
                Section {
                    unitChart95CiDenominate(
                        currentCount: $jug.bonusCountSum,
                        bigNumber: $jug.playgame,
                        setting1Denominate: 162,
                        setting2Denominate: 155,
                        setting3Denominate: 147,
                        setting4Denominate: 138,
                        setting5Denominate: 128,
                        setting6Denominate: 120
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "ボーナス合算回数")
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(8)
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
    happyJugV3View95Ci()
}
