//
//  railgunViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/19.
//

import SwiftUI
import TipKit

struct railgunViewNormal: View {
    @ObservedObject var railgun: Railgun
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
    let itemList: [String] = ["🍒", "🍉"]
    @State var selectedItem: String = "🍒"
    
    var body: some View {
//        TipView(tipVer3140railgunNormal())
        List {
            // //// レア役
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    railgunTableKoyakuPattern()
                }
            } header: {
                Text("レア役")
            }
            
            // //// コイン揃いからのCZ
            Section {
                // カウントボタン横並び
                HStack {
                    // コイン揃い
                    unitCountButtonVerticalWithoutRatio(
                        title: "コイン揃い",
                        count: $railgun.coinCount,
                        color: .personalSummerLightBlue,
                        minusBool: $railgun.minusCheck
                    )
                    // CZ当選
                    unitCountButtonVerticalWithoutRatio(
                        title: "CZ当選",
                        count: $railgun.coinCountCzHit,
                        color: .personalSummerLightRed,
                        minusBool: $railgun.minusCheck
                    )
                }
                // CZ当選率
                unitResultRatioPercent2Line(
                    title: "CZ当選",
                    count: $railgun.coinCountCzHit,
                    bigNumber: $railgun.coinCount,
                    numberofDicimal: 0
                )
                // 参考情報）Cz当選率
                unitLinkButtonViewBuilder(sheetTitle: "コイン揃いからのCZ当選率") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・コイン準備状態移行時とコイン揃い時の2段階でCZ当選を抽選")
                            Text("・どちらで当選したかは見抜けないため、実質のCZ当選率のみ記載します")
                        }
                        .padding(.bottom)
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "実質CZ当選率",
                                percentList: railgun.ratioCoinCzHit
                            )
                        }
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        railgunView95Ci(
                            railgun: railgun,
                            selection: 1,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    railgunViewBayes(
                        railgun: railgun,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                HStack {
                    Text("コイン揃いからのCZ")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "コイン揃いからのCZ",
                            textBody1: "・コイン揃い回数とコイン揃いからのCZ当選回数をカウント",
                            textBody2: "・連続演出中のコイン揃いは演出の可能性あるためカウントから除外",
                        )
                    }
                }
            }
            
            // レア役からのコイン準備移行
            Section {
                // 注意書き
                Text("通常or高確準備滞在時の🍒、🍉が対象")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // ピッカー
                Picker("", selection: self.$selectedItem) {
                    ForEach(self.itemList, id: \.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.segmented)
                
                // カウントボタン横並び
                HStack {
                    // チェリー
                    if self.selectedItem == self.itemList[0] {
                        // チェリー成立
                        unitCountButtonVerticalWithoutRatio(
                            title: "🍒成立",
                            count: $railgun.rareCzCountCherry,
                            color: .personalSummerLightRed,
                            minusBool: $railgun.minusCheck
                        )
                        // コイン準備移行
                        unitCountButtonVerticalWithoutRatio(
                            title: "コイン準備移行",
                            count: $railgun.rareCzCountCherryHit,
                            color: .red,
                            minusBool: $railgun.minusCheck
                        )
                    }
                    
                    // スイカ成立
                    else {
                        // スイカ成立
                        unitCountButtonVerticalWithoutRatio(
                            title: "🍉成立",
                            count: $railgun.rareCzCountSuika,
                            color: .personalSummerLightGreen,
                            minusBool: $railgun.minusCheck
                        )
                        // コイン準備移行
                        unitCountButtonVerticalWithoutRatio(
                            title: "コイン準備移行",
                            count: $railgun.rareCzCountSuikaHit,
                            color: .green,
                            minusBool: $railgun.minusCheck
                        )
                    }
                }
                
                // 確率結果
                HStack {
                    // 🍒
                    unitResultRatioPercent2Line(
                        title: "🍒",
                        count: $railgun.rareCzCountCherryHit,
                        bigNumber: $railgun.rareCzCountCherry,
                        numberofDicimal: 0,
                    )
                    // 🍉
                    unitResultRatioPercent2Line(
                        title: "🍉",
                        count: $railgun.rareCzCountSuikaHit,
                        bigNumber: $railgun.rareCzCountSuika,
                        numberofDicimal: 0,
                    )
                }
                
                // 参考情報）レア役からのコイン準備移行率
                unitLinkButtonViewBuilder(sheetTitle: "レア役からのコイン準備移行率") {
                    railgunTableRareCz(railgun: railgun)
                }
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    railgunViewBayes(
                        railgun: railgun,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("レア役からのコイン準備移行率")
            }
            
            // //// 通常時のモード
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "通常時のモード") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・花火ステージ(超高確orコイン準備示唆)への移行ゲームを4つのモードで管理")
                            Text("・移行ゲームは花火シナリオによって管理")
                        }
                        .padding(.bottom)
                        railgunTableMode()
                    }
                }
            } header: {
                Text("通常時のモード")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.railgunMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: railgun.machineName,
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
                unitButtonMinusCheck(minusCheck: $railgun.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: railgun.resetNormal)
            }
        }
    }
}

#Preview {
    railgunViewNormal(
        railgun: Railgun(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
