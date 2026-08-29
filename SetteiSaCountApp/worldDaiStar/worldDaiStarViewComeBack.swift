//
//  worldDaiStarViewComeBack.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct worldDaiStarViewComeBack: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var worldDaiStar: WorldDaiStar
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
            // ---- 上位ST後
            Section {
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "移行率",
                    count: $worldDaiStar.comeBackCountHit,
                    bigNumber: $worldDaiStar.comeBackCountSum,
                    numberofDicimal: 0
                )
                
                // 参考情報）移行率
                unitLinkButtonViewBuilder(sheetTitle: "上位ST後の引き戻しゾーン移行率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "移行率",
                            percentList: worldDaiStar.ratioComeBack
                        )
                    }
                }
                
                // カウント
                DisclosureGroup {
                    HStack {
                        // 移行なし
                        unitCountButtonWithoutRatioWithFunc(
                            title: "移行なし",
                            count: $worldDaiStar.comeBackCountMiss,
                            color: .personalSummerLightBlue,
                            minusBool: $worldDaiStar.minusCheck) {
                                worldDaiStar.comeBackSumFunc()
                            }
                        // 移行あり
                        unitCountButtonWithoutRatioWithFunc(
                            title: "移行あり",
                            count: $worldDaiStar.comeBackCountHit,
                            color: .personalSummerLightRed,
                            minusBool: $worldDaiStar.minusCheck) {
                                worldDaiStar.comeBackSumFunc()
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            worldDaiStarView95Ci(
                                worldDaiStar: worldDaiStar,
                                selection: 4,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        worldDaiStarViewBayes(
                            worldDaiStar: worldDaiStar,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
                .popoverTip(tipVer450WorldDaiStarComeBack())
            } header: {
                Text("上位ST後の引き戻しゾーン移行率")
            }

        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.worldDaiStarMenuComeBackBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: worldDaiStar.machineName,
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
                unitButtonMinusCheck(minusCheck: $worldDaiStar.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: worldDaiStar.resetComeBack)
            }
        }
    }
}

#Preview {
    worldDaiStarViewComeBack(
        worldDaiStar: WorldDaiStar(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
