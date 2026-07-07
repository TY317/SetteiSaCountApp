//
//  karakuri2ViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct karakuri2ViewScreen: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var karakuri2: Karakuri2
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
        "karakuri2Screen1",
        "karakuri2Screen2",
        "karakuri2Screen3",
        "karakuri2Screen4",
        "karakuri2Screen5",
        "karakuri2Screen6",
    ]
    let upperBeltTextList: [String] = [
        "しろがね",
        "歯車",
        "敵キャラ",
        "アンジェリーナ＆ルシール",
        "鳴海＆勝",
        "大好き",
    ]
    let lowerBeltTextList: [String] = [
        "???",
        "???",
        "???",
        "???",
        "???",
        "???",
    ]
    let sisaTextList: [String] = [
        "???(しろがね)",
        "???(歯車)",
        "???(敵キャラ)",
        "???(アンジェリーナ＆ルシール)",
        "???(鳴海＆勝)",
        "???(大好き)",
    ]
    let flashColorList: [Color] = [
        .gray,
        .blue,
        .brown,
        .yellow,
        .orange,
        .purple,
    ]
    let indexList: [Int] = [0,1,2,3,4,5]
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
                                            upperBeltFont: .subheadline,
                                            lowerBeltText: self.lowerBeltTextList[index],
                                        ),
                                        screenName: self.imageNameList[index],
                                        selectedScreen: self.$selectedImageName,
                                        count: bindingForScreenCount(index: index),
                                        minusCheck: $karakuri2.minusCheck,
                                        action: karakuri2.screenSumFunc,
                                    )
                                }
                            }
                        }
                    }
                    .frame(height: common.screenScrollHeight)
                }

                // //// カウント結果
                ForEach(self.indexList, id: \.self) { index in
//                    if self.lowerBeltTextList.indices.contains(index) &&
                    if self.sisaTextList.indices.contains(index) &&
                        self.flashColorList.indices.contains(index) {
                        unitResultCountListPercent(
//                            title: self.lowerBeltTextList[index],
                            title: self.sisaTextList[index],
                            count: bindingForScreenCount(index: index),
                            flashColor: self.flashColorList[index],
                            bigNumber: $karakuri2.screenCountSum,
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
        .resetBadgeOnAppear($common.karakuri2MenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: karakuri2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT終了画面")
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
                unitButtonMinusCheck(minusCheck: $karakuri2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: karakuri2.resetScreen)
            }
        }
    }
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $karakuri2.screenCount1
        case 1: return $karakuri2.screenCount2
        case 2: return $karakuri2.screenCount3
        case 3: return $karakuri2.screenCount4
        case 4: return $karakuri2.screenCount5
        case 5: return $karakuri2.screenCount6
        default: return .constant(0)
        }
    }
}

#Preview {
    karakuri2ViewScreen(
        karakuri2: Karakuri2(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
