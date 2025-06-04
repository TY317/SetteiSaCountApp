//
//  godeaterViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/13.
//

import SwiftUI
import TipKit

struct godeaterViewScreen: View {
//    @ObservedObject var godeater = Godeater()
    @ObservedObject var godeater: Godeater
    @State var isShowAlert = false
    var body: some View {
//        NavigationView {
            List {
                Section {
                    // //// 画面選択ボタン
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            // キャラなし
                            unitButtonScreenChoice(image: Image("godeaterScreenNone"), keyword: godeater.screenKeywordNone, currentKeyword: $godeater.screenCurrentKeyword, count: $godeater.screenCountNone, minusCheck: $godeater.minusCheck)
                                .popoverTip(tipUnitButtonScreenChoice())
                            // コウタ
                            unitButtonScreenChoice(image: Image("godeaterScreenKouta"), keyword: godeater.screenKeywordKota, currentKeyword: $godeater.screenCurrentKeyword, count: $godeater.screenCountKota, minusCheck: $godeater.minusCheck)
                            // アリサ
                            unitButtonScreenChoice(image: Image("godeaterScreenArisa"), keyword: godeater.screenKeywordArisa, currentKeyword: $godeater.screenCurrentKeyword, count: $godeater.screenCountArisa, minusCheck: $godeater.minusCheck)
                            // ユウ
                            unitButtonScreenChoice(image: Image("godeaterScreenYu"), keyword: godeater.screenKeywordYu, currentKeyword: $godeater.screenCurrentKeyword, count: $godeater.screenCountYu, minusCheck: $godeater.minusCheck)
                            // ソーマ
                            unitButtonScreenChoice(image: Image("godeaterScreenSoma"), keyword: godeater.screenKeywordSoma, currentKeyword: $godeater.screenCurrentKeyword, count: $godeater.screenCountSoma, minusCheck: $godeater.minusCheck)
                            // サクヤ
                            unitButtonScreenChoice(image: Image("godeaterScreenSakuya"), keyword: godeater.screenKeywordSakuya, currentKeyword: $godeater.screenCurrentKeyword, count: $godeater.screenCountSakuya, minusCheck: $godeater.minusCheck)
                            // リンドウ
                            unitButtonScreenChoice(image: Image("godeaterScreenRindo"), keyword: godeater.screenKeywordRindo, currentKeyword: $godeater.screenCurrentKeyword, count: $godeater.screenCountRindo, minusCheck: $godeater.minusCheck)
                            // シオ
                            unitButtonScreenChoice(image: Image("godeaterScreenShio"), keyword: godeater.screenKeywordShio, currentKeyword: $godeater.screenCurrentKeyword, count: $godeater.screenCountShio, minusCheck: $godeater.minusCheck)
                            // カフェ
                            unitButtonScreenChoice(image: Image("godeaterScreenCafe"), keyword: godeater.screenKeywordCafe, currentKeyword: $godeater.screenCurrentKeyword, count: $godeater.screenCountCafe, minusCheck: $godeater.minusCheck)
                            // キャラ集合
                            unitButtonScreenChoice(image: Image("godeaterScreenAll"), keyword: godeater.screenKeywordAll, currentKeyword: $godeater.screenCurrentKeyword, count: $godeater.screenCountAll, minusCheck: $godeater.minusCheck)
                            // ミニキャラ
                            unitButtonScreenChoice(image: Image("godeaterScreenMinichara"), keyword: godeater.screenKeywordMinichara, currentKeyword: $godeater.screenCurrentKeyword, count: $godeater.screenCountMinichara, minusCheck: $godeater.minusCheck)
                        }
                    }
                    .frame(height: 120)
                    // //// カウント結果
                    // キャラなし
                    unitResultCountListPercent(title: "デフォルト", count: $godeater.screenCountNone, flashColor: .gray, bigNumber: $godeater.screenCountSum)
                    // コウタ
                    unitResultCountListPercent(title: "高設定示唆 弱", count: $godeater.screenCountKota, flashColor: .blue, bigNumber: $godeater.screenCountSum)
                    // アリサ
                    unitResultCountListPercent(title: "偶数設定示唆 弱", count: $godeater.screenCountArisa, flashColor: .yellow, bigNumber: $godeater.screenCountSum)
                    // ユウ
                    unitResultCountListPercent(title: "設定２,3,4 否定", count: $godeater.screenCountYu, flashColor: .green, bigNumber: $godeater.screenCountSum)
                    // ソーマ
                    unitResultCountListPercent(title: "高設定示唆 強", count: $godeater.screenCountSoma, flashColor: .red, bigNumber: $godeater.screenCountSum)
                    // サクヤ
                    unitResultCountListPercent(title: "偶数設定示唆 強", count: $godeater.screenCountSakuya, flashColor: .yellow, bigNumber: $godeater.screenCountSum)
                    // リンドウ
                    unitResultCountListPercent(title: "設定3 以上濃厚", count: $godeater.screenCountRindo, flashColor: .orange, bigNumber: $godeater.screenCountSum)
                    // シオ
                    unitResultCountListPercent(title: "設定4 以上濃厚", count: $godeater.screenCountShio, flashColor: .purple, bigNumber: $godeater.screenCountSum)
                    // カフェ
                    unitResultCountListPercent(title: "偶数設定濃厚", count: $godeater.screenCountCafe, flashColor: .brown, bigNumber: $godeater.screenCountSum)
                    // キャラ集合
                    unitResultCountListPercent(title: "設定5 以上濃厚", count: $godeater.screenCountAll, flashColor: .red, bigNumber: $godeater.screenCountSum)
                    // ミニキャラ
                    unitResultCountListPercent(title: "設定6 濃厚", count: $godeater.screenCountMinichara, flashColor: .pink, bigNumber: $godeater.screenCountSum)
                } header: {
                    Text("AT終了画面")
                }
            }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ゴッドイーター リザレクション",
                screenClass: screenClass
            )
        }
            .navigationTitle("AT終了後画面")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        unitButtonToolbarScreenSelectReset(currentKeyword: $godeater.screenCurrentKeyword)
//                            .popoverTip(tipUnitButtonScreenChoiceClear())
                        unitButtonMinusCheck(minusCheck: $godeater.minusCheck)
                        unitButtonReset(isShowAlert: $isShowAlert, action: godeater.resetScreen)
                    }
                }
            }
//        }
//        .navigationTitle("AT終了後画面")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    unitButtonToolbarScreenSelectReset(currentKeyword: $godeater.screenCurrentKeyword)
//                        .popoverTip(tipUnitButtonScreenChoiceClear())
//                    unitButtonMinusCheck(minusCheck: $godeater.minusCheck)
//                    unitButtonReset(isShowAlert: $isShowAlert, action: godeater.resetScreen)
//                }
//            }
//        }
    }
}

#Preview {
    godeaterViewScreen(godeater: Godeater())
}
