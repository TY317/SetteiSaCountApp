//
//  gareiViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct gareiViewFirstHit: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var garei: Garei
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
    let lazyVGridCountPortrait: Int = 4
    let lazyVGridCountLandscape: Int = 6
    @State var lazyVGridCount: Int = 4
    var body: some View {
        List {
            // ゲーム数入力
            unitTextFieldNumberInputWithUnit(
                title: "通常ゲーム数",
                inputValue: $garei.normalGame,
                unitText: "Ｇ",
            )
            .focused(self.$isFocused)

            // カウントボタン横並び
            let gridItem = Array(
                repeating: GridItem(
                    .flexible(minimum: 80, maximum: 150),
                    spacing: 5,
                    alignment: .center,
                ),
                count: self.lazyVGridCount
            )
            LazyVGrid(columns: gridItem) {
                // CZ
                unitCountButtonVerticalDenominate(
                    title: "CZ",
                    count: $garei.firstHitCountCz,
                    color: .personalSummerLightGreen,
                    bigNumber: $garei.normalGame,
                    numberofDicimal: 0,
                    minusBool: $garei.minusCheck
                )
                .padding(.bottom)
                // BIG
                unitCountButtonVerticalDenominate(
                    title: "BIG",
                    count: $garei.firstHitCountBig,
                    color: .personalSummerLightRed,
                    bigNumber: $garei.normalGame,
                    numberofDicimal: 0,
                    minusBool: $garei.minusCheck
                )
                .padding(.bottom)
                // REG
                unitCountButtonVerticalDenominate(
                    title: "REG",
                    count: $garei.firstHitCountReg,
                    color: .personalSummerLightBlue,
                    bigNumber: $garei.normalGame,
                    numberofDicimal: 0,
                    minusBool: $garei.minusCheck
                )
                .padding(.bottom)
                // ART
                unitCountButtonVerticalDenominate(
                    title: "ART",
                    count: $garei.firstHitCountArt,
                    color: .personalSummerLightPurple,
                    bigNumber: $garei.normalGame,
                    numberofDicimal: 0,
                    minusBool: $garei.minusCheck
                )
                .padding(.bottom)
            }

            // 参考情報）初当り確率
            unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTableDenominate(
                        columTitle: "CZ",
                        denominateList: garei.ratioFirstHitCz
                    )
                    unitTableDenominate(
                        columTitle: "BIG",
                        denominateList: garei.ratioFirstHitBig
                    )
                    unitTableDenominate(
                        columTitle: "REG",
                        denominateList: garei.ratioFirstHitReg
                    )
                    unitTableDenominate(
                        columTitle: "ART",
                        denominateList: garei.ratioFirstHitArt
                    )
                }
//                HStack(spacing: 0) {
//                    unitTableSettingIndex()
//                    unitTableDenominate(
//                        columTitle: "REG",
//                        denominateList: garei.ratioFirstHitReg
//                    )
//                    unitTableDenominate(
//                        columTitle: "ART",
//                        denominateList: garei.ratioFirstHitArt
//                    )
//                }
            }

            // //// 95%信頼区間グラフへのリンク
            unitNaviLink95Ci(
                Ci95view: AnyView(
                    gareiView95Ci(
                        garei: garei,
                        selection: 8,
                    )
                )
            )

            // //// 設定期待値へのリンク
            unitNaviLinkBayes {
                gareiViewBayes(
                    garei: garei,
                )
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.gareiMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: garei.machineName,
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
                unitButtonMinusCheck(minusCheck: $garei.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: garei.resetFirstHit)
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
    gareiViewFirstHit(
        garei: Garei(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
