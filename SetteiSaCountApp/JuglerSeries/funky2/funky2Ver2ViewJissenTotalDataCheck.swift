//
//  funky2Ver2ViewJissenTotalDataCheck.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/09.
//

import SwiftUI

struct funky2Ver2ViewJissenTotalDataCheck: View {
//    @ObservedObject var ver391: Ver391
    @ObservedObject var funky2: Funky2
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    
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
                    if funky2.startBackCalculationEnable {
                        HStack {
                            unitResultRatioDenomination2Line(
                                title: "ぶどう確率",
                                color: .personalSummerLightBlue,
                                count: $funky2.totalBellCount,
                                bigNumber: $funky2.currentGames,
                                numberofDicimal: 2,
                                spacerBool: false
                            )
                            unitTextBackCaluculateStatus(enableStatus: funky2.startBackCalculationEnable)
                        }
                    } else {
                        HStack {
                            unitResultRatioDenomination2Line(
                                title: "ぶどう確率",
                                count: $funky2.personalBellCount,
                                bigNumber: $funky2.playGame,
                                numberofDicimal: 2,
                                spacerBool: false
                            )
                            unitTextBackCaluculateStatus(enableStatus: funky2.startBackCalculationEnable)
                        }
                    }
                }
                // 確率2段目
                HStack {
                    // BIG確率
                    unitResultRatioDenomination2Line(
                        title: "BIG確率",
                        color: .personalSummerLightBlue,
                        count: $funky2.totalBigCount,
                        bigNumber: $funky2.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // REG確率
                    unitResultRatioDenomination2Line(
                        title: "REG確率",
                        color: .personalSummerLightBlue,
                        count: $funky2.totalRegCount,
                        bigNumber: $funky2.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // ボーナス合算
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        color: .personalSummerLightBlue,
                        count: $funky2.totalBonusCountSum,
                        bigNumber: $funky2.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // 確率3段目
                HStack {
                    // 単独BIG
                    unitResultRatioDenomination2Line(
                        title: "単独BIG",
                        count: $funky2.personalAloneBigCount,
                        bigNumber: $funky2.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // 🍒REG
                    unitResultRatioDenomination2Line(
                        title: "🍒BIG",
                        count: $funky2.personalCherryBigCount,
                        bigNumber: $funky2.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // 確率4段目
                HStack {
                    // 単独REG
                    unitResultRatioDenomination2Line(
                        title: "単独REG",
                        count: $funky2.personalAloneRegCount,
                        bigNumber: $funky2.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // 🍒REG
                    unitResultRatioDenomination2Line(
                        title: "🍒REG",
                        count: $funky2.personalCherryRegCount,
                        bigNumber: $funky2.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "設定差情報",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ファンキージャグラー2設定差",
                            tableView: AnyView(funky2TableRatio(funky2: funky2))
//                            image1: Image("funky2Analysis")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(funky2Ver2View95CiTotal(funky2: funky2)))
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    funky2ViewBayes(
//                        ver391: ver391,
                        funky2: funky2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
                // 総ゲーム数
                unitResultCountListWithoutRatio(title: "総ゲーム数", count: $funky2.currentGames)
                // 自分でプレイ
                unitResultCountListWithoutRatio(title: "  (内  自分でプレイ)", count: $funky2.playGame)
                // //// ぶどう　逆算の状態に合わせて
                if funky2.startBackCalculationEnable {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ぶどう回数", count: $funky2.totalBellCount)
                    // 内 逆算分
                    unitResultCountListWithoutRatio(title: "  (内  逆算分)", count: $funky2.startBellBackCalculationCount)
                } else {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ぶどう回数", count: $funky2.personalBellCount)
                }
                // BIG
                unitResultCountListWithoutRatio(title: "BIG回数", count: $funky2.totalBigCount)
                // 内 単独BIG
                unitResultCountListWithoutRatio(title: "  (内  単独)", count: $funky2.personalAloneBigCount)
                // 内 🍒BIG
                unitResultCountListWithoutRatio(title: "  (内  チェリー重複)", count: $funky2.personalCherryBigCount)
                // REG
                unitResultCountListWithoutRatio(title: "REG回数", count: $funky2.totalRegCount)
                // 内 単独REG
                unitResultCountListWithoutRatio(title: "  (内  単独)", count: $funky2.personalAloneRegCount)
                // 内 🍒REG
                unitResultCountListWithoutRatio(title: "  (内  チェリー重複)", count: $funky2.personalCherryRegCount)
            } header: {
                Text("総合結果")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ファンキージャグラー2",
                screenClass: screenClass
            )
        }
        .navigationTitle("総合結果確認")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    funky2Ver2ViewJissenTotalDataCheck(
//        ver391: Ver391(),
        funky2: Funky2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
