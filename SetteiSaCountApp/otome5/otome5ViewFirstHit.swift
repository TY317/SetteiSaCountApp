//
//  otome5ViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/03.
//

import SwiftUI

struct otome5ViewFirstHit: View {
    @ObservedObject var otome5: Otome5
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
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
            // ---- 初当り
            Section {
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "通常ゲーム数",
                    inputValue: $otome5.normalGame,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                
                // カウントボタン横並び
                HStack {
                    // AT
                    unitCountButtonVerticalDenominate(
                        title: "AT",
                        count: $otome5.firstHitCountAt,
                        color: .personalSummerLightRed,
                        bigNumber: $otome5.normalGame,
                        numberofDicimal: 0,
                        minusBool: $otome5.minusCheck
                    )
                    // 直撃ボーナス
                    unitCountButtonVerticalDenominate(
                        title: "直撃ボーナス",
                        count: $otome5.firstHitCountDirect,
                        color: .personalSummerLightPurple,
                        bigNumber: $otome5.normalGame,
                        numberofDicimal: 0,
                        minusBool: $otome5.minusCheck
                    )
                }
                
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "AT",
                            denominateList: otome5.ratioFirstHitAt
                        )
                        unitTableDenominate(
                            columTitle: "直撃ボーナス",
                            denominateList: otome5.ratioFirstHitDirect
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        otome5View95Ci(
                            otome5: otome5,
                            selection: 1,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    otome5ViewBayes(
                        otome5: otome5,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("初当り")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.otome5MenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: otome5.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("初当り")
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
                unitButtonMinusCheck(minusCheck: $otome5.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: otome5.resetFirstHit)
            }
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button(action: {
                        isFocused = false
                    }, label: {
                        Text("完了")
                            .fontWeight(.bold)
                    })
                }
            }
        }
    }
}

#Preview {
    otome5ViewFirstHit(
        otome5: Otome5(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
