//
//  urmiraViewJissenTotalDataCheck.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/01.
//

import SwiftUI

struct urmiraViewJissenTotalDataCheck: View {
    @ObservedObject var urmira: Urmira
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
                    if urmira.startBackCalculationEnable {
                        VStack {
                            HStack {
                                unitResultRatioDenomination2Line(
                                    title: "ぶどう確率",
                                    color: .personalSummerLightBlue,
                                    count: $urmira.totalBellCount,
                                    bigNumber: $urmira.currentGames,
                                    numberofDicimal: 2,
                                    spacerBool: false
                                )
                                unitResultRatioDenomination2Line(
                                    title: "🍒",
                                    count: $urmira.personalCherryCount,
                                    bigNumber: $urmira.playGame,
                                    numberofDicimal: 1
                                )
                            }
//                            HStack {
                                unitTextBackCaluculateStatus(
                                    enableStatus: urmira.startBackCalculationEnable,
                                    textAlignment: .leading,
                                )
//                                Spacer()
//                            }
                        }
                    } else {
                        VStack {
                            HStack {
                                unitResultRatioDenomination2Line(
                                    title: "ぶどう確率",
                                    count: $urmira.personalBellCount,
                                    bigNumber: $urmira.playGame,
                                    numberofDicimal: 2,
                                    spacerBool: false
                                )
                                unitResultRatioDenomination2Line(
                                    title: "🍒",
                                    count: $urmira.personalCherryCount,
                                    bigNumber: $urmira.playGame,
                                    numberofDicimal: 1
                                )
                            }
//                            HStack {
                                unitTextBackCaluculateStatus(
                                    enableStatus: urmira.startBackCalculationEnable,
                                    textAlignment: .leading,
                                )
//                                Spacer()
//                            }
                        }
                    }
                }
                // 確率2段目
                HStack {
                    // BIG確率
                    unitResultRatioDenomination2Line(
                        title: "BIG確率",
                        color: .personalSummerLightBlue,
                        count: $urmira.totalBigCount,
                        bigNumber: $urmira.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // REG確率
                    unitResultRatioDenomination2Line(
                        title: "REG確率",
                        color: .personalSummerLightBlue,
                        count: $urmira.totalRegCount,
                        bigNumber: $urmira.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // ボーナス合算
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        color: .personalSummerLightBlue,
                        count: $urmira.totalBonusCountSum,
                        bigNumber: $urmira.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // 確率3段目
                HStack {
                    // 単独BIG
                    unitResultRatioDenomination2Line(
                        title: "単独BIG",
                        count: $urmira.personalAloneBigCount,
                        bigNumber: $urmira.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // 🍒REG
                    unitResultRatioDenomination2Line(
                        title: "🍒BIG",
                        count: $urmira.personalCherryBigCount,
                        bigNumber: $urmira.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // 確率4段目
                HStack {
                    // 単独REG
                    unitResultRatioDenomination2Line(
                        title: "単独REG",
                        count: $urmira.personalAloneRegCount,
                        bigNumber: $urmira.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // 🍒REG
                    unitResultRatioDenomination2Line(
                        title: "🍒REG",
                        count: $urmira.personalCherryRegCount,
                        bigNumber: $urmira.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "設定差情報",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "\(urmira.machineName)設定差",
                            tableView: AnyView(urmiraTableRatio(urmira: urmira))
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(urmiraView95CiTotal(urmira: urmira)))
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    urmiraViewBayes(
                        urmira: urmira,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
                // 総ゲーム数
                unitResultCountListWithoutRatio(title: "総ゲーム数", count: $urmira.currentGames)
                // 自分でプレイ
                unitResultCountListWithoutRatio(title: "  (内  自分でプレイ)", count: $urmira.playGame)
                // //// ぶどう　逆算の状態に合わせて
                if urmira.startBackCalculationEnable {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ぶどう回数", count: $urmira.totalBellCount)
                    // 内 逆算分
                    unitResultCountListWithoutRatio(title: "  (内  逆算分)", count: $urmira.startBellBackCalculationCount)
                } else {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ぶどう回数", count: $urmira.personalBellCount)
                }
                // チェリー回数
                unitResultCountListWithoutRatio(title: "🍒回数", count: $urmira.personalCherryCount)
                // BIG
                unitResultCountListWithoutRatio(title: "BIG回数", count: $urmira.totalBigCount)
                // 内 単独BIG
                unitResultCountListWithoutRatio(title: "  (内  単独)", count: $urmira.personalAloneBigCount)
                // 内 🍒BIG
                unitResultCountListWithoutRatio(title: "  (内  チェリー重複)", count: $urmira.personalCherryBigCount)
                // REG
                unitResultCountListWithoutRatio(title: "REG回数", count: $urmira.totalRegCount)
                // 内 単独REG
                unitResultCountListWithoutRatio(title: "  (内  単独)", count: $urmira.personalAloneRegCount)
                // 内 🍒REG
                unitResultCountListWithoutRatio(title: "  (内  チェリー重複)", count: $urmira.personalCherryRegCount)
            } header: {
                Text("総合結果")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ミスタージャグラー",
                screenClass: screenClass
            )
        }
        .navigationTitle("総合結果確認")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    urmiraViewJissenTotalDataCheck(
        urmira: Urmira(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
