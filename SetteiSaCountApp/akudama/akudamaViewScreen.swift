//
//  akudamaViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/06.
//

import SwiftUI

struct akudamaViewScreen: View {
    @ObservedObject var akudama: Akudama
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
        "akudamaScreen1",
        "akudamaScreen2",
        "akudamaScreen3",
        "akudamaScreen4",
        "akudamaScreen5",
        "akudamaScreen6",
        "akudamaScreen7",
        "akudamaScreen8",
        "akudamaScreen9",
    ]
    let upperBeltTextList: [String] = [
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
    let lowerBeltTextList: [String] = [
        "偶数示唆",
        "奇数示唆",
        "高設定示唆",
        "天井示唆",
        "天井示唆or4以上",
        "天井示唆or4以上",
        "天井示唆or4以上",
        "天井示唆or4以上",
        "設定4 以上濃厚",
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
        .yellow,
        .blue,
        .green,
        .gray,
        .gray,
        .gray,
        .gray,
        .gray,
        .orange,
    ]
    let indexList: [Int] = [0,1,2,3,4,5,6,7,8,]
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
                                            upperBeltFont: .subheadline,
                                            lowerBeltText: self.lowerBeltTextList[index],
                                            lowerBeltFont: .subheadline,
    //                                        lowerBeltHeight: 35,
                                        ),
                                        screenName: self.imageNameList[index],
                                        selectedScreen: self.$selectedImageName,
                                        count: bindingForScreenCount(index: index),
                                        minusCheck: $akudama.minusCheck,
                                        action: akudama.screenSumFunc,
                                    )
                                }
                            }
                        }
                    }
                    .frame(height: common.screenScrollHeight)
                    .popoverTip(tipVer3240AkudamaScreen())
                    
                    Text("※ 天井示唆：処刑課バトルの天井示唆")
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                    
                    // 天井示唆の詳細
//                    unitLinkButtonViewBuilder(sheetTitle: "天井示唆の詳細") {
//                        akudamaTableScreen()
//                    }
                }
                
                // 天井示唆の詳細
                unitLinkButtonViewBuilder(sheetTitle: "天井示唆の詳細") {
                    akudamaTableScreen()
                }
                
                // //// カウント結果
//                ForEach(self.indexList, id: \.self) { index in
                ForEach(self.indexListResult, id: \.self) { index in
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
//                            bigNumber: $akudama.screenCountSum,
                            bigNumber: $akudama.screenCountWithoutTenjoSum,
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
        .resetBadgeOnAppear($common.akudamaMenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: akudama.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("ST終了画面")
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
                unitButtonMinusCheck(minusCheck: $akudama.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: akudama.resetScreen)
            }
        }
    }
    
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $akudama.screenCount1
        case 1: return $akudama.screenCount2
        case 2: return $akudama.screenCount3
        case 3: return $akudama.screenCount4
        case 4: return $akudama.screenCount5
        case 5: return $akudama.screenCount6
        case 6: return $akudama.screenCount7
        case 7: return $akudama.screenCount8
        case 8: return $akudama.screenCount9
        default: return .constant(0)
        }
    }
}

#Preview {
    akudamaViewScreen(
        akudama: Akudama(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
