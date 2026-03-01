//
//  gobsla2ViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/25.
//

import SwiftUI

struct gobsla2ViewScreen: View {
    @ObservedObject var gobsla2: Gobsla2
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
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
        "gobsla2Screen1",
        "gobsla2Screen2",
        "gobsla2Screen3",
        "gobsla2Screen4",
        "gobsla2Screen5",
        "gobsla2Screen6",
        "gobsla2Screen7",
        "gobsla2Screen8",
        "gobsla2Screen9",
        "gobsla2Screen10",
    ]
    let upperBeltTextList: [String] = [
        "スレイヤー＆女神官",
        "スレイヤー＆妖精弓手",
        "スレイヤー＆鉱人道士",
        "スレイヤー＆蜥蜴僧侶",
        "パーティー",
        "女神官",
        "牛飼娘",
        "妖精弓手",
        "入浴中",
        "全員集合",
    ]
    let lowerBeltTextList: [String] = [
        "デフォルト",
        "規定兜pt示唆①",
        "規定兜pt示唆②",
        "規定兜pt示唆③",
        "規定兜pt示唆④",
        "高設定示唆 弱",
        "設定2 以上濃厚",
        "偶数設定濃厚",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]
    let sisaText: [String] = [
        "デフォルト",
        "???",
        "???",
        "高設定濃厚(消防服)",
        "高設定濃厚(ｵﾚﾝｼﾞ服)",
        "高設定濃厚(全員集合)",
    ]
    let flashColorList: [Color] = [
        .gray,
        .cyan,
        .mint,
        .pink,
        .indigo,
        .blue,
        .brown,
        .yellow,
        .orange,
        .purple,
    ]
    let indexList: [Int] = [0,1,2,3,4,5,6,7,8,9]
    
    var body: some View {
        List {
            // 画面カウント
            Section {
                // 注意書き
//                HStack {
//                    Text("⚠️")
//                    VStack(alignment: .leading) {
//                        Text("・設定示唆は以下の画面")
//                        Text("・これ以外にもモード示唆、炎炎激闘ストック示唆の画面もあり")
//                    }
//                    .foregroundStyle(Color.secondary)
//                    .font(.caption)
//                }
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
//                                        lowerBeltFont: .body,
//                                        lowerBeltHeight: 35,
                                    ),
                                    screenName: self.imageNameList[index],
                                    selectedScreen: self.$selectedImageName,
                                    count: bindingForScreenCount(index: index),
                                    minusCheck: $gobsla2.minusCheck,
                                    action: gobsla2.screenSumFunc,
                                )
                            }
                        }
                    }
                }
                .frame(height: common.screenScrollHeight)
                
                // 参考情報）規定兜pt示唆詳細
                unitLinkButtonViewBuilder(sheetTitle: "規定兜pt示唆詳細") {
                    gobsla2TableScreenSisaDetail()
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
                            bigNumber: $gobsla2.screenCountSum,
                            numberofDigit: 0,
                            titleFont: .body,
                        )
                    }
                }
                
                // //// 設定期待値へのリンク
//                unitNaviLinkBayes {
//                    gobsla2ViewBayes(
//                        gobsla2: gobsla2,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )
//                }
            } header: {
                unitLabelHeaderScreenCount()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.gobsla2MenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: gobsla2.machineName,
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
                unitButtonMinusCheck(minusCheck: $gobsla2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: gobsla2.resetScreen)
            }
        }
    }
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $gobsla2.screenCountDefault
        case 1: return $gobsla2.screenCountPtSisa1
        case 2: return $gobsla2.screenCountPtSisa2
        case 3: return $gobsla2.screenCountPtSisa3
        case 4: return $gobsla2.screenCountPtSisa4
        case 5: return $gobsla2.screenCountHighJaku
        case 6: return $gobsla2.screenCountOver2
        case 7: return $gobsla2.screenCountGusu
        case 8: return $gobsla2.screenCountOver4
        case 9: return $gobsla2.screenCountOver6
        default: return .constant(0)
        }
    }
}

#Preview {
    gobsla2ViewScreen(
        gobsla2: Gobsla2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
