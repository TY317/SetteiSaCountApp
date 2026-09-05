//
//  kokakukidotaiViewAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/25.
//

import SwiftUI

struct kokakukidotaiViewAt: View {
    @ObservedObject var kokakukidotai: Kokakukidotai
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
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
    
    var body: some View {
        List {
            // 引き戻しストック
            Section {
                // 注意書き
                HStack {
                    Text("⚠️")
                    VStack(alignment: .leading) {
                        Text("・タチコマCZ成功時はストック1個確定のためカウント除外")
                        Text("・AT初当りの最初のREBOOTCHANCEが対象")
                        Text("・1G目ハズレでの成功or失敗をカウント")
                    }
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                }
                
                // カウントボタン横並び
                VStack {
                    Text("[1G目ハズレでの成功or失敗]")
                    HStack {
                        // 失敗
                        unitCountButtonPercentWithFunc(
                            title: "失敗",
                            count: $kokakukidotai.rebootCountMiss,
                            color: .personalSummerLightBlue,
                            bigNumber: $kokakukidotai.rebootCountSum,
                            numberofDicimal: 0,
                            minusBool: $kokakukidotai.minusCheck) {
                                kokakukidotai.rebootSumFunc()
                            }
                        // 成功
                        unitCountButtonPercentWithFunc(
                            title: "成功",
                            count: $kokakukidotai.rebootCountSuccess,
                            color: .personalSummerLightRed,
                            bigNumber: $kokakukidotai.rebootCountSum,
                            numberofDicimal: 0,
                            minusBool: $kokakukidotai.minusCheck) {
                                kokakukidotai.rebootSumFunc()
                            }
                    }
                }
                
                // 参考情報）成功ストック獲得率
                unitLinkButtonViewBuilder(sheetTitle: "成功ストック獲得率") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・⚠️タチコマCZ成功時はストック1個確定のためカウントから除外")
                            Text("・AT当選時に成功ストックを抽選")
                            Text("・成功ストックある場合は1G目に告知される")
                        }
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "成功ストック",
                                percentList: kokakukidotai.ratioReboot,
                                numberofDicimal: 1,
                            )
                        }
                        .padding(.bottom)
                        Text("[ストック個数振分け]")
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "1個",
                                percentList: [2.5,3.3,4.2,5,5.8,6.7],
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "2個",
                                percentList: [0.8,1.3,1.6,2.1,2.5,2.9],
                                numberofDicimal: 1,
                            )
                        }
                    }
                }
//                .popoverTip(tipVer3230KokakukidotaiReboot())
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        kokakukidotaiView95Ci(
                            kokakukidotai: kokakukidotai,
                            selection: 2,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    kokakukidotaiViewBayes(
                        kokakukidotai: kokakukidotai,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("REBOOTCHANCE成功ストック")
            }

            // ---- 上位裏AT突入率
            Section {
                // 突入率
                unitResultRatioPercent2Line(
                    title: "突入率",
                    count: $kokakukidotai.highAtCountHit,
                    bigNumber: $kokakukidotai.highAtCountSum,
                    numberofDicimal: 1
                )

                // 参考情報）上位裏AT突入率
                unitLinkButtonViewBuilder(sheetTitle: "上位裏AT突入率") {
                    VStack(alignment: .leading) {
                        Text("・上位AT突入時の上位裏AT突入に設定差")
                        Text("・突入時に画面がビリビリ、消化中に下パネ点滅が上位裏の特徴")
                        Text("・上位裏では全レア役で9th Personが発生")
                    }
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "上位裏AT突入率",
                            percentList: kokakukidotai.ratioHighAt,
                            numberofDicimal: 0,
                        )
                    }
                }
                .popoverTip(tipVer460KokakukidotaiHighAt())

                // カウント
                DisclosureGroup {
                    // カウントボタン横並び
                    HStack {
                        // 突入なし
                        unitCountButtonWithoutRatioWithFunc(
                            title: "突入なし",
                            count: $kokakukidotai.highAtCountMiss,
                            color: .personalSummerLightBlue,
                            minusBool: $kokakukidotai.minusCheck) {
                                kokakukidotai.highAtSumFunc()
                            }
                        // 突入
                        unitCountButtonWithoutRatioWithFunc(
                            title: "突入",
                            count: $kokakukidotai.highAtCountHit,
                            color: .personalSummerLightRed,
                            minusBool: $kokakukidotai.minusCheck) {
                                kokakukidotai.highAtSumFunc()
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            kokakukidotaiView95Ci(
                                kokakukidotai: kokakukidotai,
                                selection: 14,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        kokakukidotaiViewBayes(
                            kokakukidotai: kokakukidotai,
                            bayes: bayes,
                            viewModel: viewModel,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("上位裏AT突入率")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kokakukidotaiMenuAtBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kokakukidotai.machineName,
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
                unitButtonMinusCheck(minusCheck: $kokakukidotai.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: kokakukidotai.resetAt)
            }
        }
    }
}

#Preview {
    kokakukidotaiViewAt(
        kokakukidotai: Kokakukidotai(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
