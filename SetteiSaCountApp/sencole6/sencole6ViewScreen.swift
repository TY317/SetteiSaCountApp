//
//  sencole6ViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/07/01.
//

import SwiftUI

struct sencole6ViewScreen: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var sencole6: Sencole6
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
        "sencole6Screen1",
        "sencole6Screen2",
        "sencole6Screen3",
        "sencole6Screen4",
        "sencole6Screen5",
        "sencole6Screen6",
        "sencole6Screen7",
    ]
    let upperBeltTextList: [String] = [
        "織田信長",
        "小野小町",
        "水着1",
        "水着2",
        "敵武将3人",
        "4人",
        "しずもん絵",
    ]
    let lowerBeltTextList: [String] = [
        "奇数示唆",
        "偶数示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]
    let flashColorList: [Color] = [
        .blue,
        .yellow,
        .green,
        .red,
        .brown,
        .orange,
        .purple,
    ]
    let indexList: [Int] = [0,1,2,3,4,5,6]
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
                                        minusCheck: $sencole6.minusCheck,
                                        action: sencole6.screenSumFunc,
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
                            bigNumber: $sencole6.screenCountSum,
                            numberofDigit: 0,
                            titleFont: .body,
                        )
                    }
                }
            } header: {
                unitLabelHeaderScreenCount()
            }
            
            // コナミコマンド
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "コナミコマンドでのボイス") {
                    sencole6TableCommand()
                }
            } header: {
                Text("コナミコマンド")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.sencole6MenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: sencole6.machineName,
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
                unitButtonMinusCheck(minusCheck: $sencole6.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: sencole6.resetScreen)
            }
        }
    }
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $sencole6.screenCount1
        case 1: return $sencole6.screenCount2
        case 2: return $sencole6.screenCount3
        case 3: return $sencole6.screenCount4
        case 4: return $sencole6.screenCount5
        case 5: return $sencole6.screenCount6
        case 6: return $sencole6.screenCount7
        default: return .constant(0)
        }
    }
}

#Preview {
    sencole6ViewScreen(
        sencole6: Sencole6(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
