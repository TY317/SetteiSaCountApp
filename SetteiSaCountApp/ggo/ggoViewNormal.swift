//
//  ggoViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ggoViewNormal: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var ggo: Ggo
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
            // ---- 天国選択率
            Section {
                // 天国選択率
                unitResultRatioPercent2Line(
                    title: "天国選択率",
                    count: $ggo.modeHeavenCountHit,
                    bigNumber: $ggo.modeHeavenCountSum,
                    numberofDicimal: 0
                )

                // 参考情報）天国選択率
                unitLinkButtonViewBuilder(sheetTitle: "天国選択率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "天国選択率",
                            percentList: ggo.ratioModeHeaven,
                            numberofDicimal: 0,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    // 情報
                    Text("・100Gや150G付近で流星ステージに移行した場合は天国濃厚")
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                    // カウントボタン横並び
                    HStack {
                        // 天国なし
                        unitCountButtonWithoutRatioWithFunc(
                            title: "天国なし",
                            count: $ggo.modeHeavenCountMiss,
                            color: .personalSummerLightBlue,
                            minusBool: $ggo.minusCheck) {
                                ggo.modeHeavenSumFunc()
                            }
                        // 天国あり
                        unitCountButtonWithoutRatioWithFunc(
                            title: "天国あり",
                            count: $ggo.modeHeavenCountHit,
                            color: .personalSummerLightRed,
                            minusBool: $ggo.minusCheck) {
                                ggo.modeHeavenSumFunc()
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            ggoView95Ci(
                                ggo: ggo,
                                selection: 4,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        ggoViewBayes(
                            ggo: ggo,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("天国選択率")
            }
            
            // レア役
            Section {
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    ggoTableKoyakuPattern()
                }
            } header: {
                Text("小役")
            }

            // ---- 通常モード
            Section {
                // 参考情報）モードごとのゾーン期待度
                unitLinkButtonViewBuilder(sheetTitle: "モードごとのゾーン期待度") {
                    ggoTableModeZone()
                }
            } header: {
                Text("通常モード")
            }

            
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.ggoMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ggo.machineName,
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
                unitButtonMinusCheck(minusCheck: $ggo.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: ggo.resetNormal)
            }
        }
    }
}

#Preview {
    ggoViewNormal(
        ggo: Ggo(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
