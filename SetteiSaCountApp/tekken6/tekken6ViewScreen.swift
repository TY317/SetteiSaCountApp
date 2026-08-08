//
//  tekken6ViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/31.
//

import SwiftUI

struct tekken6ViewScreen: View {
    @ObservedObject var tekken6: Tekken6
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
            Section {
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "鉄拳チャンス赤",
                    count: $tekken6.chanceColorCountRed,
                    bigNumber: $tekken6.chanceColorCountSum,
                    numberofDicimal: 0
                )
                .popoverTip(tipVer430Tekken6ChanceColor())
                
                // 参考情報）鉄拳チャンス赤振分け
                unitLinkButtonViewBuilder(sheetTitle: "鉄拳チャンス赤 振分け") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "赤",
                            percentList: tekken6.ratioChanceColorRed
                        )
                    }
                }
                
                // カウント
                DisclosureGroup {
                    // カウントボタン横並び
                    HStack {
                        // 赤以外
                        unitCountButtonWithoutRatioWithFunc(
                            title: "赤以外",
                            count: $tekken6.chanceColorCountAnother,
                            color: .personalSummerLightBlue,
                            minusBool: $tekken6.minusCheck) {
                                tekken6.chanceSumFunc()
                            }
                        // 赤
                        unitCountButtonWithoutRatioWithFunc(
                            title: "赤",
                            count: $tekken6.chanceColorCountRed,
                            color: .personalSummerLightRed,
                            minusBool: $tekken6.minusCheck) {
                                tekken6.chanceSumFunc()
                            }
                    }
                    
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            tekken6View95Ci(
                                tekken6: tekken6,
                                selection: 8,
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
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("鉄拳チャンス色")
            }
            Section {
                tekken6TextScreenCaution()
                tekken6TableScreen()
//                    .popoverTip(tipVer3190TekkenScreen())
            } header: {
                Text("BIG終了画面")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.tekken6MenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: tekken6.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT中")
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
                unitButtonReset(isShowAlert: $isShowAlert, action: tekken6.resetDuringAt)
            }
        }
    }
}

#Preview {
    tekken6ViewScreen(
        tekken6: Tekken6(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
