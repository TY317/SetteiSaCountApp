//
//  streetFighter6ViewContinue.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct streetFighter6ViewContinue: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var streetFighter6: StreetFighter6
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
            // ---- ベル・リプレイでの成功率
            Section {
                // 成功率
                unitResultRatioPercent2Line(
                    title: "成功率",
                    count: $streetFighter6.continueBellReplayCountHit,
                    bigNumber: $streetFighter6.continueBellReplayCountSum,
                    numberofDicimal: 0
                )
                .popoverTip(tipVer470StreetFighter6Continue())

                // 参考情報）ベル・リプレイでの成功率
                unitLinkButtonViewBuilder(sheetTitle: "ベル・リプレイでの成功率") {
                    VStack(spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("・コンティニューチャンス中のベル、リプレイでの成功率が高設定ほど優遇")
                            Text("・レア役（狙え）は全設定で成功するためカウント対象外")
                        }
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "ベル・リプレイ",
                                percentList: streetFighter6.ratioContinueBellReplay,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "レア役 狙え",
                                percentList: [streetFighter6.ratioContinueRare[0]],
                                numberofDicimal: 0,
                                lineList: [6],
                                colorList: [.white]
                            )
                        }
                    }
                }

                // カウント
                DisclosureGroup {
                    // カウントボタン横並び
                    HStack {
                        // ベル成立
                        unitCountButtonWithoutRatioWithFunc(
                            title: "ベル成立",
                            count: $streetFighter6.continueBellReplayCountBell,
                            color: .personalSpringLightYellow,
                            minusBool: $streetFighter6.minusCheck) {
                                streetFighter6.continueBellReplaySumFunc()
                            }
                        // リプレイ成立
                        unitCountButtonWithoutRatioWithFunc(
                            title: "リプレイ成立",
                            count: $streetFighter6.continueBellReplayCountReplay,
                            color: .personalSummerLightBlue,
                            minusBool: $streetFighter6.minusCheck) {
                                streetFighter6.continueBellReplaySumFunc()
                            }
                        // 成功（成立の内数なので分母は変えない）
                        unitCountButtonWithoutRatioWithFunc(
                            title: "成功",
                            count: $streetFighter6.continueBellReplayCountHit,
                            color: .personalSummerLightRed,
                            minusBool: $streetFighter6.minusCheck) {
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            streetFighter6View95Ci(
                                streetFighter6: streetFighter6,
                                selection: 4,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        streetFighter6ViewBayes(
                            streetFighter6: streetFighter6,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("ベル・リプレイでの成功率")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.streetFighter6MenuContinueBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: streetFighter6.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("コンティニューチャンス")
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
                unitButtonMinusCheck(minusCheck: $streetFighter6.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: streetFighter6.resetContinue)
            }
        }
    }
}

#Preview {
    streetFighter6ViewContinue(
        streetFighter6: StreetFighter6(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
