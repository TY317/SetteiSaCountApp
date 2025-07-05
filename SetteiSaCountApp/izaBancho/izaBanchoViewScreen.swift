//
//  izaBanchoViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/31.
//

import SwiftUI

struct izaBanchoViewScreen: View {
    @ObservedObject var ver350: Ver350
    @ObservedObject var izaBancho: IzaBancho
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "izaBanchoScreen1",
        "izaBanchoScreen2",
        "izaBanchoScreen3",
        "izaBanchoScreen4",
        "izaBanchoScreen5",
        "izaBanchoScreen6",
        "izaBanchoScreen7",
        "izaBanchoScreen8"
    ]
    
    var body: some View {
        List {
            Section {
//                VStack {
//                    Text("・右にいくほど強い示唆と予想")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Text("・小太郎 大泣きは試打動画では結構な頻度で出現。番長4のハンバーグのような示唆と予想")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                }
//                .foregroundStyle(Color.secondary)
//                .font(.caption)
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // デフォルト
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[0]),
                                upperBeltText: "夕焼け",
                                lowerBeltText: "デフォルト"
                            ),
                            screenName: self.imageNameList[0],
                            selectedScreen: self.$selectedImageName,
                            count: $izaBancho.screenCountDefault,
                            minusCheck: $izaBancho.minusCheck
                        )
//                        .popoverTip(tipUnitButtonScreenChoice())
                        // 小太郎大泣き
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[1]),
                                upperBeltText: "小太郎 大泣き",
                                lowerBeltText: "偶数示唆"
                            ),
                            screenName: self.imageNameList[1],
                            selectedScreen: self.$selectedImageName,
                            count: $izaBancho.screenCountScreen2,
                            minusCheck: $izaBancho.minusCheck
                        )
                        // 護摩業
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[2]),
                                upperBeltText: "護摩行",
                                lowerBeltText: "高設定示唆"
                            ),
                            screenName: self.imageNameList[2],
                            selectedScreen: self.$selectedImageName,
                            count: $izaBancho.screenCountScreen3,
                            minusCheck: $izaBancho.minusCheck
                        )
                        // 刺客集合
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[3]),
                                upperBeltText: "刺客集合",
                                lowerBeltText: "設定2 以上濃厚"
                            ),
                            screenName: self.imageNameList[3],
                            selectedScreen: self.$selectedImageName,
                            count: $izaBancho.screenCountScreen4,
                            minusCheck: $izaBancho.minusCheck
                        )
                        // 小太郎
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[4]),
                                upperBeltText: "小太郎",
                                lowerBeltText: "設定4 以上濃厚"
                            ),
                            screenName: self.imageNameList[4],
                            selectedScreen: self.$selectedImageName,
                            count: $izaBancho.screenCountScreen5,
                            minusCheck: $izaBancho.minusCheck
                        )
                        // 青龍
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[5]),
                                upperBeltText: "青龍",
                                lowerBeltText: "設定3,4,6 濃厚"
                            ),
                            screenName: self.imageNameList[5],
                            selectedScreen: self.$selectedImageName,
                            count: $izaBancho.screenCountScreen6,
                            minusCheck: $izaBancho.minusCheck
                        )
                        // 朱雀
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[6]),
                                upperBeltText: "朱雀",
                                lowerBeltText: "設定 2,5,6 濃厚"
                            ),
                            screenName: self.imageNameList[6],
                            selectedScreen: self.$selectedImageName,
                            count: $izaBancho.screenCountScreen7,
                            minusCheck: $izaBancho.minusCheck
                        )
                        // 露天風呂
                        unitButtonScreenChoiceVer2(
                            screen: unitScreenOnlyDisplay(
                                image: Image(self.imageNameList[7]),
                                upperBeltText: "露天風呂",
                                lowerBeltText: "設定6 濃厚"
                            ),
                            screenName: self.imageNameList[7],
                            selectedScreen: self.$selectedImageName,
                            count: $izaBancho.screenCountScreen8,
                            minusCheck: $izaBancho.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                .popoverTip(tipVer350IzaBanchoScreen())
                
                // //// カウント結果
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $izaBancho.screenCountDefault,
                    flashColor: .gray,
                    bigNumber: $izaBancho.screenCountSum
                )
                // 小太郎大泣き
                unitResultCountListPercent(
                    title: "偶数示唆",
                    count: $izaBancho.screenCountScreen2,
                    flashColor: .yellow,
                    bigNumber: $izaBancho.screenCountSum
                )
                // 護摩業
                unitResultCountListPercent(
                    title: "高設定示唆",
                    count: $izaBancho.screenCountScreen3,
                    flashColor: .blue,
                    bigNumber: $izaBancho.screenCountSum
                )
                // 刺客集合
                unitResultCountListPercent(
                    title: "設定2 以上濃厚\n出現率：2<3<4以上",
                    count: $izaBancho.screenCountScreen4,
                    flashColor: .green,
                    bigNumber: $izaBancho.screenCountSum
                )
                // 小太郎
                unitResultCountListPercent(
                    title: "設定4 以上濃厚\n出現率：4=5=6",
                    count: $izaBancho.screenCountScreen5,
                    flashColor: .red,
                    bigNumber: $izaBancho.screenCountSum
                )
                // 青龍
                unitResultCountListPercent(
                    title: "設定3,4,6 濃厚\n出現率：3<4,6",
                    count: $izaBancho.screenCountScreen6,
                    flashColor: .purple,
                    bigNumber: $izaBancho.screenCountSum
                )
                // 朱雀
                unitResultCountListPercent(
                    title: "設定2,5,6 濃厚\n出現率：2<6<5",
                    count: $izaBancho.screenCountScreen7,
                    flashColor: .gray,
                    bigNumber: $izaBancho.screenCountSum
                )
                // 露天風呂
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $izaBancho.screenCountScreen8,
                    flashColor: .orange,
                    bigNumber: $izaBancho.screenCountSum
                )
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver350.izaBanchoMenuScreenBadgeStaus)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: izaBancho.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// 画面選択解除
                    unitButtonToolbarScreenSelectReset(currentKeyword: self.$selectedImageName)
//                        .popoverTip(tipUnitButtonScreenChoiceClear())
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $izaBancho.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: izaBancho.resetScreen)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    izaBanchoViewScreen(
        ver350: Ver350(),
        izaBancho: IzaBancho()
    )
}
