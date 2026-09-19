//
//  index2ViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct index2ViewFirstHit: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var index2: Index2
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
                inputValue: $index2.normalGame,
                unitText: "Ｇ",
            )
            .focused(self.$isFocused)

            // カウントボタン横並び
            HStack {
                // 超電磁砲CZ
                unitCountButtonDenominateWithFunc(
                    title: "超電磁砲CZ",
                    count: $index2.firstHitCountRailgunCz,
                    color: .personalSpringLightYellow,
                    bigNumber: $index2.normalGame,
                    numberofDicimal: 0,
                    minusBool: $index2.minusCheck,
                    action: index2.firstHitCzSumFunc
                )
                // 一方通行CZ
                unitCountButtonDenominateWithFunc(
                    title: "一方通行CZ",
                    count: $index2.firstHitCountAcceleratorCz,
                    color: .personalSummerLightPurple,
                    bigNumber: $index2.normalGame,
                    numberofDicimal: 0,
                    minusBool: $index2.minusCheck,
                    action: index2.firstHitCzSumFunc
                )
                // AT
                unitCountButtonDenominateWithFunc(
                    title: "AT",
                    count: $index2.firstHitCountAt,
                    color: .personalSummerLightRed,
                    bigNumber: $index2.normalGame,
                    numberofDicimal: 0,
                    minusBool: $index2.minusCheck) {

                    }
            }

            // CZ合算
            unitResultRatioDenomination2Line(
                title: "CZ合算",
                count: $index2.firstHitCountCz,
                bigNumber: $index2.normalGame,
                numberofDicimal: 0
            )
            .popoverTip(tipVer470Index2Cz())

            // 参考情報）初当り確率
            unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTableDenominate(
                        columTitle: "超電磁砲CZ",
                        denominateList: index2.ratioFirstHitRailgunCz,
                        numberofDicimal: 0,
                    )
                    unitTableDenominate(
                        columTitle: "一方通行CZ",
                        denominateList: index2.ratioFirstHitAcceleratorCz,
                        numberofDicimal: 0,
                    )
                    unitTableDenominate(
                        columTitle: "AT",
                        denominateList: index2.ratioFirstHitAt,
                        numberofDicimal: 0,
                    )
                }
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTableDenominate(
                        columTitle: "CZ合算",
                        denominateList: index2.ratioFirstHitCz,
                        numberofDicimal: 0,
                    )
                }
            }
            
            // 参考情報）直撃確率
            unitLinkButtonViewBuilder(sheetTitle: "AT直撃確率") {
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTableDenominate(
                        columTitle: "AT直撃",
                        denominateList: index2.ratioDirectAt
                    )
                }
            }

            // //// 95%信頼区間グラフへのリンク
            unitNaviLink95Ci(
                Ci95view: AnyView(
                    index2View95Ci(
                        index2: index2,
                        selection: 3,
                    )
                )
            )

            // //// 設定期待値へのリンク
            unitNaviLinkBayes {
                index2ViewBayes(
                    index2: index2,
                )
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.index2MenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: index2.machineName,
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
                unitButtonMinusCheck(minusCheck: $index2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: index2.resetFirstHit)
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
    index2ViewFirstHit(
        index2: Index2(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
