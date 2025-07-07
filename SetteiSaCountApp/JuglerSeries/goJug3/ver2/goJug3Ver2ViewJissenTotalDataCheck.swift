//
//  goJug3Ver2ViewJissenTotalDataCheck.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/23.
//

import SwiftUI

struct goJug3Ver2ViewJissenTotalDataCheck: View {
//    @ObservedObject var goJug3 = GoJug3()
    @ObservedObject var goJug3: GoJug3
    
    var body: some View {
        List {
            Section {
                // //// 凡例
                VStack {
                    unitResultHanrei()
                    unitResultHanrei(
                        rectangleColor: .personalSummerLightBlue,
                        textBody: "：打ち始め＋自分のプレイデータ"
                    )
                }
                
                // 確率1段目
                HStack {
                    // ぶどう
                    if goJug3.startBackCalculationEnable {
                        HStack {
                            unitResultRatioDenomination2Line(
                                title: "ぶどう確率",
                                color: .personalSummerLightBlue,
                                count: $goJug3.totalBellCount,
                                bigNumber: $goJug3.currentGames,
                                numberofDicimal: 2,
                                spacerBool: false
                            )
                            unitTextBackCaluculateStatus(enableStatus: goJug3.startBackCalculationEnable)
                        }
                    } else {
                        HStack {
                            unitResultRatioDenomination2Line(
                                title: "ぶどう確率",
                                count: $goJug3.personalBellCount,
                                bigNumber: $goJug3.playGame,
                                numberofDicimal: 2,
                                spacerBool: false
                            )
                            unitTextBackCaluculateStatus(enableStatus: goJug3.startBackCalculationEnable)
                        }
                    }
                }
                // 確率2段目
                HStack {
                    // BIG確率
                    unitResultRatioDenomination2Line(
                        title: "BIG確率",
                        color: .personalSummerLightBlue,
                        count: $goJug3.totalBigCount,
                        bigNumber: $goJug3.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // REG確率
                    unitResultRatioDenomination2Line(
                        title: "REG確率",
                        color: .personalSummerLightBlue,
                        count: $goJug3.totalRegCount,
                        bigNumber: $goJug3.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // ボーナス合算
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        color: .personalSummerLightBlue,
                        count: $goJug3.totalBonusCountSum,
                        bigNumber: $goJug3.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "設定差情報",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ゴーゴージャグラー3設定差",
                            textBody1: "・REGは単独、チェリー重複ともに均一の設定差と思われるので分けてカウントしなくてもいいらしい",
                            tableView: AnyView(goJugTableRatio(goJug3: goJug3))
//                            image1: Image("goJug3Ratio")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(goJug3Ver2View95CiTotal(goJug3: goJug3)))
//                    .popoverTip(tipUnitButtonLink95Ci())
                // 総ゲーム数
                unitResultCountListWithoutRatio(title: "総ゲーム数", count: $goJug3.currentGames)
                // 自分でプレイ
                unitResultCountListWithoutRatio(title: "  (内  自分でプレイ)", count: $goJug3.playGame)
                // //// ぶどう　逆算の状態に合わせて
                if goJug3.startBackCalculationEnable {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ぶどう回数", count: $goJug3.totalBellCount)
                    // 内 逆算分
                    unitResultCountListWithoutRatio(title: "  (内  逆算分)", count: $goJug3.startBellBackCalculationCount)
                } else {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ぶどう回数", count: $goJug3.personalBellCount)
                }
                // BIG
                unitResultCountListWithoutRatio(title: "BIG回数", count: $goJug3.totalBigCount)
                // REG
                unitResultCountListWithoutRatio(title: "REG回数", count: $goJug3.totalRegCount)
            } header: {
                Text("総合結果")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ゴーゴージャグラー3",
                screenClass: screenClass
            )
        }
        .navigationTitle("総合結果確認")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    goJug3Ver2ViewJissenTotalDataCheck(goJug3: GoJug3())
}
