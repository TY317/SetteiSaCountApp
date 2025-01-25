//
//  myJug5Ver2ViewJissenTotalDataCheck.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/19.
//

import SwiftUI

struct myJug5Ver2ViewJissenTotalDataCheck: View {
    @ObservedObject var myJug5 = MyJug5()
    
    var body: some View {
        List {
            Section {
                // 確率1段目
                HStack {
                    // ぶどう
                    if myJug5.startBackCalculationEnable {
                        HStack {
                            unitResultRatioDenomination2Line(
                                title: "ぶどう確率",
                                count: $myJug5.totalBellCount,
                                bigNumber: $myJug5.currentGames,
                                numberofDicimal: 2,
                                spacerBool: false
                            )
                            unitTextBackCaluculateStatus(enableStatus: myJug5.startBackCalculationEnable)
                        }
                    } else {
                        HStack {
                            unitResultRatioDenomination2Line(
                                title: "ぶどう確率",
                                count: $myJug5.personalBellCount,
                                bigNumber: $myJug5.playGame,
                                numberofDicimal: 2,
                                spacerBool: false
                            )
                            unitTextBackCaluculateStatus(enableStatus: myJug5.startBackCalculationEnable)
                        }
                    }
                }
                // 確率2段目
                HStack {
                    // BIG確率
                    unitResultRatioDenomination2Line(
                        title: "BIG確率",
                        count: $myJug5.totalBigCount,
                        bigNumber: $myJug5.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // REG確率
                    unitResultRatioDenomination2Line(
                        title: "REG確率",
                        count: $myJug5.totalRegCount,
                        bigNumber: $myJug5.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // ボーナス合算
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        count: $myJug5.totalBonusCountSum,
                        bigNumber: $myJug5.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // 確率3段目
                HStack {
                    // 単独REG
                    unitResultRatioDenomination2Line(
                        title: "単独REG",
                        count: $myJug5.personalAloneRegCount,
                        bigNumber: $myJug5.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // 単独REG
                    unitResultRatioDenomination2Line(
                        title: "🍒REG",
                        count: $myJug5.personalCherryRegCount,
                        bigNumber: $myJug5.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "設定差情報",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "マイジャグラー5設定差",
                            image1: Image("myJug5Analysis")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(myJug5Ver2View95CiTotal()))
                    .popoverTip(tipUnitButtonLink95Ci())
                // 総ゲーム数
                unitResultCountListWithoutRatio(title: "総ゲーム数", count: $myJug5.currentGames)
                // 自分でプレイ
                unitResultCountListWithoutRatio(title: "  (内  自分でプレイ)", count: $myJug5.playGame)
                // //// ぶどう　逆算の状態に合わせて
                if myJug5.startBackCalculationEnable {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ぶどう回数", count: $myJug5.totalBellCount)
                    // 内 逆算分
                    unitResultCountListWithoutRatio(title: "  (内  逆算分)", count: $myJug5.startBellBackCalculationCount)
                } else {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ぶどう回数", count: $myJug5.personalBellCount)
                }
                // BIG
                unitResultCountListWithoutRatio(title: "BIG回数", count: $myJug5.totalBigCount)
                // REG
                unitResultCountListWithoutRatio(title: "REG回数", count: $myJug5.totalRegCount)
                // 内 単独REG
                unitResultCountListWithoutRatio(title: "  (内  単独)", count: $myJug5.personalAloneRegCount)
                // 内 🍒REG
                unitResultCountListWithoutRatio(title: "  (内  チェリー重複)", count: $myJug5.personalCherryRegCount)
            } header: {
                Text("総合結果")
            }
        }
        .navigationTitle("総合結果確認")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    myJug5Ver2ViewJissenTotalDataCheck()
}
