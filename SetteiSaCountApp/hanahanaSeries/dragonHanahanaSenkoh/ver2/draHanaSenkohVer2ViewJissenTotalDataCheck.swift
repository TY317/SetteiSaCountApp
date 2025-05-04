//
//  draHanaSenkohVer2ViewJissenTotalDataCheck.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/27.
//

import SwiftUI

struct draHanaSenkohVer2ViewJissenTotalDataCheck: View {
//    @ObservedObject var draHanaSenkoh = DraHanaSenkoh()
    @ObservedObject var draHanaSenkoh: DraHanaSenkoh
    
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
                        if draHanaSenkoh.startBackCalculationEnable {
                            HStack {
                                unitResultRatioDenomination2Line(
                                    title: "ベル確率",
                                    color: .personalSummerLightBlue,
                                    count: $draHanaSenkoh.totalBellCount,
                                    bigNumber: $draHanaSenkoh.currentGames,
                                    numberofDicimal: 2,
                                    spacerBool: false
                                )
                                unitTextBackCaluculateStatus(enableStatus: draHanaSenkoh.startBackCalculationEnable)
                            }
                        } else {
                            HStack {
                                unitResultRatioDenomination2Line(
                                    title: "ベル確率",
                                    count: $draHanaSenkoh.bellCount,
                                    bigNumber: $draHanaSenkoh.playGames,
                                    numberofDicimal: 2,
                                    spacerBool: false
                                )
                                unitTextBackCaluculateStatus(enableStatus: draHanaSenkoh.startBackCalculationEnable)
                            }
                        }
                    }
                    // 確率2段目
                    HStack {
                        // BIG確率
                        unitResultRatioDenomination2Line(
                            title: "BIG確率",
                            color: .personalSummerLightBlue,
                            count: $draHanaSenkoh.totalBigCount,
                            bigNumber: $draHanaSenkoh.currentGames,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // REG確率
                        unitResultRatioDenomination2Line(
                            title: "REG確率",
                            color: .personalSummerLightBlue,
                            count: $draHanaSenkoh.totalRegCount,
                            bigNumber: $draHanaSenkoh.currentGames,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // ボーナス合算
                        unitResultRatioDenomination2Line(
                            title: "ボーナス合算",
                            color: .personalSummerLightBlue,
                            count: $draHanaSenkoh.totalBonusCountSum,
                            bigNumber: $draHanaSenkoh.currentGames,
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
                            count: $draHanaSenkoh.bbSuikaCount,
                            bigNumber: $draHanaSenkoh.bigPlayGames,
                            numberofDicimal: 1,
                            spacerBool: false
                        )
                        // フェザーランプ
                        unitResultRatioPercent2Line(
                            title: "ランプ合算",
                            color: Color("grayBack"),
                            count: $draHanaSenkoh.bbLampCountSum,
                            bigNumber: $draHanaSenkoh.bigCount,
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
                        unitResultRatioPercent2Line(title: "奇数示唆", color: .grayBack, count: $draHanaSenkoh.rbLampKisuCountSum, bigNumber: $draHanaSenkoh.rbLampCountSum, numberofDicimal: 0, spacerBool: false)
                        // 偶数示唆
                        unitResultRatioPercent2Line(title: "偶数示唆", color: .grayBack, count: $draHanaSenkoh.rbLampGusuCountSum, bigNumber: $draHanaSenkoh.rbLampCountSum, numberofDicimal: 0, spacerBool: false)
                    }
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "ベル,ボーナス確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ベル・ボーナス確率",
                            tableView: AnyView(draHanaSenkohTableBellBonus(draHanaSenkoh: draHanaSenkoh))
//                            image1: Image("draHanaSenkohBellBonusAnalysis")
                        )
                    )
                )
                // スイカ確率の情報リンク
                unitLinkButton(
                    title: "BB中のスイカについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "BIG中スイカ確率",
                            tableView: AnyView(hanahanaCommonTableBigSuika())
                        )
                    )
                )
//                unitLinkButton(title: "BB中のスイカ確率", exview: AnyView(unitExView5body2image(title: "BIG中スイカ確率", image1:Image("hanaCommonBbSuika"))))
                // 参考情報リンク
                unitLinkButton(
                    title: "BIG後のフェザーランプについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "BIG後のフェザーランプ確率",
                            tableView: AnyView(hanahanaCommonTableBigLamp())
                        )
                    )
                )
//                unitLinkButton(title: "BIG後のフェザーランプ確率", exview: AnyView(unitExView5body2image(title: "BIG後のフェザーランプ確率", image1:Image("hanaCommonBbLamp"))))
                // サイドランプの参考情報リンク
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
                        )
                    )
                )
//                unitLinkButton(title: "REG中のサイドランプ確率", exview: AnyView(unitExView5body2image(title: "REG中のサイドランプ確率", textBody1: "・REG中に1回だけ確認可能", textBody2: "・左リール中段に白７ビタ押し", textBody3: "　成功したら中・右にスイカを狙う", textBody4: "・奇数設定は青・緑が６割、偶数は黄・赤が６割。\n　ただし、設定６のみ全色均等に出現する", image1: Image("hanaCommonRbSideLamp"))))
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(draHanaSenkohVer2View95CiTotal(draHanaSenkoh: draHanaSenkoh)))
                    .popoverTip(tipUnitButtonLink95Ci())
                // 総ゲーム数
                unitResultCountListWithoutRatio(title: "総ゲーム数", count: $draHanaSenkoh.currentGames)
                // 自分でプレイ
                unitResultCountListWithoutRatio(title: "  (内  自分でプレイ)", count: $draHanaSenkoh.playGames)
                // //// ぶどう　逆算の状態に合わせて
                if draHanaSenkoh.startBackCalculationEnable {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ベル回数", count: $draHanaSenkoh.totalBellCount)
                    // 内 逆算分
                    unitResultCountListWithoutRatio(title: "  (内  逆算分)", count: $draHanaSenkoh.startBellBackCalculationCount)
                } else {
                    // ぶどう総数
                    unitResultCountListWithoutRatio(title: "ベル回数", count: $draHanaSenkoh.bellCount)
                }
                // BIG
                unitResultCountListWithoutRatio(title: "BIG回数", count: $draHanaSenkoh.totalBigCount)
                // REG
                unitResultCountListWithoutRatio(title: "REG回数", count: $draHanaSenkoh.totalRegCount)
                // BB中スイカ
                unitResultCountListWithoutRatio(title: "BB中スイカ回数", count: $draHanaSenkoh.bbSuikaCount)
                // BB後フェザーランプ
                unitResultCountListWithoutRatio(title: "BB後ランプ合算回数", count: $draHanaSenkoh.bbLampCountSum)
                // 内 青
                unitResultCountListWithoutRatio(title: "  (内 　青)", count: $draHanaSenkoh.bbLampBCount)
                // 内 黄
                unitResultCountListWithoutRatio(title: "  (内 　黄)", count: $draHanaSenkoh.bbLampYCount)
                // 内 緑
                unitResultCountListWithoutRatio(title: "  (内 　緑)", count: $draHanaSenkoh.bbLampGCount)
                // 内 赤
                unitResultCountListWithoutRatio(title: "  (内 　赤)", count: $draHanaSenkoh.bbLampRCount)
                // RB中サイドランプ 青
                unitResultCountListWithoutRatio(title: "RBサイドランプ 青", count: $draHanaSenkoh.rbLampBCount)
                // RB中サイドランプ 黄
                unitResultCountListWithoutRatio(title: "RBサイドランプ 黄", count: $draHanaSenkoh.rbLampYCount)
                // RB中サイドランプ 緑
                unitResultCountListWithoutRatio(title: "RBサイドランプ 緑", count: $draHanaSenkoh.rbLampGCount)
                // RB中サイドランプ 赤
                unitResultCountListWithoutRatio(title: "RBサイドランプ 赤", count: $draHanaSenkoh.rbLampRCount)
            } header: {
                Text("総合結果")
            }
        }
        .navigationTitle("総合結果確認")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    draHanaSenkohVer2ViewJissenTotalDataCheck(draHanaSenkoh: DraHanaSenkoh())
}
