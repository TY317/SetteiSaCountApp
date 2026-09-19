//
//  imJugExVer2ViewJissenTotalDataCheck.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/22.
//

import SwiftUI

struct imJugExVer2ViewJissenTotalDataCheck: View {
//    @ObservedObject var ver391: Ver391
    @ObservedObject var imJugEx: ImJugEx
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
                    if imJugEx.startBackCalculationEnable {
                        VStack {
                            HStack {
                                unitResultRatioDenomination2Line(
                                    title: "ぶどう確率",
                                    color: .personalSummerLightBlue,
                                    count: $imJugEx.totalBellCount,
                                    bigNumber: $imJugEx.currentGames,
                                    numberofDicimal: 2,
                                    spacerBool: false
                                )
                                unitResultRatioDenomination2Line(
                                    title: "🍒確率",
                                    count: $imJugEx.personalCherryCount,
                                    bigNumber: $imJugEx.playGame,
                                    numberofDicimal: 1,
                                    spacerBool: false
                                )
                            }
                            unitTextBackCaluculateStatus(
                                enableStatus: imJugEx.startBackCalculationEnable,
                                textAlignment: .leading,
                            )
                        }
                    } else {
                        VStack {
                            HStack {
                                unitResultRatioDenomination2Line(
                                    title: "ぶどう確率",
                                    count: $imJugEx.personalBellCount,
                                    bigNumber: $imJugEx.playGame,
                                    numberofDicimal: 2,
                                    spacerBool: false
                                )
                                unitResultRatioDenomination2Line(
                                    title: "🍒確率",
                                    count: $imJugEx.personalCherryCount,
                                    bigNumber: $imJugEx.playGame,
                                    numberofDicimal: 1,
                                    spacerBool: false
                                )
                            }
                            unitTextBackCaluculateStatus(
                                enableStatus: imJugEx.startBackCalculationEnable,
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
                        count: $imJugEx.totalBigCount,
                        bigNumber: $imJugEx.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // REG確率
                    unitResultRatioDenomination2Line(
                        title: "REG確率",
                        color: .personalSummerLightBlue,
                        count: $imJugEx.totalRegCount,
                        bigNumber: $imJugEx.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // ボーナス合算
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        color: .personalSummerLightBlue,
                        count: $imJugEx.totalBonusCountSum,
                        bigNumber: $imJugEx.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // 確率3段目
                HStack {
                    // 単独REG
                    unitResultRatioDenomination2Line(
                        title: "単独REG",
                        count: $imJugEx.personalAloneRegCount,
                        bigNumber: $imJugEx.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // 単独REG
                    unitResultRatioDenomination2Line(
                        title: "🍒REG",
                        count: $imJugEx.personalCherryRegCount,
                        bigNumber: $imJugEx.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "設定差情報",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "アイムジャグラーEX設定差",
                            tableView: AnyView(imJugExTableRatio(imJugEx: imJugEx))
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(imJugExVer2View95CiTotal(imJugEx: imJugEx)))
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    imJugExViewBayes(
//                        ver391: ver391,
                        imJugEx: imJugEx,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
                // 総ゲーム数
                unitResultCountListWithoutRatio(title: "総ゲーム数", count: $imJugEx.currentGames)
                // 自分でプレイ
                unitResultCountListWithoutRatio(title: "  (内  自分でプレイ)", count: $imJugEx.playGame)
                // //// ぶどう　逆算の状態に合わせて
                if imJugEx.startBackCalculationEnable {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ぶどう回数", count: $imJugEx.totalBellCount)
                    // 内 逆算分
                    unitResultCountListWithoutRatio(title: "  (内  逆算分)", count: $imJugEx.startBellBackCalculationCount)
                } else {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ぶどう回数", count: $imJugEx.personalBellCount)
                }
                // チェリー回数
                unitResultCountListWithoutRatio(title: "🍒回数", count: $imJugEx.personalCherryCount)
                // BIG
                unitResultCountListWithoutRatio(title: "BIG回数", count: $imJugEx.totalBigCount)
                // REG
                unitResultCountListWithoutRatio(title: "REG回数", count: $imJugEx.totalRegCount)
                // 内 単独REG
                unitResultCountListWithoutRatio(title: "  (内  単独)", count: $imJugEx.personalAloneRegCount)
                // 内 🍒REG
                unitResultCountListWithoutRatio(title: "  (内  チェリー重複)", count: $imJugEx.personalCherryRegCount)
            } header: {
                Text("総合結果")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "アイムジャグラーEX",
                screenClass: screenClass
            )
        }
        .navigationTitle("総合結果確認")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    imJugExVer2ViewJissenTotalDataCheck(
//        ver391: Ver391(),
        imJugEx: ImJugEx(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
