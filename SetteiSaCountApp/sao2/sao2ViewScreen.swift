//
//  sao2ViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/07.
//

import SwiftUI

struct sao2ViewScreen: View {
    @ObservedObject var sao2: Sao2
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
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
        "sao2Screen1",
        "sao2Screen2",
        "sao2Screen3",
        "sao2Screen4",
        "sao2Screen5",
        "sao2Screen6",
        "sao2Screen7",
        "sao2Screen8",
        "sao2Screen9",
        "sao2Screen10",
    ]
    let upperBeltTextList: [String] = [
        "シノン＆キリト",
        "制服",
        "ソファー",
        "草むら",
        "夏祭り",
        "みかん",
        "ベッドの上",
        "入浴中",
        "プール",
        "パジャマ",
    ]
    let lowerBeltTextList: [String] = [
        "デフォルト",
        "奇数示唆",
        "偶数示唆",
        "高設定示唆",
        "高設定示唆 強",
        "設定5示唆",
        "設定2 以上濃厚",
        "設定3 以上濃厚",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]
    let sisaText: [String] = [
        "???(シノン＆キリト)",
        "???(制服)",
        "???(ソファー)",
        "???(草むら)",
        "???(夏祭り)",
        "???(みかん)",
        "???(ベッドの上)",
        "???(入浴中)",
        "???(プール)",
        "???(パジャマ)",
    ]
    let flashColorList: [Color] = [
        .gray,
        .blue,
        .yellow,
        .green,
        .purple,
        .red,
        .brown,
        .gray,
        .orange,
        .purple,
    ]
    let indexList: [Int] = [0,1,2,3,4,5,6,7,8,9]
    let indexListResult: [Int] = [0,1,2,8,]
    
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
//                                            upperBeltFont: .subheadline,
                                            lowerBeltText: self.lowerBeltTextList[index],
//                                            lowerBeltFont: .subheadline,
    //                                        lowerBeltHeight: 35,
                                        ),
                                        screenName: self.imageNameList[index],
                                        selectedScreen: self.$selectedImageName,
                                        count: bindingForScreenCount(index: index),
                                        minusCheck: $sao2.minusCheck,
                                        action: sao2.screenSumFunc,
                                    )
                                }
                            }
                        }
                    }
                    .frame(height: common.screenScrollHeight)
                    .popoverTip(tipVer3271Sao2ScreenSisa())
                }
                
                // //// カウント結果
                ForEach(self.indexList, id: \.self) { index in
//                ForEach(self.indexListResult, id: \.self) { index in
                    if self.lowerBeltTextList.indices.contains(index) &&
//                    if self.upperBeltTextList.indices.contains(index) &&
                        self.flashColorList.indices.contains(index) {
//                        self.flashColorList.indices.contains(index) &&
//                        self.sisaText.indices.contains(index) {
                        unitResultCountListPercent(
                            title: self.lowerBeltTextList[index],
//                            title: self.upperBeltTextList[index],
//                            title: self.sisaText[index],
                            count: bindingForScreenCount(index: index),
                            flashColor: self.flashColorList[index],
                            bigNumber: $sao2.screenCountSum,
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
        .resetBadgeOnAppear($common.sao2MenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: sao2.machineName,
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
                unitButtonMinusCheck(minusCheck: $sao2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: sao2.resetScreen)
            }
        }
    }
    
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $sao2.screenCount1
        case 1: return $sao2.screenCount2
        case 2: return $sao2.screenCount3
        case 3: return $sao2.screenCount4
        case 4: return $sao2.screenCount5
        case 5: return $sao2.screenCount6
        case 6: return $sao2.screenCount7
        case 7: return $sao2.screenCount8
        case 8: return $sao2.screenCount9
        case 9: return $sao2.screenCount10
        default: return .constant(0)
        }
    }
}

#Preview {
    sao2ViewScreen(
        sao2: Sao2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
