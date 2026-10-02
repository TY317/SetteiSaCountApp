//
//  index2ViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct index2ViewScreen: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var index2: Index2
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
                "index2Screen1",
                "index2Screen2",
                "index2Screen3",
                "index2Screen4",
                "index2Screen5",
                "index2Screen6",
                "index2Screen7",
                "index2Screen8",
                "index2Screen9",
                "index2Screen10",
                "index2Screen11",
    ]
    let upperBeltTextList: [String] = [
                "当麻＆インデックス",
                "美琴＆黒子",
                "打ち止め＆一方通行",
                "番外個体＆一方通行",
                "アリサ＆シャットアウラ",
                "初春＆美琴",
                "ハーレム",
                "アイテム",
                "スクール",
                "グループ",
                "医者",
    ]
    let lowerBeltTextList: [String] = [
                "奇数示唆",
                "偶数示唆",
                "高設定示唆 弱",
                "高設定示唆 強",
                "偶数濃厚",
                "設定4 以上濃厚",
                "設定6 濃厚",
                "残り500G以内濃厚",
                "残り300G以内濃厚",
                "残り150G以内濃厚",
                "AT復活濃厚",
    ]
    let flashColorList: [Color] = [
                .gray,
                .blue,
                .yellow,
                .green,
                .red,
                .orange,
                .purple,
                .gray,
                .gray,
                .gray,
                .gray,
    ]
    let indexList: [Int] = [0,1,2,3,4,5,6,7,8,9,10]
    let indexListResult: [Int] = [0,1,2,3,4,5,6,7,]
    let resultTextList: [String] = [
        "奇数示唆",
        "偶数示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "偶数濃厚",
        "設定4 以上濃厚",
        "設定6 濃厚",
                "設定示唆以外",
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
                                            upperBeltFont: .subheadline,
                                            lowerBeltText: self.lowerBeltTextList[index],
                                            lowerBeltFont: .subheadline,
                                        ),
                                        screenName: self.imageNameList[index],
                                        selectedScreen: self.$selectedImageName,
                                        count: bindingForScreenCount(index: index),
                                        minusCheck: $index2.minusCheck,
                                        action: index2.screenSumFunc,
                                    )
                                }
                            }
                        }
                    }
                    .frame(height: common.screenScrollHeight)
                }

                // //// カウント結果
                ForEach(self.indexListResult, id: \.self) { index in
                    if self.lowerBeltTextList.indices.contains(index) &&
                        self.resultTextList.indices.contains(index) &&
                        self.flashColorList.indices.contains(index) {
                        unitResultCountListPercent(
//                            title: self.lowerBeltTextList[index],
                            title: self.resultTextList[index],
                            count: bindingForScreenCount(index: index),
                            flashColor: self.flashColorList[index],
                            bigNumber: $index2.screenCountSum,
                            numberofDigit: 0,
                            titleFont: .body,
                        )
                    }
                }

                // 参考情報）終了画面振り分け
                unitLinkButtonViewBuilder(sheetTitle: "終了画面振り分け") {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("・残りG数示唆、AT復活示唆の画面は振り分けに含まれません")
                            .foregroundStyle(Color.secondary)
                            .font(.caption)
                        HStack(spacing: 0) {
                            unitTableSettingIndex(titleLine: 2)
                            unitTablePercent(
                                columTitle: "当麻＆\nインデックス",
                                percentList: index2.ratioScreenKisuSisa,
                                titleLine: 2
                            )
                            unitTablePercent(
                                columTitle: "美琴＆\n黒子",
                                percentList: index2.ratioScreenGusuSisa,
                                titleLine: 2
                            )
                            unitTablePercent(
                                columTitle: "打ち止め＆\n一方通行",
                                percentList: index2.ratioScreenHighJaku,
                                titleLine: 2
                            )
                        }
                        HStack(spacing: 0) {
                            unitTableSettingIndex(titleLine: 2)
                            unitTablePercent(
                                columTitle: "番外個体＆\n一方通行",
                                percentList: index2.ratioScreenHighKyo,
                                numberofDicimal: 1,
                                titleLine: 2
                            )
                            unitTablePercent(
                                columTitle: "アリサ＆\nシャットアウラ",
                                percentList: index2.ratioScreenGusu,
                                numberofDicimal: 1,
                                titleLine: 2
                            )
                            unitTablePercent(
                                columTitle: "初春＆\n美琴",
                                percentList: index2.ratioScreenOver4,
                                numberofDicimal: 1,
                                titleLine: 2
                            )
                            unitTablePercent(
                                columTitle: "ハーレム",
                                percentList: index2.ratioScreenOver6,
                                numberofDicimal: 1,
                                titleLine: 2
                            )
                        }
                    }
                }
                .popoverTip(tipVer480Index2Screen())
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    index2ViewBayes(
                        index2: index2,
                    )
                }
                
            } header: {
                unitLabelHeaderScreenCount()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.index2MenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: index2.machineName,
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
                unitButtonMinusCheck(minusCheck: $index2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: index2.resetScreen)
            }
        }
    }
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $index2.screenCount1
        case 1: return $index2.screenCount2
        case 2: return $index2.screenCount3
        case 3: return $index2.screenCount4
        case 4: return $index2.screenCount5
        case 5: return $index2.screenCount6
        case 6: return $index2.screenCount7
        case 7: return $index2.screenCount8
        case 8: return $index2.screenCount8
        case 9: return $index2.screenCount8
        case 10: return $index2.screenCount8
        default: return .constant(0)
        }
    }
}

#Preview {
    index2ViewScreen(
        index2: Index2(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
