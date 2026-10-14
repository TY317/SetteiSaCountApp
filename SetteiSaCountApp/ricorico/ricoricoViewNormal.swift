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
    // 短縮天井のゲーム数選択
    let tanshukuSegmentList: [String] = ["250G", "400G", "600G"]
    @State var tanshukuSelected: String = "250G"
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
            
            // ---- 弱リコリス目の変換高確移行率
            Section {
                // 移行率
                unitResultRatioPercent2Line(
                    title: "移行率",
                    count: $ricorico.jakuRicoHenkanCount,
                    bigNumber: $ricorico.jakuRicoCount,
                    numberofDicimal: 0
                )

                // 参考情報）弱リコリス目の変換高確移行率
                unitLinkButtonViewBuilder(sheetTitle: "弱リコリス目の変換高確移行率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "移行率",
                            percentList: ricorico.ratioJakuRicoHenkan,
                            numberofDicimal: 0,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    // カウントボタン横並び
                    HStack {
                        // 弱リコリス目
                        unitCountButtonWithoutRatioWithFunc(
                            title: "弱リコリス目",
                            count: $ricorico.jakuRicoCount,
                            color: .personalSummerLightBlue,
                            minusBool: $ricorico.minusCheck) {
                            }
                        // 高確移行
                        unitCountButtonWithoutRatioWithFunc(
                            title: "高確移行",
                            count: $ricorico.jakuRicoHenkanCount,
                            color: .personalSummerLightRed,
                            minusBool: $ricorico.minusCheck) {
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            ricoricoView95Ci(
                                ricorico: ricorico,
                                selection: 11,
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
                Text("弱リコリス目の変換高確移行率")
            }
            .popoverTip(tipVer490RicoricoTanshuku())

            // ---- 150G 変換高確移行
            Section {
                // 移行率
                unitResultRatioPercent2Line(
                    title: "移行率",
                    count: $ricorico.henkan150GCountHit,
                    bigNumber: $ricorico.henkan150GCountSum,
                    numberofDicimal: 0
                )
//                .popoverTip(tipVer480RicoricoHenkan150G())

                // 参考情報）150G 変換高確移行
                unitLinkButtonViewBuilder(sheetTitle: "150G 変換高確移行") {
                    Text("・150Gでの移行のみ設定差あり")
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

            // ---- 400G到達時のCZ当選率
            Section {
                // 当選率
                unitResultRatioPercent2Line(
                    title: "当選率",
                    count: $ricorico.cz400GCountHit,
                    bigNumber: $ricorico.cz400GCountSum,
                    numberofDicimal: 0
                )
//                .popoverTip(tipVer480RicoricoCz400G())

                // 参考情報）400G到達時のCZ当選率
                unitLinkButtonViewBuilder(sheetTitle: "400G到達時のCZ当選率") {
                    Text("・400G到達時のCZ当選率に設定差あり")
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "当選率",
                            percentList: ricorico.ratioCz400G,
                            numberofDicimal: 0,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    // カウントボタン横並び
                    HStack {
                        // 非当選
                        unitCountButtonWithoutRatioWithFunc(
                            title: "非当選",
                            count: $ricorico.cz400GCountMiss,
                            color: .personalSummerLightBlue,
                            minusBool: $ricorico.minusCheck) {
                                ricorico.cz400GSumFunc()
                            }
                        // 当選
                        unitCountButtonWithoutRatioWithFunc(
                            title: "当選",
                            count: $ricorico.cz400GCountHit,
                            color: .personalSummerLightRed,
                            minusBool: $ricorico.minusCheck) {
                                ricorico.cz400GSumFunc()
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            ricoricoView95Ci(
                                ricorico: ricorico,
                                selection: 6,
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
                Text("400G到達時のCZ当選率")
            }

            // ---- 短縮天井
            Section {
                // 確率横並び
                HStack {
                    // 250G
                    unitResultRatioPercent2Line(
                        title: "250G",
                        count: $ricorico.tanshuku250GCountHit,
                        bigNumber: $ricorico.tanshuku250GCountSum,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                    // 400G
                    unitResultRatioPercent2Line(
                        title: "400G",
                        count: $ricorico.tanshuku400GCountHit,
                        bigNumber: $ricorico.tanshuku400GCountSum,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                    // 600G
                    unitResultRatioPercent2Line(
                        title: "600G",
                        count: $ricorico.tanshuku600GCountHit,
                        bigNumber: $ricorico.tanshuku600GCountSum,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)

                // 参考情報）短縮天井
                unitLinkButtonViewBuilder(sheetTitle: "ラッシュ50終了時 短縮天井") {
                    VStack(alignment: .leading) {
                        Text("・高設定ほどラッシュ50終了時の短縮天井振分けが優遇")
                        Text("・短縮天井時はCZ最終遊技での告知、または復活告知が発生")
                        Text("・最終遊技より前に当選した場合は短縮かどうかの見分けは難しい")
                    }
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "250G",
                            percentList: ricorico.ratioTanshuku250G,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "400G",
                            percentList: ricorico.ratioTanshuku400G,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "600G",
                            percentList: ricorico.ratioTanshuku600G,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "750G",
                            percentList: [ricorico.ratioTanshuku750G[0]],
                            numberofDicimal: 1,
                            lineList: [6],
                            colorList: [.white]
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    // 注意書き
                    unitLabelCautionText {
                        Text("・短縮時はCZ最終ゲームでの告知or復活")
                        Text("・最終ゲームより前に自力成功した場合は見抜けないためカウント除外")
                    }
                    // セグメントピッカー
                    Picker("", selection: self.$tanshukuSelected) {
                        ForEach(self.tanshukuSegmentList, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.segmented)

                    // カウントボタン横並び
                    HStack {
                        if self.tanshukuSelected == self.tanshukuSegmentList[0] {
                            // 天井なし
                            unitCountButtonWithoutRatioWithFunc(
                                title: "天井なし",
                                count: $ricorico.tanshuku250GCountMiss,
                                color: .personalSummerLightBlue,
                                minusBool: $ricorico.minusCheck) {
                                    ricorico.tanshuku250GSumFunc()
                                }
                            // 天井あり
                            unitCountButtonWithoutRatioWithFunc(
                                title: "天井あり",
                                count: $ricorico.tanshuku250GCountHit,
                                color: .blue,
                                minusBool: $ricorico.minusCheck) {
                                    ricorico.tanshuku250GSumFunc()
                                }
                        }
                        else if self.tanshukuSelected == self.tanshukuSegmentList[1] {
                            // 天井なし
                            unitCountButtonWithoutRatioWithFunc(
                                title: "天井なし",
                                count: $ricorico.tanshuku400GCountMiss,
                                color: .personalSummerLightGreen,
                                minusBool: $ricorico.minusCheck) {
                                    ricorico.tanshuku400GSumFunc()
                                }
                            // 天井あり
                            unitCountButtonWithoutRatioWithFunc(
                                title: "天井あり",
                                count: $ricorico.tanshuku400GCountHit,
                                color: .green,
                                minusBool: $ricorico.minusCheck) {
                                    ricorico.tanshuku400GSumFunc()
                                }
                        }
                        else if self.tanshukuSelected == self.tanshukuSegmentList[2] {
                            // 天井なし
                            unitCountButtonWithoutRatioWithFunc(
                                title: "天井なし",
                                count: $ricorico.tanshuku600GCountMiss,
                                color: .personalSummerLightRed,
                                minusBool: $ricorico.minusCheck) {
                                    ricorico.tanshuku600GSumFunc()
                                }
                            // 天井あり
                            unitCountButtonWithoutRatioWithFunc(
                                title: "天井あり",
                                count: $ricorico.tanshuku600GCountHit,
                                color: .red,
                                minusBool: $ricorico.minusCheck) {
                                    ricorico.tanshuku600GSumFunc()
                                }
                        }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            ricoricoView95Ci(
                                ricorico: ricorico,
                                selection: 8 + (self.tanshukuSegmentList.firstIndex(of: self.tanshukuSelected) ?? 0),
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
                Text("短縮天井")
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
