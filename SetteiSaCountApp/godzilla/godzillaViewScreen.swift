//
//  godzillaViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/13.
//

import SwiftUI

struct godzillaViewScreen: View {
    @ObservedObject var godzilla: Godzilla
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "godzillaBonusScreenHedora",
        "godzillaBonusScreenAngirasu",
        "godzillaBonusScreenRadon",
        "godzillaBonusScreenGaigan",
        "godzillaBonusScreenBiorante",
        "godzillaBonusScreenDestoroia",
        "godzillaBonusScreenKingGidora",
        "godzillaBonusScreenGodzillaRed",
        "godzillaBonusScreenGodzillaMonoChrome"
    ]
    
    var body: some View {
        List {
            Section {
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // ヘドラ
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[0]),
                            keyword: self.imageNameList[0],
                            currentKeyword: self.$selectedImageName,
                            count: $godzilla.bonusScreenCountDefault,
                            minusCheck: $godzilla.minusCheck
                        )
                        // アンギラス
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[1]),
                            keyword: self.imageNameList[1],
                            currentKeyword: self.$selectedImageName,
                            count: $godzilla.bonusScreenCountDefault,
                            minusCheck: $godzilla.minusCheck
                        )
                        // ラドン
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[2]),
                            keyword: self.imageNameList[2],
                            currentKeyword: self.$selectedImageName,
                            count: $godzilla.bonusScreenCountKisu,
                            minusCheck: $godzilla.minusCheck
                        )
                        // ガイガン
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[3]),
                            keyword: self.imageNameList[3],
                            currentKeyword: self.$selectedImageName,
                            count: $godzilla.bonusScreenCountGusu,
                            minusCheck: $godzilla.minusCheck
                        )
                        // ビオランテ
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[4]),
                            keyword: self.imageNameList[4],
                            currentKeyword: self.$selectedImageName,
                            count: $godzilla.bonusScreenCountKisuHigh,
                            minusCheck: $godzilla.minusCheck
                        )
                        // デストロイア
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[5]),
                            keyword: self.imageNameList[5],
                            currentKeyword: self.$selectedImageName,
                            count: $godzilla.bonusScreenCountGusuHigh,
                            minusCheck: $godzilla.minusCheck
                        )
                        // キングギドラ
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[6]),
                            keyword: self.imageNameList[6],
                            currentKeyword: self.$selectedImageName,
                            count: $godzilla.bonusScreenCount4Over,
                            minusCheck: $godzilla.minusCheck
                        )
                        // ゴジラ赤
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[7]),
                            keyword: self.imageNameList[7],
                            currentKeyword: self.$selectedImageName,
                            count: $godzilla.bonusScreenCount5Over,
                            minusCheck: $godzilla.minusCheck
                        )
                        // ゴジラ白黒
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[8]),
                            keyword: self.imageNameList[8],
                            currentKeyword: self.$selectedImageName,
                            count: $godzilla.bonusScreenCount6Over,
                            minusCheck: $godzilla.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $godzilla.bonusScreenCountDefault,
                    flashColor: .gray,
                    bigNumber: $godzilla.bonusScreenCountSum
                )
                // 奇数示唆
                unitResultCountListPercent(
                    title: "奇数示唆",
                    count: $godzilla.bonusScreenCountKisu,
                    flashColor: .blue,
                    bigNumber: $godzilla.bonusScreenCountSum
                )
                // 偶数示唆
                unitResultCountListPercent(
                    title: "偶数示唆",
                    count: $godzilla.bonusScreenCountGusu,
                    flashColor: .yellow,
                    bigNumber: $godzilla.bonusScreenCountSum
                )
                // 奇数示唆かつ高設定示唆
                unitResultCountListPercent(
                    title: "奇数&高設定示唆",
                    count: $godzilla.bonusScreenCountKisuHigh,
                    flashColor: .cyan,
                    bigNumber: $godzilla.bonusScreenCountSum
                )
                // 偶数示唆かつ高設定示唆
                unitResultCountListPercent(
                    title: "偶数&高設定示唆",
                    count: $godzilla.bonusScreenCountGusuHigh,
                    flashColor: .orange,
                    bigNumber: $godzilla.bonusScreenCountSum
                )
                // 設定４以上
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $godzilla.bonusScreenCount4Over,
                    flashColor: .green,
                    bigNumber: $godzilla.bonusScreenCountSum
                )
                // 設定5以上
                unitResultCountListPercent(
                    title: "設定5 以上濃厚",
                    count: $godzilla.bonusScreenCount5Over,
                    flashColor: .red,
                    bigNumber: $godzilla.bonusScreenCountSum
                )
                // 設定6以上
                unitResultCountListPercent(
                    title: "設定6 以上濃厚",
                    count: $godzilla.bonusScreenCount6Over,
                    flashColor: .purple,
                    bigNumber: $godzilla.bonusScreenCountSum
                )
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ゴジラ",
                screenClass: screenClass
            )
        }
        .navigationTitle("ボーナス終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $godzilla.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: godzilla.resetBonusScreen)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    godzillaViewScreen(godzilla: Godzilla())
}
