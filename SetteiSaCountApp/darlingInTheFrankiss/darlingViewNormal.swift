//
//  darlingViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/27.
//

import SwiftUI

struct darlingViewNormal: View {
//    @ObservedObject var ver380: Ver380
//    @ObservedObject var ver390: Ver390
    @ObservedObject var darling: Darling
    @State var selectedSegment: String = "🍒"
    let segmentList: [String] = ["🍒", "チャンス目"]
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
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    
    var body: some View {
        List {
            // //// 小役関連
            Section {
                unitLinkButtonViewBuilder(
                    sheetTitle: "レア役停止系",
                    linkText: "レア役停止系",
                ) {
                        darlingTableKoyakuPattern()
                    }
            } header: {
                Text("小役")
            }
            
            // //// フランクス高確移行率
            Section {
                // 注意書き
                Text("高確集中状態での抽選はカウント対象外")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // セグメントピッカー
                Picker("", selection: self.$selectedSegment) {
                    ForEach(self.segmentList, id: \.self) { segment in
                        Text(segment)
                    }
                }
                .pickerStyle(.segmented)
//                .popoverTip(tipVer380DarlingKokaku())
                
                // カウントボタン横並び
                // チェリー
                if self.selectedSegment == self.segmentList[0] {
                    HStack {
                        // 移行なし
                        unitCountButtonWithoutRatioWithFunc(
                            title: "移行なし",
                            count: $darling.kokakuCountCherryMiss,
                            color: .personalSummerLightRed,
                            minusBool: $darling.minusCheck) {
                                darling.kokakuCountSumFunc()
                            }
                        // 移行あり
                        unitCountButtonWithoutRatioWithFunc(
                            title: "移行あり",
                            count: $darling.kokakuCountCherryHit,
                            color: .red,
                            minusBool: $darling.minusCheck) {
                                darling.kokakuCountSumFunc()
                            }
                    }
                }
                // チャンス目
                else {
                    HStack {
                        // 移行なし
                        unitCountButtonWithoutRatioWithFunc(
                            title: "移行なし",
                            count: $darling.kokakuCountChanceMiss,
                            color: .personalSummerLightPurple,
                            minusBool: $darling.minusCheck) {
                                darling.kokakuCountSumFunc()
                            }
                        // 移行あり
                        unitCountButtonWithoutRatioWithFunc(
                            title: "移行あり",
                            count: $darling.kokakuCountChanceHit,
                            color: .purple,
                            minusBool: $darling.minusCheck) {
                                darling.kokakuCountSumFunc()
                            }
                    }
                }
                // 結果横並び
                HStack {
                    // チェリー
                    unitResultRatioPercent2Line(
                        title: "🍒",
                        count: $darling.kokakuCountCherryHit,
                        bigNumber: $darling.kokakuCountCherrySum,
                        numberofDicimal: 0
                    )
                    // チャンス目
                    unitResultRatioPercent2Line(
                        title: "チャンス目",
                        count: $darling.kokakuCountChanceHit,
                        bigNumber: $darling.kokakuCountChanceSum,
                        numberofDicimal: 0
                    )
                }
                // 参考情報）フランクス高確移行率
                unitLinkButtonViewBuilder(sheetTitle: "フランクス高確移行率") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・高確集中状態を除く通常状態からの移行率に設定差")
                            Text("・🍒、チャンス目以外からでも稀に移行する")
                        }
                        .padding(.bottom)
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "🍒",
                                percentList: darling.ratioKokakuCherry
                            )
                            unitTablePercent(
                                columTitle: "チャンス目",
                                percentList: darling.ratioKokakuChance
                            )
                        }
                    }
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        darlingView95Ci(
                            darling: darling,
                            selection: 4,
                        )
                    )
                )
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    darlingViewBayes(
//                        ver390: ver390,
                        darling: darling,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("フランクス高確移行率")
            }
            
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
            
//            unitAdBannerMediumRectangle()
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver380.darlingMenuNormalBadge)
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
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $darling.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: darling.resetNormal)
                }
            }
        }
    }
}

#Preview {
    darlingViewNormal(
//        ver380: Ver380(),
//        ver390: Ver390(),
        darling: Darling(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
