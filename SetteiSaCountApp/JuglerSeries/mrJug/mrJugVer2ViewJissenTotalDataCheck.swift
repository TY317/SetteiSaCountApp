//
//  mrJugVer2ViewJissenTotalDataCheck.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/08.
//

import SwiftUI

struct mrJugVer2ViewJissenTotalDataCheck: View {
//    @ObservedObject var ver391: Ver391
    @ObservedObject var mrJug: MrJug
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
                    if mrJug.startBackCalculationEnable {
                        VStack {
                            HStack {
                                unitResultRatioDenomination2Line(
                                    title: "ぶどう確率",
                                    color: .personalSummerLightBlue,
                                    count: $mrJug.totalBellCount,
                                    bigNumber: $mrJug.currentGames,
                                    numberofDicimal: 2,
                                    spacerBool: false
                                )
                                unitResultRatioDenomination2Line(
                                    title: "🍒確率",
                                    count: $mrJug.personalCherryCount,
                                    bigNumber: $mrJug.playGame,
                                    numberofDicimal: 1,
                                    spacerBool: false
                                )
                            }
                            unitTextBackCaluculateStatus(
                                enableStatus: mrJug.startBackCalculationEnable,
                                textAlignment: .leading,
                            )
                        }
                    } else {
                        VStack {
                            HStack {
                                unitResultRatioDenomination2Line(
                                    title: "ぶどう確率",
                                    count: $mrJug.personalBellCount,
                                    bigNumber: $mrJug.playGame,
                                    numberofDicimal: 2,
                                    spacerBool: false
                                )
                                unitResultRatioDenomination2Line(
                                    title: "🍒確率",
                                    count: $mrJug.personalCherryCount,
                                    bigNumber: $mrJug.playGame,
                                    numberofDicimal: 1,
                                    spacerBool: false
                                )
                            }
                            unitTextBackCaluculateStatus(
                                enableStatus: mrJug.startBackCalculationEnable,
                                textAlignment: .leading,
                            )
                        }
                    }
                }
                // 確率2段目
                HStack {
                    // BIG確率
                    unitResultRatioDenomination2Line(
                        title: "BIG確率",
                        color: .personalSummerLightBlue,
                        count: $mrJug.totalBigCount,
                        bigNumber: $mrJug.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // REG確率
                    unitResultRatioDenomination2Line(
                        title: "REG確率",
                        color: .personalSummerLightBlue,
                        count: $mrJug.totalRegCount,
                        bigNumber: $mrJug.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // ボーナス合算
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        color: .personalSummerLightBlue,
                        count: $mrJug.totalBonusCountSum,
                        bigNumber: $mrJug.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // 確率3段目
                HStack {
                    // 単独BIG
                    unitResultRatioDenomination2Line(
                        title: "単独BIG",
                        count: $mrJug.personalAloneBigCount,
                        bigNumber: $mrJug.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // 🍒REG
                    unitResultRatioDenomination2Line(
                        title: "🍒BIG",
                        count: $mrJug.personalCherryBigCount,
                        bigNumber: $mrJug.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // 確率4段目
                HStack {
                    // 単独REG
                    unitResultRatioDenomination2Line(
                        title: "単独REG",
                        count: $mrJug.personalAloneRegCount,
                        bigNumber: $mrJug.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // 🍒REG
                    unitResultRatioDenomination2Line(
                        title: "🍒REG",
                        count: $mrJug.personalCherryRegCount,
                        bigNumber: $mrJug.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "設定差情報",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ミスタージャグラー設定差",
                            tableView: AnyView(mrJugSubViewTableRatio(mrJug: mrJug))
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(mrJugVer2View95CiTotal(mrJug: mrJug)))
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    mrJugViewBayes(
//                        ver391: ver391,
                        mrJug: mrJug,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
                // 総ゲーム数
                unitResultCountListWithoutRatio(title: "総ゲーム数", count: $mrJug.currentGames)
                // 自分でプレイ
                unitResultCountListWithoutRatio(title: "  (内  自分でプレイ)", count: $mrJug.playGame)
                // //// ぶどう　逆算の状態に合わせて
                if mrJug.startBackCalculationEnable {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ぶどう回数", count: $mrJug.totalBellCount)
                    // 内 逆算分
                    unitResultCountListWithoutRatio(title: "  (内  逆算分)", count: $mrJug.startBellBackCalculationCount)
                } else {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ぶどう回数", count: $mrJug.personalBellCount)
                }
                // チェリー回数
                unitResultCountListWithoutRatio(title: "🍒回数", count: $mrJug.personalCherryCount)
                // BIG
                unitResultCountListWithoutRatio(title: "BIG回数", count: $mrJug.totalBigCount)
                // 内 単独BIG
                unitResultCountListWithoutRatio(title: "  (内  単独)", count: $mrJug.personalAloneBigCount)
                // 内 🍒BIG
                unitResultCountListWithoutRatio(title: "  (内  チェリー重複)", count: $mrJug.personalCherryBigCount)
                // REG
                unitResultCountListWithoutRatio(title: "REG回数", count: $mrJug.totalRegCount)
                // 内 単独REG
                unitResultCountListWithoutRatio(title: "  (内  単独)", count: $mrJug.personalAloneRegCount)
                // 内 🍒REG
                unitResultCountListWithoutRatio(title: "  (内  チェリー重複)", count: $mrJug.personalCherryRegCount)
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
    mrJugVer2ViewJissenTotalDataCheck(
//        ver391: Ver391(),
        mrJug: MrJug(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
