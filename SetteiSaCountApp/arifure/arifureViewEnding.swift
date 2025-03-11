//
//  arifureViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/06.
//

import SwiftUI

struct arifureViewEnding: View {
    @ObservedObject var arifure = Arifure()
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "arifureEndingScreenKisu",
        "arifureEndingScreenGusu",
        "arifureEndingScreenHighJaku",
        "arifureEndingScreenHighKyo",
        "arifureEndScreenOver4",
        "arifureEndScreenOver5",
        "arifureEndScreenOver6"
    ]
    
    var body: some View {
        List {
            // //// 画面選択ボタン
            ScrollView(.horizontal) {
                HStack(spacing: 20.0) {
                    // 奇数示唆
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[0]),
                        keyword: self.imageNameList[0],
                        currentKeyword: self.$selectedImageName,
                        count: $arifure.endingCountKisu,
                        minusCheck: $arifure.minusCheck
                    )
                    // 偶数示唆
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[1]),
                        keyword: self.imageNameList[1],
                        currentKeyword: self.$selectedImageName,
                        count: $arifure.endingCountGusu,
                        minusCheck: $arifure.minusCheck
                    )
                    // 高設定示唆 弱
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[2]),
                        keyword: self.imageNameList[2],
                        currentKeyword: self.$selectedImageName,
                        count: $arifure.endingCountHighJaku,
                        minusCheck: $arifure.minusCheck
                    )
                    // 高設定示唆 強
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[3]),
                        keyword: self.imageNameList[3],
                        currentKeyword: self.$selectedImageName,
                        count: $arifure.endingCountHighKyo,
                        minusCheck: $arifure.minusCheck
                    )
                    // 設定4 以上示唆
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[4]),
                        keyword: self.imageNameList[4],
                        currentKeyword: self.$selectedImageName,
                        count: $arifure.endingCountOver4,
                        minusCheck: $arifure.minusCheck
                    )
                    // 設定5 以上示唆
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[5]),
                        keyword: self.imageNameList[5],
                        currentKeyword: self.$selectedImageName,
                        count: $arifure.endingCountOver5,
                        minusCheck: $arifure.minusCheck
                    )
                    // 設定6 示唆
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[6]),
                        keyword: self.imageNameList[6],
                        currentKeyword: self.$selectedImageName,
                        count: $arifure.endingCountOver6,
                        minusCheck: $arifure.minusCheck
                    )
                }
            }
            .frame(height: 120)
            
            // //// カウント結果
            // 奇数示唆
            unitResultCountListPercent(
                title: "奇数示唆",
                count: $arifure.endingCountKisu,
                flashColor: .blue,
                bigNumber: $arifure.endingCountSum
            )
            // 偶数示唆
            unitResultCountListPercent(
                title: "偶数示唆",
                count: $arifure.endingCountGusu,
                flashColor: .yellow,
                bigNumber: $arifure.endingCountSum
            )
            // 高設定示唆 弱
            unitResultCountListPercent(
                title: "高設定示唆 弱",
                count: $arifure.endingCountHighJaku,
                flashColor: .green,
                bigNumber: $arifure.endingCountSum
            )
            // 高設定示唆 強
            unitResultCountListPercent(
                title: "高設定示唆 強",
                count: $arifure.endingCountHighKyo,
                flashColor: .red,
                bigNumber: $arifure.endingCountSum
            )
            // 設定4 以上濃厚
            unitResultCountListPercent(
                title: "設定4 以上濃厚",
                count: $arifure.endingCountOver4,
                flashColor: .purple,
                bigNumber: $arifure.endingCountSum
            )
            // 設定5 以上濃厚
            unitResultCountListPercent(
                title: "設定5 以上濃厚",
                count: $arifure.endingCountOver5,
                flashColor: .brown,
                bigNumber: $arifure.endingCountSum
            )
            // 設定6 濃厚
            unitResultCountListPercent(
                title: "設定6 濃厚",
                count: $arifure.endingCountOver6,
                flashColor: .brown,
                bigNumber: $arifure.endingCountSum
            )
        }
        .navigationTitle("エンディング")
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
                    unitButtonReset(isShowAlert: $isShowAlert, action: arifure.resetEnding)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    arifureViewEnding()
}
