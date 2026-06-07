//
//  sao2ViewComeBack.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/07.
//

import SwiftUI

struct sao2ViewComeBack: View {
    @ObservedObject var sao2: Sao2
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
            Section {
                // 注意書き
                unitLabelCautionText {
                    Text("・引き戻し対象は50G")
                    Text("・50G目にレア役は引き戻し確定のためカウント除外")
                }
                
                // カウントボタン横並び
                HStack {
                    // 引き戻しなし
                    unitCountButtonWithoutRatioWithFunc(
                        title: "引き戻しなし",
                        count: $sao2.comeBackCountMiss,
                        color: .personalSummerLightBlue,
                        minusBool: $sao2.minusCheck) {
                            sao2.comeBackSumFunc()
                        }
                    // 引き戻し
                    unitCountButtonWithoutRatioWithFunc(
                        title: "引き戻し",
                        count: $sao2.comeBackCountHit,
                        color: .personalSummerLightRed,
                        minusBool: $sao2.minusCheck) {
                            sao2.comeBackSumFunc()
                        }
                }
                
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "引き戻し率",
                    count: $sao2.comeBackCountHit,
                    bigNumber: $sao2.comeBackCountSum,
                    numberofDicimal: 0
                )
                
                // 参考情報）引き戻し率
                unitLinkButtonViewBuilder(sheetTitle: "引き戻し率") {
                    VStack(spacing: 20) {
                        Text("・引き戻し率は高設定ほど優遇")
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "引き戻し率",
                                percentList: sao2.ratioComeBack
                            )
                        }
                    }
                }
            } header: {
                Text("引き戻し")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.sao2MenuComeBackBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: sao2.machineName,
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
                unitButtonMinusCheck(minusCheck: $sao2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: sao2.resetComeBack)
            }
        }
    }
}

#Preview {
    sao2ViewComeBack(
        sao2: Sao2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
