//
//  happyJugV3Ver2ViewJissenTotalDataCheck.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/25.
//

import SwiftUI

struct happyJugV3Ver2ViewJissenTotalDataCheck: View {
//    @ObservedObject var happyJugV3 = HappyJugV3()
    @ObservedObject var happyJugV3: HappyJugV3
    
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
                    if happyJugV3.startBackCalculationEnable {
                        HStack {
                            unitResultRatioDenomination2Line(
                                title: "ぶどう確率",
                                color: .personalSummerLightBlue,
                                count: $happyJugV3.totalBellCount,
                                bigNumber: $happyJugV3.currentGames,
                                numberofDicimal: 2,
                                spacerBool: false
                            )
                            unitTextBackCaluculateStatus(enableStatus: happyJugV3.startBackCalculationEnable)
                        }
                    } else {
                        HStack {
                            unitResultRatioDenomination2Line(
                                title: "ぶどう確率",
                                count: $happyJugV3.personalBellCount,
                                bigNumber: $happyJugV3.playGame,
                                numberofDicimal: 2,
                                spacerBool: false
                            )
                            unitTextBackCaluculateStatus(enableStatus: happyJugV3.startBackCalculationEnable)
                        }
                    }
                }
                // 確率2段目
                HStack {
                    // BIG確率
                    unitResultRatioDenomination2Line(
                        title: "BIG確率",
                        color: .personalSummerLightBlue,
                        count: $happyJugV3.totalBigCount,
                        bigNumber: $happyJugV3.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // REG確率
                    unitResultRatioDenomination2Line(
                        title: "REG確率",
                        color: .personalSummerLightBlue,
                        count: $happyJugV3.totalRegCount,
                        bigNumber: $happyJugV3.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // ボーナス合算
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        color: .personalSummerLightBlue,
                        count: $happyJugV3.totalBonusCountSum,
                        bigNumber: $happyJugV3.currentGames,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // 確率3段目
                HStack {
                    // 単独BIG
                    unitResultRatioDenomination2Line(
                        title: "単独BIG",
                        count: $happyJugV3.personalAloneBigCount,
                        bigNumber: $happyJugV3.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // 🍒REG
                    unitResultRatioDenomination2Line(
                        title: "🍒BIG",
                        count: $happyJugV3.personalCherryBigCount,
                        bigNumber: $happyJugV3.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // 確率4段目
                HStack {
                    // 単独REG
                    unitResultRatioDenomination2Line(
                        title: "単独REG",
                        count: $happyJugV3.personalAloneRegCount,
                        bigNumber: $happyJugV3.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // 🍒REG
                    unitResultRatioDenomination2Line(
                        title: "🍒REG",
                        count: $happyJugV3.personalCherryRegCount,
                        bigNumber: $happyJugV3.playGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "設定差情報",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ハッピージャグラーV3設定差",
                            image1: Image("happyJugV3Analysis")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(happyJugV3Ver2View95CiTotal(happyJugV3: happyJugV3)))
                    .popoverTip(tipUnitButtonLink95Ci())
                // 総ゲーム数
                unitResultCountListWithoutRatio(title: "総ゲーム数", count: $happyJugV3.currentGames)
                // 自分でプレイ
                unitResultCountListWithoutRatio(title: "  (内  自分でプレイ)", count: $happyJugV3.playGame)
                // //// ぶどう　逆算の状態に合わせて
                if happyJugV3.startBackCalculationEnable {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ぶどう回数", count: $happyJugV3.totalBellCount)
                    // 内 逆算分
                    unitResultCountListWithoutRatio(title: "  (内  逆算分)", count: $happyJugV3.startBellBackCalculationCount)
                } else {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ぶどう回数", count: $happyJugV3.personalBellCount)
                }
                // BIG
                unitResultCountListWithoutRatio(title: "BIG回数", count: $happyJugV3.totalBigCount)
                // 内 単独BIG
                unitResultCountListWithoutRatio(title: "  (内  単独)", count: $happyJugV3.personalAloneBigCount)
                // 内 🍒BIG
                unitResultCountListWithoutRatio(title: "  (内  チェリー重複)", count: $happyJugV3.personalCherryBigCount)
                // REG
                unitResultCountListWithoutRatio(title: "REG回数", count: $happyJugV3.totalRegCount)
                // 内 単独REG
                unitResultCountListWithoutRatio(title: "  (内  単独)", count: $happyJugV3.personalAloneRegCount)
                // 内 🍒REG
                unitResultCountListWithoutRatio(title: "  (内  チェリー重複)", count: $happyJugV3.personalCherryRegCount)
            } header: {
                Text("総合結果")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ハッピージャグラーV3",
                screenClass: screenClass
            )
        }
        .navigationTitle("総合結果確認")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    happyJugV3Ver2ViewJissenTotalDataCheck(happyJugV3: HappyJugV3())
}
