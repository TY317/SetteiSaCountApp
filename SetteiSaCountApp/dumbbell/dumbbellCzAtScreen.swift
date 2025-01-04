//
//  dumbbellCzAtScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/02.
//

import SwiftUI

struct dumbbellCzAtScreen: View {
    @ObservedObject var dumbbell = Dumbbell()
    @State var isShowAlert: Bool = false
    
    var body: some View {
        List {
            Section {
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // ひびき
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[0]),
                            keyword: dumbbell.czBonusScreenKeywordList[0],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountDefault,
                            minusCheck: $dumbbell.minusCheck
                        )
                        .popoverTip(tipUnitButtonScreenChoice())
                        // 白枠 朱美
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[1]),
                            keyword: dumbbell.czBonusScreenKeywordList[1],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountAny,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // 白枠 さやか
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[2]),
                            keyword: dumbbell.czBonusScreenKeywordList[2],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountAny,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // 白枠 朱美
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[3]),
                            keyword: dumbbell.czBonusScreenKeywordList[3],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountOver3Sisa,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // 白枠 朱美
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[4]),
                            keyword: dumbbell.czBonusScreenKeywordList[4],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountAny,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // 赤枠
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[5]),
                            keyword: dumbbell.czBonusScreenKeywordList[5],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountHigh,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // 紫枠
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[6]),
                            keyword: dumbbell.czBonusScreenKeywordList[6],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountOverTokutei,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // 銀枠 ドレス
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[7]),
                            keyword: dumbbell.czBonusScreenKeywordList[7],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountOver4,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // 銀枠 水着
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[8]),
                            keyword: dumbbell.czBonusScreenKeywordList[8],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountOver4Kyo,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // 金枠
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[9]),
                            keyword: dumbbell.czBonusScreenKeywordList[9],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountOver6,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // サウナ
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[10]),
                            keyword: dumbbell.czBonusScreenKeywordList[10],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountMode,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // トランプ
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[11]),
                            keyword: dumbbell.czBonusScreenKeywordList[11],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCount1or6,
                            minusCheck: $dumbbell.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $dumbbell.czBonusScreenCountDefault,
                    flashColor: .gray,
                    bigNumber: $dumbbell.czBonusScreenCountSum
                )
                // ?
                unitResultCountListPercent(
                    title: "?",
                    count: $dumbbell.czBonusScreenCountAny,
                    flashColor: .blue,
                    bigNumber: $dumbbell.czBonusScreenCountSum
                )
                // 設定3 以上示唆
                unitResultCountListPercent(
                    title: "設定3 以上示唆",
                    count: $dumbbell.czBonusScreenCountOver3Sisa,
                    flashColor: .yellow,
                    bigNumber: $dumbbell.czBonusScreenCountSum
                )
                // 高設定示唆
                unitResultCountListPercent(
                    title: "高設定示唆",
                    count: $dumbbell.czBonusScreenCountHigh,
                    flashColor: .green,
                    bigNumber: $dumbbell.czBonusScreenCountSum
                )
                // 特定設定以上濃厚
                unitResultCountListPercent(
                    title: "特定設定以上濃厚",
                    count: $dumbbell.czBonusScreenCountOverTokutei,
                    flashColor: .cyan,
                    bigNumber: $dumbbell.czBonusScreenCountSum
                )
                // 設定4 以上濃厚
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $dumbbell.czBonusScreenCountOver4,
                    flashColor: .red,
                    bigNumber: $dumbbell.czBonusScreenCountSum
                )
                // 設定4 以上濃厚 強
                VStack(spacing:0) {
                    unitResultCountListPercent(
                        title: "設定4 以上濃厚 強",
                        count: $dumbbell.czBonusScreenCountOver4Kyo,
                        flashColor: .red,
                        bigNumber: $dumbbell.czBonusScreenCountSum
                    )
                    Text("※ 紫枠 ドレスより強い")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                // 設定6 濃厚
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $dumbbell.czBonusScreenCountOver6,
                    flashColor: .orange,
                    bigNumber: $dumbbell.czBonusScreenCountSum
                )
                // モード示唆
                VStack(spacing:0) {
                    unitResultCountListPercent(
                        title: "モード示唆",
                        count: $dumbbell.czBonusScreenCountMode,
                        flashColor: .indigo,
                        bigNumber: $dumbbell.czBonusScreenCountSum
                    )
                    Text("※ 人数少ないほど早い規定カロリーに期待")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                // 設定1or6 濃厚
                unitResultCountListPercent(
                    title: "設定1 or 6 濃厚",
                    count: $dumbbell.czBonusScreenCount1or6,
                    flashColor: .mint,
                    bigNumber: $dumbbell.czBonusScreenCountSum
                )
            } header: {
                Text("CZ・AT終了画面")
            }
        }
        .navigationTitle("CZ・AT終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonToolbarScreenSelectReset(currentKeyword: $dumbbell.czBonusScreenCurrentKeyword)
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $dumbbell.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: dumbbell.resetCzBonusScreen)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    dumbbellCzAtScreen()
}
