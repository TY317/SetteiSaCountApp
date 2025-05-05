//
//  tokyoGhoulViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/22.
//

import SwiftUI

struct tokyoGhoulViewScreen: View {
//    @ObservedObject var tokyoGhoul = TokyoGhoul()
    @ObservedObject var tokyoGhoul: TokyoGhoul
    @State var isShowAlert: Bool = false
    
    var body: some View {
        List {
            // //// 画面選択ボタン
            ScrollView(.horizontal) {
                HStack(spacing: 20.0) {
                    // デフォルト
                    unitButtonScreenChoice(
                        image: Image(tokyoGhoul.atScreenKeywordList[0]),
                        keyword: tokyoGhoul.atScreenKeywordList[0],
                        currentKeyword: $tokyoGhoul.screenCurrentKeyword,
                        count: $tokyoGhoul.screenCountDefault,
                        minusCheck: $tokyoGhoul.minusCheck
                    )
                    .popoverTip(tipUnitButtonScreenChoice())
                    // 奇数示唆
                    unitButtonScreenChoice(
                        image: Image(tokyoGhoul.atScreenKeywordList[1]),
                        keyword: tokyoGhoul.atScreenKeywordList[1],
                        currentKeyword: $tokyoGhoul.screenCurrentKeyword,
                        count: $tokyoGhoul.screenCountKisu,
                        minusCheck: $tokyoGhoul.minusCheck
                    )
                    // 偶数示唆
                    unitButtonScreenChoice(
                        image: Image(tokyoGhoul.atScreenKeywordList[2]),
                        keyword: tokyoGhoul.atScreenKeywordList[2],
                        currentKeyword: $tokyoGhoul.screenCurrentKeyword,
                        count: $tokyoGhoul.screenCountGusu,
                        minusCheck: $tokyoGhoul.minusCheck
                    )
                    // 1否定
                    unitButtonScreenChoice(
                        image: Image(tokyoGhoul.atScreenKeywordList[3]),
                        keyword: tokyoGhoul.atScreenKeywordList[3],
                        currentKeyword: $tokyoGhoul.screenCurrentKeyword,
                        count: $tokyoGhoul.screenCountNot1,
                        minusCheck: $tokyoGhoul.minusCheck
                    )
                    // 高設定示唆　弱
                    unitButtonScreenChoice(
                        image: Image(tokyoGhoul.atScreenKeywordList[4]),
                        keyword: tokyoGhoul.atScreenKeywordList[4],
                        currentKeyword: $tokyoGhoul.screenCurrentKeyword,
                        count: $tokyoGhoul.screenCountHighJaku,
                        minusCheck: $tokyoGhoul.minusCheck
                    )
                    // 高設定示唆　強
                    unitButtonScreenChoice(
                        image: Image(tokyoGhoul.atScreenKeywordList[5]),
                        keyword: tokyoGhoul.atScreenKeywordList[5],
                        currentKeyword: $tokyoGhoul.screenCurrentKeyword,
                        count: $tokyoGhoul.screenCountHighKyo,
                        minusCheck: $tokyoGhoul.minusCheck
                    )
                    // 設定4以上
                    unitButtonScreenChoice(
                        image: Image(tokyoGhoul.atScreenKeywordList[6]),
                        keyword: tokyoGhoul.atScreenKeywordList[6],
                        currentKeyword: $tokyoGhoul.screenCurrentKeyword,
                        count: $tokyoGhoul.screenCountOver4,
                        minusCheck: $tokyoGhoul.minusCheck
                    )
                    // 設定6
                    unitButtonScreenChoice(
                        image: Image(tokyoGhoul.atScreenKeywordList[7]),
                        keyword: tokyoGhoul.atScreenKeywordList[7],
                        currentKeyword: $tokyoGhoul.screenCurrentKeyword,
                        count: $tokyoGhoul.screenCountOver6,
                        minusCheck: $tokyoGhoul.minusCheck
                    )
                }
            }
            .frame(height: 120)
            
            // //// カウント結果
            // デフォルト
            unitResultCountListPercent(
                title: "デフォルト",
                count: $tokyoGhoul.screenCountDefault,
                flashColor: .gray,
                bigNumber: $tokyoGhoul.screenCountSum
            )
            // 奇数示唆
            unitResultCountListPercent(
                title: "奇数示唆",
                count: $tokyoGhoul.screenCountKisu,
                flashColor: .blue,
                bigNumber: $tokyoGhoul.screenCountSum
            )
            // 偶数示唆
            unitResultCountListPercent(
                title: "偶数示唆",
                count: $tokyoGhoul.screenCountGusu,
                flashColor: .yellow,
                bigNumber: $tokyoGhoul.screenCountSum
            )
            // 1否定
            unitResultCountListPercent(
                title: "設定1 否定",
                count: $tokyoGhoul.screenCountNot1,
                flashColor: .cyan,
                bigNumber: $tokyoGhoul.screenCountSum
            )
            // 高設定示唆　弱
            unitResultCountListPercent(
                title: "高設定示唆 弱",
                count: $tokyoGhoul.screenCountHighJaku,
                flashColor: .green,
                bigNumber: $tokyoGhoul.screenCountSum
            )
            // 高設定示唆　強
            unitResultCountListPercent(
                title: "高設定示唆 強",
                count: $tokyoGhoul.screenCountHighKyo,
                flashColor: .red,
                bigNumber: $tokyoGhoul.screenCountSum
            )
            // 設定4以上
            unitResultCountListPercent(
                title: "設定4 以上濃厚",
                count: $tokyoGhoul.screenCountOver4,
                flashColor: .purple,
                bigNumber: $tokyoGhoul.screenCountSum
            )
            // 設定6
            unitResultCountListPercent(
                title: "設定6 濃厚",
                count: $tokyoGhoul.screenCountOver6,
                flashColor: .orange,
                bigNumber: $tokyoGhoul.screenCountSum
            )
        }
        .navigationTitle("AT終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// 画面選択解除
                    unitButtonToolbarScreenSelectReset(currentKeyword: $tokyoGhoul.screenCurrentKeyword)
                        .popoverTip(tipUnitButtonScreenChoiceClear())
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $tokyoGhoul.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: tokyoGhoul.resetScreen)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    tokyoGhoulViewScreen(tokyoGhoul: TokyoGhoul())
}
