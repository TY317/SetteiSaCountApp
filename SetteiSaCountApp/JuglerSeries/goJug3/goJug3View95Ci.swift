//
//  goJug3View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/24.
//

import SwiftUI

struct goJug3View95Ci: View {
    @ObservedObject var jug = goJug3()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            //ぶどう
            List {
                Section {
                    unitChart95CiDenominate(
                        currentCount: $jug.bellCount,
                        bigNumber: $jug.playGame,
                        setting1Denominate: 6.25,
                        setting2Denominate: 6.20,
                        setting3Denominate: 6.15,
                        setting4Denominate: 6.07,
                        setting5Denominate: 6.00,
                        setting6Denominate: 5.92,
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
                        setting1Denominate: 259,
                        setting2Denominate: 258,
                        setting3Denominate: 257,
                        setting4Denominate: 254,
                        setting5Denominate: 247,
                        setting6Denominate: 235
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "ビッグ回数")
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(2)
            // REG回数
            List {
                Section {
                    unitChart95CiDenominate(
                        currentCount: $jug.regCount,
                        bigNumber: $jug.playGame,
                        setting1Denominate: 354,
                        setting2Denominate: 333,
                        setting3Denominate: 306,
                        setting4Denominate: 269,
                        setting5Denominate: 247,
                        setting6Denominate: 235
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "REG回数")
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(3)
            // ボーナス合算
            List {
                Section {
                    unitChart95CiDenominate(
                        currentCount: $jug.bonusCountSum,
                        bigNumber: $jug.playGame,
                        setting1Denominate: 150,
                        setting2Denominate: 145,
                        setting3Denominate: 140,
                        setting4Denominate: 131,
                        setting5Denominate: 124,
                        setting6Denominate: 117
                    )
                } header: {
                    unitLabelMachineTopTitle(machineName: "ボーナス合算回数")
                }
//                .popoverTip(tipUnit95CiViewExplain())
            }
            .tag(4)
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
    goJug3View95Ci()
}
