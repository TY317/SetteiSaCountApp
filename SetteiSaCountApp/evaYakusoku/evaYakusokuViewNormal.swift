//
//  evaYakusokuViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/29.
//

import SwiftUI
//import GoogleMobileAds

struct evaYakusokuViewNormal: View {
//    @ObservedObject var ver380: Ver380
    @ObservedObject var evaYakusoku: EvaYakusoku
    @State var isShowAlert = false
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
    @EnvironmentObject var common: commonVar
    @State var selectedSegment: String = "小役カウント"
    let segmentList: [String] = ["小役カウント", "重複当選"]
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    
    var body: some View {
        List {
            // //// 小役関連
            Section {
                // //// セグメントピッカー
                Picker("", selection: self.$selectedSegment) {
                    ForEach(self.segmentList, id: \.self) { segment in
                        Text(segment)
                    }
                }
                .pickerStyle(.segmented)
                .popoverTip(tipVer3100EvaYakusokuNormal())
                // //// カウントボタン横並び
                let gridItem = Array(
                    repeating: GridItem(
                        .flexible(minimum: 80, maximum: 150),
                        spacing: 5,
                        alignment: .center,
                    ),
                    count: self.lazyVGridCount
                )
                LazyVGrid(columns: gridItem) {
                    // //// 小役カウント
                    if self.selectedSegment == self.segmentList[0] {
                        // ベル
                        unitCountButtonDenominateWithFunc(
                            title: "🔔",
                            count: $evaYakusoku.koyakuCountBell,
                            color: .personalSpringLightYellow,
                            bigNumber: $evaYakusoku.gameNumberPlay,
                            numberofDicimal: 2,
                            minusBool: $evaYakusoku.minusCheck,
                            flushColor: .yellow,
                            action: evaYakusoku.koyakuSumFunc
                        )
                        .padding(.bottom)
                        // チェリー
                        unitCountButtonDenominateWithFunc(
                            title: "🍒",
                            count: $evaYakusoku.koyakuCountCherry,
                            color: .personalSummerLightRed,
                            bigNumber: $evaYakusoku.gameNumberPlay,
                            numberofDicimal: 1,
                            minusBool: $evaYakusoku.minusCheck,
                            action: evaYakusoku.koyakuSumFunc
                        )
                        .padding(.bottom)
                        // スイカ
                        unitCountButtonDenominateWithFunc(
                            title: "弱🍉",
                            count: $evaYakusoku.koyakuCountSuikaJaku,
                            color: .personalSummerLightGreen,
                            bigNumber: $evaYakusoku.gameNumberPlay,
                            numberofDicimal: 1,
                            minusBool: $evaYakusoku.minusCheck,
                            action: evaYakusoku.koyakuSumFunc
                        )
                        .padding(.bottom)
                        // 強スイカ
                        unitCountButtonDenominateWithFunc(
                            title: "強🍉",
                            count: $evaYakusoku.koyakuCountSuikaKyo,
                            color: .personalSummerLightPurple,
                            bigNumber: $evaYakusoku.gameNumberPlay,
                            numberofDicimal: 1,
                            minusBool: $evaYakusoku.minusCheck,
                            action: evaYakusoku.koyakuSumFunc
                        )
                        .padding(.bottom)
                        // リーチ目役
                        unitCountButtonDenominateWithFunc(
                            title: "リーチ目役",
                            count: $evaYakusoku.koyakuCountReach,
                            color: .personalSummerLightBlue,
                            bigNumber: $evaYakusoku.gameNumberPlay,
                            numberofDicimal: 0,
                            minusBool: $evaYakusoku.minusCheck,
                            action: evaYakusoku.koyakuSumFunc
                        )
                        .padding(.bottom)
                    }
                    // //// 重複カウント
                    else {
                        // ベル
                        unitCountButtonVerticalPercent(
                            title: "🔔",
                            count: $evaYakusoku.chofukuCountBell,
                            color: .yellow,
                            bigNumber: $evaYakusoku.koyakuCountBell,
                            numberofDicimal: 2,
                            minusBool: $evaYakusoku.minusCheck
                        )
                        .padding(.bottom)
                        // チェリー
                        unitCountButtonVerticalPercent(
                            title: "🍒",
                            count: $evaYakusoku.chofukuCountCherry,
                            color: .red,
                            bigNumber: $evaYakusoku.koyakuCountCherry,
                            numberofDicimal: 0,
                            minusBool: $evaYakusoku.minusCheck
                        )
                        .padding(.bottom)
                        // 弱スイカ
                        unitCountButtonVerticalPercent(
                            title: "弱🍉",
                            count: $evaYakusoku.chofukuCountSuikaJaku,
                            color: .green,
                            bigNumber: $evaYakusoku.koyakuCountSuikaJaku,
                            numberofDicimal: 0,
                            minusBool: $evaYakusoku.minusCheck
                        )
                        .padding(.bottom)
                        // 強スイカ
                        unitCountButtonVerticalPercent(
                            title: "強🍉",
                            count: $evaYakusoku.chofukuCountSuikaKyo,
                            color: .purple,
                            bigNumber: $evaYakusoku.koyakuCountSuikaKyo,
                            numberofDicimal: 0,
                            minusBool: $evaYakusoku.minusCheck
                        )
                        .padding(.bottom)
                    }
                }
                // スイカ合算確率
                unitResultRatioDenomination2Line(
                    title: "🍉合算",
                    count: $evaYakusoku.koyakuCountSuikaSum,
                    bigNumber: $evaYakusoku.gameNumberPlay,
                    numberofDicimal: 1,
                )
                // 小役停止形
                unitLinkButton(
                    title: "小役停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "小役停止形",
                            tableView: AnyView(evaYakusokuTableKoyakuPattern())
                        )
                    )
                )
                // //// 参考情報）小役確率
                unitLinkButton(
                    title: "小役確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "小役確率",
                            tableView: AnyView(
                                evaYakusokuTableKoyakuRatio(
                                    evaYakusoku: evaYakusoku
                                )
                            )
                        )
                    )
                )
                // 重複確率
                unitLinkButtonViewBuilder(sheetTitle: "ボーナス重複当選率") {
                    evaYakusokuTableKoyakuChofuku(evaYakusoku: evaYakusoku)
                }
                // 95%信頼区間グラフ
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        evaYakusokuView95Ci(
                            evaYakusoku: evaYakusoku,
                            selection: 4,
                        )
                    )
                )
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    evaYakusokuViewBayes(
                        evaYakusoku: evaYakusoku,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                HStack {
                    Text("小役")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "小役、重複カウント",
                            textBody1: "・小役カウントでは小役成立ごとにカウントして下さい",
                            textBody2: "・重複当選ではボーナス重複当選ごとにカウントして下さい。小役のカウント数と重複回数から重複当選率を算出します",
                        )
                    }
                }
            }
            
            // //// ゲーム数入力
            Section {
                // //// ゲーム数入力
                // 打ち始め入力
                unitTextFieldNumberInputWithUnit(
                    title: "打ち始め",
                    inputValue: $evaYakusoku.gameNumberStart,
                    unitText: "Ｇ"
                )
                .focused(self.$isFocused)
                .onChange(of: evaYakusoku.gameNumberStart) {
                    let playGame = evaYakusoku.gameNumberCurrent - evaYakusoku.gameNumberStart
                    evaYakusoku.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // 現在入力
                unitTextFieldNumberInputWithUnit(
                    title: "現在",
                    inputValue: $evaYakusoku.gameNumberCurrent,
                    unitText: "Ｇ"
                )
                .focused(self.$isFocused)
                .onChange(of: evaYakusoku.gameNumberCurrent) {
                    let playGame = evaYakusoku.gameNumberCurrent - evaYakusoku.gameNumberStart
                    evaYakusoku.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // プレイ数
                unitTextGameNumberWithoutInput(
                    gameNumber: evaYakusoku.gameNumberPlay
                )
                
            } header: {
                Text("ゲーム数入力")
            }
            
            //            unitAdBannerMediumRectangle()
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.evaYakusokuMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: evaYakusoku.machineName,
                screenClass: screenClass
            )
        }
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
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // カウント値ダイレクト入力
                    unitToolbarButtonCountDirectInput(
                        inputView: {
                            // ベル
                            unitTextFieldNumberInputWithUnit(
                                title: "🔔",
                                inputValue: $evaYakusoku.koyakuCountBell
                            )
                            .focused(self.$isFocused)
                            // チェリー
                            unitTextFieldNumberInputWithUnit(
                                title: "🍒",
                                inputValue: $evaYakusoku.koyakuCountCherry
                            )
                            .focused(self.$isFocused)
//                            // 強弱スイカ
//                            unitTextFieldNumberInputWithUnit(
//                                title: "強弱🍉",
//                                inputValue: $evaYakusoku.koyakuCountSuikaSum
//                            )
//                            .focused(self.$isFocused)
                            // 弱スイカ
                            unitTextFieldNumberInputWithUnit(
                                title: "弱🍉",
                                inputValue: $evaYakusoku.koyakuCountSuikaJaku
                            )
                            .focused(self.$isFocused)
                            // 強弱スイカ
                            unitTextFieldNumberInputWithUnit(
                                title: "強🍉",
                                inputValue: $evaYakusoku.koyakuCountSuikaKyo
                            )
                            .focused(self.$isFocused)
                            // リーチ目役
                            unitTextFieldNumberInputWithUnit(
                                title: "リーチ目役",
                                inputValue: $evaYakusoku.koyakuCountReach
                            )
                            .focused(self.$isFocused)
                            // 暴走リプレイ
                            unitTextFieldNumberInputWithUnit(
                                title: "暴走リプレイ",
                                inputValue: $evaYakusoku.koyakuCountBoso
                            )
                            .focused(self.$isFocused)
                        },
                        focus: $isFocused
                    )
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $evaYakusoku.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: evaYakusoku.resetNormal)
                }
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
    evaYakusokuViewNormal(
//        ver380: Ver380(),
        evaYakusoku: EvaYakusoku(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
