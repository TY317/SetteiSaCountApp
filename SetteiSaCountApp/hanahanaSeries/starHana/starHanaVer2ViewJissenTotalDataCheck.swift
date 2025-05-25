//
//  starHanaVer2ViewJissenTotalDataCheck.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/15.
//

import SwiftUI

struct starHanaVer2ViewJissenTotalDataCheck: View {
//    @ObservedObject var starHana = StarHana()
    @ObservedObject var starHana: StarHana
    
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
                // //// 通常時
                VStack {
                    // セクションタイトル
                    HStack {
                        Text("  [通常時]")
                            .foregroundStyle(Color.secondary)
                            .font(.footnote)
                        Spacer()
                    }
                    // 確率1段目
                    HStack {
                        // ぶどう
                        if starHana.startBackCalculationEnable {
                            HStack {
                                unitResultRatioDenomination2Line(
                                    title: "ベル確率",
                                    color: .personalSummerLightBlue,
                                    count: $starHana.totalBellCount,
                                    bigNumber: $starHana.currentGames,
                                    numberofDicimal: 2,
                                    spacerBool: false
                                )
                                unitTextBackCaluculateStatus(enableStatus: starHana.startBackCalculationEnable)
                            }
                        } else {
                            HStack {
                                unitResultRatioDenomination2Line(
                                    title: "ベル確率",
                                    count: $starHana.bellCount,
                                    bigNumber: $starHana.playGames,
                                    numberofDicimal: 2,
                                    spacerBool: false
                                )
                                unitTextBackCaluculateStatus(enableStatus: starHana.startBackCalculationEnable)
                            }
                        }
                    }
                    // 確率2段目
                    HStack {
                        // BIG確率
                        unitResultRatioDenomination2Line(
                            title: "BIG確率",
                            color: .personalSummerLightBlue,
                            count: $starHana.totalBigCount,
                            bigNumber: $starHana.currentGames,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // REG確率
                        unitResultRatioDenomination2Line(
                            title: "REG確率",
                            color: .personalSummerLightBlue,
                            count: $starHana.totalRegCount,
                            bigNumber: $starHana.currentGames,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // ボーナス合算
                        unitResultRatioDenomination2Line(
                            title: "ボーナス合算",
                            color: .personalSummerLightBlue,
                            count: $starHana.totalBonusCountSum,
                            bigNumber: $starHana.currentGames,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                    }
                }
                // //// BB中
                VStack {
                    // セクションタイトル
                    HStack {
                        Text("  [BB中]")
                            .foregroundStyle(Color.secondary)
                            .font(.footnote)
                        Spacer()
                    }
                    // 確率結果
                    HStack {
                        // スイカ確率
                        unitResultRatioDenomination2Line(
                            title: "スイカ確率",
                            count: $starHana.bbSuikaCount,
                            bigNumber: $starHana.bigPlayGames,
                            numberofDicimal: 1,
                            spacerBool: false
                        )
                        // フェザーランプ
                        unitResultRatioPercent2Line(
                            title: "ランプ合算",
                            color: Color("grayBack"),
                            count: $starHana.bbLampCountSum,
                            bigNumber: $starHana.bigCount,
                            numberofDicimal: 1,
                            spacerBool: false
                        )
                    }
                }
                // //// RB中
                VStack {
                    // セクションタイトル
                    HStack {
                        Text("  [RB中サイドランプ]")
                            .foregroundStyle(Color.secondary)
                            .font(.footnote)
                        Spacer()
                    }
                    // サイドランプ示唆
                    HStack {
                        // 奇数示唆
                        unitResultRatioPercent2Line(title: "奇数示唆", color: .grayBack, count: $starHana.rbLampKisuCountSum, bigNumber: $starHana.rbLampCountSum, numberofDicimal: 0, spacerBool: false)
                        // 偶数示唆
                        unitResultRatioPercent2Line(title: "偶数示唆", color: .grayBack, count: $starHana.rbLampGusuCountSum, bigNumber: $starHana.rbLampCountSum, numberofDicimal: 0, spacerBool: false)
                    }
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "ベル,ボーナス確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ベル・ボーナス確率",
                            tableView: AnyView(starHanaTableBellBonus(starHana: starHana))
//                            image1: Image("starHanaBellBonusAnalysis")
                        )
                    )
                )
                unitLinkButton(
                    title: "BB中のスイカについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "BIG中スイカ確率",
                            tableView: AnyView(hanahanaCommonTableBigSuika())
//                            image1Title: "[参考] 過去のハナハナシリーズ数値",
//                            image1:Image("hanaCommonBbSuika")
                        )
                    )
                )
                unitLinkButton(
                    title: "BIG後のフェザーランプについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "BIG後のフェザーランプ確率",
                            tableView: AnyView(hanahanaCommonTableBigLamp())
//                            image1Title: "[参考] 過去のハナハナシリーズ数値",
//                            image1:Image("hanaCommonBbLamp")
                        )
                    )
                )
                unitLinkButton(
                    title: "REG中のサイドランプについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "REG中のサイドランプ確率",
                            textBody1: "・REG中に1回だけ確認可能",
                            textBody2: "・左リール中段に白７ビタ押し",
                            textBody3: "　成功したら中・右にスイカを狙う",
                            textBody4: "・奇数設定は青・緑が６割、偶数は黄・赤が６割。\n　ただし、設定６のみ全色均等に出現する",
                            tableView: AnyView(hanahanaCommonTableRegSideLamp())
//                            image1Title: "[参考] 過去のハナハナシリーズ数値",
//                            image1: Image("hanaCommonRbSideLamp")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(starHanaVer2View95CiTotal(starHana: starHana)))
                    .popoverTip(tipUnitButtonLink95Ci())
                // 総ゲーム数
                unitResultCountListWithoutRatio(title: "総ゲーム数", count: $starHana.currentGames)
                // 自分でプレイ
                unitResultCountListWithoutRatio(title: "  (内  自分でプレイ)", count: $starHana.playGames)
                // //// ぶどう　逆算の状態に合わせて
                if starHana.startBackCalculationEnable {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ベル回数", count: $starHana.totalBellCount)
                    // 内 逆算分
                    unitResultCountListWithoutRatio(title: "  (内  逆算分)", count: $starHana.startBellBackCalculationCount)
                } else {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ベル回数", count: $starHana.bellCount)
                }
                // BIG
                unitResultCountListWithoutRatio(title: "BIG回数", count: $starHana.totalBigCount)
                // REG
                unitResultCountListWithoutRatio(title: "REG回数", count: $starHana.totalRegCount)
                // BB中スイカ
                unitResultCountListWithoutRatio(title: "BB中スイカ回数", count: $starHana.bbSuikaCount)
                // BB後フェザーランプ
                unitResultCountListWithoutRatio(title: "BB後ランプ合算回数", count: $starHana.bbLampCountSum)
                // 内 青
                unitResultCountListWithoutRatio(title: "  (内 　青)", count: $starHana.bbLampBCount)
                // 内 黄
                unitResultCountListWithoutRatio(title: "  (内 　黄)", count: $starHana.bbLampYCount)
                // 内 緑
                unitResultCountListWithoutRatio(title: "  (内 　緑)", count: $starHana.bbLampGCount)
                // 内 赤
                unitResultCountListWithoutRatio(title: "  (内 　赤)", count: $starHana.bbLampRCount)
                // RB中サイドランプ 青
                unitResultCountListWithoutRatio(title: "RBサイドランプ 青", count: $starHana.rbLampBCount)
                // RB中サイドランプ 黄
                unitResultCountListWithoutRatio(title: "RBサイドランプ 黄", count: $starHana.rbLampYCount)
                // RB中サイドランプ 緑
                unitResultCountListWithoutRatio(title: "RBサイドランプ 緑", count: $starHana.rbLampGCount)
                // RB中サイドランプ 赤
                unitResultCountListWithoutRatio(title: "RBサイドランプ 赤", count: $starHana.rbLampRCount)
            } header: {
                Text("総合結果")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "スターハナハナ",
                screenClass: screenClass
            )
        }
        .navigationTitle("総合結果確認")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    starHanaVer2ViewJissenTotalDataCheck(starHana: StarHana())
}
