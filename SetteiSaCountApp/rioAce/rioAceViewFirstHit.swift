//
//  rioAceViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/03.
//

import SwiftUI

struct rioAceViewFirstHit: View {
    @ObservedObject var rioAce: RioAce
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
            // 初当り
            Section {
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "通常ゲーム数",
                    inputValue: $rioAce.normalGame,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                
                // カウントボタン横並び
                HStack {
                    // ノワールルーム
                    unitCountButtonVerticalDenominate(
                        title: "ﾉﾜｰﾙﾙｰﾑ",
                        count: $rioAce.firstHitCountNoirRoom,
                        color: .personalSummerLightPurple,
                        bigNumber: $rioAce.normalGame,
                        numberofDicimal: 0,
                        minusBool: $rioAce.minusCheck
                    )
                    // 直撃ボーナス以外
                    unitCountButtonVerticalDenominate(
                        title: "直撃ﾎﾞﾅ以外",
                        count: $rioAce.firstHitCountWithoutDirect,
                        color: .personalSummerLightGreen,
                        bigNumber: $rioAce.normalGame,
                        numberofDicimal: 0,
                        minusBool: $rioAce.minusCheck
                    )
                    // 直撃ボーナス
                    unitCountButtonVerticalDenominate(
                        title: "直撃ﾎﾞｰﾅｽ",
                        count: $rioAce.firstHitCountDirectBonus,
                        color: .personalSummerLightRed,
                        bigNumber: $rioAce.normalGame,
                        numberofDicimal: 0,
                        minusBool: $rioAce.minusCheck
                    )
                }
                
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "ﾉﾜｰﾙﾙｰﾑ",
                            denominateList: rioAce.ratioFirstHitNoirRoom
                        )
                        unitTableDenominate(
                            columTitle: "直撃ﾎﾞｰﾅｽ以外",
                            denominateList: rioAce.ratioFirstHitWithoutDirect
                        )
                        unitTableDenominate(
                            columTitle: "直撃ﾎﾞｰﾅｽ",
                            denominateList: rioAce.ratioFirstHitDirectBonus
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        rioAceView95Ci(
                            rioAce: rioAce,
                            selection: 1,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    rioAceViewBayes(
                        rioAce: rioAce,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("初当り")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.rioAceMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: rioAce.machineName,
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
                unitButtonMinusCheck(minusCheck: $rioAce.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: rioAce.resetFirstHit)
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
    rioAceViewFirstHit(
        rioAce: RioAce(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
