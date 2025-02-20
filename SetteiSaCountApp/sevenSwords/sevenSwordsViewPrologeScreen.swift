//
//  sevenSwordsViewPrologeScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/14.
//

import SwiftUI

struct sevenSwordsViewPrologeScreen: View {
    @ObservedObject var sevenSwords = SevenSwords()
    @State var isShowAlert: Bool = false
    
    var body: some View {
        List {
            // //// 画面選択ボタン
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    // 通常A
                    unitButtonScreenChoice(
                        image: Image(sevenSwords.bonusScreenKeywordList[0]),
                        keyword: sevenSwords.bonusScreenKeywordList[0],
                        currentKeyword: $sevenSwords.bonusScreenCurrentKeyword,
                        count: $sevenSwords.bonusScreenCountDefault,
                        minusCheck: $sevenSwords.minusCheck
                    )
                    .popoverTip(tipUnitButtonScreenChoice())
                    // 通常B
                    unitButtonScreenChoice(
                        image: Image(sevenSwords.bonusScreenKeywordList[1]),
                        keyword: sevenSwords.bonusScreenKeywordList[1],
                        currentKeyword: $sevenSwords.bonusScreenCurrentKeyword,
                        count: $sevenSwords.bonusScreenCountDefault,
                        minusCheck: $sevenSwords.minusCheck
                    )
                    // 通常C
                    unitButtonScreenChoice(
                        image: Image(sevenSwords.bonusScreenKeywordList[2]),
                        keyword: sevenSwords.bonusScreenKeywordList[2],
                        currentKeyword: $sevenSwords.bonusScreenCurrentKeyword,
                        count: $sevenSwords.bonusScreenCountDefault,
                        minusCheck: $sevenSwords.minusCheck
                    )
                    // オリバー＆ナナオA
                    unitButtonScreenChoice(
                        image: Image(sevenSwords.bonusScreenKeywordList[3]),
                        keyword: sevenSwords.bonusScreenKeywordList[3],
                        currentKeyword: $sevenSwords.bonusScreenCurrentKeyword,
                        count: $sevenSwords.bonusScreenCountGusu,
                        minusCheck: $sevenSwords.minusCheck
                    )
                    // オリバー＆ナナオB
                    unitButtonScreenChoice(
                        image: Image(sevenSwords.bonusScreenKeywordList[4]),
                        keyword: sevenSwords.bonusScreenKeywordList[4],
                        currentKeyword: $sevenSwords.bonusScreenCurrentKeyword,
                        count: $sevenSwords.bonusScreenCountOver2,
                        minusCheck: $sevenSwords.minusCheck
                    )
                    // ナナオと箒
                    unitButtonScreenChoice(
                        image: Image(sevenSwords.bonusScreenKeywordList[5]),
                        keyword: sevenSwords.bonusScreenKeywordList[5],
                        currentKeyword: $sevenSwords.bonusScreenCurrentKeyword,
                        count: $sevenSwords.bonusScreenCountOver3,
                        minusCheck: $sevenSwords.minusCheck
                    )
                    // オリバー＆ナナオC
                    unitButtonScreenChoice(
                        image: Image(sevenSwords.bonusScreenKeywordList[6]),
                        keyword: sevenSwords.bonusScreenKeywordList[6],
                        currentKeyword: $sevenSwords.bonusScreenCurrentKeyword,
                        count: $sevenSwords.bonusScreenCountOver4,
                        minusCheck: $sevenSwords.minusCheck
                    )
                    // 剣花団
                    unitButtonScreenChoice(
                        image: Image(sevenSwords.bonusScreenKeywordList[7]),
                        keyword: sevenSwords.bonusScreenKeywordList[7],
                        currentKeyword: $sevenSwords.bonusScreenCurrentKeyword,
                        count: $sevenSwords.bonusScreenCountOver6,
                        minusCheck: $sevenSwords.minusCheck
                    )
                }
            }
            .frame(height: 120)
            
            // //// カウント結果
            // デフォルト
            unitResultCountListPercent(
                title: "デフォルト",
                count: $sevenSwords.bonusScreenCountDefault,
                flashColor: .gray,
                bigNumber: $sevenSwords.bonusScreenCountSum
            )
            // 偶数示唆
            unitResultCountListPercent(
                title: "偶数示唆",
                count: $sevenSwords.bonusScreenCountGusu,
                flashColor: .blue,
                bigNumber: $sevenSwords.bonusScreenCountSum
            )
            // 設定2 以上
            unitResultCountListPercent(
                title: "設定2 以上濃厚",
                count: $sevenSwords.bonusScreenCountOver2,
                flashColor: .yellow,
                bigNumber: $sevenSwords.bonusScreenCountSum
            )
            // 設定3 以上
            unitResultCountListPercent(
                title: "設定3 以上濃厚",
                count: $sevenSwords.bonusScreenCountOver3,
                flashColor: .green,
                bigNumber: $sevenSwords.bonusScreenCountSum
            )
            // 設定4 以上
            unitResultCountListPercent(
                title: "設定4 以上濃厚",
                count: $sevenSwords.bonusScreenCountOver4,
                flashColor: .red,
                bigNumber: $sevenSwords.bonusScreenCountSum
            )
            // 設定6
            unitResultCountListPercent(
                title: "設定6 濃厚",
                count: $sevenSwords.bonusScreenCountOver6,
                flashColor: .purple,
                bigNumber: $sevenSwords.bonusScreenCountSum
            )
        }
        .navigationTitle("プロローグBONUS終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// 画面選択解除
                    unitButtonToolbarScreenSelectReset(currentKeyword: $sevenSwords.bonusScreenCurrentKeyword)
                        .popoverTip(tipUnitButtonScreenChoiceClear())
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $sevenSwords.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: sevenSwords.resetBonusScreen)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    sevenSwordsViewPrologeScreen()
}
