//
//  draHanaSenkohVer2View95CiPersonal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/27.
//

import SwiftUI

struct draHanaSenkohVer2View95CiPersonal: View {
//    @ObservedObject var draHanaSenkoh = DraHanaSenkoh()
    @ObservedObject var draHanaSenkoh: DraHanaSenkoh
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // ベル回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nベル回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $draHanaSenkoh.bellCount,
                        bigNumber: $draHanaSenkoh.playGames,
                        setting1Denominate: draHanaSenkoh.denominateListBell[0],
                        setting2Denominate: draHanaSenkoh.denominateListBell[1],
                        setting3Denominate: draHanaSenkoh.denominateListBell[2],
                        setting4Denominate: draHanaSenkoh.denominateListBell[3],
                        setting5Denominate: draHanaSenkoh.denominateListBell[4],
                        setting6Denominate: draHanaSenkoh.denominateListBell[5],
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
                        currentCount: $draHanaSenkoh.bigCount,
                        bigNumber: $draHanaSenkoh.playGames,
                        setting1Denominate: draHanaSenkoh.denominateListBig[0],
                        setting2Denominate: draHanaSenkoh.denominateListBig[1],
                        setting3Denominate: draHanaSenkoh.denominateListBig[2],
                        setting4Denominate: draHanaSenkoh.denominateListBig[3],
                        setting5Denominate: draHanaSenkoh.denominateListBig[4],
                        setting6Denominate: draHanaSenkoh.denominateListBig[5]
                    )
                )
            )
            .tag(2)
            // REG回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nREG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $draHanaSenkoh.regCount,
                        bigNumber: $draHanaSenkoh.playGames,
                        setting1Denominate: draHanaSenkoh.denominateListReg[0],
                        setting2Denominate: draHanaSenkoh.denominateListReg[1],
                        setting3Denominate: draHanaSenkoh.denominateListReg[2],
                        setting4Denominate: draHanaSenkoh.denominateListReg[3],
                        setting5Denominate: draHanaSenkoh.denominateListReg[4],
                        setting6Denominate: draHanaSenkoh.denominateListReg[5]
                    )
                )
            )
            .tag(3)
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $draHanaSenkoh.totalBonus,
                        bigNumber: $draHanaSenkoh.playGames,
                        setting1Denominate: draHanaSenkoh.denominateListBonusSum[0],
                        setting2Denominate: draHanaSenkoh.denominateListBonusSum[1],
                        setting3Denominate: draHanaSenkoh.denominateListBonusSum[2],
                        setting4Denominate: draHanaSenkoh.denominateListBonusSum[3],
                        setting5Denominate: draHanaSenkoh.denominateListBonusSum[4],
                        setting6Denominate: draHanaSenkoh.denominateListBonusSum[5]
                    )
                )
            )
            .tag(4)
            // BIG中スイカ回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nBIG中スイカ回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $draHanaSenkoh.bbSuikaCount,
                        bigNumber: $draHanaSenkoh.bigPlayGames,
                        setting1Denominate: draHanaSenkoh.denominateListBbSuika[0],
                        setting2Denominate: draHanaSenkoh.denominateListBbSuika[1],
                        setting3Denominate: draHanaSenkoh.denominateListBbSuika[2],
                        setting4Denominate: draHanaSenkoh.denominateListBbSuika[3],
                        setting5Denominate: draHanaSenkoh.denominateListBbSuika[4],
                        setting6Denominate: draHanaSenkoh.denominateListBbSuika[5]
                    )
                )
            )
            .tag(5)
            // BIG後ランプ合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nBIG後ランプ合算回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $draHanaSenkoh.bbLampCountSum,
                        bigNumber: $draHanaSenkoh.bigCount,
                        setting1Percent: draHanaSenkoh.percentListBbLamp[0],
                        setting2Percent: draHanaSenkoh.percentListBbLamp[1],
                        setting3Percent: draHanaSenkoh.percentListBbLamp[2],
                        setting4Percent: draHanaSenkoh.percentListBbLamp[3],
                        setting5Percent: draHanaSenkoh.percentListBbLamp[4],
                        setting6Percent: draHanaSenkoh.percentListBbLamp[5]
                    )
                )
            )
            .tag(6)
            // REGサイドランプ 奇数示唆回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nREGサイドランプ 奇数示唆回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $draHanaSenkoh.rbLampKisuCountSum,
                        bigNumber: $draHanaSenkoh.rbLampCountSum,
                        setting1Percent: draHanaSenkoh.percentListRbLampKisuSisa[0],
                        setting2Percent: draHanaSenkoh.percentListRbLampKisuSisa[1],
                        setting3Percent: draHanaSenkoh.percentListRbLampKisuSisa[2],
                        setting4Percent: draHanaSenkoh.percentListRbLampKisuSisa[3],
                        setting5Percent: draHanaSenkoh.percentListRbLampKisuSisa[4],
                        setting6Percent: draHanaSenkoh.percentListRbLampKisuSisa[5]
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
    draHanaSenkohVer2View95CiPersonal(draHanaSenkoh: DraHanaSenkoh())
}
