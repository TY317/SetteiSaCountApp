//
//  ricoricoViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ricoricoViewNormal: View {
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
            // ---- 共通ベル
            Section {
                // 共通ベル確率
                unitResultRatioDenomination2Line(
                    title: "共通🔔確率",
                    count: $ricorico.commonBellCount,
                    bigNumber: $ricorico.gameNumberPlay,
                    numberofDicimal: 1
                )

                // 参考情報）共通ベル
                unitLinkButtonViewBuilder(sheetTitle: "共通ベル") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "共通🔔",
                            denominateList: ricorico.ratioCommonBell,
                            numberofDicimal: 1,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    // カウントボタン
                    HStack {
                        // 共通🔔
                        unitCountButtonWithoutRatioWithFunc(
                            title: "共通🔔",
                            count: $ricorico.commonBellCount,
                            color: .personalSpringLightYellow,
                            minusBool: $ricorico.minusCheck,
                            flushColor: .yellow,
                        ) { }
                    }
                    
                    // 打ち始め
                    unitTextFieldNumberInputWithUnit(
                        title: "打ち始め",
                        inputValue: $ricorico.gameNumberStart,
                        unitText: "Ｇ",
                    )
                    .focused(self.$isFocused)
                    .onChange(of: ricorico.gameNumberStart) {
                        let playGame = ricorico.gameNumberCurrent - ricorico.gameNumberStart
                        ricorico.gameNumberPlay = playGame > 0 ? playGame : 0
                    }
                    // 現在
                    unitTextFieldNumberInputWithUnit(
                        title: "現在",
                        inputValue: $ricorico.gameNumberCurrent,
                        unitText: "Ｇ",
                    )
                    .focused(self.$isFocused)
                    .onChange(of: ricorico.gameNumberCurrent) {
                        let playGame = ricorico.gameNumberCurrent - ricorico.gameNumberStart
                        ricorico.gameNumberPlay = playGame > 0 ? playGame : 0
                    }
                    // プレイ数
                    unitTextGameNumberWithoutInput(gameNumber: ricorico.gameNumberPlay)

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            ricoricoView95Ci(
                                ricorico: ricorico,
                                selection: 4,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        ricoricoViewBayes(
                            ricorico: ricorico,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("共通ベル")
            }

            // ---- 150G 変換高確移行
            Section {
                // 移行率
                unitResultRatioPercent2Line(
                    title: "移行率",
                    count: $ricorico.henkan150GCountHit,
                    bigNumber: $ricorico.henkan150GCountSum,
                    numberofDicimal: 0
                )
                .popoverTip(tipVer480RicoricoHenkan150G())

                // 参考情報）150G 変換高確移行
                unitLinkButtonViewBuilder(sheetTitle: "150G 変換高確移行") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "移行率",
                            percentList: ricorico.ratioHenkan150G,
                            numberofDicimal: 0,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    // カウントボタン横並び
                    HStack {
                        // 移行なし
                        unitCountButtonWithoutRatioWithFunc(
                            title: "移行なし",
                            count: $ricorico.henkan150GCountMiss,
                            color: .personalSummerLightBlue,
                            minusBool: $ricorico.minusCheck) {
                                ricorico.henkan150GSumFunc()
                            }
                        // 移行あり
                        unitCountButtonWithoutRatioWithFunc(
                            title: "移行あり",
                            count: $ricorico.henkan150GCountHit,
                            color: .personalSummerLightRed,
                            minusBool: $ricorico.minusCheck) {
                                ricorico.henkan150GSumFunc()
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            ricoricoView95Ci(
                                ricorico: ricorico,
                                selection: 5,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        ricoricoViewBayes(
                            ricorico: ricorico,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("150G 変換高確移行")
            }
            
            // レア役
            Section {
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    ricoricoTableKoyakuPattern()
                }
            } header: {
                Text("小役")
            }
            
            // 規定ゲーム数
            Section {
                // 規定ゲーム数
                unitLinkButtonViewBuilder(sheetTitle: "ゲーム数 期待度テーブル") {
                    ricoricoTableGameTable()
                }
            } header: {
                Text("規定ゲーム数")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.ricoricoMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ricorico.machineName,
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
                unitButtonMinusCheck(minusCheck: $ricorico.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: ricorico.resetNormal)
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
    ricoricoViewNormal(
        ricorico: Ricorico(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
