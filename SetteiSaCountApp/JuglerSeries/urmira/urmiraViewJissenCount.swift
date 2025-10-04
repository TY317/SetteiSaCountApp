//
//  urmiraViewJissenCount.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/01.
//

import SwiftUI

struct urmiraViewJissenCount: View {
    @ObservedObject var urmira: Urmira
    @State var isShowAlert = false
    @FocusState var isFocused: Bool
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 300.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 300.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    
    var body: some View {
        List {
            // //// 小役、ボーナスカウント
            Section {
                // //// 横画面
                if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                    // //// 1段目
                    HStack {
                        // ぶどう
                        unitCountButtonVerticalDenominate(
                            title: "ぶどう",
                            count: $urmira.personalBellCount,
                            color: .personalSummerLightGreen,
                            bigNumber: $urmira.playGame,
                            numberofDicimal: 2,
                            minusBool: $urmira.minusCheck
                        )
                        // チェリー
                        unitCountButtonVerticalDenominate(
                            title: "🍒",
                            count: $urmira.personalCherryCount,
                            color: .personalSummerLightRed,
                            bigNumber: $urmira.playGame,
                            numberofDicimal: 1,
                            minusBool: $urmira.minusCheck
                        )
                    }
                    // //// カウントボタン
                    HStack {
//                        // ぶどう
//                        unitCountButtonVerticalDenominate(
//                            title: "ぶどう",
//                            count: $urmira.personalBellCount,
//                            color: .personalSummerLightGreen,
//                            bigNumber: $urmira.playGame,
//                            numberofDicimal: 2,
//                            minusBool: $urmira.minusCheck
//                        )
//                        // チェリー
//                        unitCountButtonVerticalDenominate(
//                            title: "🍒",
//                            count: $urmira.personalCherryCount,
//                            color: .personalSummerLightRed,
//                            bigNumber: $urmira.playGame,
//                            numberofDicimal: 1,
//                            minusBool: $urmira.minusCheck
//                        )
//                        // BIG
//                        unitCountButtonVerticalDenominate(
//                            title: "BIG",
//                            count: $urmira.personalBigCountSum,
//                            color: .personalSummerLightRed,
//                            bigNumber: $urmira.playGame,
//                            numberofDicimal: 0,
//                            minusBool: $urmira.minusCheck
//                        )
                        // 単独BIG
                        unitCountButtonVerticalDenominate(
                            title: "単独BIG",
                            count: $urmira.personalAloneBigCount,
                            color: .personalSummerLightRed,
                            bigNumber: $urmira.playGame,
                            numberofDicimal: 0,
                            minusBool: $urmira.minusCheck
                        )
                        // 🍒BIG
                        unitCountButtonVerticalDenominate(
                            title: "🍒BIG",
                            count: $urmira.personalCherryBigCount,
                            color: .personalSpringLightYellow,
                            bigNumber: $urmira.playGame,
                            numberofDicimal: 0,
                            minusBool: $urmira.minusCheck,
                            flushColor: .yellow
                        )
//                        // REG
//                        unitCountButtonVerticalDenominate(
//                            title: "REG",
//                            count: $urmira.personalRegCountSum,
//                            color: .personalSummerLightBlue,
//                            bigNumber: $urmira.playGame,
//                            numberofDicimal: 0,
//                            minusBool: $urmira.minusCheck
//                        )
                        // 単独REG
                        unitCountButtonVerticalDenominate(
                            title: "単独REG",
                            count: $urmira.personalAloneRegCount,
                            color: .personalSummerLightBlue,
                            bigNumber: $urmira.playGame,
                            numberofDicimal: 0,
                            minusBool: $urmira.minusCheck
                        )
                        // 🍒REG
                        unitCountButtonVerticalDenominate(
                            title: "🍒REG",
                            count: $urmira.personalCherryRegCount,
                            color: .personalSummerLightPurple,
                            bigNumber: $urmira.playGame,
                            numberofDicimal: 0,
                            minusBool: $urmira.minusCheck
                        )
                    }
                    // //// 結果
                    HStack {
                        // BIG合算
                        unitResultRatioDenomination2Line(
                            title: "BIG合算",
                            count: $urmira.personalBigCountSum,
                            bigNumber: $urmira.playGame,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // REG合算
                        unitResultRatioDenomination2Line(
                            title: "REG合算",
                            count: $urmira.personalRegCountSum,
                            bigNumber: $urmira.playGame,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
//                        Spacer()
                        // ボーナス合算
                        unitResultRatioDenomination2Line(
                            title: "ボーナス合算",
                            count: $urmira.personalBonusCountSum,
                            bigNumber: $urmira.playGame,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
//                        Spacer()
                    }
                }
                // //// 縦画面
                else {
                    // //// カウントボタン
                    // 1段目
                    HStack {
                        // ぶどう
                        unitCountButtonVerticalDenominate(
                            title: "ぶどう",
                            count: $urmira.personalBellCount,
                            color: .personalSummerLightGreen,
                            bigNumber: $urmira.playGame,
                            numberofDicimal: 2,
                            minusBool: $urmira.minusCheck
                        )
                        // チェリー
                        unitCountButtonVerticalDenominate(
                            title: "🍒",
                            count: $urmira.personalCherryCount,
                            color: .personalSummerLightRed,
                            bigNumber: $urmira.playGame,
                            numberofDicimal: 1,
                            minusBool: $urmira.minusCheck
                        )
//                        // BIG
//                        unitCountButtonVerticalDenominate(
//                            title: "BIG",
//                            count: $urmira.personalBigCountSum,
//                            color: .personalSummerLightRed,
//                            bigNumber: $urmira.playGame,
//                            numberofDicimal: 0,
//                            minusBool: $urmira.minusCheck
//                        )
//                        // REG
//                        unitCountButtonVerticalDenominate(
//                            title: "REG",
//                            count: $urmira.personalRegCountSum,
//                            color: .personalSummerLightBlue,
//                            bigNumber: $urmira.playGame,
//                            numberofDicimal: 0,
//                            minusBool: $urmira.minusCheck
//                        )
                    }
                    // 2段目
                    HStack {
                        // 単独BIG
                        unitCountButtonVerticalDenominate(
                            title: "単独BIG",
                            count: $urmira.personalAloneBigCount,
                            color: .personalSummerLightRed,
                            bigNumber: $urmira.playGame,
                            numberofDicimal: 0,
                            minusBool: $urmira.minusCheck
                        )
                        // 🍒BIG
                        unitCountButtonVerticalDenominate(
                            title: "🍒BIG",
                            count: $urmira.personalCherryBigCount,
                            color: .personalSpringLightYellow,
                            bigNumber: $urmira.playGame,
                            numberofDicimal: 0,
                            minusBool: $urmira.minusCheck,
                            flushColor: .yellow
                        )
                        // 単独REG
                        unitCountButtonVerticalDenominate(
                            title: "単独REG",
                            count: $urmira.personalAloneRegCount,
                            color: .personalSummerLightBlue,
                            bigNumber: $urmira.playGame,
                            numberofDicimal: 0,
                            minusBool: $urmira.minusCheck
                        )
                        // 🍒REG
                        unitCountButtonVerticalDenominate(
                            title: "🍒REG",
                            count: $urmira.personalCherryRegCount,
                            color: .personalSummerLightPurple,
                            bigNumber: $urmira.playGame,
                            numberofDicimal: 0,
                            minusBool: $urmira.minusCheck
                        )
                    }
                    // //// 結果
                    HStack {
                        // BIG合算
                        unitResultRatioDenomination2Line(
                            title: "BIG合算",
                            count: $urmira.personalBigCountSum,
                            bigNumber: $urmira.playGame,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // REG合算
                        unitResultRatioDenomination2Line(
                            title: "REG合算",
                            count: $urmira.personalRegCountSum,
                            bigNumber: $urmira.playGame,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
//                        Spacer()
                        // ボーナス合算
                        unitResultRatioDenomination2Line(
                            title: "ボーナス合算",
                            count: $urmira.personalBonusCountSum,
                            bigNumber: $urmira.playGame,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
//                        Spacer()
                    }
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "設定差情報",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "\(urmira.machineName)設定差",
                            tableView: AnyView(urmiraTableRatio(urmira: urmira))
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(urmiraView95CiPersonal(urmira: urmira)))
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    urmiraViewBayes(
                        urmira: urmira,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("小役,ボーナス カウント")
            }
            
            // //// ゲーム数入力
            Section {
                // 打ち始め
                HStack {
                    Text("打ち始め")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(urmira.startGameInput)")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundStyle(Color.secondary)
                }
                // 現在
                unitTextFieldGamesInput(title: "現在", inputValue: $urmira.currentGames)
                    .focused($isFocused)
                    .toolbar {
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
                // 消化ゲーム数
                HStack {
                    Text("自分のプレイ数")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(urmira.playGame)")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundStyle(Color.secondary)
                }
            } header: {
                Text("ゲーム数入力")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: urmira.machineName,
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
        .navigationTitle("実戦カウント")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // カウント入力
                    unitButtonCountNumberInput(
                        inputView: AnyView(
                            urmiraSubViewCountInput(
                                urmira: urmira
                            )
                        )
                    )
                    .popoverTip(tipUnitJugHanaCommonCountInput())
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $urmira.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: urmira.resetCountData)
                }
            }
        }
    }
}

#Preview {
    urmiraViewJissenCount(
        urmira: Urmira(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
