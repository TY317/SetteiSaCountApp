//
//  midoriDonViewBonusScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/04.
//

import SwiftUI

struct midoriDonViewBonusScreen: View {
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
                Text("参考）右の画面ほど強い示唆と予想")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // 画面1
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[0]),
                                upperBeltText: "画面1",
                                lowerBeltText: "デフォルト"
                            ),
                            screenName: self.imageNameList[0],
                            selectedScreen: self.$selectedImageName,
                            count: $midoriDon.bonusScreenCountScreen1,
                            minusCheck: $midoriDon.minusCheck
                        )
                        .popoverTip(tipUnitButtonScreenChoice())
                        // 画面2
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[1]),
                                upperBeltText: "画面2",
                                lowerBeltText: "???"
                            ),
                            screenName: self.imageNameList[1],
                            selectedScreen: self.$selectedImageName,
                            count: $midoriDon.bonusScreenCountScreen2,
                            minusCheck: $midoriDon.minusCheck
                        )
                        // 画面3
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[2]),
                                upperBeltText: "画面3",
                                lowerBeltText: "???"
                            ),
                            screenName: self.imageNameList[2],
                            selectedScreen: self.$selectedImageName,
                            count: $midoriDon.bonusScreenCountScreen3,
                            minusCheck: $midoriDon.minusCheck
                        )
                        // 画面4
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[3]),
                                upperBeltText: "画面4",
                                lowerBeltText: "???"
                            ),
                            screenName: self.imageNameList[3],
                            selectedScreen: self.$selectedImageName,
                            count: $midoriDon.bonusScreenCountScreen4,
                            minusCheck: $midoriDon.minusCheck
                        )
                        // 画面5
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[4]),
                                upperBeltText: "画面5",
                                lowerBeltText: "???"
                            ),
                            screenName: self.imageNameList[4],
                            selectedScreen: self.$selectedImageName,
                            count: $midoriDon.bonusScreenCountScreen5,
                            minusCheck: $midoriDon.minusCheck
                        )
                        // 画面6
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[5]),
                                upperBeltText: "画面6",
                                lowerBeltText: "???"
                            ),
                            screenName: self.imageNameList[5],
                            selectedScreen: self.$selectedImageName,
                            count: $midoriDon.bonusScreenCountScreen6,
                            minusCheck: $midoriDon.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $midoriDon.bonusScreenCountScreen1,
                    flashColor: .gray,
                    bigNumber: $midoriDon.bonusScreenCountSum
                )
                // 画面2
                unitResultCountListPercent(
                    title: "??? 画面2",
                    count: $midoriDon.bonusScreenCountScreen2,
                    flashColor: .blue,
                    bigNumber: $midoriDon.bonusScreenCountSum
                )
                // 画面3
                unitResultCountListPercent(
                    title: "??? 画面3",
                    count: $midoriDon.bonusScreenCountScreen3,
                    flashColor: .yellow,
                    bigNumber: $midoriDon.bonusScreenCountSum
                )
                // 画面4
                unitResultCountListPercent(
                    title: "??? 画面4",
                    count: $midoriDon.bonusScreenCountScreen4,
                    flashColor: .green,
                    bigNumber: $midoriDon.bonusScreenCountSum
                )
                // 画面5
                unitResultCountListPercent(
                    title: "??? 画面5",
                    count: $midoriDon.bonusScreenCountScreen5,
                    flashColor: .red,
                    bigNumber: $midoriDon.bonusScreenCountSum
                )
                // 画面6
                unitResultCountListPercent(
                    title: "??? 画面6",
                    count: $midoriDon.bonusScreenCountScreen6,
                    flashColor: .purple,
                    bigNumber: $midoriDon.bonusScreenCountSum
                )
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
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    midoriDonViewBonusScreen(
        midoriDon: MidoriDon()
    )
}
