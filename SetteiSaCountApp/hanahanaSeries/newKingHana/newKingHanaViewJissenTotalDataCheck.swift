//
//  newKingHanaViewJissenTotalDataCheck.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/21.
//

import SwiftUI

struct newKingHanaViewJissenTotalDataCheck: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var newKingHana: NewKingHana
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
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
                        if newKingHana.startBackCalculationEnable {
                            HStack {
                                unitResultRatioDenomination2Line(
                                    title: "ベル確率",
                                    color: .personalSummerLightBlue,
                                    count: $newKingHana.totalBellCount,
                                    bigNumber: $newKingHana.currentGames,
                                    numberofDicimal: 2,
                                    spacerBool: false
                                )
                                unitTextBackCaluculateStatus(enableStatus: newKingHana.startBackCalculationEnable)
                            }
                        } else {
                            HStack {
                                unitResultRatioDenomination2Line(
                                    title: "ベル確率",
                                    count: $newKingHana.bellCount,
                                    bigNumber: $newKingHana.playGames,
                                    numberofDicimal: 2,
                                    spacerBool: false
                                )
                                unitTextBackCaluculateStatus(enableStatus: newKingHana.startBackCalculationEnable)
                            }
                        }
                    }
                    // 確率2段目
                    HStack {
                        // BIG確率
                        unitResultRatioDenomination2Line(
                            title: "BIG確率",
                            color: .personalSummerLightBlue,
                            count: $newKingHana.totalBigCount,
                            bigNumber: $newKingHana.currentGames,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // REG確率
                        unitResultRatioDenomination2Line(
                            title: "REG確率",
                            color: .personalSummerLightBlue,
                            count: $newKingHana.totalRegCount,
                            bigNumber: $newKingHana.currentGames,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // ボーナス合算
                        unitResultRatioDenomination2Line(
                            title: "ボーナス合算",
                            color: .personalSummerLightBlue,
                            count: $newKingHana.totalBonusCountSum,
                            bigNumber: $newKingHana.currentGames,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                    }
                }
                
                // ボーナス中すいか
                VStack {
                    // セクションタイトル
                    HStack {
                        Text("  [ボーナス中🍉]")
                            .foregroundStyle(Color.secondary)
                            .font(.footnote)
                        Spacer()
                    }
                    
                    // 確率結果
                    HStack {
                        // BIG前半
                        unitResultRatioDenomination2Line(
                            title: "BIG前半中",
                            count: $newKingHana.bbSuikaCount,
                            bigNumber: $newKingHana.bigPlayGames,
                            numberofDicimal: 1,
                            spacerBool: false
                        )
                        // REG
                        unitResultRatioDenomination2Line(
                            title: "REG中",
                            count: $newKingHana.regSuikaCount,
                            bigNumber: $newKingHana.regPlayGames,
                            numberofDicimal: 1,
                            spacerBool: false
                        )
                    }
                }
                
                // サイドランプ
                VStack {
                    // セクションタイトル
                    HStack {
                        Text("  [BIG後半中 サイドランプ]")
                            .foregroundStyle(Color.secondary)
                            .font(.footnote)
                        Spacer()
                    }
                    
                    // 奇数・偶数確率
                    HStack {
                        // 奇数示唆
                        unitResultRatioPercent2Line(
                            title: "奇数示唆",
                            color: .grayBack,
                            count: $newKingHana.sideLampCountKisu,
                            bigNumber: $newKingHana.sideLampCountSum,
                            numberofDicimal: 0,
                            spacerBool: false,
                        )
                        // 偶数示唆
                        unitResultRatioPercent2Line(
                            title: "偶数示唆",
                            color: .grayBack,
                            count: $newKingHana.sideLampCountGusu,
                            bigNumber: $newKingHana.sideLampCountSum,
                            numberofDicimal: 0,
                            spacerBool: false,
                        )
                    }
                }
                
                // BIG終了後ランプ
                VStack {
                    // セクションタイトル
                    HStack {
                        Text("  [BIG終了後 トップランプ]")
                            .foregroundStyle(Color.secondary)
                            .font(.footnote)
                        Spacer()
                    }
                    
                    // ランプ合算確率
                    unitResultRatioPercent2Line(
                        title: "ランプ合算",
                        count: $newKingHana.bigTopLampCountSum,
                        bigNumber: $newKingHana.bigCount,
                        numberofDicimal: 1
                    )
                }
                
                // 参考情報）ベル、ボーナス確率
                unitLinkButtonViewBuilder(sheetTitle: "🔔,ボーナス確率") {
                    newKingHanaTableBellBonus(newKingHana: newKingHana)
                }
                
                // 参考情報）BIG中スイカ確率
                unitLinkButtonViewBuilder(sheetTitle: "BIG中🍉確率") {
                    VStack {
                        Text("[参考] 過去のハナハナシリーズ数値")
                        HStack(spacing: 0) {
                            unitTableSettingIndex(settingList: [1,2,3,4,6])
                            unitTableDenominate(
                                columTitle: "BIG中🍉",
                                denominateList: newKingHana.ratioBigSuika
                            )
                        }
                    }
                }
                
                // 参考情報）REG中スイカ確率
                unitLinkButtonViewBuilder(sheetTitle: "REG中🍉確率") {
                    VStack {
//                                Text("[参考] 過去のハナハナシリーズ数値")
                        HStack(spacing: 0) {
                            unitTableSettingIndex(settingList: [1,2,3,4,6])
                            unitTableDenominate(
                                columTitle: "REG中🍉",
                                denominateList: newKingHana.ratioRegSuika
                            )
                        }
                    }
                }
                
                // サイドランプ振り分け
                unitLinkButtonViewBuilder(sheetTitle: "サイドランプ振分け") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・BIG後半中に1回だけ確認可能")
                            Text("・左リール中段に白７ビタ押し。成功したら中・右にスイカを狙う")
                            Text("・奇数設定は青・緑が６割、偶数は黄・赤が６割。\n　ただし、設定６のみ全色均等に出現する")
                        }
                        .padding(.bottom)
                        Text("[参考] 過去のハナハナシリーズ数値")
                        HStack(spacing: 0) {
                            unitTableSettingIndex(settingList: [1,2,3,4,6])
                            unitTablePercent(
                                columTitle: "青",
                                percentList: newKingHana.ratioSideLampBlue
                            )
                            unitTablePercent(
                                columTitle: "黄",
                                percentList: newKingHana.ratioSideLampYellow
                            )
                            unitTablePercent(
                                columTitle: "緑",
                                percentList: newKingHana.ratioSideLampGreen
                            )
                            unitTablePercent(
                                columTitle: "赤",
                                percentList: newKingHana.ratioSideLampRed
                            )
                            unitTablePercent(
                                columTitle: "虹",
                                percentList: newKingHana.ratioSideLampRainbow,
                                numberofDicimal: 2,
                            )
                        }
                    }
                }
                
                // 参考情報）ランプ振分け
                unitLinkButtonViewBuilder(sheetTitle: "BIG終了後ランプ") {
                    VStack {
                        Text("[参考] 過去のハナハナシリーズ数値")
                        HStack(spacing: 0) {
                            unitTableSettingIndex(settingList: [1,2,3,4,6])
                            unitTablePercent(
                                columTitle: "青",
                                percentList: newKingHana.ratioBigTopLampBlue,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "黄",
                                percentList: newKingHana.ratioBigTopLampYellow,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "緑",
                                percentList: newKingHana.ratioBigTopLampGreen,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "紫",
                                percentList: newKingHana.ratioBigTopLampPurple,
                                numberofDicimal: 1,
                            )
                        }
                        HStack(spacing: 0) {
                            unitTableSettingIndex(settingList: [1,2,3,4,6])
                            unitTablePercent(
                                columTitle: "虹",
                                percentList: newKingHana.ratioBigTopLampRainbow,
                                numberofDicimal: 2,
                            )
                            unitTablePercent(
                                columTitle: "合算",
                                percentList: newKingHana.ratioBigTopLampSum,
                                numberofDicimal: 1,
                            )
                        }
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        newKingHanaView95CiTotal(
                            newKingHana: newKingHana,
                            selection: 1,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    newKingHanaViewBayes(
                        newKingHana: newKingHana,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
                
                // ---- 詳細結果
                // 総ゲーム数
                unitTextGameNumberWithoutInput(
                    titleText: "総ゲーム数",
                    gameNumber: newKingHana.currentGames
                )
                // 自分でプレイゲーム数
                unitTextGameNumberWithoutInput(
                    titleText: "  (内  自分でプレイ)",
                    gameNumber: newKingHana.playGames
                )
                // ベル　逆算状態に合わせて
                if newKingHana.startBackCalculationEnable {
                    // ベル総数
                    unitTextGameNumberWithoutInput(
                        titleText: "ベル回数",
                        gameNumber: newKingHana.totalBellCount,
                        unitText: "回",
                    )
                    // 内逆算分
                    unitTextGameNumberWithoutInput(
                        titleText: "  (内  逆算分)",
                        gameNumber: newKingHana.startBellBackCalculationCount,
                        unitText: "回",
                    )
                } else {
                    // ベル総数
                    unitTextGameNumberWithoutInput(
                        titleText: "ベル回数",
                        gameNumber: newKingHana.bellCount,
                        unitText: "回",
                    )
                }
                // BIG
                unitTextGameNumberWithoutInput(
                    titleText: "BIG",
                    gameNumber: newKingHana.totalBigCount,
                    unitText: "回",
                )
                // REG
                unitTextGameNumberWithoutInput(
                    titleText: "REG",
                    gameNumber: newKingHana.totalRegCount,
                    unitText: "回",
                )
                // BIG前半中スイカ
                unitTextGameNumberWithoutInput(
                    titleText: "BIG前半中🍉",
                    gameNumber: newKingHana.bbSuikaCount,
                    unitText: "回",
                )
                // REG中スイカ
                unitTextGameNumberWithoutInput(
                    titleText: "REG中🍉",
                    gameNumber: newKingHana.regSuikaCount,
                    unitText: "回",
                )
                // サイドランプ青
                unitTextGameNumberWithoutInput(
                    titleText: "サイドランプ 青",
                    gameNumber: newKingHana.sideLampCountBlue,
                    unitText: "回",
                )
                // サイドランプ黄色
                unitTextGameNumberWithoutInput(
                    titleText: "サイドランプ 黄",
                    gameNumber: newKingHana.sideLampCountYellow,
                    unitText: "回",
                )
                // サイドランプ緑
                unitTextGameNumberWithoutInput(
                    titleText: "サイドランプ 緑",
                    gameNumber: newKingHana.sideLampCountGreen,
                    unitText: "回",
                )
                // サイドランプ赤
                unitTextGameNumberWithoutInput(
                    titleText: "サイドランプ 赤",
                    gameNumber: newKingHana.sideLampCountRed,
                    unitText: "回",
                )
                // BIG終了後ランプ 青
                unitTextGameNumberWithoutInput(
                    titleText: "BIG終了後ランプ 青",
                    gameNumber: newKingHana.bigTopLampCountBlue,
                    unitText: "回",
                )
                // BIG終了後ランプ 黄色
                unitTextGameNumberWithoutInput(
                    titleText: "BIG終了後ランプ 黄",
                    gameNumber: newKingHana.bigTopLampCountYellow,
                    unitText: "回",
                )
                // BIG終了後ランプ 緑
                unitTextGameNumberWithoutInput(
                    titleText: "BIG終了後ランプ 緑",
                    gameNumber: newKingHana.bigTopLampCountGreen,
                    unitText: "回",
                )
                // BIG終了後ランプ 赤
                unitTextGameNumberWithoutInput(
                    titleText: "BIG終了後ランプ 紫",
                    gameNumber: newKingHana.bigTopLampCountPurple,
                    unitText: "回",
                )
            } header: {
                Text("総合結果")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: newKingHana.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("総合結果確認")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    newKingHanaViewJissenTotalDataCheck(
        newKingHana: NewKingHana(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
