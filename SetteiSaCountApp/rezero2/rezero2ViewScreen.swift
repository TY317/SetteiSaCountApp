//
//  rezero2ViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/02.
//

import SwiftUI

struct rezero2ViewScreen: View {
//    @ObservedObject var rezero2 = Rezero2()
    @ObservedObject var rezero2: Rezero2
    @State var isShowAlert: Bool = false
    var body: some View {
        List {
            Section {
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // 墓所
                        unitButtonScreenChoice(
                            image: Image(rezero2.screenKeywordList[0]),
                            keyword: rezero2.screenKeywordList[0],
                            currentKeyword: $rezero2.screenCurrentKeyword,
                            count: $rezero2.screenCountGrave,
                            minusCheck: $rezero2.minusCheck
                        )
                        .popoverTip(tipUnitButtonScreenChoice())
                        // 風呂男性
                        unitButtonScreenChoice(
                            image: Image(rezero2.screenKeywordList[1]),
                            keyword: rezero2.screenKeywordList[1],
                            currentKeyword: $rezero2.screenCurrentKeyword,
                            count: $rezero2.screenCountBathMen,
                            minusCheck: $rezero2.minusCheck
                        )
                        // 風呂女性
                        unitButtonScreenChoice(
                            image: Image(rezero2.screenKeywordList[2]),
                            keyword: rezero2.screenKeywordList[2],
                            currentKeyword: $rezero2.screenCurrentKeyword,
                            count: $rezero2.screenCountBathWomen,
                            minusCheck: $rezero2.minusCheck
                        )
                        // ラム＆レム
                        unitButtonScreenChoice(
                            image: Image(rezero2.screenKeywordList[3]),
                            keyword: rezero2.screenKeywordList[3],
                            currentKeyword: $rezero2.screenCurrentKeyword,
                            count: $rezero2.screenCountRamRem,
                            minusCheck: $rezero2.minusCheck
                        )
                        // お茶会
                        unitButtonScreenChoice(
                            image: Image(rezero2.screenKeywordList[4]),
                            keyword: rezero2.screenKeywordList[4],
                            currentKeyword: $rezero2.screenCurrentKeyword,
                            count: $rezero2.screenCountTeaParty,
                            minusCheck: $rezero2.minusCheck
                        )
                        // 露天風呂
                        unitButtonScreenChoice(
                            image: Image(rezero2.screenKeywordList[5]),
                            keyword: rezero2.screenKeywordList[5],
                            currentKeyword: $rezero2.screenCurrentKeyword,
                            count: $rezero2.screenCountOutdoorBath,
                            minusCheck: $rezero2.minusCheck
                        )
                        // エキドナ
                        unitButtonScreenChoice(
                            image: Image(rezero2.screenKeywordList[6]),
                            keyword: rezero2.screenKeywordList[6],
                            currentKeyword: $rezero2.screenCurrentKeyword,
                            count: $rezero2.screenCountEkidona,
                            minusCheck: $rezero2.minusCheck
                        )
                        // ベアトリス
                        unitButtonScreenChoice(
                            image: Image(rezero2.screenKeywordList[7]),
                            keyword: rezero2.screenKeywordList[7],
                            currentKeyword: $rezero2.screenCurrentKeyword,
                            count: $rezero2.screenCountBeatris,
                            minusCheck: $rezero2.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                // 墓所
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $rezero2.screenCountGrave,
                    flashColor: .gray,
                    bigNumber: $rezero2.screenCountSum
                )
                // 風呂男性
                unitResultCountListPercent(
                    title: "高設定示唆",
                    count: $rezero2.screenCountBathMen,
                    flashColor: .blue,
                    bigNumber: $rezero2.screenCountSum
                )
                // 風呂女性
                unitResultCountListPercent(
                    title: "設定2 以上濃厚",
                    count: $rezero2.screenCountBathWomen,
                    flashColor: .yellow,
                    bigNumber: $rezero2.screenCountSum
                )
                // ラムレム
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $rezero2.screenCountRamRem,
                    flashColor: .green,
                    bigNumber: $rezero2.screenCountSum
                )
                // お茶会
                unitResultCountListPercent(
                    title: "設定5 以上濃厚",
                    count: $rezero2.screenCountTeaParty,
                    flashColor: .red,
                    bigNumber: $rezero2.screenCountSum
                )
                // 露天風呂
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $rezero2.screenCountOutdoorBath,
                    flashColor: .purple,
                    bigNumber: $rezero2.screenCountSum
                )
                // エキドナ
                unitResultCountListPercent(
                    title: "AT復活期待度UP",
                    count: $rezero2.screenCountEkidona,
                    flashColor: .brown,
                    bigNumber: $rezero2.screenCountSum
                )
                // ベアトリス
                unitResultCountListPercent(
                    title: "AT復活濃厚",
                    count: $rezero2.screenCountBeatris,
                    flashColor: .orange,
                    bigNumber: $rezero2.screenCountSum
                )
            } header: {
                Text("AT終了画面")
            }
        }
        .navigationTitle("AT終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                // 画面選択解除
                unitButtonToolbarScreenSelectReset(currentKeyword: $rezero2.screenCurrentKeyword)
                    .popoverTip(tipUnitButtonScreenChoiceClear())
                // マイナスチェック
                unitButtonMinusCheck(minusCheck: $rezero2.minusCheck)
                // リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: rezero2.resetScreen)
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}

#Preview {
    rezero2ViewScreen(rezero2: Rezero2())
}
