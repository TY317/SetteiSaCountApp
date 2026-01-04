//
//  tekken6ViewBack.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/31.
//

import SwiftUI

struct tekken6ViewBack: View {
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
            Section {
                // カウントボタン横並び
                HStack {
                    // 非当選
                    unitCountButtonPercentWithFunc(
                        title: "非当選",
                        count: $tekken6.backCountMiss,
                        color: .personalSummerLightBlue,
                        bigNumber: $tekken6.backCountSum,
                        numberofDicimal: 0,
                        minusBool: $tekken6.minusCheck) {
                            tekken6.backSumFunc()
                        }
                    // 当選
                    unitCountButtonPercentWithFunc(
                        title: "当選",
                        count: $tekken6.backCountHit,
                        color: .personalSummerLightRed,
                        bigNumber: $tekken6.backCountSum,
                        numberofDicimal: 0,
                        minusBool: $tekken6.minusCheck) {
                            tekken6.backSumFunc()
                        }
                }
                
                // 参考情報）引き戻し当選率
                unitLinkButtonViewBuilder(sheetTitle: "引き戻し当選率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "引き戻し",
                            percentList: tekken6.ratioBack
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        tekken6View95Ci(
                            tekken6: tekken6,
                            selection: 4,
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
                Text("引き戻し")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.tekken6MenuBackBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: tekken6.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("引き戻し")
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
                unitButtonReset(isShowAlert: $isShowAlert, action: tekken6.resetBack)
            }
        }
    }
}

#Preview {
    tekken6ViewBack(
        tekken6: Tekken6(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
