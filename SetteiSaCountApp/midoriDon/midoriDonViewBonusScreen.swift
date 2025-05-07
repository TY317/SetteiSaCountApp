//
//  midoriDonViewBonusScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/04.
//

import SwiftUI

struct midoriDonViewBonusScreen: View {
    @ObservedObject var ver301: Ver301
    @ObservedObject var midoriDon: MidoriDon
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "midoriDonBonusScreen1",
        "midoriDonBonusScreen2",
        "midoriDonBonusScreen3",
        "midoriDonBonusScreen4",
        "midoriDonBonusScreen5",
        "midoriDonBonusScreen6"
    ]
    
    var body: some View {
        List {
            Section {
                Text("ボーナス終了画面でPUSHボタンを押すと表示されます")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
//                Text("参考）右の画面ほど強い示唆と予想")
//                    .foregroundStyle(Color.secondary)
//                    .font(.caption)
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // ドン・ビリー
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[0]),
                                upperBeltText: "ドン・ビリー",
                                lowerBeltText: "デフォルト"
                            ),
                            screenName: self.imageNameList[0],
                            selectedScreen: self.$selectedImageName,
                            count: $midoriDon.bonusScreenCountScreen1,
                            minusCheck: $midoriDon.minusCheck
                        )
                        .popoverTip(tipUnitButtonScreenChoice())
                        // ドン・ファビオ
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[1]),
                                upperBeltText: "ドン・ファビオ",
                                lowerBeltText: "奇数示唆"
                            ),
                            screenName: self.imageNameList[1],
                            selectedScreen: self.$selectedImageName,
                            count: $midoriDon.bonusScreenCountScreen2,
                            minusCheck: $midoriDon.minusCheck
                        )
                        // ドン・葉月・ビリー
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[2]),
                                upperBeltText: "ドン・葉月・ビリー",
                                lowerBeltText: "偶数示唆"
                            ),
                            screenName: self.imageNameList[2],
                            selectedScreen: self.$selectedImageName,
                            count: $midoriDon.bonusScreenCountScreen3,
                            minusCheck: $midoriDon.minusCheck
                        )
                        // 葉月・マリア
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[3]),
                                upperBeltText: "葉月・マリア",
                                lowerBeltText: "設定2 以上示唆"
                            ),
                            screenName: self.imageNameList[3],
                            selectedScreen: self.$selectedImageName,
                            count: $midoriDon.bonusScreenCountScreen4,
                            minusCheck: $midoriDon.minusCheck
                        )
                        // 全員集合
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[4]),
                                upperBeltText: "全員集合",
                                lowerBeltText: "設定4 以上示唆"
                            ),
                            screenName: self.imageNameList[4],
                            selectedScreen: self.$selectedImageName,
                            count: $midoriDon.bonusScreenCountScreen5,
                            minusCheck: $midoriDon.minusCheck
                        )
                        // 実写ビリー
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[5]),
                                upperBeltText: "実写ビリー",
                                lowerBeltText: "設定6 濃厚"
                            ),
                            screenName: self.imageNameList[5],
                            selectedScreen: self.$selectedImageName,
                            count: $midoriDon.bonusScreenCountScreen6,
                            minusCheck: $midoriDon.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                .popoverTip(tipVer301MidoriDonScreen())
                
                // //// カウント結果
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $midoriDon.bonusScreenCountScreen1,
                    flashColor: .gray,
                    bigNumber: $midoriDon.bonusScreenCountSum
                )
                // ドン・ファビオ
                unitResultCountListPercent(
                    title: "奇数示唆",
                    count: $midoriDon.bonusScreenCountScreen2,
                    flashColor: .blue,
                    bigNumber: $midoriDon.bonusScreenCountSum
                )
                // ドン・葉月・ビリー
                unitResultCountListPercent(
                    title: "偶数示唆",
                    count: $midoriDon.bonusScreenCountScreen3,
                    flashColor: .yellow,
                    bigNumber: $midoriDon.bonusScreenCountSum
                )
                // 葉月・マリア
                unitResultCountListPercent(
                    title: "設定2 以上示唆",
                    count: $midoriDon.bonusScreenCountScreen4,
                    flashColor: .green,
                    bigNumber: $midoriDon.bonusScreenCountSum
                )
                // 全員集合
                unitResultCountListPercent(
                    title: "設定4 以上示唆",
                    count: $midoriDon.bonusScreenCountScreen5,
                    flashColor: .red,
                    bigNumber: $midoriDon.bonusScreenCountSum
                )
                // 実写ビリー
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $midoriDon.bonusScreenCountScreen6,
                    flashColor: .purple,
                    bigNumber: $midoriDon.bonusScreenCountSum
                )
            }
        }
        .onAppear {
            if ver301.midoriDonMenuScreenBadgeStatus != "none" {
                ver301.midoriDonMenuScreenBadgeStatus = "none"
            }
        }
        .navigationTitle("ボーナス終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// 画面選択解除
                    unitButtonToolbarScreenSelectReset(currentKeyword: self.$selectedImageName)
                        .popoverTip(tipUnitButtonScreenChoiceClear())
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $midoriDon.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: midoriDon.resetBonusScreen)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    midoriDonViewBonusScreen(
        ver301: Ver301(),
        midoriDon: MidoriDon()
    )
}
