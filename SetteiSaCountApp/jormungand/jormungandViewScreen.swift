//
//  jormungandViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/09.
//

import SwiftUI

struct jormungandViewScreen: View {
    @ObservedObject var jormungand: Jormungand
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    
    @State var isShowAlert: Bool = false
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
        "jormungandScreen1",
        "jormungandScreen2",
        "jormungandScreen3",
        "jormungandScreen4",
        "jormungandScreen5",
        "jormungandScreen6",
        "jormungandScreen7",
        "jormungandScreen8",
    ]
    let upperBeltTextList: [String] = [
        "地平線",
        "博士3人",
        "夕焼け2人",
        "バルメ",
        "ハンドガン",
        "旧ココ部隊",
        "キャスパー",
        "黄金の畑のカカシ",
    ]
    let lowerBeltTextList: [String] = [
        "デフォルト",
        "高設定示唆",
        "奇数示唆",
        "偶数示唆",
        "2否定＆5以上示唆",
        "偶数濃厚",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]
    let sisaText: [String] = [
        "喧嘩屋＆チンピラ",
        "キラー＆医者＆ハッカー",
        "運び屋＆詐欺師",
        "処刑課",
        "遊園地",
        "十字架",
        "ロケット",
        "絶対隔離領域",
        "変化なし",
    ]
    let flashColorList: [Color] = [
        .gray,
        .green,
        .blue,
        .yellow,
        .brown,
        .yellow,
        .orange,
        .purple,
    ]
    let indexList: [Int] = [0,1,2,3,4,5,6,7,]
    
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
    //                                        lowerBeltFont: .body,
    //                                        lowerBeltHeight: 35,
                                        ),
                                        screenName: self.imageNameList[index],
                                        selectedScreen: self.$selectedImageName,
                                        count: bindingForScreenCount(index: index),
                                        minusCheck: $jormungand.minusCheck,
                                        action: jormungand.screenSumFunc,
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
                            bigNumber: $jormungand.screenCountSum,
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
        .resetBadgeOnAppear($common.jormungandMenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: jormungand.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("ボーナス終了画面")
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
                unitButtonMinusCheck(minusCheck: $jormungand.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: jormungand.resetScreen)
            }
        }
    }
    
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $jormungand.screenCountDefault
        case 1: return $jormungand.screenCountHigh
        case 2: return $jormungand.screenCountKisu
        case 3: return $jormungand.screenCountGusu
        case 4: return $jormungand.screenCountNegate2
        case 5: return $jormungand.screenCountGusuFix
        case 6: return $jormungand.screenCountOver4
        case 7: return $jormungand.screenCountOver6
        default: return .constant(0)
        }
    }
}

#Preview {
    jormungandViewScreen(
        jormungand: Jormungand(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
