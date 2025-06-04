//
//  lupinViewAtScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/13.
//

import SwiftUI

struct lupinViewAtScreen: View {
//    @ObservedObject var lupin = Lupin()
    @ObservedObject var lupin: Lupin
    @State var isShowAlert: Bool = false
    
    var body: some View {
        List {
            Section {
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // デフォルト
                        unitButtonScreenChoice(
                            image: Image(lupin.atScreenKeywordList[0]),
                            keyword: lupin.atScreenKeywordList[0],
                            currentKeyword: $lupin.atScreenCurrentKeyword,
                            count: $lupin.atScreenCountDefault,
                            minusCheck: $lupin.minusCheck
                        )
                        .popoverTip(tipUnitButtonScreenChoice())
                        // ルパン一味
                        unitButtonScreenChoice(
                            image: Image(lupin.atScreenKeywordList[1]),
                            keyword: lupin.atScreenKeywordList[1],
                            currentKeyword: $lupin.atScreenCurrentKeyword,
                            count: $lupin.atScreenCountIchimi,
                            minusCheck: $lupin.minusCheck
                        )
                        // 可スタンプ
                        unitButtonScreenChoice(
                            image: Image(lupin.atScreenKeywordList[2]),
                            keyword: lupin.atScreenKeywordList[2],
                            currentKeyword: $lupin.atScreenCurrentKeyword,
                            count: $lupin.atScreenCountKa,
                            minusCheck: $lupin.minusCheck
                        )
                        // 吉スタンプ
                        unitButtonScreenChoice(
                            image: Image(lupin.atScreenKeywordList[3]),
                            keyword: lupin.atScreenKeywordList[3],
                            currentKeyword: $lupin.atScreenCurrentKeyword,
                            count: $lupin.atScreenCountKichi,
                            minusCheck: $lupin.minusCheck
                        )
                        // 良スタンプ
                        unitButtonScreenChoice(
                            image: Image(lupin.atScreenKeywordList[4]),
                            keyword: lupin.atScreenKeywordList[4],
                            currentKeyword: $lupin.atScreenCurrentKeyword,
                            count: $lupin.atScreenCountRyo,
                            minusCheck: $lupin.minusCheck
                        )
                        // 優スタンプ
                        unitButtonScreenChoice(
                            image: Image(lupin.atScreenKeywordList[5]),
                            keyword: lupin.atScreenKeywordList[5],
                            currentKeyword: $lupin.atScreenCurrentKeyword,
                            count: $lupin.atScreenCountYu,
                            minusCheck: $lupin.minusCheck
                        )
                        // 極スタンプ
                        unitButtonScreenChoice(
                            image: Image(lupin.atScreenKeywordList[6]),
                            keyword: lupin.atScreenKeywordList[6],
                            currentKeyword: $lupin.atScreenCurrentKeyword,
                            count: $lupin.atScreenCountKiwami,
                            minusCheck: $lupin.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $lupin.atScreenCountDefault,
                    flashColor: .gray,
                    bigNumber: $lupin.atScreenCountSum
                )
                // ルパン一味
                unitResultCountListPercent(
                    title: "高設定示唆",
                    count: $lupin.atScreenCountIchimi,
                    flashColor: .yellow,
                    bigNumber: $lupin.atScreenCountSum
                )
                // 可スタンプ
                unitResultCountListPercent(
                    title: "設定2 以上濃厚",
                    count: $lupin.atScreenCountKa,
                    flashColor: .blue,
                    bigNumber: $lupin.atScreenCountSum
                )
                // 吉スタンプ
                unitResultCountListPercent(
                    title: "設定3 以上濃厚",
                    count: $lupin.atScreenCountKichi,
                    flashColor: .green,
                    bigNumber: $lupin.atScreenCountSum
                )
                // 良スタンプ
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $lupin.atScreenCountRyo,
                    flashColor: .red,
                    bigNumber: $lupin.atScreenCountSum
                )
                // 優スタンプ
                unitResultCountListPercent(
                    title: "設定5 以上濃厚",
                    count: $lupin.atScreenCountYu,
                    flashColor: .gray,
                    bigNumber: $lupin.atScreenCountSum
                )
                // 極スタンプ
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $lupin.atScreenCountKiwami,
                    flashColor: .orange,
                    bigNumber: $lupin.atScreenCountSum
                )
            } header: {
                Text("AT終了画面")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ルパン3世 大航海者の秘宝",
                screenClass: screenClass
            )
        }
        .navigationTitle("AT終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                // 画面選択解除
                unitButtonToolbarScreenSelectReset(currentKeyword: $lupin.atScreenCurrentKeyword)
//                    .popoverTip(tipUnitButtonScreenChoiceClear())
                // マイナスチェック
                unitButtonMinusCheck(minusCheck: $lupin.minusCheck)
                // リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: lupin.resetAtScreen)
//                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}

#Preview {
    lupinViewAtScreen(lupin: Lupin())
}
