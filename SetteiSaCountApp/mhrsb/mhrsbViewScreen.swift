//
//  mhrsbViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct mhrsbViewScreen: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var mhrsb: Mhrsb
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
        "mhrsbScreen1",
        "mhrsbScreen2",
        "mhrsbScreen3",
        "mhrsbScreen4",
        "mhrsbScreen5",
        "mhrsbScreen6",
        "mhrsbScreen7",
        "mhrsbScreen8",
        "mhrsbScreen9",
        "mhrsbScreen10",
        "mhrsbScreen11",
        "mhrsbScreen12",
    ]
    let upperBeltTextList: [String] = [
        "ジェイ",
        "アルロー",
        "ガレアス",
        "ロンディーネ",
        "ルーチカ",
        "フィオレーネ&オトモアイルー",
        "チッチェ&オトモアイルー&ガルク",
        "フィオレーネ&ロンディーネ",
        "ジェイ&アルロー&ガレアス",
        "ヒノエ&ミノト",
        "全員集合",
        "エンタライオン",
    ]
    let lowerBeltTextList: [String] = [
        "奇数示唆",
        "奇数示唆",
        "奇数示唆",
        "偶数示唆",
        "偶数示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定2 否定",
        "設定3 否定",
        "設定2 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]
    let flashColorList: [Color] = [
        .blue,
        .blue,
        .blue,
        .yellow,
        .yellow,
        .green,
        .red,
        .cyan,
        .indigo,
        .brown,
        .red,
        .purple,
    ]
    let indexList: [Int] = [0,1,2,3,4,5,6,7,8,9,10,11]
    // 結果表示用（同じ示唆の画面は1つのカウントにまとめる）
    let resultIndexList: [Int] = [0,1,2,3,4,5,6,7,8]
    let resultTitleList: [String] = [
        "奇数示唆",
        "偶数示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定2 否定",
        "設定3 否定",
        "設定2 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]
    let resultColorList: [Color] = [
        .blue,
        .yellow,
        .green,
        .red,
        .cyan,
        .indigo,
        .brown,
        .red,
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
                                        count: bindingForScreenCount(index: resultIndex(screenIndex: index)),
                                        minusCheck: $mhrsb.minusCheck,
                                        action: mhrsb.screenSumFunc,
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
                            count: bindingForScreenCount(index: index),
                            flashColor: self.resultColorList[index],
                            bigNumber: $mhrsb.screenCountSum,
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
        .resetBadgeOnAppear($common.mhrsbMenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: mhrsb.machineName,
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
                unitButtonMinusCheck(minusCheck: $mhrsb.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: mhrsb.resetScreen)
            }
        }
    }
    // 画面のインデックス → 結果（カウント変数）のインデックス
    func resultIndex(screenIndex: Int) -> Int {
        switch screenIndex {
        case 0, 1, 2: return 0      // 奇数示唆
        case 3, 4: return 1         // 偶数示唆
        case 5: return 2            // 高設定示唆 弱
        case 6: return 3            // 高設定示唆 強
        case 7: return 4            // 設定2 否定
        case 8: return 5            // 設定3 否定
        case 9: return 6            // 設定2 以上濃厚
        case 10: return 7           // 設定5 以上濃厚
        case 11: return 8           // 設定6 濃厚
        default: return -1
        }
    }
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $mhrsb.screenCount1
        case 1: return $mhrsb.screenCount2
        case 2: return $mhrsb.screenCount3
        case 3: return $mhrsb.screenCount4
        case 4: return $mhrsb.screenCount5
        case 5: return $mhrsb.screenCount6
        case 6: return $mhrsb.screenCount7
        case 7: return $mhrsb.screenCount8
        case 8: return $mhrsb.screenCount9
        default: return .constant(0)
        }
    }
}

#Preview {
    mhrsbViewScreen(
        mhrsb: Mhrsb(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
