//
//  gundamSeedViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/11.
//

import SwiftUI

struct gundamSeedViewScreen: View {
    @ObservedObject var gundamSeed: GundamSeed
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "gundamSeedScreen1",
        "gundamSeedScreen2",
        "gundamSeedScreen3",
        "gundamSeedScreen4",
        "gundamSeedScreen5",
        "gundamSeedScreen6",
        "gundamSeedScreen7",
        "gundamSeedScreen8",
        "gundamSeedScreen9",
        "gundamSeedScreen10",
        "gundamSeedScreen11",
        "gundamSeedScreen12",
        "gundamSeedScreen13",
        "gundamSeedScreen14",
    ]
    
    var body: some View {
        List {
            Section {
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // CZデフォルト
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[0]),
                                upperBeltText: "枠なし 背景",
                                lowerBeltText: "CZ デフォルト"
                            ),
                            screenName: self.imageNameList[0],
                            selectedScreen: self.$selectedImageName,
                            count: $gundamSeed.screenCountDefault,
                            minusCheck: $gundamSeed.minusCheck
                        )
                        .popoverTip(tipUnitButtonScreenChoice())
                        // ATデフォルト
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[1]),
                                upperBeltText: "枠なし ガンダム",
                                lowerBeltText: "AT デフォルト"
                            ),
                            screenName: self.imageNameList[1],
                            selectedScreen: self.$selectedImageName,
                            count: $gundamSeed.screenCountDefault,
                            minusCheck: $gundamSeed.minusCheck
                        )
                        // 復活濃厚
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[2]),
                                upperBeltText: "枠なし ラクス",
                                lowerBeltText: "CZ復活濃厚"
                            ),
                            screenName: self.imageNameList[2],
                            selectedScreen: self.$selectedImageName,
                            count: $gundamSeed.screenCountRebirth,
                            minusCheck: $gundamSeed.minusCheck
                        )
                        // 奇数示唆
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[3]),
                                upperBeltText: "白枠 ｱｰｸｴﾝｼﾞｪﾙｸﾙｰ",
                                lowerBeltText: "奇数示唆"
                            ),
                            screenName: self.imageNameList[3],
                            selectedScreen: self.$selectedImageName,
                            count: $gundamSeed.screenCountKisu,
                            minusCheck: $gundamSeed.minusCheck
                        )
                        // 偶数示唆
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[4]),
                                upperBeltText: "白枠 ｻﾞﾌﾄ赤服4人",
                                lowerBeltText: "偶数示唆"
                            ),
                            screenName: self.imageNameList[4],
                            selectedScreen: self.$selectedImageName,
                            count: $gundamSeed.screenCountGusu,
                            minusCheck: $gundamSeed.minusCheck
                        )
                        // 高設定示唆 弱
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[5]),
                                upperBeltText: "赤枠 ｽﾄﾗｲｸｶﾞﾝﾀﾞﾑ",
                                lowerBeltText: "高設定示唆 弱"
                            ),
                            screenName: self.imageNameList[5],
                            selectedScreen: self.$selectedImageName,
                            count: $gundamSeed.screenCountHighJaku,
                            minusCheck: $gundamSeed.minusCheck
                        )
                        // 高設定示唆 強
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[6]),
                                upperBeltText: "赤枠 ｱｽﾗﾝ&ｷﾗ",
                                lowerBeltText: "高設定示唆 強"
                            ),
                            screenName: self.imageNameList[6],
                            selectedScreen: self.$selectedImageName,
                            count: $gundamSeed.screenCountHighKyo,
                            minusCheck: $gundamSeed.minusCheck
                        )
                        // 設定変更濃厚＆高設定示唆
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[7]),
                                upperBeltText: "紫枠 ｱｽﾗﾝ&ｶｶﾞﾘ",
                                lowerBeltText: "設定変更濃厚＆高設定示唆",
                                lowerBeltFont: .subheadline
                            ),
                            screenName: self.imageNameList[7],
                            selectedScreen: self.$selectedImageName,
                            count: $gundamSeed.screenCountChangeHigh,
                            minusCheck: $gundamSeed.minusCheck
                        )
                        // 偶数濃厚
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[8]),
                                upperBeltText: "紫枠 ﾗｸｽ&ｷﾗ",
                                lowerBeltText: "偶数濃厚"
                            ),
                            screenName: self.imageNameList[8],
                            selectedScreen: self.$selectedImageName,
                            count: $gundamSeed.screenCountGusuFix,
                            minusCheck: $gundamSeed.minusCheck
                        )
                        // 1否定
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[9]),
                                upperBeltText: "紫枠 ｶｶﾞﾘ&ｷﾗ",
                                lowerBeltText: "設定1 否定"
                            ),
                            screenName: self.imageNameList[9],
                            selectedScreen: self.$selectedImageName,
                            count: $gundamSeed.screenCountNegate1,
                            minusCheck: $gundamSeed.minusCheck
                        )
                        // 2否定
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[10]),
                                upperBeltText: "紫枠 ﾏﾘｭｰ&ﾑｳ",
                                lowerBeltText: "設定2 否定"
                            ),
                            screenName: self.imageNameList[10],
                            selectedScreen: self.$selectedImageName,
                            count: $gundamSeed.screenCountNegate2,
                            minusCheck: $gundamSeed.minusCheck
                        )
                        // 3否定&高設定示唆
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[11]),
                                upperBeltText: "紫枠 ｸﾙｰｾﾞ&ﾑｳ",
                                lowerBeltText: "3否定＆高設定示唆"
                            ),
                            screenName: self.imageNameList[11],
                            selectedScreen: self.$selectedImageName,
                            count: $gundamSeed.screenCountNegate3High,
                            minusCheck: $gundamSeed.minusCheck
                        )
                        // 4以上
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[12]),
                                upperBeltText: "銀枠 ｷﾗ&ｱｽﾗﾝ",
                                lowerBeltText: "設定4 以上濃厚"
                            ),
                            screenName: self.imageNameList[12],
                            selectedScreen: self.$selectedImageName,
                            count: $gundamSeed.screenCountOver4,
                            minusCheck: $gundamSeed.minusCheck
                        )
                        // 6以上
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[13]),
                                upperBeltText: "金枠 ｶｯﾌﾟﾙ2組",
                                lowerBeltText: "設定6 濃厚"
                            ),
                            screenName: self.imageNameList[13],
                            selectedScreen: self.$selectedImageName,
                            count: $gundamSeed.screenCountOver6,
                            minusCheck: $gundamSeed.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $gundamSeed.screenCountDefault,
                    flashColor: .gray,
                    bigNumber: $gundamSeed.screenCountSum
                )
                // 復活濃厚
                unitResultCountListPercent(
                    title: "CZ復活濃厚",
                    count: $gundamSeed.screenCountRebirth,
                    flashColor: .gray,
                    bigNumber: $gundamSeed.screenCountSum
                )
                // 奇数示唆
                unitResultCountListPercent(
                    title: "奇数示唆",
                    count: $gundamSeed.screenCountKisu,
                    flashColor: .blue,
                    bigNumber: $gundamSeed.screenCountSum
                )
                // 偶数示唆
                unitResultCountListPercent(
                    title: "偶数示唆",
                    count: $gundamSeed.screenCountGusu,
                    flashColor: .yellow,
                    bigNumber: $gundamSeed.screenCountSum
                )
                // 高設定示唆 弱
                unitResultCountListPercent(
                    title: "高設定示唆 弱",
                    count: $gundamSeed.screenCountHighJaku,
                    flashColor: .red,
                    bigNumber: $gundamSeed.screenCountSum
                )
                // 高設定示唆 強
                unitResultCountListPercent(
                    title: "高設定示唆 強",
                    count: $gundamSeed.screenCountHighKyo,
                    flashColor: .red,
                    bigNumber: $gundamSeed.screenCountSum
                )
                // 設定変更濃厚＆高設定示唆
                unitResultCountListPercent(
                    title: "設定変更濃厚＆高設定示唆",
                    count: $gundamSeed.screenCountChangeHigh,
                    flashColor: .purple,
                    bigNumber: $gundamSeed.screenCountSum
                )
                // 偶数濃厚
                unitResultCountListPercent(
                    title: "偶数濃厚",
                    count: $gundamSeed.screenCountGusuFix,
                    flashColor: .purple,
                    bigNumber: $gundamSeed.screenCountSum
                )
                // 1否定
                unitResultCountListPercent(
                    title: "設定1 否定",
                    count: $gundamSeed.screenCountNegate1,
                    flashColor: .purple,
                    bigNumber: $gundamSeed.screenCountSum
                )
                // 2否定
                unitResultCountListPercent(
                    title: "設定2 否定",
                    count: $gundamSeed.screenCountNegate2,
                    flashColor: .purple,
                    bigNumber: $gundamSeed.screenCountSum
                )
                // 3否定&高設定示唆
                unitResultCountListPercent(
                    title: "3否定＆高設定示唆",
                    count: $gundamSeed.screenCountNegate3High,
                    flashColor: .purple,
                    bigNumber: $gundamSeed.screenCountSum
                )
                // 4以上
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $gundamSeed.screenCountOver4,
                    flashColor: .gray,
                    bigNumber: $gundamSeed.screenCountSum
                )
                // 6以上
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $gundamSeed.screenCountOver6,
                    flashColor: .orange,
                    bigNumber: $gundamSeed.screenCountSum
                )
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ガンダムSEED",
                screenClass: screenClass
            )
        }
        .navigationTitle("CZ,AT 終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// 画面選択解除
                    unitButtonToolbarScreenSelectReset(currentKeyword: self.$selectedImageName)
//                        .popoverTip(tipUnitButtonScreenChoiceClear())
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $gundamSeed.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: gundamSeed.resetScreen)
                }
            }
        }
    }
}

#Preview {
    gundamSeedViewScreen(
        gundamSeed: GundamSeed()
    )
}
