//
//  enenViewDendosha.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/17.
//

import SwiftUI

struct enenViewDendosha: View {
    @ObservedObject var enen: Enen
    @State var isShowAlert = false
    @State var selectedSegment: String = "十字目変換"
    let segmentList: [String] = ["十字目変換", "弱レア役"]
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
    
    var body: some View {
        List {
            // //// ボーナス当選率
            Section {
                // セグメントピッカー
                Picker("", selection: self.$selectedSegment) {
                    ForEach(self.segmentList, id: \.self) { text in
                        Text(text)
                    }
                }
                .pickerStyle(.segmented)
                // カウントボタン
                HStack {
                    // 十字目変換
                    if self.selectedSegment == self.segmentList[0] {
                       unitCountButtonVerticalWithoutRatio(
                        title: "十字目変換",
                        count: $enen.dendoshaCountJuji,
                        color: .personalSummerLightBlue,
                        minusBool: $enen.minusCheck
                       )
                        unitCountButtonVerticalWithoutRatio(
                         title: "ボーナス当選",
                         count: $enen.dendoshaCountJujiHit,
                         color: .blue,
                         minusBool: $enen.minusCheck
                        )
                    }
                    // 弱レア役
                    else {
                        unitCountButtonVerticalWithoutRatio(
                         title: "弱レア役",
                         count: $enen.dendoshaCountJakuRare,
                         color: .personalSummerLightRed,
                         minusBool: $enen.minusCheck
                        )
                        unitCountButtonVerticalWithoutRatio(
                         title: "ボーナス当選",
                         count: $enen.dendoshaCountJakuRareHit,
                         color: .red,
                         minusBool: $enen.minusCheck
                        )
                    }
                }
                // 当選率結果
                VStack {
                    Text("[ボーナス当選率]")
                    HStack {
                        // 十字目変換
                        unitResultRatioPercent2Line(
                            title: "十字目変換",
                            count: $enen.dendoshaCountJujiHit,
                            bigNumber: $enen.dendoshaCountJuji,
                            numberofDicimal: 0
                        )
                        // 弱レア役
                        unitResultRatioPercent2Line(
                            title: "弱レア役",
                            count: $enen.dendoshaCountJakuRareHit,
                            bigNumber: $enen.dendoshaCountJakuRare,
                            numberofDicimal: 0
                        )
                    }
                }
                // 参考情報）ボーナス当選率
                unitLinkButtonViewBuilder(sheetTitle: "レア役からのボーナス当選率") {
                    VStack {
                        Text("・伝道者の影中の十字目変換、弱レア役からのボーナス当選率に設定差あり")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(spacing: 0) {
                            unitTableSettingIndex(settingList: [1,2,4,5,6])
                            unitTablePercent(
                                columTitle: "十字目変換",
                                percentList: enen.ratioDendoshaJuji
                            )
                            unitTablePercent(
                                columTitle: "弱レア役",
                                percentList: enen.ratioDendoshaJakuRare
                            )
                            unitTablePercent(
                                columTitle: "強🍒",
                                percentList: [71],
                                lineList: [5],
                                colorList: [.white],
                            )
                            unitTablePercent(
                                columTitle: "十字リプレイ",
                                percentList: [79],
                                lineList: [5],
                                colorList: [.white],
                            )
                        }
                    }
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        enenView95Ci(
                            enen: enen,
                            selection: 6,
                        )
                    )
                )
            } header: {
                HStack {
                    Text("ボーナス当選率")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "利用方法",
                            textBody1: "・十字目変換ボタンと弱レア役ボタンはそれぞれの小役出現ごとにカウントして下さい",
                            textBody2: "・ボーナス当選ボタンはそれぞれの小役契機のボーナス当選が確認できたらカウントして下さい",
                            textBody3: "・ボーナス当選回数 ÷ 小役出現回数から当選率を算出しています",
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
        .navigationTitle("伝道者の影")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $enen.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: enen.resetDendosha)
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
}

#Preview {
    enenViewDendosha(
        enen: Enen(),
    )
}
