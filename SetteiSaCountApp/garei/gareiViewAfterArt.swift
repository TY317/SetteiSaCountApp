//
//  gareiViewAfterArt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct gareiViewAfterArt: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var garei: Garei
    @State var isShowDestination: Bool = false
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
            // ---- 高確スタート
            Section {
                // 状態別の振分け
                HStack {
                    // 高確
                    unitResultRatioPercent2Line(
                        title: "高確",
                        count: $garei.startStatusCountHigh,
                        bigNumber: $garei.startStatusCountSum,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                    // 超高確
                    unitResultRatioPercent2Line(
                        title: "超高確",
                        count: $garei.startStatusCountSuperHigh,
                        bigNumber: $garei.startStatusCountSum,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)

                // 参考情報）高確スタート
                unitLinkButtonViewBuilder(sheetTitle: "高確スタート確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "高確",
                            percentList: garei.ratioStartStatusHigh,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "超高確",
                            percentList: garei.ratioStartStatusSuperHigh,
                            numberofDicimal: 1,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    // カウントボタン横並び
                    HStack {
                        // 通常
                        unitCountButtonWithoutRatioWithFunc(
                            title: "通常",
                            count: $garei.startStatusCountNormal,
                            color: .personalSummerLightBlue,
                            minusBool: $garei.minusCheck) {
                                garei.startStatusSumFunc()
                            }
                        // 高確
                        unitCountButtonWithoutRatioWithFunc(
                            title: "高確",
                            count: $garei.startStatusCountHigh,
                            color: .personalSummerLightGreen,
                            minusBool: $garei.minusCheck) {
                                garei.startStatusSumFunc()
                            }
                        // 超高確
                        unitCountButtonWithoutRatioWithFunc(
                            title: "超高確",
                            count: $garei.startStatusCountSuperHigh,
                            color: .personalSummerLightRed,
                            minusBool: $garei.minusCheck) {
                                garei.startStatusSumFunc()
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            gareiView95Ci(
                                garei: garei,
                                selection: 14,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        gareiViewBayes(
                            garei: garei,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("高確スタート")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.gareiMenuAfterArtBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: garei.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("ART終了後")
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
                unitButtonMinusCheck(minusCheck: $garei.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: garei.resetAfterArt)
            }
        }
    }
}

#Preview {
    gareiViewAfterArt(
        garei: Garei(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
