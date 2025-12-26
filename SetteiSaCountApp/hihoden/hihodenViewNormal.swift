//
//  hihodenViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/13.
//

import SwiftUI

struct hihodenViewNormal: View {
    @ObservedObject var hihoden: Hihoden
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
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
    
    var body: some View {
        List {
            // //// レア役
            Section {
                Text("ダイトモを参考に入力して下さい")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "ゲーム数",
                    inputValue: $hihoden.totalGame,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                // チェリー回数入力
                unitTextFieldNumberInputWithUnit(
                    title: "🍒",
                    inputValue: $hihoden.koyakuCountCherry,
                )
                .focused(self.$isFocused)
                
                // 確率結果
                unitResultRatioDenomination2Line(
                    title: "🍒",
                    count: $hihoden.koyakuCountCherry,
                    bigNumber: $hihoden.totalGame,
                    numberofDicimal: 0
                )
                
                // 参考情報）チェリー確率
                unitLinkButtonViewBuilder(
                    sheetTitle: "🍒確率") {
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTableDenominate(
                                columTitle: "🍒",
                                denominateList: hihoden.ratioKoyakuCherry
                            )
                        }
                    }
                // 参考情報）レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    hihodenTableKoyakuPattern()
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        hihodenView95Ci(
                            hihoden: hihoden,
                            selection: 1,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    hihodenViewBayes(
                        hihoden: hihoden,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("レア役")
            }
            
            // チャンス目からの高確率
            Section {
                // 注意書き
                Text("伝説モード中以外でカウントして下さい")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // カウントボタン横並び
                HStack {
                    // チャンス目成立
                    unitCountButtonVerticalWithoutRatio(
                        title: "チャンス目成立",
                        count: $hihoden.koyakuCountChance,
                        color: .personalSummerLightPurple,
                        minusBool: $hihoden.minusCheck
                    )
                    // チャンス目成立
                    unitCountButtonVerticalWithoutRatio(
                        title: "高確率当選",
                        count: $hihoden.chanceKokakuCount,
                        color: .personalSummerLightRed,
                        minusBool: $hihoden.minusCheck
                    )
                }
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "チャンス目からの高確率",
                    count: $hihoden.chanceKokakuCount,
                    bigNumber: $hihoden.koyakuCountChance,
                    numberofDicimal: 0
                )
                // 参考情報)チャンス目からの高確率
                unitLinkButtonViewBuilder(sheetTitle: "チャンス目からの高確当選率") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・否伝説モード中の高確率当選に設定差あり")
                            Text("・偶数設定ほど当選率が優遇")
                        }
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "高確率当選",
                                percentList: hihoden.ratioChanceKokaku
                            )
                        }
                    }
                }
                // 参考情報）高確率関連の注目ポイント
                unitLinkButtonViewBuilder(sheetTitle: "高確率関連の注目ポイント") {
                    VStack(alignment: .leading) {
                        Text("・否伝説モード中の突高確率(突入契機が謎の高確率)の当選率")
                        Text("・BB高確率が出てくるほど！？")
                        Text("・高確率失敗時に伝説モードへ突入するほど！？")
                        Text("・クレア高確率当選率＝設定5が最も入りやすい")
                    }
                }
                // 参考情報）伝説モード示唆演出
                unitLinkButtonViewBuilder(sheetTitle: "伝説モード示唆演出") {
                    hihodenTableLegendSisa()
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        hihodenView95Ci(
                            hihoden: hihoden,
                            selection: 4,
                        )
                    )
                )
                
            } header: {
                Text("チャンス目からの高確率")
            }
            
            // //// 設定示唆演出
            Section {
                // 秘宝ニュース
                unitLinkButtonViewBuilder(sheetTitle: "秘宝ニュース") {
                    hihodenTableHihoNews()
                }
            } header: {
                Text("設定示唆演出")
            }
            
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hihodenMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hihoden.machineName,
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
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $hihoden.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: hihoden.resetNormal)
            }
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button(action: {
                        isFocused = false
                    }, label: {
                        Text("完了")
                            .fontWeight(.bold)
                    })
                }
            }
        }
    }
}

#Preview {
    hihodenViewNormal(
        hihoden: Hihoden(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
