//
//  ricoricoViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ricoricoViewFirstHit: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var ricorico: Ricorico
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
            // ゲーム数入力
            unitTextFieldNumberInputWithUnit(
                title: "通常ゲーム数",
                inputValue: $ricorico.normalGame,
                unitText: "Ｇ",
            )
            .focused(self.$isFocused)

            // カウントボタン横並び
            HStack {
                // バトルCZ
                unitCountButtonDenominateWithFunc(
                    title: "バトルCZ",
                    count: $ricorico.firstHitCountBattleCz,
                    color: .personalSummerLightRed,
                    bigNumber: $ricorico.normalGame,
                    numberofDicimal: 0,
                    minusBool: $ricorico.minusCheck,
                    action: ricorico.firstHitCzSumFunc
                )
                // 幼少期CZ
                unitCountButtonDenominateWithFunc(
                    title: "幼少期CZ",
                    count: $ricorico.firstHitCountYoshokiCz,
                    color: .personalSummerLightPurple,
                    bigNumber: $ricorico.normalGame,
                    numberofDicimal: 0,
                    minusBool: $ricorico.minusCheck,
                    action: ricorico.firstHitCzSumFunc
                )
                // AT
                unitCountButtonDenominateWithFunc(
                    title: "AT",
                    count: $ricorico.firstHitCountAt,
                    color: .personalSummerLightBlue,
                    bigNumber: $ricorico.normalGame,
                    numberofDicimal: 0,
                    minusBool: $ricorico.minusCheck) {

                    }
            }

            // CZ合算
            unitResultRatioDenomination2Line(
                title: "CZ合算",
                count: $ricorico.firstHitCountCz,
                bigNumber: $ricorico.normalGame,
                numberofDicimal: 0
            )

            // 参考情報）初当り確率
            unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTableDenominate(
                        columTitle: "バトルCZ",
                        denominateList: ricorico.ratioFirstHitBattleCz
                    )
                    unitTableDenominate(
                        columTitle: "幼少期CZ",
                        denominateList: ricorico.ratioFirstHitYoshokiCz
                    )
                }
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTableDenominate(
                        columTitle: "CZ合算",
                        denominateList: ricorico.ratioFirstHitCz
                    )
                    unitTableDenominate(
                        columTitle: "AT",
                        denominateList: ricorico.ratioFirstHitAt
                    )
                }
            }
            .popoverTip(tipVer480RicoricoFirstHit())
            
            // 参考情報）AT直撃確率
            unitLinkButtonViewBuilder(sheetTitle: "AT直撃確率") {
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTableDenominate(
                        columTitle: "AT直撃",
                        denominateList: ricorico.ratioFirstHitAtDirect
                    )
                }
            }

            // //// 95%信頼区間グラフへのリンク
            unitNaviLink95Ci(
                Ci95view: AnyView(
                    ricoricoView95Ci(
                        ricorico: ricorico,
                        selection: 2,
                    )
                )
            )

            // //// 設定期待値へのリンク
            unitNaviLinkBayes {
                ricoricoViewBayes(
                    ricorico: ricorico,
                )
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.ricoricoMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ricorico.machineName,
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
                unitButtonMinusCheck(minusCheck: $ricorico.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: ricorico.resetFirstHit)
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
    ricoricoViewFirstHit(
        ricorico: Ricorico(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
