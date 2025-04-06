//
//  hanaTenshoVer2ViewJissenTotalDataCheck.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/26.
//

import SwiftUI

struct hanaTenshoVer2ViewJissenTotalDataCheck: View {
    @ObservedObject var hanaTensho = HanaTensho()
    
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
                        if hanaTensho.startBackCalculationEnable {
                            HStack {
                                unitResultRatioDenomination2Line(
                                    title: "ベル確率",
                                    color: .personalSummerLightBlue,
                                    count: $hanaTensho.totalBellCount,
                                    bigNumber: $hanaTensho.currentGames,
                                    numberofDicimal: 2,
                                    spacerBool: false
                                )
                                unitTextBackCaluculateStatus(enableStatus: hanaTensho.startBackCalculationEnable)
                            }
                        } else {
                            HStack {
                                unitResultRatioDenomination2Line(
                                    title: "ベル確率",
                                    count: $hanaTensho.bellCount,
                                    bigNumber: $hanaTensho.playGames,
                                    numberofDicimal: 2,
                                    spacerBool: false
                                )
                                unitTextBackCaluculateStatus(enableStatus: hanaTensho.startBackCalculationEnable)
                            }
                        }
                    }
                    // 確率2段目
                    HStack {
                        // BIG確率
                        unitResultRatioDenomination2Line(
                            title: "BIG確率",
                            color: .personalSummerLightBlue,
                            count: $hanaTensho.totalBigCount,
                            bigNumber: $hanaTensho.currentGames,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // REG確率
                        unitResultRatioDenomination2Line(
                            title: "REG確率",
                            color: .personalSummerLightBlue,
                            count: $hanaTensho.totalRegCount,
                            bigNumber: $hanaTensho.currentGames,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // ボーナス合算
                        unitResultRatioDenomination2Line(
                            title: "ボーナス合算",
                            color: .personalSummerLightBlue,
                            count: $hanaTensho.totalBonusCountSum,
                            bigNumber: $hanaTensho.currentGames,
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
                            count: $hanaTensho.bbSuikaCount,
                            bigNumber: $hanaTensho.bigPlayGames,
                            numberofDicimal: 1,
                            spacerBool: false
                        )
                        // 鳳玉ランプ
                        unitResultRatioPercent2Line(
                            title: "ランプ合算",
                            color: Color("grayBack"),
                            count: $hanaTensho.bbLampCountSum,
                            bigNumber: $hanaTensho.bigCount,
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
                        unitResultRatioPercent2Line(title: "奇数示唆", color: .grayBack, count: $hanaTensho.rbLampKisuCountSum, bigNumber: $hanaTensho.rbLampCountSum, numberofDicimal: 0, spacerBool: false)
                        // 偶数示唆
                        unitResultRatioPercent2Line(title: "偶数示唆", color: .grayBack, count: $hanaTensho.rbLampGusuCountSum, bigNumber: $hanaTensho.rbLampCountSum, numberofDicimal: 0, spacerBool: false)
                    }
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "ベル,ボーナス確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ベル・ボーナス確率",
                            tableView: AnyView(hanaTenshoTableBellBonus())
//                                image1: Image("hanaTenshoBellBonus")
                        )
                    )
                )
//                unitLinkButton(title: "ベル,ボーナス確率", exview: AnyView(unitExView5body2image(title: "ベル・ボーナス確率", image1: Image("hanaTenshoBellBonus"))))
                // スイカ確率の情報リンク
                unitLinkButton(
                    title: "BB中のスイカについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "BIG中スイカ確率",
                            tableView: AnyView(hanahanaCommonTableBigSuika())
//                                        image1:Image("hanaTenshoBbSuika")
                        )
                    )
                )
//                unitLinkButton(title: "BB中のスイカ確率", exview: AnyView(unitExView5body2image(title: "BIG中スイカ確率", image1:Image("hanaTenshoBbSuika"))))
                // 参考情報リンク
                unitLinkButton(
                    title: "BIG後の鳳玉ランプについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "BIG後の鳳玉ランプ確率",
                            tableView: AnyView(hanahanaCommonTableBigLamp())
//                                        image1:Image("hanaTenshoBigLamp")
                        )
                    )
                )
//                unitLinkButton(title: "BIG後の鳳玉ランプ確率", exview: AnyView(unitExView5body2image(title: "BIG後の鳳玉ランプ確率", image1:Image("hanaTenshoBigLamp"))))
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
//                                    image1: Image("hanaTenshoRegSideLamp")
                        )
                    )
                )
//                unitLinkButton(title: "REG中のサイドランプ確率", exview: AnyView(unitExView5body2image(title: "REG中のサイドランプ確率", textBody1: "・REG中に1回だけ確認可能", textBody2: "・左リール中段に白７ビタ押し", textBody3: "　成功したら中・右にスイカを狙う", textBody4: "・奇数設定は青・緑が６割、偶数は黄・赤が６割。\n　ただし、設定６のみ全色均等に出現する", image1: Image("hanaTenshoRegSideLamp"))))
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(hanaTenshoVer2View95CiTotal()))
                    .popoverTip(tipUnitButtonLink95Ci())
                // 総ゲーム数
                unitResultCountListWithoutRatio(title: "総ゲーム数", count: $hanaTensho.currentGames)
                // 自分でプレイ
                unitResultCountListWithoutRatio(title: "  (内  自分でプレイ)", count: $hanaTensho.playGames)
                // //// ぶどう　逆算の状態に合わせて
                if hanaTensho.startBackCalculationEnable {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ベル回数", count: $hanaTensho.totalBellCount)
                    // 内 逆算分
                    unitResultCountListWithoutRatio(title: "  (内  逆算分)", count: $hanaTensho.startBellBackCalculationCount)
                } else {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ベル回数", count: $hanaTensho.bellCount)
                }
                // BIG
                unitResultCountListWithoutRatio(title: "BIG回数", count: $hanaTensho.totalBigCount)
                // REG
                unitResultCountListWithoutRatio(title: "REG回数", count: $hanaTensho.totalRegCount)
                // BB中スイカ
                unitResultCountListWithoutRatio(title: "BB中スイカ回数", count: $hanaTensho.bbSuikaCount)
                // BB後鳳玉ランプ
                unitResultCountListWithoutRatio(title: "BB後ランプ合算回数", count: $hanaTensho.bbLampCountSum)
                // 内 青
                unitResultCountListWithoutRatio(title: "  (内 　青)", count: $hanaTensho.bbLampBCount)
                // 内 黄
                unitResultCountListWithoutRatio(title: "  (内 　黄)", count: $hanaTensho.bbLampYCount)
                // 内 緑
                unitResultCountListWithoutRatio(title: "  (内 　緑)", count: $hanaTensho.bbLampGCount)
                // 内 赤
                unitResultCountListWithoutRatio(title: "  (内 　赤)", count: $hanaTensho.bbLampRCount)
                // RB中サイドランプ 青
                unitResultCountListWithoutRatio(title: "RBサイドランプ 青", count: $hanaTensho.rbLampBCount)
                // RB中サイドランプ 黄
                unitResultCountListWithoutRatio(title: "RBサイドランプ 黄", count: $hanaTensho.rbLampYCount)
                // RB中サイドランプ 緑
                unitResultCountListWithoutRatio(title: "RBサイドランプ 緑", count: $hanaTensho.rbLampGCount)
                // RB中サイドランプ 赤
                unitResultCountListWithoutRatio(title: "RBサイドランプ 赤", count: $hanaTensho.rbLampRCount)
            } header: {
                Text("総合結果")
            }
        }
        .navigationTitle("総合結果確認")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    hanaTenshoVer2ViewJissenTotalDataCheck()
}
