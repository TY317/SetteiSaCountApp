//
//  railgunViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/08.
//

import SwiftUI

struct railgunViewScreen: View {
    @ObservedObject var railgun: Railgun
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "railgunScreen1",
        "railgunScreen2",
        "railgunScreen3",
        "railgunScreen4",
        "railgunScreen5",
        "railgunScreen6",
        "railgunScreen7",
        "railgunScreen8",
        "railgunScreen9",
    ]
    let upperBeltTextList: [String] = [
        "枠なし 友達A",
        "枠なし 友達B",
        "枠なし ライバル",
        "枠なし チア",
        "赤枠 露天風呂",
        "赤枠 水着",
        "紫枠 寝起き",
        "金枠 アイドル",
        "虹枠 ウェディング",
    ]
    let lowerBeltTextList: [String] = [
        "デフォルト",
        "偶数示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定2 以上濃厚",
        "設定3 以上濃厚",
        "設定4 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]
    let flashColorList: [Color] = [
        .gray,
        .yellow,
        .blue,
        .green,
        .red,
        .red,
        .purple,
        .orange,
        .purple,
    ]
    let indexList: [Int] = [0,1,2,3,4,5,6,7,8]
    var body: some View {
        List {
            Section {
                // //// 画面カウントボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(self.indexList, id: \.self) { index in
                            if self.imageNameList.indices.contains(index) &&
                                self.upperBeltTextList.indices.contains(index) &&
                                self.lowerBeltTextList.indices.contains(index) {
                                unitButtonScreenChoiceVer3(
                                    screen: unitScreenOnlyDisplay(
                                        image: Image(self.imageNameList[index]),
                                        upperBeltText: self.upperBeltTextList[index],
                                        lowerBeltText: self.lowerBeltTextList[index],
//                                        lowerBeltFont: .body,
//                                        lowerBeltHeight: 35,
                                    ),
                                    screenName: self.imageNameList[index],
                                    selectedScreen: self.$selectedImageName,
                                    count: bindingForScreenCount(index: index),
                                    minusCheck: $railgun.minusCheck,
                                    action: railgun.screenSumFunc,
                                )
                            }
                        }
                    }
                }
                .frame(height: common.screenScrollHeight)
                
                // //// カウント結果
                ForEach(self.indexList, id: \.self) { index in
                    if self.lowerBeltTextList.indices.contains(index) &&
                        self.flashColorList.indices.contains(index) {
//                        self.flashColorList.indices.contains(index) &&
//                        self.sisaText.indices.contains(index) {
                        unitResultCountListPercent(
                            title: self.lowerBeltTextList[index],
//                            title: self.sisaText[index],
                            count: bindingForScreenCount(index: index),
                            flashColor: self.flashColorList[index],
                            bigNumber: $railgun.screenCountSum,
                            numberofDigit: 0,
                            titleFont: .body,
                        )
                    }
                }
            } header: {
                unitLabelHeaderScreenCount()
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: railgun.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// 画面選択解除
                unitButtonToolbarScreenSelectReset(
                    currentKeyword: self.$selectedImageName
                )
            }
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $railgun.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: railgun.resetScreen)
            }
        }
    }
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $railgun.screenCountDefault
        case 1: return $railgun.screenCountGusu
        case 2: return $railgun.screenCountHighJaku
        case 3: return $railgun.screenCountHighKyo
        case 4: return $railgun.screenCountOver2
        case 5: return $railgun.screenCountOver3
        case 6: return $railgun.screenCountOver4
        case 7: return $railgun.screenCountOver5
        case 8: return $railgun.screenCountOver6
        default: return .constant(0)
        }
    }
}

#Preview {
    railgunViewScreen(
        railgun: Railgun(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
