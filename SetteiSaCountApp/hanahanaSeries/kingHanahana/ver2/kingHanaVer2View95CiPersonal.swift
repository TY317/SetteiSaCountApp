//
//  kingHanaVer2View95CiPersonal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/26.
//

import SwiftUI

struct kingHanaVer2View95CiPersonal: View {
    @ObservedObject var kingHana = KingHana()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // ベル回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nベル回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kingHana.bellCount,
                        bigNumber: $kingHana.playGames,
                        setting1Denominate: kingHana.denominateListBell[0],
                        setting2Denominate: kingHana.denominateListBell[1],
                        setting3Denominate: kingHana.denominateListBell[2],
                        setting4Denominate: kingHana.denominateListBell[3],
                        setting5Denominate: kingHana.denominateListBell[4],
                        setting6Denominate: kingHana.denominateListBell[5],
                        yScaleKeisu: 0.05
                    )
                )
            )
            .tag(1)
            // BIG回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nBIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kingHana.bigCount,
                        bigNumber: $kingHana.playGames,
                        setting1Denominate: kingHana.denominateListBig[0],
                        setting2Denominate: kingHana.denominateListBig[1],
                        setting3Denominate: kingHana.denominateListBig[2],
                        setting4Denominate: kingHana.denominateListBig[3],
                        setting5Denominate: kingHana.denominateListBig[4],
                        setting6Denominate: kingHana.denominateListBig[5]
                    )
                )
            )
            .tag(2)
            // REG回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nREG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kingHana.regCount,
                        bigNumber: $kingHana.playGames,
                        setting1Denominate: kingHana.denominateListReg[0],
                        setting2Denominate: kingHana.denominateListReg[1],
                        setting3Denominate: kingHana.denominateListReg[2],
                        setting4Denominate: kingHana.denominateListReg[3],
                        setting5Denominate: kingHana.denominateListReg[4],
                        setting6Denominate: kingHana.denominateListReg[5]
                    )
                )
            )
            .tag(3)
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kingHana.totalBonus,
                        bigNumber: $kingHana.playGames,
                        setting1Denominate: kingHana.denominateListBonusSum[0],
                        setting2Denominate: kingHana.denominateListBonusSum[1],
                        setting3Denominate: kingHana.denominateListBonusSum[2],
                        setting4Denominate: kingHana.denominateListBonusSum[3],
                        setting5Denominate: kingHana.denominateListBonusSum[4],
                        setting6Denominate: kingHana.denominateListBonusSum[5]
                    )
                )
            )
            .tag(4)
            // BIG中スイカ回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nBIG中スイカ回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kingHana.bbSuikaCount,
                        bigNumber: $kingHana.bigPlayGames,
                        setting1Denominate: kingHana.denominateListBbSuika[0],
                        setting2Denominate: kingHana.denominateListBbSuika[1],
                        setting3Denominate: kingHana.denominateListBbSuika[2],
                        setting4Denominate: kingHana.denominateListBbSuika[3],
                        setting5Denominate: kingHana.denominateListBbSuika[4],
                        setting6Denominate: kingHana.denominateListBbSuika[5]
                    )
                )
            )
            .tag(5)
            // BIG後ランプ合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nBIG後ランプ合算回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kingHana.bbLampCountSum,
                        bigNumber: $kingHana.bigCount,
                        setting1Percent: kingHana.percentListBbLamp[0],
                        setting2Percent: kingHana.percentListBbLamp[1],
                        setting3Percent: kingHana.percentListBbLamp[2],
                        setting4Percent: kingHana.percentListBbLamp[3],
                        setting5Percent: kingHana.percentListBbLamp[4],
                        setting6Percent: kingHana.percentListBbLamp[5]
                    )
                )
            )
            .tag(6)
            // REGサイドランプ 奇数示唆回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nREGサイドランプ 奇数示唆回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kingHana.rbLampKisuCountSum,
                        bigNumber: $kingHana.rbLampCountSum,
                        setting1Percent: kingHana.percentListRbLampKisuSisa[0],
                        setting2Percent: kingHana.percentListRbLampKisuSisa[1],
                        setting3Percent: kingHana.percentListRbLampKisuSisa[2],
                        setting4Percent: kingHana.percentListRbLampKisuSisa[3],
                        setting5Percent: kingHana.percentListRbLampKisuSisa[4],
                        setting6Percent: kingHana.percentListRbLampKisuSisa[5]
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
    kingHanaVer2View95CiPersonal()
}
