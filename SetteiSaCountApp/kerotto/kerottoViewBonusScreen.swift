//
//  kerottoViewBonusScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct kerottoViewBonusScreen: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var kerotto: Kerotto
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
        "kerottoBonusScreen1",
        "kerottoBonusScreen2",
        "kerottoBonusScreen3",
    ]
    let upperBeltTextList: [String] = [
        "人差し指",
        "ピース",
        "ハート",
    ]
    let lowerBeltTextList: [String] = [
        "奇数示唆",
        "偶数示唆",
        "高設定示唆",
    ]
    let flashColorList: [Color] = [
        .blue,
        .yellow,
        .green,
    ]
    let indexList: [Int] = [0, 1, 2]

    var body: some View {
        List {
            // 画面カウント
            Section {
                // コメント
                Text("虹河ラキモードかつBIG以上の確定画面で設定示唆")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                
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
                                        minusCheck: $kerotto.minusCheck,
                                        action: kerotto.bonusScreenSumFunc,
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
                            bigNumber: $kerotto.bonusScreenCountSum,
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
        .resetBadgeOnAppear($common.kerottoMenuBonusScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kerotto.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("ボーナス確定画面")
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
                unitButtonMinusCheck(minusCheck: $kerotto.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: kerotto.resetBonusScreen)
            }
        }
    }
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $kerotto.bonusScreenCount1
        case 1: return $kerotto.bonusScreenCount2
        case 2: return $kerotto.bonusScreenCount3
        default: return .constant(0)
        }
    }
}

#Preview {
    kerottoViewBonusScreen(
        kerotto: Kerotto(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
