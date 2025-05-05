//
//  acceleratorViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/05.
//

import SwiftUI

struct acceleratorViewScreen: View {
//    @ObservedObject var accelerator = Accelerator()
    @ObservedObject var accelerator: Accelerator
    @State var isShowAlert: Bool = false
    
    var body: some View {
        List {
            Section {
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing:20) {
                        // 5人
                        unitButtonScreenChoice(
                            image: Image(accelerator.screenKeywordList[0]),
                            keyword: accelerator.screenKeywordList[0],
                            currentKeyword: $accelerator.screenCurrentKeyword,
                            count: $accelerator.screenCountDefault,
                            minusCheck: $accelerator.minusCheck
                        )
                        .popoverTip(tipUnitButtonScreenChoice())
                        // 夜景
                        unitButtonScreenChoice(
                            image: Image(accelerator.screenKeywordList[1]),
                            keyword: accelerator.screenKeywordList[1],
                            currentKeyword: $accelerator.screenCurrentKeyword,
                            count: $accelerator.screenCountDefault,
                            minusCheck: $accelerator.minusCheck
                        )
                        // どアップ
                        unitButtonScreenChoice(
                            image: Image(accelerator.screenKeywordList[2]),
                            keyword: accelerator.screenKeywordList[2],
                            currentKeyword: $accelerator.screenCurrentKeyword,
                            count: $accelerator.screenCountKeizoku,
                            minusCheck: $accelerator.minusCheck
                        )
                        // デート
                        unitButtonScreenChoice(
                            image: Image(accelerator.screenKeywordList[3]),
                            keyword: accelerator.screenKeywordList[3],
                            currentKeyword: $accelerator.screenCurrentKeyword,
                            count: $accelerator.screenCountHighJaku,
                            minusCheck: $accelerator.minusCheck
                        )
                        // 鐘つき
                        unitButtonScreenChoice(
                            image: Image(accelerator.screenKeywordList[4]),
                            keyword: accelerator.screenKeywordList[4],
                            currentKeyword: $accelerator.screenCurrentKeyword,
                            count: $accelerator.screenCountHighKyo,
                            minusCheck: $accelerator.minusCheck
                        )
                        // 水着
                        unitButtonScreenChoice(
                            image: Image(accelerator.screenKeywordList[5]),
                            keyword: accelerator.screenKeywordList[5],
                            currentKeyword: $accelerator.screenCurrentKeyword,
                            count: $accelerator.screenCountGusuSisa,
                            minusCheck: $accelerator.minusCheck
                        )
                        // 猫耳
                        unitButtonScreenChoice(
                            image: Image(accelerator.screenKeywordList[6]),
                            keyword: accelerator.screenKeywordList[6],
                            currentKeyword: $accelerator.screenCurrentKeyword,
                            count: $accelerator.screenCountGusuFix,
                            minusCheck: $accelerator.minusCheck
                        )
                        // ハロウィン
                        unitButtonScreenChoice(
                            image: Image(accelerator.screenKeywordList[7]),
                            keyword: accelerator.screenKeywordList[7],
                            currentKeyword: $accelerator.screenCurrentKeyword,
                            count: $accelerator.screenCountOver2,
                            minusCheck: $accelerator.minusCheck
                        )
                        // 金枠
                        unitButtonScreenChoice(
                            image: Image(accelerator.screenKeywordList[8]),
                            keyword: accelerator.screenKeywordList[8],
                            currentKeyword: $accelerator.screenCurrentKeyword,
                            count: $accelerator.screenCountOver4,
                            minusCheck: $accelerator.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $accelerator.screenCountDefault,
                    flashColor: .gray,
                    bigNumber: $accelerator.screenCountSum
                )
                // 継続示唆
                unitResultCountListPercent(
                    title: "継続示唆",
                    count: $accelerator.screenCountKeizoku,
                    flashColor: .blue,
                    bigNumber: $accelerator.screenCountSum
                )
                // 高設定示唆 弱
                unitResultCountListPercent(
                    title: "高設定示唆 弱",
                    count: $accelerator.screenCountHighJaku,
                    flashColor: .yellow,
                    bigNumber: $accelerator.screenCountSum
                )
                // 高設定示唆 強
                unitResultCountListPercent(
                    title: "高設定示唆 強",
                    count: $accelerator.screenCountHighKyo,
                    flashColor: .green,
                    bigNumber: $accelerator.screenCountSum
                )
                // 偶数示唆
                unitResultCountListPercent(
                    title: "偶数設定 示唆",
                    count: $accelerator.screenCountGusuSisa,
                    flashColor: .cyan,
                    bigNumber: $accelerator.screenCountSum
                )
                // 偶数濃厚
                unitResultCountListPercent(
                    title: "偶数設定 濃厚",
                    count: $accelerator.screenCountGusuFix,
                    flashColor: .red,
                    bigNumber: $accelerator.screenCountSum
                )
                // 設定2以上濃厚
                unitResultCountListPercent(
                    title: "設定2 以上濃厚",
                    count: $accelerator.screenCountOver2,
                    flashColor: .purple,
                    bigNumber: $accelerator.screenCountSum
                )
                // 設定4 以上濃厚
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $accelerator.screenCountOver4,
                    flashColor: .orange,
                    bigNumber: $accelerator.screenCountSum
                )
            } header: {
                Text("ビッグ,AT終了画面")
            }
        }
        .navigationTitle("ビッグ,AT終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// 画面選択解除
                    unitButtonToolbarScreenSelectReset(currentKeyword: $accelerator.screenCurrentKeyword)
                        .popoverTip(tipUnitButtonScreenChoiceClear())
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $accelerator.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: accelerator.resetScreen)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    acceleratorViewScreen(accelerator: Accelerator())
}
