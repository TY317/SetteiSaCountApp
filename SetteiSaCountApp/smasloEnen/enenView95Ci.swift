//
//  enenView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/15.
//

import SwiftUI

struct enenView95Ci: View {
    @ObservedObject var enen: Enen
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    
    var body: some View {
        TabView(selection: self.$selection) {
            // 十字目変換からのボーナス回数
            unitListSection95Ci(
                grafTitle: "通常時\n十字目変換からのボーナス回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $enen.rareBonusCountJujiHit,
                        bigNumber: $enen.rareBonusCountJuji,
                        setting1Percent: enen.ratioRareBonusJuji[0],
                        setting2Percent: enen.ratioRareBonusJuji[1],
                        setting3Enable: false,
                        setting3Percent: -1,
                        setting4Percent: enen.ratioRareBonusJuji[2],
                        setting5Percent: enen.ratioRareBonusJuji[3],
                        setting6Percent: enen.ratioRareBonusJuji[4]
                    )
                )
            )
            .tag(1)
            // 強🍒からのボーナス回数
            unitListSection95Ci(
                grafTitle: "通常時\n強🍒からのボーナス回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $enen.rareBonusCountKyoCherryHit,
                        bigNumber: $enen.rareBonusCountKyoCherry,
                        setting1Percent: enen.ratioRareBonusKyoCherry[0],
                        setting2Percent: enen.ratioRareBonusKyoCherry[1],
                        setting3Enable: false,
                        setting3Percent: -1,
                        setting4Percent: enen.ratioRareBonusKyoCherry[2],
                        setting5Percent: enen.ratioRareBonusKyoCherry[3],
                        setting6Percent: enen.ratioRareBonusKyoCherry[4]
                    )
                )
            )
            .tag(2)
            // REGキャラ　デフォルト回数
            unitListSection95Ci(
                grafTitle: "REGキャラ紹介シナリオ\nデフォルト回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $enen.charaCountDefault,
                        bigNumber: $enen.charaCountSum,
                        setting1Percent: enen.ratioCharaDefault[0],
                        setting2Percent: enen.ratioCharaDefault[1],
                        setting3Enable: false,
                        setting3Percent: -1,
                        setting4Percent: enen.ratioCharaDefault[2],
                        setting5Percent: enen.ratioCharaDefault[3],
                        setting6Percent: enen.ratioCharaDefault[4]
                    )
                )
            )
            .tag(3)
            // REGキャラ　１・４・６示唆回数
            unitListSection95Ci(
                grafTitle: "REGキャラ紹介シナリオ\n1・4・6示唆回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $enen.charaCountDefault,
                        bigNumber: $enen.charaCountSum,
                        setting1Percent: enen.ratioChara146Sisa[0],
                        setting2Percent: enen.ratioChara146Sisa[1],
                        setting3Enable: false,
                        setting3Percent: -1,
                        setting4Percent: enen.ratioChara146Sisa[2],
                        setting5Percent: enen.ratioChara146Sisa[3],
                        setting6Percent: enen.ratioChara146Sisa[4]
                    )
                )
            )
            .tag(4)
            // REGキャラ　2・5示唆回数
            unitListSection95Ci(
                grafTitle: "REGキャラ紹介シナリオ\n2・5示唆回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $enen.charaCountDefault,
                        bigNumber: $enen.charaCountSum,
                        setting1Percent: enen.ratioChara25Sisa[0],
                        setting2Percent: enen.ratioChara25Sisa[1],
                        setting3Enable: false,
                        setting3Percent: -1,
                        setting4Percent: enen.ratioChara25Sisa[2],
                        setting5Percent: enen.ratioChara25Sisa[3],
                        setting6Percent: enen.ratioChara25Sisa[4]
                    )
                )
            )
            .tag(5)
            // REG終了画面　デフォルト・その他回数
            unitListSection95Ci(
                grafTitle: "REG終了画面\nデフォルト・その他回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $enen.regScreenCountDefault,
                        bigNumber: $enen.regScreenCountSum,
                        setting1Percent: enen.ratioRegScreenDefault[0],
                        setting2Percent: enen.ratioRegScreenDefault[1],
                        setting3Enable: false,
                        setting3Percent: -1,
                        setting4Percent: enen.ratioRegScreenDefault[2],
                        setting5Percent: enen.ratioRegScreenDefault[3],
                        setting6Percent: enen.ratioRegScreenDefault[4]
                    )
                )
            )
            .tag(8)
            // REG終了画面　高設定示唆 弱回数
            unitListSection95Ci(
                grafTitle: "REG終了画面\n高設定示唆 弱回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $enen.regScreenCountHighJaku,
                        bigNumber: $enen.regScreenCountSum,
                        setting1Percent: enen.ratioRegScreenHighJaku[0],
                        setting2Percent: enen.ratioRegScreenHighJaku[1],
                        setting3Enable: false,
                        setting3Percent: -1,
                        setting4Percent: enen.ratioRegScreenHighJaku[2],
                        setting5Percent: enen.ratioRegScreenHighJaku[3],
                        setting6Percent: enen.ratioRegScreenHighJaku[4]
                    )
                )
            )
            .tag(9)
            // REG終了画面　高設定示唆 強回数
            unitListSection95Ci(
                grafTitle: "REG終了画面\n高設定示唆 強回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $enen.regScreenCountHighKyo,
                        bigNumber: $enen.regScreenCountSum,
                        setting1Percent: enen.ratioRegScreenHighKyo[0],
                        setting2Percent: enen.ratioRegScreenHighKyo[1],
                        setting3Enable: false,
                        setting3Percent: -1,
                        setting4Percent: enen.ratioRegScreenHighKyo[2],
                        setting5Percent: enen.ratioRegScreenHighKyo[3],
                        setting6Percent: enen.ratioRegScreenHighKyo[4]
                    )
                )
            )
            .tag(10)
            // 十字目変換からのボーナス回数
            unitListSection95Ci(
                grafTitle: "伝道者の影\n十字目変換からのボーナス回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $enen.dendoshaCountJujiHit,
                        bigNumber: $enen.dendoshaCountJuji,
                        setting1Percent: enen.ratioDendoshaJuji[0],
                        setting2Percent: enen.ratioDendoshaJuji[1],
                        setting3Enable: false,
                        setting3Percent: -1,
                        setting4Percent: enen.ratioDendoshaJuji[2],
                        setting5Percent: enen.ratioDendoshaJuji[3],
                        setting6Percent: enen.ratioDendoshaJuji[4]
                    )
                )
            )
            .tag(6)
            // 弱レアからのボーナス回数
            unitListSection95Ci(
                grafTitle: "伝道者の影\n弱レア役からのボーナス回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $enen.dendoshaCountJakuRareHit,
                        bigNumber: $enen.dendoshaCountJakuRare,
                        setting1Percent: enen.ratioDendoshaJakuRare[0],
                        setting2Percent: enen.ratioDendoshaJakuRare[1],
                        setting3Enable: false,
                        setting3Percent: -1,
                        setting4Percent: enen.ratioDendoshaJakuRare[2],
                        setting5Percent: enen.ratioDendoshaJakuRare[3],
                        setting6Percent: enen.ratioDendoshaJakuRare[4]
                    )
                )
            )
            .tag(7)
            // BIG終了画面　デフォルト・その他回数
            unitListSection95Ci(
                grafTitle: "BIG終了画面\nデフォルト・その他回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $enen.bigScreenCountDefault,
                        bigNumber: $enen.bigScreenCountSum,
                        setting1Percent: enen.ratioBigScreenDefault[0],
                        setting2Percent: enen.ratioBigScreenDefault[1],
                        setting3Enable: false,
                        setting3Percent: -1,
                        setting4Percent: enen.ratioBigScreenDefault[2],
                        setting5Percent: enen.ratioBigScreenDefault[3],
                        setting6Percent: enen.ratioBigScreenDefault[4]
                    )
                )
            )
            .tag(11)
            // BIG終了画面　高設定示唆 弱回数
            unitListSection95Ci(
                grafTitle: "BIG終了画面\n高設定示唆 弱回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $enen.bigScreenCountHighJaku,
                        bigNumber: $enen.bigScreenCountSum,
                        setting1Percent: enen.ratioBigScreenHighJaku[0],
                        setting2Percent: enen.ratioBigScreenHighJaku[1],
                        setting3Enable: false,
                        setting3Percent: -1,
                        setting4Percent: enen.ratioBigScreenHighJaku[2],
                        setting5Percent: enen.ratioBigScreenHighJaku[3],
                        setting6Percent: enen.ratioBigScreenHighJaku[4]
                    )
                )
            )
            .tag(12)
            // BIG終了画面　高設定示唆 強回数
            unitListSection95Ci(
                grafTitle: "BIG終了画面\n高設定示唆 強回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $enen.bigScreenCountHighKyo,
                        bigNumber: $enen.bigScreenCountSum,
                        setting1Percent: enen.ratioBigScreenHighKyo[0],
                        setting2Percent: enen.ratioBigScreenHighKyo[1],
                        setting3Enable: false,
                        setting3Percent: -1,
                        setting4Percent: enen.ratioBigScreenHighKyo[2],
                        setting5Percent: enen.ratioBigScreenHighKyo[3],
                        setting6Percent: enen.ratioBigScreenHighKyo[4]
                    )
                )
            )
            .tag(13)
            // 炎炎JAC 設定2・5 示唆回数
            unitListSection95Ci(
                grafTitle: "炎炎JAC開始画面\n設定2・5 示唆回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $enen.adoraCount25Sisa,
                        bigNumber: $enen.adoraCountSum,
                        setting1Percent: enen.ratioAdora25Sisa[0],
                        setting2Percent: enen.ratioAdora25Sisa[1],
                        setting3Enable: false,
                        setting3Percent: -1,
                        setting4Percent: enen.ratioAdora25Sisa[2],
                        setting5Percent: enen.ratioAdora25Sisa[3],
                        setting6Percent: enen.ratioAdora25Sisa[4]
                    )
                )
            )
            .tag(14)
            // 炎炎JAC 設定1・4・6 示唆回数
            unitListSection95Ci(
                grafTitle: "炎炎JAC開始画面\n設定1・4・6 示唆回数",
                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $enen.adoraCount146Sisa,
                        bigNumber: $enen.adoraCountSum,
                        setting1Percent: enen.ratioAdora146Sisa[0],
                        setting2Percent: enen.ratioAdora146Sisa[1],
                        setting3Enable: false,
                        setting3Percent: -1,
                        setting4Percent: enen.ratioAdora146Sisa[2],
                        setting5Percent: enen.ratioAdora146Sisa[3],
                        setting6Percent: enen.ratioAdora146Sisa[4]
                    )
                )
            )
            .tag(15)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: enen.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("95%信頼区間グラフ")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButton95CiExplain(isShow95CiExplain: isShow95CiExplain)
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    enenView95Ci(
        enen: Enen(),
    )
}
