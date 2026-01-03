//
//  mushotenViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/03.
//

import SwiftUI

struct mushotenViewFirstHit: View {
    @ObservedObject var mushoten: Mushoten
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
            // ---- 初当り
            Section {
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "通常ゲーム数",
                    inputValue: $mushoten.normalGame,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                
                // カウントボタン横並び
                VStack {
                    VStack(alignment: .leading) {
                        Text("REG：魔術ボーナス")
                        Text("BIG：無職転生ボーナス")
                        Text("AT：異世界行ったら本気だす")
                    }
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                    HStack {
                        // 魔術ボーナス
                        unitCountButtonWithoutRatioWithFunc(
                            title: "REG",
                            count: $mushoten.firstHitCountReg,
                            color: .personalSummerLightBlue,
                            minusBool: $mushoten.minusCheck) {
                                mushoten.bonusSumFunc()
                            }
                        // 無職転生ボーナス
                        unitCountButtonWithoutRatioWithFunc(
                            title: "BIG",
                            count: $mushoten.firstHitCountBig,
                            color: .personalSummerLightGreen,
                            minusBool: $mushoten.minusCheck) {
                                mushoten.bonusSumFunc()
                            }
                        // AT
                        unitCountButtonVerticalWithoutRatio(
                            title: "AT",
                            count: $mushoten.firstHitCountAt,
                            color: .personalSummerLightRed,
                            minusBool: $mushoten.minusCheck
                        )
                    }
                }
                
                // 確率結果
                HStack {
                    // ボーナス合算
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        count: $mushoten.firstHitCountBonusSum,
                        bigNumber: $mushoten.normalGame,
                        numberofDicimal: 0
                    )
                    // AT
                    unitResultRatioDenomination2Line(
                        title: "AT",
                        count: $mushoten.firstHitCountAt,
                        bigNumber: $mushoten.normalGame,
                        numberofDicimal: 0
                    )
                }
                
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "ボーナス合算",
                            denominateList: mushoten.ratioFirstHitBonusSum
                        )
                        unitTableDenominate(
                            columTitle: "AT",
                            denominateList: mushoten.ratioFirstHitAt
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        mushotenView95Ci(
                            mushoten: mushoten,
                            selection: 3,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    mushotenViewBayes(
                        mushoten: mushoten,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("初当り")
            }
            
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.mushotenMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: mushoten.machineName,
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
                unitButtonMinusCheck(minusCheck: $mushoten.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: mushoten.resetFirstHit)
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
    mushotenViewFirstHit(
        mushoten: Mushoten(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
