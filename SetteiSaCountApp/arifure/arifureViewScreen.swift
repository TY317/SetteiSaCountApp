//
//  arifureViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/05.
//

import SwiftUI

struct arifureViewScreen: View {
    @ObservedObject var arifure = Arifure()
    @State var isShowAlert: Bool = false
    let imageNameList: [String] = [
        "arifureEndScreenDefault",
        "arifureEndScreenHigh",
        "arifureEndScreenOver4",
        "arifureEndScreenOver5",
        "arifureEndScreenOver6"
    ]
    @State var selectedImageName: String = ""
    
    var body: some View {
        List {
            // //// 画面選択ボタン
            ScrollView(.horizontal) {
                HStack(spacing: 20.0) {
                    // デフォルト
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[0]),
                        keyword: self.imageNameList[0],
                        currentKeyword: self.$selectedImageName,
                        count: $arifure.endScreenCountDefault,
                        minusCheck: $arifure.minusCheck
                    )
                    .popoverTip(tipUnitButtonScreenChoice())
                    // 高設定示唆
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[1]),
                        keyword: self.imageNameList[1],
                        currentKeyword: self.$selectedImageName,
                        count: $arifure.endScreenCountHigh,
                        minusCheck: $arifure.minusCheck
                    )
                    // 設定4 以上濃厚
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[2]),
                        keyword: self.imageNameList[2],
                        currentKeyword: self.$selectedImageName,
                        count: $arifure.endScreenCountOver4,
                        minusCheck: $arifure.minusCheck
                    )
                    // 設定5 以上濃厚
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[3]),
                        keyword: self.imageNameList[3],
                        currentKeyword: self.$selectedImageName,
                        count: $arifure.endScreenCountOver5,
                        minusCheck: $arifure.minusCheck
                    )
                    // 設定6 濃厚
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[4]),
                        keyword: self.imageNameList[4],
                        currentKeyword: self.$selectedImageName,
                        count: $arifure.endScreenCountOver6,
                        minusCheck: $arifure.minusCheck
                    )
                }
            }
            .frame(height: 120)
            
            // //// カウント結果
            // デフォルト
            unitResultCountListPercent(
                title: "デフォルト",
                count: $arifure.endScreenCountDefault,
                flashColor: .gray,
                bigNumber: $arifure.endScreenCountSum
            )
            // 高設定示唆
            unitResultCountListPercent(
                title: "高設定示唆",
                count: $arifure.endScreenCountHigh,
                flashColor: .blue,
                bigNumber: $arifure.endScreenCountSum
            )
            // 設定4 以上濃厚
            unitResultCountListPercent(
                title: "設定4 以上濃厚",
                count: $arifure.endScreenCountOver4,
                flashColor: .green,
                bigNumber: $arifure.endScreenCountSum
            )
            // 設定5 以上濃厚
            unitResultCountListPercent(
                title: "設定5 以上濃厚",
                count: $arifure.endScreenCountOver5,
                flashColor: .red,
                bigNumber: $arifure.endScreenCountSum
            )
            // 設定6 濃厚
            unitResultCountListPercent(
                title: "設定6 濃厚",
                count: $arifure.endScreenCountOver6,
                flashColor: .purple,
                bigNumber: $arifure.endScreenCountSum
            )
        }
        .navigationTitle("AT終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// 画面選択解除
                    unitButtonToolbarScreenSelectReset(currentKeyword: self.$selectedImageName)
                        .popoverTip(tipUnitButtonScreenChoiceClear())
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $arifure.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: arifure.resetScreen)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    arifureViewScreen()
}
