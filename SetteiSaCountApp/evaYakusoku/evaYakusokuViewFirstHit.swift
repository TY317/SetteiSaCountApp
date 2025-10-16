//
//  evaYakusokuViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/29.
//

import SwiftUI

struct evaYakusokuViewFirstHit: View {
    @EnvironmentObject var common: commonVar
//    @ObservedObject var ver352: Ver352
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
    @State var lazyVGridCount: Int = 2
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    
    var body: some View {
        List {
            // //// ボーナス回数カウント
            Section {
                // 現在入力
                unitTextFieldNumberInputWithUnit(
                    title: "現在ゲーム数",
                    inputValue: $evaYakusoku.gameNumberCurrent,
                    unitText: "Ｇ"
                )
                .focused(self.$isFocused)
                .onChange(of: evaYakusoku.gameNumberCurrent) {
                    let playGame = evaYakusoku.gameNumberCurrent - evaYakusoku.gameNumberStart
                    evaYakusoku.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // //// カウントボタン横並び（ver3.5.2以降）
                let gridItem = Array(
                    repeating: GridItem(
                        .flexible(minimum: 80, maximum: 150),
                        spacing: 5,
                        alignment: .center,
                    ),
                    count: self.lazyVGridCount
                )
                LazyVGrid(columns: gridItem) {
                    // 黄BB
                    unitCountButtonDenominateWithFunc(
                        title: "黄BB",
                        count: $evaYakusoku.bonusCountBig,
                        color: .personalSpringLightYellow,
                        bigNumber: $evaYakusoku.gameNumberCurrent,
                        numberofDicimal: 0,
                        minusBool: $evaYakusoku.minusCheck,
                        action: evaYakusoku.bonusSumFunc
                    )
                    .padding(.bottom)
                    // 赤SBB
                    unitCountButtonDenominateWithFunc(
                        title: "赤SBB",
                        count: $evaYakusoku.bonusCountSBig,
                        color: .personalSummerLightRed,
                        bigNumber: $evaYakusoku.gameNumberCurrent,
                        numberofDicimal: 0,
                        minusBool: $evaYakusoku.minusCheck,
                        action: evaYakusoku.bonusSumFunc
                    )
                    .padding(.bottom)
                    // 青SBB
                    unitCountButtonDenominateWithFunc(
                        title: "青SBB",
                        count: $evaYakusoku.bonusCountSBigBlue,
                        color: .personalSummerLightBlue,
                        bigNumber: $evaYakusoku.gameNumberCurrent,
                        numberofDicimal: 0,
                        minusBool: $evaYakusoku.minusCheck,
                        action: evaYakusoku.bonusSumFunc
                    )
                    .padding(.bottom)
                    // REG
                    unitCountButtonDenominateWithFunc(
                        title: "REG",
                        count: $evaYakusoku.bonusCountReg,
                        color: .personalSummerLightGreen,
                        bigNumber: $evaYakusoku.gameNumberCurrent,
                        numberofDicimal: 0,
                        minusBool: $evaYakusoku.minusCheck,
                        action: evaYakusoku.bonusSumFunc
                    )
                    .padding(.bottom)
                    // 暴走
                    unitCountButtonDenominateWithFunc(
                        title: "暴走モード",
                        count: $evaYakusoku.koyakuCountBoso,
                        color: .personalSummerLightPurple,
                        bigNumber: $evaYakusoku.gameNumberCurrent,
                        numberofDicimal: 0,
                        minusBool: $evaYakusoku.minusCheck,
                        action: evaYakusoku.bonusSumFunc
                    )
                    .padding(.bottom)
                }
                // //// カウントボタン横並び
//                HStack {
//                    // BB
//                    unitCountButtonDenominateWithFunc(
//                        title: "BB",
//                        count: $evaYakusoku.bonusCountBig,
//                        color: .personalSpringLightYellow,
//                        bigNumber: $evaYakusoku.gameNumberPlay,
//                        numberofDicimal: 0,
//                        minusBool: $evaYakusoku.minusCheck,
//                        action: evaYakusoku.bonusSumFunc
//                    )
//                    // SBB
//                    unitCountButtonDenominateWithFunc(
//                        title: "SBB",
//                        count: $evaYakusoku.bonusCountSBig,
//                        color: .personalSummerLightRed,
//                        bigNumber: $evaYakusoku.gameNumberPlay,
//                        numberofDicimal: 0,
//                        minusBool: $evaYakusoku.minusCheck,
//                        action: evaYakusoku.bonusSumFunc
//                    )
//                    // REG
//                    unitCountButtonDenominateWithFunc(
//                        title: "REG",
//                        count: $evaYakusoku.bonusCountReg,
//                        color: .personalSummerLightBlue,
//                        bigNumber: $evaYakusoku.gameNumberPlay,
//                        numberofDicimal: 0,
//                        minusBool: $evaYakusoku.minusCheck,
//                        action: evaYakusoku.bonusSumFunc
//                    )
//                }
                // //// 確率結果横並び
                HStack {
//                    // BB合算
//                    unitResultRatioDenomination2Line(
//                        title: "BIG合算",
//                        count: $evaYakusoku.bonusCountBigSum,
//                        bigNumber: $evaYakusoku.gameNumberPlay,
//                        numberofDicimal: 0,
//                        spacerBool: false,
//                    )
//                    // REG
//                    unitResultRatioDenomination2Line(
//                        title: "REG",
//                        count: $evaYakusoku.bonusCountReg,
//                        bigNumber: $evaYakusoku.gameNumberPlay,
//                        numberofDicimal: 0,
//                        spacerBool: false,
//                    )
                    Spacer()
                    // 初当り合算
                    unitResultRatioDenomination2Line(
                        title: "初当り合算",
                        count: $evaYakusoku.bonusCountAllSum,
                        bigNumber: $evaYakusoku.gameNumberCurrent,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    Spacer()
                }
                // //// 参考情報）初当り確率
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(
                                evaYakusokuTableFirstHit(
                                    evaYakusoku: evaYakusoku
                                )
                            )
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        evaYakusokuView95Ci(
                            evaYakusoku: evaYakusoku,
                            selection: 1
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
                    Text("初当り")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "初当り",
                            textBody1: "・ゲーム数は現在の総ゲーム数を入力して下さい",
                            textBody2: "・前任者分含めた総ボーナス回数でカウントして下さい。台のメニュー画面で確認できます",
                        )
                    }
//                    .popoverTip(tipVer3100EvaFirstHit())
                }
            }
            
//            Section {
//                // //// ゲーム数入力
//                // 打ち始め入力
//                unitTextFieldNumberInputWithUnit(
//                    title: "打ち始め",
//                    inputValue: $evaYakusoku.gameNumberStart,
//                    unitText: "Ｇ"
//                )
//                .keyboardDoneToolbar(focus: self.$isFocused)
//                .onChange(of: evaYakusoku.gameNumberStart) {
//                    let playGame = evaYakusoku.gameNumberCurrent - evaYakusoku.gameNumberStart
//                    evaYakusoku.gameNumberPlay = playGame > 0 ? playGame : 0
//                }
//                // 現在入力
//                unitTextFieldNumberInputWithUnit(
//                    title: "現在",
//                    inputValue: $evaYakusoku.gameNumberCurrent,
//                    unitText: "Ｇ"
//                )
//                .focused(self.$isFocused)
//                .onChange(of: evaYakusoku.gameNumberCurrent) {
//                    let playGame = evaYakusoku.gameNumberCurrent - evaYakusoku.gameNumberStart
//                    evaYakusoku.gameNumberPlay = playGame > 0 ? playGame : 0
//                }
//                // プレイ数
//                unitTextGameNumberWithoutInput(
//                    gameNumber: evaYakusoku.gameNumberPlay
//                )
//                
//            } header: {
//                Text("ゲーム数入力")
//            }
            
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.evaYakusokuMenuFirstHitBadge)
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
        .navigationTitle("初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // カウント値直接入力
                    unitToolbarButtonCountDirectInput(
                        inputView: {
                            // BB
                            unitTextFieldNumberInputWithUnit(
                                title: "黄BB",
                                inputValue: $evaYakusoku.bonusCountBig
                            )
                            .focused($isFocused)
                            .onChange(of: evaYakusoku.bonusCountBig) {
                                evaYakusoku.bonusSumFunc()
                            }
                            // SBB
                            unitTextFieldNumberInputWithUnit(
                                title: "赤SBB",
                                inputValue: $evaYakusoku.bonusCountSBig,
                            )
                            .focused($isFocused)
                            .onChange(of: evaYakusoku.bonusCountSBig) {
                                evaYakusoku.bonusSumFunc()
                            }
                            // 青SBB
                            unitTextFieldNumberInputWithUnit(
                                title: "青SBB",
                                inputValue: $evaYakusoku.bonusCountSBigBlue,
                            )
                            .focused($isFocused)
                            .onChange(of: evaYakusoku.bonusCountSBig) {
                                evaYakusoku.bonusSumFunc()
                            }
                            // REG
                            unitTextFieldNumberInputWithUnit(
                                title: "REG",
                                inputValue: $evaYakusoku.bonusCountReg,
                            )
                            .focused($isFocused)
                            .onChange(of: evaYakusoku.bonusCountReg) {
                                evaYakusoku.bonusSumFunc()
                            }
                            // 暴走モード
                            unitTextFieldNumberInputWithUnit(
                                title: "暴走モード",
                                inputValue: $evaYakusoku.koyakuCountBoso,
                            )
                            .focused($isFocused)
                            .onChange(of: evaYakusoku.bonusCountReg) {
                                evaYakusoku.bonusSumFunc()
                            }
                        }, focus: self.$isFocused
                    )
                    // マイナスチェック
//                    unitButtonMinusCheck(minusCheck: $evaYakusoku.minusCheck)
                    // リセットボタン
//                    unitButtonReset(isShowAlert: $isShowAlert, action: evaYakusoku.resetFirstHit)
                }
            }
            ToolbarItem(placement: .automatic) {
                // マイナスチェック
                unitButtonMinusCheck(minusCheck: $evaYakusoku.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // リセットボタン
                unitButtonReset(isShowAlert: $isShowAlert, action: evaYakusoku.resetFirstHit)
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
    evaYakusokuViewFirstHit(
//        ver352: Ver352(),
        evaYakusoku: EvaYakusoku(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
