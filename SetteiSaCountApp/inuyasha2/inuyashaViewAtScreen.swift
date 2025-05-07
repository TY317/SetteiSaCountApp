//
//  inuyashaViewAtScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/21.
//

import SwiftUI

struct inuyashaViewAtScreen: View {
//    @ObservedObject var inuyasha = Inuyasha()
    @ObservedObject var inuyasha: Inuyasha
    @State var isShowAlert: Bool = false
    
    var body: some View {
        List {
            Section {
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // 青枠　昼寝
                        unitButtonScreenChoice(
                            image: Image(inuyasha.atScreenKeywordList[0]),
                            keyword: inuyasha.atScreenKeywordList[0],
                            currentKeyword: $inuyasha.atScreenCurrentKeyword,
                            count: $inuyasha.atScreenCountDefault,
                            minusCheck: $inuyasha.minusCheck
                        )
                        .popoverTip(tipUnitButtonScreenChoice())
                        // 青枠　おんぶ
                        unitButtonScreenChoice(
                            image: Image(inuyasha.atScreenKeywordList[1]),
                            keyword: inuyasha.atScreenKeywordList[1],
                            currentKeyword: $inuyasha.atScreenCurrentKeyword,
                            count: $inuyasha.atScreenCountGusu,
                            minusCheck: $inuyasha.minusCheck
                        )
                        // 青枠　おすわり
                        unitButtonScreenChoice(
                            image: Image(inuyasha.atScreenKeywordList[2]),
                            keyword: inuyasha.atScreenKeywordList[2],
                            currentKeyword: $inuyasha.atScreenCurrentKeyword,
                            count: $inuyasha.atScreenCountOver2,
                            minusCheck: $inuyasha.minusCheck
                        )
                        // 黄枠
                        unitButtonScreenChoice(
                            image: Image(inuyasha.atScreenKeywordList[3]),
                            keyword: inuyasha.atScreenKeywordList[3],
                            currentKeyword: $inuyasha.atScreenCurrentKeyword,
                            count: $inuyasha.atScreenCountHighJaku,
                            minusCheck: $inuyasha.minusCheck
                        )
                        // 緑枠
                        unitButtonScreenChoice(
                            image: Image(inuyasha.atScreenKeywordList[4]),
                            keyword: inuyasha.atScreenKeywordList[4],
                            currentKeyword: $inuyasha.atScreenCurrentKeyword,
                            count: $inuyasha.atScreenCountHighChu,
                            minusCheck: $inuyasha.minusCheck
                        )
                        // 赤枠
                        unitButtonScreenChoice(
                            image: Image(inuyasha.atScreenKeywordList[5]),
                            keyword: inuyasha.atScreenKeywordList[5],
                            currentKeyword: $inuyasha.atScreenCurrentKeyword,
                            count: $inuyasha.atScreenCountHighKyo,
                            minusCheck: $inuyasha.minusCheck
                        )
                        // 金枠
                        unitButtonScreenChoice(
                            image: Image(inuyasha.atScreenKeywordList[6]),
                            keyword: inuyasha.atScreenKeywordList[6],
                            currentKeyword: $inuyasha.atScreenCurrentKeyword,
                            count: $inuyasha.atScreenCountOver4,
                            minusCheck: $inuyasha.minusCheck
                        )
                        // 虹枠
                        unitButtonScreenChoice(
                            image: Image(inuyasha.atScreenKeywordList[7]),
                            keyword: inuyasha.atScreenKeywordList[7],
                            currentKeyword: $inuyasha.atScreenCurrentKeyword,
                            count: $inuyasha.atScreenCount6Kaku,
                            minusCheck: $inuyasha.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $inuyasha.atScreenCountDefault,
                    flashColor: .gray,
                    bigNumber: $inuyasha.atScreenCountSum
                )
                // 偶数示唆 弱
                unitResultCountListPercent(
                    title: "偶数示唆 弱",
                    count: $inuyasha.atScreenCountGusu,
                    flashColor: .blue,
                    bigNumber: $inuyasha.atScreenCountSum
                )
                // 設定2 以上
                unitResultCountListPercent(
                    title: "設定2 以上濃厚",
                    count: $inuyasha.atScreenCountOver2,
                    flashColor: .cyan,
                    bigNumber: $inuyasha.atScreenCountSum
                )
                // 高設定示唆 弱
                unitResultCountListPercent(
                    title: "高設定示唆 弱",
                    count: $inuyasha.atScreenCountHighJaku,
                    flashColor: .yellow,
                    bigNumber: $inuyasha.atScreenCountSum
                )
                // 高設定示唆 中
                unitResultCountListPercent(
                    title: "高設定示唆 中",
                    count: $inuyasha.atScreenCountHighChu,
                    flashColor: .green,
                    bigNumber: $inuyasha.atScreenCountSum
                )
                // 高設定示唆 強
                unitResultCountListPercent(
                    title: "高設定示唆 強",
                    count: $inuyasha.atScreenCountHighKyo,
                    flashColor: .red,
                    bigNumber: $inuyasha.atScreenCountSum
                )
                // 設定4 以上濃厚
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $inuyasha.atScreenCountOver4,
                    flashColor: .orange,
                    bigNumber: $inuyasha.atScreenCountSum
                )
                // 設定6 濃厚
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $inuyasha.atScreenCount6Kaku,
                    flashColor: .purple,
                    bigNumber: $inuyasha.atScreenCountSum
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
                unitButtonToolbarScreenSelectReset(currentKeyword: $inuyasha.atScreenCurrentKeyword)
                    .popoverTip(tipUnitButtonScreenChoiceClear())
                // マイナスチェック
                unitButtonMinusCheck(minusCheck: $inuyasha.minusCheck)
                // リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: inuyasha.resetAtScreen)
//                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}

#Preview {
    inuyashaViewAtScreen(inuyasha: Inuyasha())
}
