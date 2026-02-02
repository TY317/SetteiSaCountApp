//
//  tekken6ViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/31.
//

import SwiftUI

struct tekken6ViewNormal: View {
    @ObservedObject var tekken6: Tekken6
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @State var selectedItem: String = "弱🍒・🍉・チャンス目"
    let itemList: [String] = ["弱🍒・🍉・チャンス目", "強🍒"]
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 200.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 200.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    
    var body: some View {
        List {
            // ----- レア役
            Section {
                // セグメントピッカー
                Picker("", selection: self.$selectedItem) {
                    ForEach(self.itemList, id: \.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.segmented)
                .popoverTip(tipVer3180tekken6RareDirect())
                
                // カウントボタン横並び
                HStack {
                    // 弱レア
                    if self.selectedItem == self.itemList[0] {
                        // 弱🍒
                        unitCountButtonWithoutRatioWithFunc(
                            title: "弱🍒",
                            count: $tekken6.rareDirectCountJakuCherry,
                            color: .personalSummerLightRed,
                            minusBool: $tekken6.minusCheck) {
                                tekken6.jakuRareSumFunc()
                            }
                        // 🍉
                        unitCountButtonWithoutRatioWithFunc(
                            title: "🍉",
                            count: $tekken6.rareDirectCountSuika,
                            color: .personalSummerLightGreen,
                            minusBool: $tekken6.minusCheck) {
                                tekken6.jakuRareSumFunc()
                            }
                        // チャンス目
                        unitCountButtonWithoutRatioWithFunc(
                            title: "ﾁｬﾝｽ目",
                            count: $tekken6.rareDirectCountChance,
                            color: .personalSummerLightPurple,
                            minusBool: $tekken6.minusCheck) {
                                tekken6.jakuRareSumFunc()
                            }
                        // 直撃
                        unitCountButtonWithoutRatioWithFunc(
                            title: "直撃",
                            count: $tekken6.rareDirectCountJakuHit,
                            color: .personalSummerLightBlue,
                            minusBool: $tekken6.minusCheck) {
                                tekken6.jakuRareSumFunc()
                            }
                    }
                    // 強チェリー
                    else {
                        // 強🍒
                        unitCountButtonWithoutRatioWithFunc(
                            title: "強🍒",
                            count: $tekken6.rareDirectCountKyoCherry,
                            color: .red,
                            minusBool: $tekken6.minusCheck) {
                                tekken6.jakuRareSumFunc()
                            }
                        // 直撃
                        unitCountButtonWithoutRatioWithFunc(
                            title: "直撃",
                            count: $tekken6.rareDirectCountKyoHit,
                            color: .blue,
                            minusBool: $tekken6.minusCheck) {
                                tekken6.jakuRareSumFunc()
                            }
                    }
                }
                
                // 確率結果
                HStack {
                    // 弱レア役
                    unitResultRatioPercent2Line(
                        title: "弱レア役",
                        count: $tekken6.rareDirectCountJakuHit,
                        bigNumber: $tekken6.rareDirectCountJakuSum,
                        numberofDicimal: 1
                    )
                    // 弱レア役
                    unitResultRatioPercent2Line(
                        title: "強🍒",
                        count: $tekken6.rareDirectCountKyoHit,
                        bigNumber: $tekken6.rareDirectCountKyoCherry,
                        numberofDicimal: 1
                    )
                }
                
                // 参考情報
                unitLinkButtonViewBuilder(sheetTitle: "ボーナス直撃確率") {
                    tekken6TableRareDirect(tekken6: tekken6)
                }
                
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    tekken6TableKoyakuPattern()
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        tekken6View95Ci(
                            tekken6: tekken6,
                            selection: 5,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    tekken6ViewBayes(
                        tekken6: tekken6,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("レア役からのボーナス直撃")
            }
            
            // ---- モード
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "通常時のモード") {
                    tekkenTableMode()
                }
            } header: {
                Text("通常時のモード")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.tekken6MenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: tekken6.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $tekken6.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: tekken6.resetNormal)
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
    tekken6ViewNormal(
        tekken6: Tekken6(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
