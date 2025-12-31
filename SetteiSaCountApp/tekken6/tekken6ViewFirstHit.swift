//
//  tekken6ViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/31.
//

import SwiftUI

struct tekken6ViewFirstHit: View {
    @ObservedObject var tekken6: Tekken6
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
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
                Text("スロプラNEXTを参考に入力して下さい")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "通常ゲーム数",
                    inputValue: $tekken6.normalGame,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                // カウントボタン横並び
                HStack {
                    // CZ
                    unitCountButtonVerticalWithoutRatio(
                        title: "CZ",
                        count: $tekken6.firstHitCountCz,
                        color: .personalSummerLightGreen,
                        minusBool: $tekken6.minusCheck
                    )
                    // 青７
                    unitCountButtonWithoutRatioWithFunc(
                        title: "青7",
                        count: $tekken6.firstHitCountBonusBlue,
                        color: .personalSummerLightBlue,
                        minusBool: $tekken6.minusCheck) {
                            tekken6.bonusSumFunc()
                        }
                    // 赤７
                    unitCountButtonWithoutRatioWithFunc(
                        title: "赤7",
                        count: $tekken6.firstHitCountBonusRed,
                        color: .personalSummerLightRed,
                        minusBool: $tekken6.minusCheck) {
                            tekken6.bonusSumFunc()
                        }
                    // AT
                    unitCountButtonVerticalWithoutRatio(
                        title: "AT",
                        count: $tekken6.firstHitCountAt,
                        color: .personalSummerLightPurple,
                        minusBool: $tekken6.minusCheck
                    )
                }
                
                // 確率結果
                HStack {
                    // CZ
                    unitResultRatioDenomination2Line(
                        title: "CZ",
                        count: $tekken6.firstHitCountCz,
                        bigNumber: $tekken6.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // BIG
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        count: $tekken6.firstHitCountBonusSum,
                        bigNumber: $tekken6.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // AT
                    unitResultRatioDenomination2Line(
                        title: "AT",
                        count: $tekken6.firstHitCountAt,
                        bigNumber: $tekken6.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "CZ",
                            denominateList: tekken6.ratioFirstHitCz
                        )
                        unitTableDenominate(
                            columTitle: "ボーナス合算",
                            denominateList: tekken6.ratioFirstHitBonus
                        )
                        unitTableDenominate(
                            columTitle: "AT",
                            denominateList: tekken6.ratioFirstHitAt
                        )
                    }
                }
                
                // 参考情報）AT直撃確率
                unitLinkButtonViewBuilder(sheetTitle: "AT直撃確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "AT直撃",
                            denominateList: tekken6.ratioDirectAt
                        )
                    }
                }
                
                // 参考情報）エピソードボーナス発生率
                unitLinkButtonViewBuilder(sheetTitle: "エピソードボーナス発生率") {
                    VStack {
                        Text("・通常時の赤7ボーナス時のエピソードボーナス発生率に設定差あり")
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        tekken6View95Ci(
                            tekken6: tekken6,
                            selection: 1,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    tekken6ViewBayes(
                        tekken6: tekken6,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("初当り")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.tekken6MenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: tekken6.machineName,
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
                unitButtonMinusCheck(minusCheck: $tekken6.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: tekken6.resetFirstHit)
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
    tekken6ViewFirstHit(
        tekken6: Tekken6(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
