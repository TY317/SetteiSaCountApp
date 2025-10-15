//
//  newOni3ViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/11.
//

import SwiftUI

struct newOni3ViewScreen: View {
    @ObservedObject var newOni3: NewOni3
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "newOni3Screen1",
        "newOni3Screen2",
        "newOni3Screen3",
        "newOni3Screen4",
        "newOni3Screen5",
        "newOni3Screen6",
        "newOni3Screen7",
        "newOni3Screen8",
        "newOni3Screen9",
    ]
    let upperBeltTextList: [String] = [
        "人物なし",
        "男性 3人",
        "女性 2人",
        "阿倫＆みの吉",
        "蒼鬼＆茜",
        "戦闘シーン",
        "敵キャラ集合",
        "覚醒鬼武者",
        "デフォルメ(金)",
    ]
    let lowerBeltTextList: [String] = [
        "デフォルト",
        "奇数示唆",
        "偶数示唆",
        "高設定示唆",
        "設定2 以上濃厚",
        "設定3 以上濃厚",
        "設定4 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]
    let flashColorList: [Color] = [
        .gray,
        .blue,
        .yellow,
        .green,
        .cyan,
        .gray,
        .red,
        .purple,
        .orange,
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
                                    minusCheck: $newOni3.minusCheck,
                                    action: newOni3.screenSumFunc,
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
//                        self.sisaText.indices.contains(index) {
                        unitResultCountListPercent(
                            title: self.lowerBeltTextList[index],
//                            title: self.sisaText[index],
                            count: bindingForScreenCount(index: index),
                            flashColor: self.flashColorList[index],
                            bigNumber: $newOni3.screenCountSum,
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
                screenName: newOni3.machineName,
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
                unitButtonMinusCheck(minusCheck: $newOni3.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: newOni3.resetScreen)
            }
        }
    }
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $newOni3.screenCountDefault
        case 1: return $newOni3.screenCountKisu
        case 2: return $newOni3.screenCountGusu
        case 3: return $newOni3.screenCountHigh
        case 4: return $newOni3.screenCountOver2
        case 5: return $newOni3.screenCountOver3
        case 6: return $newOni3.screenCountOver4
        case 7: return $newOni3.screenCountOver5
        case 8: return $newOni3.screenCountOver6
        default: return .constant(0)
        }
    }
}

#Preview {
    newOni3ViewScreen(
        newOni3: NewOni3(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
