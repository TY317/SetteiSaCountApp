//
//  bioViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/12.
//

import SwiftUI

struct bioViewScreen: View {
    @ObservedObject var bio = Bio()
    @State var isShowAlert: Bool = false
    let imageNameList: [String] = [
        "bioScreenDefault",
        "bioScreenKisu",
        "bioScreenGusu",
        "bioScreenExcepted1",
        "bioScreenExcepted2",
        "bioScreenExcepted3",
        "bioScreenHighJaku",
        "bioScreenHighKyo",
        "bioScreenOver3",
        "bioScreenOver4",
        "bioScreenOver5",
        "bioScreenOver6"
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
                        count: $bio.screenCountDefault,
                        minusCheck: $bio.minusCheck
                    )
                    .popoverTip(tipUnitButtonScreenChoice())
                    // 奇数示唆
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[1]),
                        keyword: self.imageNameList[1],
                        currentKeyword: self.$selectedImageName,
                        count: $bio.screenCountKisu,
                        minusCheck: $bio.minusCheck
                    )
                    // 偶数示唆
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[2]),
                        keyword: self.imageNameList[2],
                        currentKeyword: self.$selectedImageName,
                        count: $bio.screenCountGusu,
                        minusCheck: $bio.minusCheck
                    )
                    // １否定
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[3]),
                        keyword: self.imageNameList[3],
                        currentKeyword: self.$selectedImageName,
                        count: $bio.screenCountExcepted1,
                        minusCheck: $bio.minusCheck
                    )
                    // 2否定
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[4]),
                        keyword: self.imageNameList[4],
                        currentKeyword: self.$selectedImageName,
                        count: $bio.screenCountExcepted2,
                        minusCheck: $bio.minusCheck
                    )
                    // 3否定
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[5]),
                        keyword: self.imageNameList[5],
                        currentKeyword: self.$selectedImageName,
                        count: $bio.screenCountExcepted3,
                        minusCheck: $bio.minusCheck
                    )
                    // 高設定示唆 弱
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[6]),
                        keyword: self.imageNameList[6],
                        currentKeyword: self.$selectedImageName,
                        count: $bio.screenCountHighJaku,
                        minusCheck: $bio.minusCheck
                    )
                    // 高設定示唆 強
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[7]),
                        keyword: self.imageNameList[7],
                        currentKeyword: self.$selectedImageName,
                        count: $bio.screenCountHighKyo,
                        minusCheck: $bio.minusCheck
                    )
                    // 3以上
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[8]),
                        keyword: self.imageNameList[8],
                        currentKeyword: self.$selectedImageName,
                        count: $bio.screenCountOver3,
                        minusCheck: $bio.minusCheck
                    )
                    // 4以上
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[9]),
                        keyword: self.imageNameList[9],
                        currentKeyword: self.$selectedImageName,
                        count: $bio.screenCountOver4,
                        minusCheck: $bio.minusCheck
                    )
                    // 5以上
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[10]),
                        keyword: self.imageNameList[10],
                        currentKeyword: self.$selectedImageName,
                        count: $bio.screenCountOver5,
                        minusCheck: $bio.minusCheck
                    )
                    // 6以上
                    unitButtonScreenChoice(
                        image: Image(self.imageNameList[11]),
                        keyword: self.imageNameList[11],
                        currentKeyword: self.$selectedImageName,
                        count: $bio.screenCountOver6,
                        minusCheck: $bio.minusCheck
                    )
                }
            }
            .frame(height: 120)
            
            // //// カウント結果
            // デフォルト
            unitResultCountListPercent(
                title: "デフォルト",
                count: $bio.screenCountDefault,
                flashColor: .gray,
                bigNumber: $bio.screenCountSum
            )
            // 奇数示唆
            unitResultCountListPercent(
                title: "奇数示唆",
                count: $bio.screenCountKisu,
                flashColor: .blue,
                bigNumber: $bio.screenCountSum
            )
            // 偶数示唆
            unitResultCountListPercent(
                title: "偶数示唆",
                count: $bio.screenCountGusu,
                flashColor: .yellow,
                bigNumber: $bio.screenCountSum
            )
            // １否定
            unitResultCountListPercent(
                title: "設定1 否定",
                count: $bio.screenCountExcepted1,
                flashColor: .brown,
                bigNumber: $bio.screenCountSum
            )
            // 2否定
            unitResultCountListPercent(
                title: "設定2 否定",
                count: $bio.screenCountExcepted2,
                flashColor: .cyan,
                bigNumber: $bio.screenCountSum
            )
            // 3否定
            unitResultCountListPercent(
                title: "設定3 否定",
                count: $bio.screenCountExcepted3,
                flashColor: .indigo,
                bigNumber: $bio.screenCountSum
            )
            // 高設定示唆 弱
            unitResultCountListPercent(
                title: "高設定示唆 弱",
                count: $bio.screenCountHighJaku,
                flashColor: .green,
                bigNumber: $bio.screenCountSum
            )
            // 高設定示唆 強
            unitResultCountListPercent(
                title: "高設定示唆 強",
                count: $bio.screenCountHighKyo,
                flashColor: .red,
                bigNumber: $bio.screenCountSum
            )
            // 3以上
            unitResultCountListPercent(
                title: "設定3 以上濃厚",
                count: $bio.screenCountOver3,
                flashColor: .gray,
                bigNumber: $bio.screenCountSum
            )
            // 4以上
            unitResultCountListPercent(
                title: "設定4 以上濃厚",
                count: $bio.screenCountOver4,
                flashColor: .orange,
                bigNumber: $bio.screenCountSum
            )
            // 5以上
            unitResultCountListPercent(
                title: "設定5 以上濃厚",
                count: $bio.screenCountOver5,
                flashColor: .pink,
                bigNumber: $bio.screenCountSum
            )
            // 6以上
            unitResultCountListPercent(
                title: "設定6 濃厚",
                count: $bio.screenCountOver6,
                flashColor: .purple,
                bigNumber: $bio.screenCountSum
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
                    unitButtonMinusCheck(minusCheck: $bio.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: bio.resetScreen)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    bioViewScreen()
}
