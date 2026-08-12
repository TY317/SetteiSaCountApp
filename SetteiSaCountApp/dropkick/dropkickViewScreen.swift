//
//  dropkickViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct dropkickViewScreen: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var dropkick: Dropkick
    @State var isShowDestination: Bool = false
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3

    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "dropkickScreen1",
        "dropkickScreen2",
        "dropkickScreen3",
        "dropkickScreen4",
        "dropkickScreen5",
        "dropkickScreen6",
        "dropkickScreen7",
        "dropkickScreen8",
        "dropkickScreen9",
        "dropkickScreen10",
        "dropkickScreen11",
    ]
    let upperBeltTextList: [String] = [
        "邪神ちゃん",
        "ミノス",
        "メデューサ",
        "ぺこら",
        "ぽぽろん",
        "ゆりねA",
        "ゆりねB",
        "悪だくみ",
        "水着",
        "パジャマ",
        "全員集合",
    ]
    let lowerBeltTextList: [String] = [
        "デフォルト",
        "奇数示唆 弱",
        "奇数示唆 強",
        "偶数示唆 弱",
        "偶数示唆 強",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]
    let flashColorList: [Color] = [
        .gray,
        .blue,
        .blue,
        .yellow,
        .yellow,
        .green,
        .red,
        .brown,
        .orange,
        .orange,
        .purple,
    ]
    let indexList: [Int] = [0,1,2,3,4,5,6,7,8,9,10]
    var body: some View {
        List {
            // 画面カウント
            Section {
                VStack {
                    // カウントボタン
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
                                        ),
                                        screenName: self.imageNameList[index],
                                        selectedScreen: self.$selectedImageName,
                                        count: bindingForScreenCount(index: index),
                                        minusCheck: $dropkick.minusCheck,
                                        action: dropkick.screenSumFunc,
                                    )
                                }
                            }
                        }
                    }
                    .frame(height: common.screenScrollHeight)
                }

                // //// カウント結果
                ForEach(self.indexList, id: \.self) { index in
                    if self.lowerBeltTextList.indices.contains(index) &&
                        self.flashColorList.indices.contains(index) {
                        unitResultCountListPercent(
                            title: self.lowerBeltTextList[index],
                            count: bindingForScreenCount(index: index),
                            flashColor: self.flashColorList[index],
                            bigNumber: $dropkick.screenCountSum,
                            numberofDigit: 0,
                            titleFont: .body,
                        )
                    }
                }
            } header: {
                unitLabelHeaderScreenCount()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.dropkickMenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: dropkick.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("終了画面")
        .navigationBarTitleDisplayMode(.inline)
        // //// 画面の向き情報の取得部分
        .applyOrientationHandling(
            orientation: self.$orientation,
            lastOrientation: self.$lastOrientation,
            scrollViewHeight: self.$scrollViewHeight,
            spaceHeight: self.$spaceHeight,
            lazyVGridCount: self.$lazyVGridCount,
            scrollViewHeightPortrait: self.scrollViewHeightPortrait,
            scrollViewHeightLandscape: self.scrollViewHeightLandscape,
            spaceHeightPortrait: self.spaceHeightPortrait,
            spaceHeightLandscape: self.spaceHeightLandscape,
            lazyVGridCountPortrait: self.lazyVGridCountPortrait,
            lazyVGridCountLandscape: self.lazyVGridCountLandscape
        )
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// 画面選択解除
                unitButtonToolbarScreenSelectReset(
                    currentKeyword: self.$selectedImageName
                )
            }
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $dropkick.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: dropkick.resetScreen)
            }
        }
    }
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $dropkick.screenCount1
        case 1: return $dropkick.screenCount2
        case 2: return $dropkick.screenCount3
        case 3: return $dropkick.screenCount4
        case 4: return $dropkick.screenCount5
        case 5: return $dropkick.screenCount6
        case 6: return $dropkick.screenCount7
        case 7: return $dropkick.screenCount8
        case 8: return $dropkick.screenCount9
        case 9: return $dropkick.screenCount10
        case 10: return $dropkick.screenCount11
        default: return .constant(0)
        }
    }
}

#Preview {
    dropkickViewScreen(
        dropkick: Dropkick(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
