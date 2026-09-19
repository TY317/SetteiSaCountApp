//
//  girlsSSVer2ViewJissenTotalDataCheck.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/09.
//

import SwiftUI

struct girlsSSVer2ViewJissenTotalDataCheck: View {
//    @ObservedObject var ver391: Ver391
    @ObservedObject var girlsSS: GirlsSS
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
                    if girlsSS.startBackCalculationEnable {
                        VStack {
                            HStack {
                                unitResultRatioDenomination2Line(
                                    title: "ぶどう確率",
                                    color: .personalSummerLightBlue,
                                    count: $girlsSS.totalBellCount,
                                    bigNumber: $girlsSS.currentGames,
                                    numberofDicimal: 2,
                                    spacerBool: false
                                )
                                unitResultRatioDenomination2Line(
                                    title: "🍒確率",
                                    count: $girlsSS.personalCherryCount,
                                    bigNumber: $girlsSS.playGame,
                                    numberofDicimal: 1,
                                    spacerBool: false
                                )
                            }
                            unitTextBackCaluculateStatus(
                                enableStatus: girlsSS.startBackCalculationEnable,
                                textAlignment: .leading,
                            )
                        }
                    } else {
                        VStack {
                            HStack {
                                unitResultRatioDenomination2Line(
                                    title: "ぶどう確率",
                                    count: $girlsSS.personalBellCount,
                                    bigNumber: $girlsSS.playGame,
                                    numberofDicimal: 2,
                                    spacerBool: false
                                )
                                unitResultRatioDenomination2Line(
                                    title: "🍒確率",
                                    count: $girlsSS.personalCherryCount,
                                    bigNumber: $girlsSS.playGame,
                                    numberofDicimal: 1,
                                    spacerBool: false
                                )
                            }
                            unitTextBackCaluculateStatus(
                                enableStatus: girlsSS.startBackCalculationEnable,
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
                        count: $girlsSS.totalBigCount,
                        bigNumber: $girlsSS.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // REG確率
                    unitResultRatioDenomination2Line(
                        title: "REG確率",
                        color: .personalSummerLightBlue,
                        count: $girlsSS.totalRegCount,
                        bigNumber: $girlsSS.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // ボーナス合算
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        color: .personalSummerLightBlue,
                        count: $girlsSS.totalBonusCountSum,
                        bigNumber: $girlsSS.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
//                // 確率3段目
//                HStack {
//                    // 単独BIG
//                    unitResultRatioDenomination2Line(
//                        title: "単独BIG",
//                        count: $girlsSS.personalAloneBigCount,
//                        bigNumber: $girlsSS.playGame,
//                        numberofDicimal: 0,
//                        spacerBool: false
//                    )
//                    // 🍒REG
//                    unitResultRatioDenomination2Line(
//                        title: "🍒BIG",
//                        count: $girlsSS.personalCherryBigCount,
//                        bigNumber: $girlsSS.playGame,
//                        numberofDicimal: 0,
//                        spacerBool: false
//                    )
//                }
                // 確率4段目
                HStack {
                    // 単独REG
                    unitResultRatioDenomination2Line(
                        title: "単独REG",
                        count: $girlsSS.personalAloneRegCount,
                        bigNumber: $girlsSS.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // 🍒REG
                    unitResultRatioDenomination2Line(
                        title: "🍒REG",
                        count: $girlsSS.personalCherryRegCount,
                        bigNumber: $girlsSS.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "設定差情報",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ジャグラーガールズSS設定差",
                            tableView: AnyView(girlsSSTableRatio(girlsSS: girlsSS))
//                            image1: Image("girlsSSAnalysis"),
//                            image2Title: "[5号機数値からの予測値]\n※ただの予測です。参考程度としてください",
//                            image2: Image("girlsSSYosoku")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(girlsSSVer2View95CiTotal(girlsSS: girlsSS)))
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    girlsSSViewBayes(
//                        ver391: ver391,
                        girlsSS: girlsSS,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
                // 総ゲーム数
                unitResultCountListWithoutRatio(title: "総ゲーム数", count: $girlsSS.currentGames)
                // 自分でプレイ
                unitResultCountListWithoutRatio(title: "  (内  自分でプレイ)", count: $girlsSS.playGame)
                // //// ぶどう　逆算の状態に合わせて
                if girlsSS.startBackCalculationEnable {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ぶどう回数", count: $girlsSS.totalBellCount)
                    // 内 逆算分
                    unitResultCountListWithoutRatio(title: "  (内  逆算分)", count: $girlsSS.startBellBackCalculationCount)
                } else {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ぶどう回数", count: $girlsSS.personalBellCount)
                }
                // チェリー回数
                unitResultCountListWithoutRatio(title: "🍒回数", count: $girlsSS.personalCherryCount)
                // BIG
                unitResultCountListWithoutRatio(title: "BIG回数", count: $girlsSS.totalBigCount)
//                // 内 単独BIG
//                unitResultCountListWithoutRatio(title: "  (内  単独)", count: $girlsSS.personalAloneBigCount)
//                // 内 🍒BIG
//                unitResultCountListWithoutRatio(title: "  (内  チェリー重複)", count: $girlsSS.personalCherryBigCount)
                // REG
                unitResultCountListWithoutRatio(title: "REG回数", count: $girlsSS.totalRegCount)
                // 内 単独REG
                unitResultCountListWithoutRatio(title: "  (内  単独)", count: $girlsSS.personalAloneRegCount)
                // 内 🍒REG
                unitResultCountListWithoutRatio(title: "  (内  チェリー重複)", count: $girlsSS.personalCherryRegCount)
            } header: {
                Text("総合結果")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ジャグラーガールズSS",
                screenClass: screenClass
            )
        }
        .navigationTitle("総合結果確認")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    girlsSSVer2ViewJissenTotalDataCheck(
//        ver391: Ver391(),
        girlsSS: GirlsSS(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
