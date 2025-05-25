//
//  mahjongViewBonusScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/18.
//

import SwiftUI

struct mahjongViewBonusScreen: View {
    @ObservedObject var mahjong: Mahjong
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "mahjongBonusScreenDefault",
        "mahjongBonusScreenGusu",
        "mahjongBonusScreenKisu",
        "mahjongBonusScreen2Over",
        "mahjongBonusScreen5Over",
        "mahjongBonusScreen6Over"
    ]
    
    var body: some View {
        List {
            Section {
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // デフォルト
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[0]),
                            keyword: self.imageNameList[0],
                            currentKeyword: self.$selectedImageName,
                            count: $mahjong.bonusScreenCountDefault,
                            minusCheck: $mahjong.minusCheck
                        )
                        .popoverTip(tipUnitButtonScreenChoice())
                        // 偶数示唆
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[1]),
                            keyword: self.imageNameList[1],
                            currentKeyword: self.$selectedImageName,
                            count: $mahjong.bonusScreenCountGusu,
                            minusCheck: $mahjong.minusCheck
                        )
                        // 奇数示唆
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[2]),
                            keyword: self.imageNameList[2],
                            currentKeyword: self.$selectedImageName,
                            count: $mahjong.bonusScreenCountKisu,
                            minusCheck: $mahjong.minusCheck
                        )
                        // 設定2以上
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[3]),
                            keyword: self.imageNameList[3],
                            currentKeyword: self.$selectedImageName,
                            count: $mahjong.bonusScreenCount2Over,
                            minusCheck: $mahjong.minusCheck
                        )
                        // 設定5以上
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[4]),
                            keyword: self.imageNameList[4],
                            currentKeyword: self.$selectedImageName,
                            count: $mahjong.bonusScreenCount5Over,
                            minusCheck: $mahjong.minusCheck
                        )
                        // 設定6以上
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[5]),
                            keyword: self.imageNameList[5],
                            currentKeyword: self.$selectedImageName,
                            count: $mahjong.bonusScreenCount6Over,
                            minusCheck: $mahjong.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $mahjong.bonusScreenCountDefault,
                    flashColor: .gray,
                    bigNumber: $mahjong.bonusScreenCountSum
                )
                // 偶数示唆
                unitResultCountListPercent(
                    title: "偶数示唆",
                    count: $mahjong.bonusScreenCountGusu,
                    flashColor: .yellow,
                    bigNumber: $mahjong.bonusScreenCountSum
                )
                // 奇数示唆
                unitResultCountListPercent(
                    title: "奇数示唆",
                    count: $mahjong.bonusScreenCountKisu,
                    flashColor: .blue,
                    bigNumber: $mahjong.bonusScreenCountSum
                )
                // 設定２以上
                unitResultCountListPercent(
                    title: "設定2 以上濃厚",
                    count: $mahjong.bonusScreenCount2Over,
                    flashColor: .green,
                    bigNumber: $mahjong.bonusScreenCountSum
                )
                // 設定5以上
                unitResultCountListPercent(
                    title: "設定5 以上濃厚",
                    count: $mahjong.bonusScreenCount5Over,
                    flashColor: .red,
                    bigNumber: $mahjong.bonusScreenCountSum
                )
                // 設定6以上
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $mahjong.bonusScreenCount6Over,
                    flashColor: .purple,
                    bigNumber: $mahjong.bonusScreenCountSum
                )
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "麻雀物語",
                screenClass: screenClass
            )
        }
        .navigationTitle("BIG終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// 画面選択解除
                    unitButtonToolbarScreenSelectReset(currentKeyword: self.$selectedImageName)
                        .popoverTip(tipUnitButtonScreenChoiceClear())
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $mahjong.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: mahjong.resetBonusScreen)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    mahjongViewBonusScreen(mahjong: Mahjong())
}
