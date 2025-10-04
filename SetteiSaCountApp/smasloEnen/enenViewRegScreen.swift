//
//  enenViewRegScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/17.
//

import SwiftUI

struct enenViewRegScreen: View {
//    @ObservedObject var ver391: Ver391
    @ObservedObject var enen: Enen
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "enenScreen0",
        "enenScreen1",
        "enenScreen2",
        "enenScreen3",
        "enenScreen4",
        "enenScreen5",
    ]
    let upperBeltTextList: [String] = [
        "設定示唆 以外",
        "第8 A",
        "第8 B",
        "第8 C",
        "第8 D",
        "全員集合",
    ]
    let lowerBeltTextList: [String] = [
        "デフォルト・その他",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定4 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]
    let flashColorList: [Color] = [
        .gray,
        .blue,
        .yellow,
        .green,
        .red,
        .purple,
    ]
//    let sisaList: [String] = [
//        "デフォルト",
//        "???(白背景)",
//        "???(黒背景)",
//        "???(水着)",
//        "???(和服)",
//        "???(全員集合)",
//    ]
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
    let maxWidth2: CGFloat = 60
    let maxWidth3: CGFloat = .infinity
    let maxWidth4: CGFloat = .infinity
    let maxWidth5: CGFloat = 60
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    
    var body: some View {
        List {
            Section {
                // //// 画面カウントボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(self.imageNameList.indices, id: \.self) { index in
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
                                    minusCheck: $enen.minusCheck,
                                    action: enen.regScreenCountSumFunc
                                )
                            }
                        }
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                ForEach(self.lowerBeltTextList.indices, id: \.self) { index in
//                    if self.sisaList.indices.contains(index) &&
                    if self.lowerBeltTextList.indices.contains(index) &&
                        self.flashColorList.indices.contains(index) {
                        unitResultCountListPercent(
//                            title: self.sisaList[index],
                            title: self.lowerBeltTextList[index],
                            count: bindingForScreenCount(index: index),
                            flashColor: self.flashColorList[index],
                            bigNumber: $enen.regScreenCountSum,
                        )
                    }
                }
                
                // //// 参考情報）設定示唆画面の振分け
                unitLinkButtonViewBuilder(sheetTitle: "設定示唆画面の振分け") {
                    enenTableRegScreen(
                        enen: enen,
                    )
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        enenView95Ci(
                            enen: enen,
                            selection: 8,
                        )
                    )
                )
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    enenViewBayes(
//                        ver391: ver391,
                        enen: enen,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                HStack {
                    Text("画面カウント")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "画面カウント",
                            textBody1: "・画面を選択した状態でもう一度タップするとカウントできます",
                            textBody2: "・選択解除は画面上部のボタンでできます"
                        )
                    }
                }
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: enen.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("REG終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// 画面選択解除
                    unitButtonToolbarScreenSelectReset(
                        currentKeyword: self.$selectedImageName
                    )
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $enen.minusCheck)
                    // /// リセット
                    unitButtonReset(
                        isShowAlert: $isShowAlert,
                        action: enen.resetRegScreen,
                    )
                }
            }
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
    }
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $enen.regScreenCountDefault
        case 1: return $enen.regScreenCountHighJaku
        case 2: return $enen.regScreenCountHighKyo
        case 3: return $enen.regScreenCountOver4
        case 4: return $enen.regScreenCountOver5
        case 5: return $enen.regScreenCountOver6
        default: return .constant(0)
        }
    }
}

#Preview {
    enenViewRegScreen(
//        ver391: Ver391(),
        enen: Enen(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
