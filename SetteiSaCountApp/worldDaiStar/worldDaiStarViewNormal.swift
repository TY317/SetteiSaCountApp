//
//  worldDaiStarViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct worldDaiStarViewNormal: View {
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
            Section {
                // レア役停止形
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    VStack(alignment: .leading) {
                        Text("・レア役はチャンス目のみ")
                        Text("・カバネリ、ToLOVEると同じ")
                    }
                }
            } header: {
                Text("小役")
            }
            
            // ---- モード
            Section {
                // 規定G数
                unitLinkButtonViewBuilder(sheetTitle: "規定G数消化時の抽選") {
                    worldDaiStarTableKiteiGame()
                }
                
                // ラッキーモード
                unitLinkButtonViewBuilder(sheetTitle: "ラッキーモード") {
                    worldDaiStarTableLuckyMode()
                }

                // 参考情報）ST終了時のラッキーモード移行率
                unitLinkButtonViewBuilder(sheetTitle: "ST終了時のラッキーモード移行率") {
                    VStack(spacing: 20) {
                        Text("・高設定ほどラッキーモード移行率が優遇")
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "基本",
                                percentList: worldDaiStar.ratioLuckyModeOther,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "ST駆け抜け時",
                                percentList: worldDaiStar.ratioLuckyModeStThrough,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "上位ST後",
                                percentList: worldDaiStar.ratioLuckyModeAfterHighSt,
                                numberofDicimal: 1,
                            )
                        }
                    }
                }
                .popoverTip(tipVer470WorldDaiStarLuckyMode())
            } header: {
                Text("規定G数、モード")
            }

        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.worldDaiStarMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: worldDaiStar.machineName,
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
                unitButtonMinusCheck(minusCheck: $worldDaiStar.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: worldDaiStar.resetNormal)
            }
        }
    }
}

#Preview {
    worldDaiStarViewNormal(
        worldDaiStar: WorldDaiStar(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
