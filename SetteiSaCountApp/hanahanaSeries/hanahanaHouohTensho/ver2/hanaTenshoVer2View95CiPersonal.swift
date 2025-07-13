//
//  hanaTenshoVer2View95CiPersonal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/26.
//

import SwiftUI

struct hanaTenshoVer2View95CiPersonal: View {
//    @ObservedObject var hanaTensho = HanaTensho()
    @ObservedObject var hanaTensho: HanaTensho
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // ベル回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nベル回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hanaTensho.bellCount,
                        bigNumber: $hanaTensho.playGames,
                        setting1Denominate: hanaTensho.denominateListBell[0],
                        setting2Denominate: hanaTensho.denominateListBell[1],
                        setting3Denominate: hanaTensho.denominateListBell[2],
                        setting4Denominate: hanaTensho.denominateListBell[3],
                        setting5Denominate: hanaTensho.denominateListBell[4],
                        setting6Denominate: hanaTensho.denominateListBell[5],
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
                        currentCount: $hanaTensho.bigCount,
                        bigNumber: $hanaTensho.playGames,
                        setting1Denominate: hanaTensho.denominateListBig[0],
                        setting2Denominate: hanaTensho.denominateListBig[1],
                        setting3Denominate: hanaTensho.denominateListBig[2],
                        setting4Denominate: hanaTensho.denominateListBig[3],
                        setting5Denominate: hanaTensho.denominateListBig[4],
                        setting6Denominate: hanaTensho.denominateListBig[5]
                    )
                )
            )
            .tag(2)
            // REG回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nREG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hanaTensho.regCount,
                        bigNumber: $hanaTensho.playGames,
                        setting1Denominate: hanaTensho.denominateListReg[0],
                        setting2Denominate: hanaTensho.denominateListReg[1],
                        setting3Denominate: hanaTensho.denominateListReg[2],
                        setting4Denominate: hanaTensho.denominateListReg[3],
                        setting5Denominate: hanaTensho.denominateListReg[4],
                        setting6Denominate: hanaTensho.denominateListReg[5]
                    )
                )
            )
            .tag(3)
            // ボーナス合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hanaTensho.totalBonus,
                        bigNumber: $hanaTensho.playGames,
                        setting1Denominate: hanaTensho.denominateListBonusSum[0],
                        setting2Denominate: hanaTensho.denominateListBonusSum[1],
                        setting3Denominate: hanaTensho.denominateListBonusSum[2],
                        setting4Denominate: hanaTensho.denominateListBonusSum[3],
                        setting5Denominate: hanaTensho.denominateListBonusSum[4],
                        setting6Denominate: hanaTensho.denominateListBonusSum[5]
                    )
                )
            )
            .tag(4)
            // BIG中スイカ回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nBIG中スイカ回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $hanaTensho.bbSuikaCount,
                        bigNumber: $hanaTensho.bigPlayGames,
                        setting1Denominate: hanaTensho.denominateListBbSuika[0],
                        setting2Denominate: hanaTensho.denominateListBbSuika[1],
                        setting3Denominate: hanaTensho.denominateListBbSuika[2],
                        setting4Denominate: hanaTensho.denominateListBbSuika[3],
                        setting5Denominate: hanaTensho.denominateListBbSuika[4],
                        setting6Denominate: hanaTensho.denominateListBbSuika[5]
                    )
                )
            )
            .tag(5)
            // BIG後ランプ合算回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nBIG後ランプ合算回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $hanaTensho.bbLampCountSum,
                        bigNumber: $hanaTensho.bigCount,
                        setting1Percent: hanaTensho.percentListBbLamp[0],
                        setting2Percent: hanaTensho.percentListBbLamp[1],
                        setting3Percent: hanaTensho.percentListBbLamp[2],
                        setting4Percent: hanaTensho.percentListBbLamp[3],
                        setting5Percent: hanaTensho.percentListBbLamp[4],
                        setting6Percent: hanaTensho.percentListBbLamp[5]
                    )
                )
            )
            .tag(6)
            // REGサイドランプ 奇数示唆回数
            unitListSection95Ci(
                grafTitle: "自分のプレイデータ\nREGサイドランプ 奇数示唆回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $hanaTensho.rbLampKisuCountSum,
                        bigNumber: $hanaTensho.rbLampCountSum,
                        setting1Percent: hanaTensho.percentListRbLampKisuSisa[0],
                        setting2Percent: hanaTensho.percentListRbLampKisuSisa[1],
                        setting3Percent: hanaTensho.percentListRbLampKisuSisa[2],
                        setting4Percent: hanaTensho.percentListRbLampKisuSisa[3],
                        setting5Percent: hanaTensho.percentListRbLampKisuSisa[4],
                        setting6Percent: hanaTensho.percentListRbLampKisuSisa[5]
                    )
                )
            )
            .tag(7)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ハナハナ鳳凰天翔",
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
    hanaTenshoVer2View95CiPersonal(hanaTensho: HanaTensho())
}
