//
//  takosloViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct takosloViewNormal: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var takoslo: Takoslo
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
            // ---- 小役
            Section {
                // プラム確率
                unitResultRatioDenomination2Line(
                    title: "プラム確率",
                    count: $takoslo.koyakuCountPlum,
                    bigNumber: $takoslo.gameNumberPlay,
                    numberofDicimal: 1
                )

                // スイカ確率
                unitResultRatioDenomination2Line(
                    title: "スイカ確率",
                    count: $takoslo.koyakuCountSuika,
                    bigNumber: $takoslo.gameNumberPlay,
                    numberofDicimal: 0
                )

                // チェリー確率
                unitResultRatioDenomination2Line(
                    title: "チェリー確率",
                    count: $takoslo.koyakuCountCherry,
                    bigNumber: $takoslo.gameNumberPlay,
                    numberofDicimal: 0
                )

                // 参考情報）小役確率
                unitLinkButtonViewBuilder(sheetTitle: "小役確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex(settingList: [1,2,5,6])
                        unitTableDenominate(
                            columTitle: "プラム",
                            denominateList: takoslo.ratioKoyakuPlum,
                            numberofDicimal: 1,
                        )
                        unitTableDenominate(
                            columTitle: "スイカ",
                            denominateList: takoslo.ratioKoyakuSuika,
                            numberofDicimal: 0,
                        )
                        unitTableDenominate(
                            columTitle: "チェリー",
                            denominateList: takoslo.ratioKoyakuCherry,
                            numberofDicimal: 0,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    // カウントボタン横並び
                    HStack {
                        // プラム
                        unitCountButtonWithoutRatioWithFunc(
                            title: "プラム",
                            count: $takoslo.koyakuCountPlum,
                            color: .personalSummerLightBlue,
                            minusBool: $takoslo.minusCheck) {
                            }
                        // スイカ
                        unitCountButtonWithoutRatioWithFunc(
                            title: "スイカ",
                            count: $takoslo.koyakuCountSuika,
                            color: .personalSummerLightGreen,
                            minusBool: $takoslo.minusCheck) {
                            }
                        // チェリー
                        unitCountButtonWithoutRatioWithFunc(
                            title: "チェリー",
                            count: $takoslo.koyakuCountCherry,
                            color: .personalSummerLightRed,
                            minusBool: $takoslo.minusCheck) {
                            }
                    }

                    // ゲーム数入力
                    unitTextFieldNumberInputWithUnit(
                        title: "打ち始め",
                        inputValue: $takoslo.gameNumberStart,
                        unitText: "Ｇ",
                    )
                    .focused(self.$isFocused)
                    .onChange(of: takoslo.gameNumberStart) {
                        let playGame = takoslo.gameNumberCurrent - takoslo.gameNumberStart
                        takoslo.gameNumberPlay = playGame > 0 ? playGame : 0
                    }
                    unitTextFieldNumberInputWithUnit(
                        title: "現在",
                        inputValue: $takoslo.gameNumberCurrent,
                        unitText: "Ｇ",
                    )
                    .focused(self.$isFocused)
                    .onChange(of: takoslo.gameNumberCurrent) {
                        let playGame = takoslo.gameNumberCurrent - takoslo.gameNumberStart
                        takoslo.gameNumberPlay = playGame > 0 ? playGame : 0
                    }
                    unitTextGameNumberWithoutInput(gameNumber: takoslo.gameNumberPlay)

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            takosloView95Ci(
                                takoslo: takoslo,
                                selection: 1,
                            )
                        )
                    )
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("小役")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.takosloMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: takoslo.machineName,
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
                unitButtonMinusCheck(minusCheck: $takoslo.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: takoslo.resetNormal)
            }
        }
    }
}

#Preview {
    takosloViewNormal(
        takoslo: Takoslo(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
