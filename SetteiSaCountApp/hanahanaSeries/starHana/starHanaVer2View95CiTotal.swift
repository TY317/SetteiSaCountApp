//
//  starHanaVer2View95CiTotal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/15.
//

import SwiftUI

struct starHanaVer2View95CiTotal: View {
//    @ObservedObject var starHana = StarHana()
    @ObservedObject var starHana: StarHana
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // //// ベル逆算ON
            if starHana.startBackCalculationEnable {
                // ベル回数、逆算分含む
                unitListSection95Ci(
                    grafTitle: "総合結果\nベル回数",
                    grafView: AnyView(
                        unitChart95CiDenominate(
                            currentCount: $starHana.totalBellCount,
                            bigNumber: $starHana.currentGames,
                            setting1Denominate: starHana.denominateListBell[0],
                            setting2Denominate: starHana.denominateListBell[1],
                            setting3Denominate: starHana.denominateListBell[2],
                            setting4Denominate: starHana.denominateListBell[3],
                            setting5Denominate: starHana.denominateListBell[4],
                            setting6Denominate: starHana.denominateListBell[5],
                            yScaleKeisu: 0.05
                        )
                    )
                )
                .tag(1)
            }
            // //// ベル逆算OFF
            else {
                // ベル回数、自分の分のみ
                unitListSection95Ci(
                    grafTitle: "自分のプレイデータ\nベル回数",
                    grafView: AnyView(
                        unitChart95CiDenominate(
                            currentCount: $starHana.bellCount,
                            bigNumber: $starHana.playGames,
                            setting1Denominate: starHana.denominateListBell[0],
                            setting2Denominate: starHana.denominateListBell[1],
                            setting3Denominate: starHana.denominateListBell[2],
                            setting4Denominate: starHana.denominateListBell[3],
                            setting5Denominate: starHana.denominateListBell[4],
                            setting6Denominate: starHana.denominateListBell[5],
                            yScaleKeisu: 0.05
                        )
                    )
                )
                .tag(1)
            }
            // BIG回数
            unitListSection95Ci(
                grafTitle: "総合結果\nBIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $starHana.totalBigCount,
                        bigNumber: $starHana.currentGames,
                        setting1Denominate: starHana.denominateListBig[0],
                        setting2Denominate: starHana.denominateListBig[1],
                        setting3Denominate: starHana.denominateListBig[2],
                        setting4Denominate: starHana.denominateListBig[3],
                        setting5Denominate: starHana.denominateListBig[4],
                        setting6Denominate: starHana.denominateListBig[5]
                    )
                )
            )
            .tag(2)
            // REG回数
            unitListSection95Ci(
                grafTitle: "総合結果\nREG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $starHana.totalRegCount,
                        bigNumber: $starHana.currentGames,
                        setting1Denominate: starHana.denominateListReg[0],
                        setting2Denominate: starHana.denominateListReg[1],
                        setting3Denominate: starHana.denominateListReg[2],
                        setting4Denominate: starHana.denominateListReg[3],
                        setting5Denominate: starHana.denominateListReg[4],
                        setting6Denominate: starHana.denominateListReg[5]
                    )
                )
            )
            .tag(3)
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "総合結果\nボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $starHana.totalBonusCountSum,
                        bigNumber: $starHana.currentGames,
                        setting1Denominate: starHana.denominateListBonusSum[0],
                        setting2Denominate: starHana.denominateListBonusSum[1],
                        setting3Denominate: starHana.denominateListBonusSum[2],
                        setting4Denominate: starHana.denominateListBonusSum[3],
                        setting5Denominate: starHana.denominateListBonusSum[4],
                        setting6Denominate: starHana.denominateListBonusSum[5]
                    )
                )
            )
            .tag(4)
            // BIG中スイカ回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nBIG中スイカ回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $starHana.bbSuikaCount,
                        bigNumber: $starHana.bigPlayGames,
                        setting1Denominate: starHana.denominateListBbSuika[0],
                        setting2Denominate: starHana.denominateListBbSuika[1],
                        setting3Denominate: starHana.denominateListBbSuika[2],
                        setting4Denominate: starHana.denominateListBbSuika[3],
                        setting5Denominate: starHana.denominateListBbSuika[4],
                        setting6Denominate: starHana.denominateListBbSuika[5]
                    )
                )
            )
            .tag(5)
            // BIG後ランプ合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nBIG後ランプ合算回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $starHana.bbLampCountSum,
                        bigNumber: $starHana.bigCount,
                        setting1Percent: starHana.percentListBbLamp[0],
                        setting2Percent: starHana.percentListBbLamp[1],
                        setting3Percent: starHana.percentListBbLamp[2],
                        setting4Percent: starHana.percentListBbLamp[3],
                        setting5Percent: starHana.percentListBbLamp[4],
                        setting6Percent: starHana.percentListBbLamp[5]
                    )
                )
            )
            .tag(6)
            // REGサイドランプ 奇数示唆回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nREGサイドランプ 奇数示唆回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $starHana.rbLampKisuCountSum,
                        bigNumber: $starHana.rbLampCountSum,
                        setting1Percent: starHana.percentListRbLampKisuSisa[0],
                        setting2Percent: starHana.percentListRbLampKisuSisa[1],
                        setting3Percent: starHana.percentListRbLampKisuSisa[2],
                        setting4Percent: starHana.percentListRbLampKisuSisa[3],
                        setting5Percent: starHana.percentListRbLampKisuSisa[4],
                        setting6Percent: starHana.percentListRbLampKisuSisa[5]
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
    starHanaVer2View95CiTotal(starHana: StarHana())
}
