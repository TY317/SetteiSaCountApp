//
//  enenViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/15.
//

import SwiftUI

struct enenViewNormal: View {
//    @ObservedObject var ver391: Ver391
    @ObservedObject var enen: Enen
    @State var isShowAlert = false
    let segmentList: [String] = ["十字目変換", "強🍒"]
    @State var selectedSegment: String = "十字目変換"
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
    let maxWidth2: CGFloat = 60
    let maxWidth3: CGFloat = .infinity
    let maxWidth4: CGFloat = .infinity
    let maxWidth5: CGFloat = 60
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    
    var body: some View {
        List {
            // //// 小役関連
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形", linkText: "レア役停止形") {
                    enenTableKoyakuPattern()
                }
            } header: {
                Text("レア役")
            }
            
            // //// モード
            Section {
                // 朝一モード
                unitLinkButtonViewBuilder(sheetTitle: "朝一モード") {
                    enenTableModeMorning()
                }
                // 朝一モード
                unitLinkButtonViewBuilder(sheetTitle: "通常時モード") {
                    enenTableModeNormal()
                }
            } header: {
                Text("規定ゲーム数モード")
            }
            
            // //// レア役からのボーナス当選率
            Section {
                // セグメントピッカー
                Picker("", selection: self.$selectedSegment) {
                    ForEach(self.segmentList, id: \.self) { seg in
                        Text(seg)
                    }
                }
                .pickerStyle(.segmented)
                // カウントボタン
                // 十字目変換
                if self.selectedSegment == self.segmentList[0] {
                    HStack {
                        // 十字目変換
                        unitCountButtonVerticalWithoutRatio(
                            title: "十字目変換",
                            count: $enen.rareBonusCountJuji,
                            color: .personalSummerLightGreen,
                            minusBool: $enen.minusCheck
                        )
                        // ボーナス当選
                        unitCountButtonVerticalWithoutRatio(
                            title: "ボーナス当選",
                            count: $enen.rareBonusCountJujiHit,
                            color: .green,
                            minusBool: $enen.minusCheck
                        )
                    }
                }
                // 強チェリー
                else {
                    HStack {
                        // 強チェリー
                        unitCountButtonVerticalWithoutRatio(
                            title: "強🍒",
                            count: $enen.rareBonusCountKyoCherry,
                            color: .personalSummerLightRed,
                            minusBool: $enen.minusCheck
                        )
                        // 強チェリー
                        unitCountButtonVerticalWithoutRatio(
                            title: "ボーナス当選",
                            count: $enen.rareBonusCountKyoCherryHit,
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
                            count: $enen.rareBonusCountJujiHit,
                            bigNumber: $enen.rareBonusCountJuji,
                            numberofDicimal: 0
                        )
                        // 強🍒
                        unitResultRatioPercent2Line(
                            title: "強🍒",
                            count: $enen.rareBonusCountKyoCherryHit,
                            bigNumber: $enen.rareBonusCountKyoCherry,
                            numberofDicimal: 0
                        )
                    }
                }
                // 参考情報）ボーナス当選率
                unitLinkButtonViewBuilder(sheetTitle: "レア役からのボーナス当選率") {
                    VStack {
                        Text("・通常字の十字目変換、強🍒からのボーナス当選率に設定差あり")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(spacing: 0) {
                            unitTableSettingIndex(settingList: [1,2,4,5,6])
                            unitTablePercent(
                                columTitle: "十字目変換",
                                percentList: enen.ratioRareBonusJuji
                            )
                            unitTablePercent(
                                columTitle: "強🍒",
                                percentList: enen.ratioRareBonusKyoCherry
                            )
                            unitTablePercent(
                                columTitle: "十字目リプレイ",
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
                            selection: 1,
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
                    Text("レア役からのボーナス当選率")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "利用方法",
                            textBody1: "・十字目変換ボタンと強チェリーボタンはそれぞれの小役出現ごとにカウントして下さい",
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
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $enen.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: enen.resetNormal)
                }
            }
        }
    }
}

#Preview {
    enenViewNormal(
//        ver391: Ver391(),
        enen: Enen(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
