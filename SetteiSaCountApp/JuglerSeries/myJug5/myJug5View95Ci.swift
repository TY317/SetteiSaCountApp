//
//  myJug5View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/24.
//

import SwiftUI

struct myJug5View95Ci: View {
    @ObservedObject var jug = myJug5Var()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // ぶどう
            List {
                Section {
                    unitChart95CiDenominate(
                        currentCount: $jug.bellCount,
                        bigNumber: $jug.playGame,
                        setting1Denominate: 5.90,
                        setting2Denominate: 5.85,
                        setting3Denominate: 5.80,
                        setting4Denominate: 5.78,
                        setting5Denominate: 5.76,
                        setting6Denominate: 5.66,
                        yScaleKeisu: 0.05
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "ぶどう回数")
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(1)
            // ビッグ回数
            List {
                Section {
                    unitChart95CiDenominate(
                        currentCount: $jug.bigCount,
                        bigNumber: $jug.playGame,
                        setting1Denominate: 273,
                        setting2Denominate: 271,
                        setting3Denominate: 266,
                        setting4Denominate: 254,
                        setting5Denominate: 240,
                        setting6Denominate: 229
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "ビッグ回数")
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(2)
            // 単独REG回数
            List {
                Section {
                    unitChart95CiDenominate(
                        currentCount: $jug.aloneRegCount,
                        bigNumber: $jug.playGame,
                        setting1Denominate: 655,
                        setting2Denominate: 596,
                        setting3Denominate: 497,
                        setting4Denominate: 405,
                        setting5Denominate: 390,
                        setting6Denominate: 328
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "単独REG回数")
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(3)
            // 🍒REG回数
            List {
                Section {
                    unitChart95CiDenominate(
                        currentCount: $jug.cherryRegCount,
                        bigNumber: $jug.playGame,
                        setting1Denominate: 1092,
                        setting2Denominate: 1092,
                        setting3Denominate: 1040,
                        setting4Denominate: 1024,
                        setting5Denominate: 862,
                        setting6Denominate: 762
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "🍒REG回数")
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(4)
            // REG合算回数
            List {
                Section {
                    unitChart95CiDenominate(
                        currentCount: $jug.regCountSum,
                        bigNumber: $jug.playGame,
                        setting1Denominate: 410,
                        setting2Denominate: 386,
                        setting3Denominate: 336,
                        setting4Denominate: 290,
                        setting5Denominate: 269,
                        setting6Denominate: 229
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "REG合算回数")
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(5)
            // ボーナス合算回数
            List {
                Section {
                    unitChart95CiDenominate(
                        currentCount: $jug.bonusCountSum,
                        bigNumber: $jug.playGame,
                        setting1Denominate: 164,
                        setting2Denominate: 159,
                        setting3Denominate: 149,
                        setting4Denominate: 135,
                        setting5Denominate: 127,
                        setting6Denominate: 115
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "ボーナス合算回数")
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(6)
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
    myJug5View95Ci()
}
