//
//  mushotenViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/03.
//

import SwiftUI

struct mushotenViewScreen: View {
    @ObservedObject var mushoten: Mushoten
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
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
        "mushotenEndScreen1",
        "mushotenEndScreen2",
        "mushotenEndScreen3",
        "mushotenEndScreen4",
        "mushotenEndScreen5",
        "mushotenEndScreen6",
        "mushotenEndScreen7",
    ]
    let upperBeltTextList: [String] = [
        "枠なし 後ろ姿",
        "白枠 師弟",
        "青枠 夕暮れ",
        "赤枠 城下町",
        "銅枠 夜営",
        "銀枠 4人",
        "金枠",
    ]
    let lowerBeltTextList: [String] = [
        "デフォルト",
        "偶数示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]
    let flashColorList: [Color] = [
        .gray,
        .yellow,
        .blue,
        .red,
        .brown,
        .gray,
        .orange,
    ]
    let indexList: [Int] = [0,1,2,3,4,5,6]
    
    var body: some View {
        List {
            // 画面カウント
            Section {
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
//                                        lowerBeltFont: .body,
//                                        lowerBeltHeight: 35,
                                    ),
                                    screenName: self.imageNameList[index],
                                    selectedScreen: self.$selectedImageName,
                                    count: bindingForScreenCount(index: index),
                                    minusCheck: $mushoten.minusCheck,
                                    action: mushoten.screenSumFunc,
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
                            bigNumber: $mushoten.screenCountSum,
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
        .resetBadgeOnAppear($common.mushotenMenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: mushoten.machineName,
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
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $mushoten.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: mushoten.resetScreen)
            }
        }
    }
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $mushoten.screenCountDefault
        case 1: return $mushoten.screenCountGusu
        case 2: return $mushoten.screenCountHighJaku
        case 3: return $mushoten.screenCountHighKyo
        case 4: return $mushoten.screenCountOver2
        case 5: return $mushoten.screenCountOver4
        case 6: return $mushoten.screenCountOver6
        default: return .constant(0)
        }
    }
}

#Preview {
    mushotenViewScreen(
        mushoten: Mushoten(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
