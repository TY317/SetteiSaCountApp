//
//  darlingViewCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/30.
//

import SwiftUI

struct darlingViewCz: View {
    @ObservedObject var ver390: Ver390
    @ObservedObject var darling: Darling
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 300.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 300.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    @State var isShowAlert = false
    let titleList: [String] = ["白","青","黄","緑","赤"]
    @State var selectedFinalColor: String = "白"
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    
    var body: some View {
        List {
            // //// 初期レベル
            Section {
                // カウントボタン横並び
                let gridItem = Array(
                    repeating: GridItem(
                        .flexible(minimum: 80, maximum: 150),
                        spacing: 5,
                        alignment: .center,
                    ),
                    count: self.lazyVGridCount
                )
                LazyVGrid(columns: gridItem) {
                    ForEach(self.titleList.indices, id: \.self) { index in
                        unitCountButtonPercentWithFunc(
                            title: self.titleList[index],
                            count: bindingCount(index: index),
                            color: buttonColor(index: index),
                            bigNumber: $darling.czLevelCountSum,
                            numberofDicimal: 1,
                            minusBool: $darling.minusCheck) {
                                darling.czLevelCountSumFunc()
                            }
                            .padding(.bottom)
                    }
                }
                // 参考情報）初期レベル振分け
                unitLinkButtonViewBuilder(sheetTitle: "初期レベル振分け") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "白",
                            percentList: darling.ratioCzLevelWhite,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "青",
                            percentList: darling.ratioCzLevelBlue,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "黄",
                            percentList: darling.ratioCzLevelYellow,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "緑",
                            percentList: darling.ratioCzLevelGreen,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "赤",
                            percentList: darling.ratioCzLevelRed,
                            numberofDicimal: 1,
                        )
                    }
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        darlingView95Ci(
                            darling: darling,
                            selection: 6,
                        )
                    )
                )
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    darlingViewBayes(
                        ver390: ver390,
                        darling: darling,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("初期レベル カウント")
            }
            
            // //// 最終レベル別の当選率
            Section {
                // セグメントピッカー
                Picker("", selection: self.$selectedFinalColor) {
                    ForEach(self.titleList, id: \.self) { color in
                        Text(color)
                    }
                }
                .pickerStyle(.segmented)
                .popoverTip(tipVer390DarlingCz())
                // カウントボタン横並び
                HStack {
                    // 白
                    if self.selectedFinalColor == self.titleList[0] {
                        unitCountButtonWithoutRatioWithFunc(
                            title: "失敗",
                            count: $darling.czFLCountWhiteMiss,
                            color: .grayBack,
                            minusBool: $darling.minusCheck) {
                                darling.czFLCountSumFunc()
                            }
                        unitCountButtonWithoutRatioWithFunc(
                            title: "突破",
                            count: $darling.czFLCountWhiteHit,
                            color: .gray,
                            minusBool: $darling.minusCheck) {
                                darling.czFLCountSumFunc()
                            }
                    }
                    // 青
                    else if self.selectedFinalColor == self.titleList[1] {
                        unitCountButtonWithoutRatioWithFunc(
                            title: "失敗",
                            count: $darling.czFLCountBlueMiss,
                            color: .personalSummerLightBlue,
                            minusBool: $darling.minusCheck) {
                                darling.czFLCountSumFunc()
                            }
                        unitCountButtonWithoutRatioWithFunc(
                            title: "突破",
                            count: $darling.czFLCountBlueHit,
                            color: .blue,
                            minusBool: $darling.minusCheck) {
                                darling.czFLCountSumFunc()
                            }
                    }
                    // 黄色
                    else if self.selectedFinalColor == self.titleList[2] {
                        unitCountButtonWithoutRatioWithFunc(
                            title: "失敗",
                            count: $darling.czFLCountYellowMiss,
                            color: .personalSpringLightYellow,
                            minusBool: $darling.minusCheck) {
                                darling.czFLCountSumFunc()
                            }
                        unitCountButtonWithoutRatioWithFunc(
                            title: "突破",
                            count: $darling.czFLCountYellowHit,
                            color: .yellow,
                            minusBool: $darling.minusCheck) {
                                darling.czFLCountSumFunc()
                            }
                    }
                    // 緑
                    else if self.selectedFinalColor == self.titleList[3] {
                        unitCountButtonWithoutRatioWithFunc(
                            title: "失敗",
                            count: $darling.czFLCountGreenMiss,
                            color: .personalSummerLightGreen,
                            minusBool: $darling.minusCheck) {
                                darling.czFLCountSumFunc()
                            }
                        unitCountButtonWithoutRatioWithFunc(
                            title: "突破",
                            count: $darling.czFLCountGreenHit,
                            color: .green,
                            minusBool: $darling.minusCheck) {
                                darling.czFLCountSumFunc()
                            }
                    }
                    // 赤
                    else {
                        unitCountButtonWithoutRatioWithFunc(
                            title: "失敗",
                            count: $darling.czFLCountRedMiss,
                            color: .personalSummerLightRed,
                            minusBool: $darling.minusCheck) {
                                darling.czFLCountSumFunc()
                            }
                        unitCountButtonWithoutRatioWithFunc(
                            title: "突破",
                            count: $darling.czFLCountRedHit,
                            color: .red,
                            minusBool: $darling.minusCheck) {
                                darling.czFLCountSumFunc()
                            }
                    }
                }
                // //// 結果横並び
                let gridItem = Array(
                    repeating: GridItem(
                        .flexible(minimum: 80, maximum: 150),
                        spacing: 5,
                        alignment: .center,
                    ),
                    count: self.lazyVGridCount
                )
                LazyVGrid(columns: gridItem) {
                    ForEach(self.titleList, id: \.self) { color in
                        unitResultRatioPercent2Line(
                            title: color,
                            count: bindingFLCountHit(color: color),
                            bigNumber: bindingFLCountSum(color: color),
                            numberofDicimal: 0,
                            spacerBool: false,
                        )
                    }
                }
                // 参考情報）当選率
                unitLinkButtonViewBuilder(sheetTitle: "最終レベル別の当選率") {
                    VStack {
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "白",
                                percentList: darling.ratioCzFLWhite,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "青",
                                percentList: darling.ratioCzFLBlue,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "黄",
                                percentList: darling.ratioCzFLYellow,
                                numberofDicimal: 0,
                            )
                            unitTablePercent(
                                columTitle: "緑",
                                percentList: darling.ratioCzFLGreen,
                                numberofDicimal: 0,
                            )
                            unitTablePercent(
                                columTitle: "赤",
                                percentList: darling.ratioCzFLRed,
                                numberofDicimal: 0,
                            )
                        }
                    }
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        darlingView95Ci(
                            darling: darling,
                            selection: 7,
                        )
                    )
                )
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    darlingViewBayes(
                        ver390: ver390,
                        darling: darling,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("最終レベル別の当選率")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver390.darlingMenuCzBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: darling.machineName,
                screenClass: screenClass
            )
        }
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
        .navigationTitle("CZ コネクトチャンス")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $darling.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: darling.resetCz)
                }
            }
        }
    }
    func bindingCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return darling.$czLevelCountWhite
        case 1: return darling.$czLevelCountBlue
        case 2: return darling.$czLevelCountYellow
        case 3: return darling.$czLevelCountGreen
        case 4: return darling.$czLevelCountRed
        default: return .constant(0)
        }
     }
    
    func buttonColor(index: Int) -> Color {
        switch index {
        case 0: return .grayBack
        case 1: return .personalSummerLightBlue
        case 2: return .personalSpringLightYellow
        case 3: return .personalSummerLightGreen
        case 4: return .personalSummerLightRed
        default: return .grayBack
        }
    }
//    func bindingFLCountMiss(index: Int) -> Binding<Int> {
//        switch index {
//        case 0: return darling.$czFLCountWhiteMiss
//        case 1: return darling.$czFLCountBlueMiss
//        case 2: return darling.$czFLCountYellowMiss
//        case 3: return darling.$czFLCountGreenMiss
//        case 4: return darling.$czFLCountRedMiss
//        default: return .constant(0)
//        }
//    }
    func bindingFLCountHit(color: String) -> Binding<Int> {
        switch color {
        case self.titleList[0]: return darling.$czFLCountWhiteHit
        case self.titleList[1]: return darling.$czFLCountBlueHit
        case self.titleList[2]: return darling.$czFLCountYellowHit
        case self.titleList[3]: return darling.$czFLCountGreenHit
        case self.titleList[4]: return darling.$czFLCountRedHit
        default: return .constant(0)
        }
    }
    func bindingFLCountSum(color: String) -> Binding<Int> {
        switch color {
        case self.titleList[0]: return darling.$czFLCountWhiteSum
        case self.titleList[1]: return darling.$czFLCountBlueSum
        case self.titleList[2]: return darling.$czFLCountYellowSum
        case self.titleList[3]: return darling.$czFLCountGreenSum
        case self.titleList[4]: return darling.$czFLCountRedSum
        default: return .constant(0)
        }
    }
//    func buttonColorHit(index: Int) -> Color {
//        switch index {
//        case 0: return .gray
//        case 1: return .blue
//        case 2: return .yellow
//        case 3: return .green
//        case 4: return .red
//        default: return .gray
//        }
//    }
}

#Preview {
    darlingViewCz(
        ver390: Ver390(),
        darling: Darling(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
