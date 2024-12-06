//
//  imJugExView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/24.
//

import SwiftUI

struct imJugExView95Ci: View {
    @ObservedObject var jug = imJugEx()
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
                        setting1Denominate: 6.02,
                        setting2Denominate: 6.02,
                        setting3Denominate: 6.02,
                        setting4Denominate: 6.02,
                        setting5Denominate: 6.02,
                        setting6Denominate: 5.78,
                        yScaleKeisu: 0.05
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "ぶどう回数")
                }
                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(1)
            // ビッグ回数
            List {
                Section {
                    unitChart95CiDenominate(
                        currentCount: $jug.bigCount,
                        bigNumber: $jug.playGame,
                        setting1Denominate: 273,
                        setting2Denominate: 270,
                        setting3Denominate: 270,
                        setting4Denominate: 259,
                        setting5Denominate: 259,
                        setting6Denominate: 255
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "ビッグ回数")
                }
                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(2)
            // 単独REG回数
            List {
                Section {
                    unitChart95CiDenominate(
                        currentCount: $jug.regCountAlone,
                        bigNumber: $jug.playGame,
                        setting1Denominate: 630,
                        setting2Denominate: 575,
                        setting3Denominate: 475,
                        setting4Denominate: 449,
                        setting5Denominate: 364,
                        setting6Denominate: 364
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "単独REG回数")
                }
                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(3)
            // 🍒REG回数
            List {
                Section {
                    unitChart95CiDenominate(
                        currentCount: $jug.regCountCherry,
                        bigNumber: $jug.playGame,
                        setting1Denominate: 1456,
                        setting2Denominate: 1311,
                        setting3Denominate: 1092,
                        setting4Denominate: 1057,
                        setting5Denominate: 851,
                        setting6Denominate: 851
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "🍒REG回数")
                }
                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(4)
            // REG合算回数
            unitListSection95Ci(
                grafTitle: "REG合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $jug.regCountSum,
                        bigNumber: $jug.playGame,
                        setting1Denominate: 440,
                        setting2Denominate: 400,
                        setting3Denominate: 331,
                        setting4Denominate: 315,
                        setting5Denominate: 255,
                        setting6Denominate: 255
                    )
                )
            )
            .tag(5)
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $jug.bonusCountSum,
                        bigNumber: $jug.playGame,
                        setting1Denominate: 169,
                        setting2Denominate: 161,
                        setting3Denominate: 149,
                        setting4Denominate: 142,
                        setting5Denominate: 129,
                        setting6Denominate: 128
                    )
                )
            )
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
    imJugExView95Ci()
}
