//
//  tekken6ViewBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/31.
//

import SwiftUI

struct tekken6ViewBonus: View {
    @ObservedObject var tekken6: Tekken6
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
            // 赤7ビッグ開始時のエピソード
            Section {
                // カウントボタン横並び
                HStack {
                    // なし
                    unitCountButtonPercentWithFunc(
                        title: "なし",
                        count: $tekken6.episodeCountNone,
                        color: .personalSummerLightBlue,
                        bigNumber: $tekken6.episodeCountSum,
                        numberofDicimal: 0,
                        minusBool: $tekken6.minusCheck) {
                            tekken6.episodeSumFunc()
                        }
                    // あり
                    unitCountButtonPercentWithFunc(
                        title: "あり",
                        count: $tekken6.episodeCountHit,
                        color: .personalSummerLightRed,
                        bigNumber: $tekken6.episodeCountSum,
                        numberofDicimal: 0,
                        minusBool: $tekken6.minusCheck) {
                            tekken6.episodeSumFunc()
                        }
                }
                
                // 参考情報）エピソード発生率
                unitLinkButtonViewBuilder(sheetTitle: "エピソード発生率") {
                    VStack {
                        Text("・通常時の赤7ビッグボーナス開始時のエピソード発生率に設定差あり")
                            .padding(.bottom)
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "発生率",
                                percentList: tekken6.ratioEpisode
                            )
                        }
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        tekken6View95Ci(
                            tekken6: tekken6,
                            selection: 7,
                        )
                    )
                )
            } header: {
                Text("赤7ビッグ開始時のエピソード")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.tekken6MenuBonusBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: tekken6.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時のボーナス")
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
                unitButtonMinusCheck(minusCheck: $tekken6.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: tekken6.resetBonus)
            }
        }
    }
}

#Preview {
    tekken6ViewBonus(
        tekken6: Tekken6(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
