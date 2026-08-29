//
//  yajikitaViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct yajikitaViewNormal: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var yajikita: Yajikita
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
            // ---- 温泉前兆移行率
            Section {
                // 移行率
                unitResultRatioPercent2Line(
                    title: "移行率",
                    count: $yajikita.onsenCountHit,
                    bigNumber: $yajikita.onsenCountSum,
                    numberofDicimal: 0,
                )

                // 参考情報）温泉前兆移行率
                unitLinkButtonViewBuilder(sheetTitle: "温泉前兆移行率") {
                    VStack(alignment: .leading) {
                        Text("・まいるチャージ4回以上かつ終了時に規定まいる到達なし")
                        Text("・関所チャレンジ本前兆突入時")
                        Text("に温泉前兆移行抽選")
                    }
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "温泉前兆移行率",
                            percentList: yajikita.ratioOnsen,
                            numberofDicimal: 1,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    // 注意書き
                    unitLabelCautionText {
                        Text("・まいるチャージ4回以上かつ終了時に規定まいる到達なし")
                        Text("・関所チャレンジ本前兆突入時")
                        Text("がカウント対象")
                    }
                    // カウントボタン横並び
                    HStack {
                        // 移行なし
                        unitCountButtonWithoutRatioWithFunc(
                            title: "移行なし",
                            count: $yajikita.onsenCountMiss,
                            color: .personalSummerLightBlue,
                            minusBool: $yajikita.minusCheck) {
                                yajikita.onsenSumFunc()
                            }
                        // 移行あり
                        unitCountButtonWithoutRatioWithFunc(
                            title: "移行あり",
                            count: $yajikita.onsenCountHit,
                            color: .personalSummerLightRed,
                            minusBool: $yajikita.minusCheck) {
                                yajikita.onsenSumFunc()
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            yajikitaView95Ci(
                                yajikita: yajikita,
                                selection: 4,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        yajikitaViewBayes(
                            yajikita: yajikita,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("温泉前兆移行率")
            }
            // レア役
            Section {
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    yajikitaTableKoyakuPattern()
                }
            } header: {
                Text("小役")
            }
            
            // モード
            Section {
                // 規定まいるテーブル
                unitLinkButtonViewBuilder(sheetTitle: "モードごとの規定まいるテーブル") {
                    yajikitaTableMileTable()
                }
                // モード移行振分け
                unitLinkButtonViewBuilder(sheetTitle: "モード移行振分け") {
                    yajikitaTableModeMoveRatio()
                }
            } header: {
                Text("モード")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.yajikitaMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: yajikita.machineName,
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
                unitButtonMinusCheck(minusCheck: $yajikita.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: yajikita.resetNormal)
            }
        }
    }
}

#Preview {
    yajikitaViewNormal(
        yajikita: Yajikita(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
