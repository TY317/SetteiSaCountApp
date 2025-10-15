//
//  zeni5ViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/14.
//

import SwiftUI

struct zeni5ViewScreen: View {
    @ObservedObject var zeni5: Zeni5
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "zeni5Screen1",
        "zeni5Screen2",
        "zeni5Screen3",
        "zeni5Screen4",
        "zeni5Screen5",
        "zeni5Screen6",
        "zeni5Screen7",
    ]
    let upperBeltTextList: [String] = [
        "演説",
        "銭形 手錠",
        "銭形 十手",
        "吉スタンプ",
        "良スタンプ",
        "優スタンプ",
        "極スタンプ",
    ]
    let lowerBeltTextList: [String] = [
        "デフォルト",
        "？？？",
        "？？？",
        "設定3 以上濃厚",
        "設定4 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]
    let sisaText: [String] = [
        "デフォルト",
        "銭形 手錠",
        "銭形 十手",
        "設定3 以上濃厚",
        "設定4 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]
    let flashColorList: [Color] = [
        .gray,
        .yellow,
        .yellow,
        .green,
        .purple,
        .purple,
        .orange,
    ]
    let indexList: [Int] = [0,1,2,3,4,5,6]
    
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
                                    minusCheck: $zeni5.minusCheck,
                                    action: zeni5.screenSumFunc,
                                )
                            }
                        }
                    }
                }
                .frame(height: common.screenScrollHeight)
                
                // //// カウント結果
                ForEach(self.indexList, id: \.self) { index in
                    if self.lowerBeltTextList.indices.contains(index) &&
//                        self.flashColorList.indices.contains(index) {
                        self.flashColorList.indices.contains(index) &&
                        self.sisaText.indices.contains(index) {
                        unitResultCountListPercent(
//                            title: self.lowerBeltTextList[index],
                            title: self.sisaText[index],
                            count: bindingForScreenCount(index: index),
                            flashColor: self.flashColorList[index],
                            bigNumber: $zeni5.screenCountSum,
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
                screenName: zeni5.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("ボーナス終了画面")
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
                unitButtonMinusCheck(minusCheck: $zeni5.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: zeni5.resetScreen)
            }
        }
    }
    
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $zeni5.screenCountDefault
        case 1: return $zeni5.screenCountZeni1
        case 2: return $zeni5.screenCountZeni2
        case 3: return $zeni5.screenCountOver3
        case 4: return $zeni5.screenCountOver4
        case 5: return $zeni5.screenCountOver5
        case 6: return $zeni5.screenCountOver6
        default: return .constant(0)
        }
    }
}

#Preview {
    zeni5ViewScreen(
        zeni5: Zeni5(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
