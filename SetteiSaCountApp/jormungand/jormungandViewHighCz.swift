//
//  jormungandViewHighCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/30.
//

import SwiftUI

struct jormungandViewHighCz: View {
    @ObservedObject var jormungand: Jormungand
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
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    var body: some View {
        List {
            // ---- 突入時の成功抽選
            Section {
                // 注意書き
                unitLabelCautionText {
                    Text("自力での成功はカウント除外")
                }
                
                // カウントボタン横並び
                HStack {
                    // 失敗
                    unitCountButtonWithoutRatioWithFunc(
                        title: "失敗",
                        count: $jormungand.highCzCountMiss,
                        color: .personalSummerLightBlue,
                        minusBool: $jormungand.minusCheck) {
                            jormungand.highCzSumFunc()
                        }
                    // 成功
                    unitCountButtonWithoutRatioWithFunc(
                        title: "成功",
                        count: $jormungand.highCzCountHit,
                        color: .personalSummerLightRed,
                        minusBool: $jormungand.minusCheck) {
                            jormungand.highCzSumFunc()
                        }
                }
                
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "成功率",
                    count: $jormungand.highCzCountHit,
                    bigNumber: $jormungand.highCzCountSum,
                    numberofDicimal: 0
                )
                
                // 参考情報）突入時の成功率
                unitLinkButtonViewBuilder(sheetTitle: "突入時の成功率") {
                    Text("・恥の世紀突入時に成功抽選しており、当選率に設定差")
                        .padding(.bottom)
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "成功率",
                            percentList: jormungand.ratioHighCzHit
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        jormungandView95Ci(
                            jormungand: jormungand,
                            selection: 7,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    jormungandViewBayes(
                        jormungand: jormungand,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
                
            } header: {
                Text("突入時の成功抽選")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.jormungandMenuHighCzBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: jormungand.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("恥の世紀")
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
                unitButtonMinusCheck(minusCheck: $jormungand.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: jormungand.resetHighCz)
            }
        }
    }
}

#Preview {
    jormungandViewHighCz(
        jormungand: Jormungand(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
