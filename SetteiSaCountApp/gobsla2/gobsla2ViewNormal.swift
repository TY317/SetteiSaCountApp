//
//  gobsla2ViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/23.
//

import SwiftUI

struct gobsla2ViewNormal: View {
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
    
    var body: some View {
        List {
            // ---- 弱レア役からのCZ当選
            Section {
                // 注意書き
                unitLabelCautionText {
                    Text("履歴内にレア役なし時がカウント対象")
                    Text("（履歴内にレア役2個以上になった場合は別抽選）")
                }
                
                // カウントボタン横並び
                HStack {
                    // 弱チェリー
                    unitCountButtonWithoutRatioWithFunc(
                        title: "弱🍒",
                        count: $gobsla2.jakuRareCountJakuCherry,
                        color: .personalSummerLightRed,
                        minusBool: $gobsla2.minusCheck) {
                            gobsla2.normalSumFunc()
                        }
                    // スイカ
                    unitCountButtonWithoutRatioWithFunc(
                        title: "🍉",
                        count: $gobsla2.jakuRareCountSuika,
                        color: .personalSummerLightGreen,
                        minusBool: $gobsla2.minusCheck) {
                            gobsla2.normalSumFunc()
                        }
                    // CZ当選
                    unitCountButtonWithoutRatioWithFunc(
                        title: "CZ当選",
                        count: $gobsla2.jakuRareCountHit,
                        color: .personalSummerLightPurple,
                        minusBool: $gobsla2.minusCheck) {
                            gobsla2.normalSumFunc()
                        }
                }
                
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "CZ当選",
                    count: $gobsla2.jakuRareCountHit,
                    bigNumber: $gobsla2.jakuRareCountSum,
                    numberofDicimal: 1,
                )
                
                // 参考情報）弱レア役からのCZ当選
                unitLinkButtonViewBuilder(sheetTitle: "弱レア役からのCZ当選") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "CZ当選",
                            percentList: gobsla2.ratioJakuRareCZ,
                            numberofDicimal: 1,
                        )
                    }
                }
                
                // 参考情報）レア役
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    VStack {
                        Text("・全リールフリー打ち＆液晶リール判断でOK")
                            .padding(.bottom)
                        VStack(alignment: .leading) {
                            Text("弱🍒：🍒1or2個停止")
                            Text("強🍒：🍒3個停止")
                            Text("🍉：🍉3個停止")
                        }
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        gobsla2View95Ci(
                            gobsla2: gobsla2,
                            selection: 1,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    gobsla2ViewBayes(
                        gobsla2: gobsla2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("弱レア役からのCZ当選")
            }
            
            // ---- 300or500G到達時の当選
            Section {
                // カウントボタン横並び
                HStack {
                    // ハズレ
                    unitCountButtonPercentWithFunc(
                        title: "ハズレ",
                        count: $gobsla2.game35HitCountMiss,
                        color: .personalSummerLightBlue,
                        bigNumber: $gobsla2.game35HitCountSum,
                        numberofDicimal: 0,
                        minusBool: $gobsla2.minusCheck) {
                            gobsla2.game35SumFunc()
                        }
                    // 当選
                    unitCountButtonPercentWithFunc(
                        title: "当選",
                        count: $gobsla2.game35HitCountHit,
                        color: .personalSummerLightRed,
                        bigNumber: $gobsla2.game35HitCountSum,
                        numberofDicimal: 0,
                        minusBool: $gobsla2.minusCheck) {
                            gobsla2.game35SumFunc()
                        }
                }
                
                // 参考情報）300・500G到達時の当選率
                unitLinkButtonViewBuilder(sheetTitle: "300・500G到達時のCZ当選率") {
                    VStack {
                        Text("・AT間300・500G消化時にCZ抽選があり高設定ほど当選率が優遇")
                            .padding(.bottom)
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "CZ当選",
                                percentList: gobsla2.ratio35Hit,
                                numberofDicimal: 1,
                            )
                        }
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        gobsla2View95Ci(
                            gobsla2: gobsla2,
                            selection: 2,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    gobsla2ViewBayes(
                        gobsla2: gobsla2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("300・500G到達時のCZ当選")
            }
            
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.gobsla2MenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: gobsla2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
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
                unitButtonMinusCheck(minusCheck: $gobsla2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: gobsla2.resetNormal)
            }
        }
    }
}

#Preview {
    gobsla2ViewNormal(
        gobsla2: Gobsla2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
