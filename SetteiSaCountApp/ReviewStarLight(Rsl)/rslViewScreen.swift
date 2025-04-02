//
//  rslViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/26.
//

import SwiftUI

struct rslViewScreen: View {
    @ObservedObject var rsl = Rsl()
    @State var isShowAlert: Bool = false
    let imageNameList: [String] = [
        "rslScreenDefault",
        "rslScreenHighJaku",
        "rslScreenHighKyo",
        "rslScreenOver2",
        "rslScreenOver4",
        "rslScreenOver5",
        "rslScreenOver6"
    ]
    @State var selectedImageName: String = ""
    
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
                            count: $rsl.screenCountDefault,
                            minusCheck: $rsl.minusCheck
                        )
                        .popoverTip(tipUnitButtonScreenChoice())
                        // 高設定示唆　弱
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[1]),
                            keyword: self.imageNameList[1],
                            currentKeyword: self.$selectedImageName,
                            count: $rsl.screenCountHighJaku,
                            minusCheck: $rsl.minusCheck
                        )
                        // 高設定示唆　弱
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[2]),
                            keyword: self.imageNameList[2],
                            currentKeyword: self.$selectedImageName,
                            count: $rsl.screenCountHighKyo,
                            minusCheck: $rsl.minusCheck
                        )
                        // 設定2 以上濃厚
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[3]),
                            keyword: self.imageNameList[3],
                            currentKeyword: self.$selectedImageName,
                            count: $rsl.screenCountOver2,
                            minusCheck: $rsl.minusCheck
                        )
                        // 設定4 以上濃厚
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[4]),
                            keyword: self.imageNameList[4],
                            currentKeyword: self.$selectedImageName,
                            count: $rsl.screenCountOver4,
                            minusCheck: $rsl.minusCheck
                        )
                        // 設定5 以上濃厚
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[5]),
                            keyword: self.imageNameList[5],
                            currentKeyword: self.$selectedImageName,
                            count: $rsl.screenCountOver5,
                            minusCheck: $rsl.minusCheck
                        )
                        // 設定6 以上濃厚
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[6]),
                            keyword: self.imageNameList[6],
                            currentKeyword: self.$selectedImageName,
                            count: $rsl.screenCountOver6,
                            minusCheck: $rsl.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $rsl.screenCountDefault,
                    flashColor: .gray,
                    bigNumber: $rsl.screenCountSum
                )
                // 高設定示唆 弱
                unitResultCountListPercent(
                    title: "高設定示唆 弱",
                    count: $rsl.screenCountHighJaku,
                    flashColor: .blue,
                    bigNumber: $rsl.screenCountSum
                )
                // 高設定示唆 強
                unitResultCountListPercent(
                    title: "高設定示唆 強",
                    count: $rsl.screenCountHighKyo,
                    flashColor: .yellow,
                    bigNumber: $rsl.screenCountSum
                )
                // 設定2 以上濃厚
                unitResultCountListPercent(
                    title: "設定2 以上濃厚",
                    count: $rsl.screenCountOver2,
                    flashColor: .cyan,
                    bigNumber: $rsl.screenCountSum
                )
                // 設定4 以上濃厚
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $rsl.screenCountOver4,
                    flashColor: .green,
                    bigNumber: $rsl.screenCountSum
                )
                // 設定5 以上濃厚
                unitResultCountListPercent(
                    title: "設定5 以上濃厚",
                    count: $rsl.screenCountOver5,
                    flashColor: .red,
                    bigNumber: $rsl.screenCountSum
                )
                // 設定6 濃厚
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $rsl.screenCountOver6,
                    flashColor: .purple,
                    bigNumber: $rsl.screenCountSum
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
                    unitButtonMinusCheck(minusCheck: $rsl.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: rsl.resetScreen)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    rslViewScreen()
}
