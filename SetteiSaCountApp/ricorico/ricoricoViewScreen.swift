//
//  ricoricoViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ricoricoViewScreen: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var ricorico: Ricorico
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
        "ricoricoScreen1",
        "ricoricoScreen2",
        "ricoricoScreen3",
        "ricoricoScreen4",
        "ricoricoScreen5",
        "ricoricoScreen6",
        "ricoricoScreen7",
        "ricoricoScreen8",
    ]
    let upperBeltTextList: [String] = [
        "たきな制服",
        "千束 制服",
        "たきな私服",
        "千束 私服",
        "千束＆たきな",
        "風景",
        "ロボ太",
        "全員集合",
    ]
    let lowerBeltTextList: [String] = [
        "デフォルト",
        "デフォルト",
        "???",
        "???",
        "???",
        "???",
        "???",
        "???",
    ]
    let flashColorList: [Color] = [
        .gray,
        .gray,
        .blue,
        .yellow,
        .green,
        .red,
        .orange,
        .purple,
    ]
    let indexList: [Int] = [0,1,2,3,4,5,6,7]
    // 結果表示用（たきな制服・千束 制服は同じカウント＝デフォルト なので7行）
    let resultIndexList: [Int] = [0,1,2,3,4,5,6]
    let resultTitleList: [String] = [
        "デフォルト",
        "???(たきな私服)",
        "???(千束 私服)",
        "???(千束＆たきな)",
        "???(風景)",
        "???(ロボ太)",
        "???(全員集合)",
    ]
    let resultColorList: [Color] = [
        .gray,
        .blue,
        .yellow,
        .green,
        .red,
        .orange,
        .purple,
    ]
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
                                        minusCheck: $ricorico.minusCheck,
                                        action: ricorico.screenSumFunc,
                                    )
                                }
                            }
                        }
                    }
                    .frame(height: common.screenScrollHeight)
                }

                // //// カウント結果
                ForEach(self.resultIndexList, id: \.self) { index in
                    if self.resultTitleList.indices.contains(index) &&
                        self.resultColorList.indices.contains(index) {
                        unitResultCountListPercent(
                            title: self.resultTitleList[index],
                            count: bindingForResultCount(index: index),
                            flashColor: self.resultColorList[index],
                            bigNumber: $ricorico.screenCountSum,
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
        .resetBadgeOnAppear($common.ricoricoMenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ricorico.machineName,
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
                unitButtonMinusCheck(minusCheck: $ricorico.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: ricorico.resetScreen)
            }
        }
    }
    // 画像8枚 → カウント7本のマッピング
    // （たきな制服・千束 制服はどちらも screenCount1＝デフォルト）
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $ricorico.screenCount1
        case 1: return $ricorico.screenCount1
        case 2: return $ricorico.screenCount2
        case 3: return $ricorico.screenCount3
        case 4: return $ricorico.screenCount4
        case 5: return $ricorico.screenCount5
        case 6: return $ricorico.screenCount6
        case 7: return $ricorico.screenCount7
        default: return .constant(0)
        }
    }

    func bindingForResultCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $ricorico.screenCount1
        case 1: return $ricorico.screenCount2
        case 2: return $ricorico.screenCount3
        case 3: return $ricorico.screenCount4
        case 4: return $ricorico.screenCount5
        case 5: return $ricorico.screenCount6
        case 6: return $ricorico.screenCount7
        default: return .constant(0)
        }
    }
}

#Preview {
    ricoricoViewScreen(
        ricorico: Ricorico(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
