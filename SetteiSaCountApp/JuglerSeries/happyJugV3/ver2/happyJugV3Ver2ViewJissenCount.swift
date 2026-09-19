//
//  happyJugV3Ver2ViewJissenCount.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/25.
//

import SwiftUI
import Combine

struct happyJugV3Ver2ViewJissenCount: View {
//    @ObservedObject var ver391: Ver391
    @ObservedObject var happyJugV3: HappyJugV3
    @State var isShowAlert = false
    @FocusState var isFocused: Bool
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 100.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 100.0
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    
    @State private var isAutoCountOn: Bool = false
    @State private var nextAutoCountDate: Date? = nil
    @EnvironmentObject var common: commonVar
    private var autoCountTimer: Publishers.Autoconnect<Timer.TimerPublisher> { Timer.publish(every: common.autoGameInterval, on: .main, in: .common).autoconnect() }
    
    var body: some View {
        List {
            // //// 小役、ボーナスカウント
            Section {
                // //// 横画面
                if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                    // //// カウントボタン
                    HStack {
                        // ぶどう
                        unitCountButtonVerticalDenominate(
                            title: "ぶどう",
                            count: $happyJugV3.personalBellCount,
                            color: .personalSummerLightGreen,
                            bigNumber: $happyJugV3.playGame,
                            numberofDicimal: 2,
                            minusBool: $happyJugV3.minusCheck
                        )
                        // チェリー
                        unitCountButtonVerticalDenominate(
                            title: "🍒",
                            count: $happyJugV3.personalCherryCount,
                            color: .personalSummerLightRed,
                            bigNumber: $happyJugV3.playGame,
                            numberofDicimal: 1,
                            minusBool: $happyJugV3.minusCheck
                        )
                    }
                    // 2段目
                    HStack {
                        // 単独BIG
                        unitCountButtonVerticalDenominate(
                            title: "単独BIG",
                            count: $happyJugV3.personalAloneBigCount,
                            color: .personalSummerLightRed,
                            bigNumber: $happyJugV3.playGame,
                            numberofDicimal: 0,
                            minusBool: $happyJugV3.minusCheck
                        )
                        // 🍒BIG
                        unitCountButtonVerticalDenominate(
                            title: "🍒BIG",
                            count: $happyJugV3.personalCherryBigCount,
                            color: .personalSpringLightYellow,
                            bigNumber: $happyJugV3.playGame,
                            numberofDicimal: 0,
                            minusBool: $happyJugV3.minusCheck,
                            flushColor: .yellow
                        )
                        // 単独REG
                        unitCountButtonVerticalDenominate(
                            title: "単独REG",
                            count: $happyJugV3.personalAloneRegCount,
                            color: .personalSummerLightBlue,
                            bigNumber: $happyJugV3.playGame,
                            numberofDicimal: 0,
                            minusBool: $happyJugV3.minusCheck
                        )
                        // 🍒REG
                        unitCountButtonVerticalDenominate(
                            title: "🍒REG",
                            count: $happyJugV3.personalCherryRegCount,
                            color: .personalSummerLightPurple,
                            bigNumber: $happyJugV3.playGame,
                            numberofDicimal: 0,
                            minusBool: $happyJugV3.minusCheck
                        )
                    }
                    // //// 結果
                    HStack {
                        // BIG合算
                        unitResultRatioDenomination2Line(
                            title: "BIG合算",
                            count: $happyJugV3.personalBigCountSum,
                            bigNumber: $happyJugV3.playGame,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // REG合算
                        unitResultRatioDenomination2Line(
                            title: "REG合算",
                            count: $happyJugV3.personalRegCountSum,
                            bigNumber: $happyJugV3.playGame,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // ボーナス合算
                        unitResultRatioDenomination2Line(
                            title: "ボーナス合算",
                            count: $happyJugV3.personalBonusCountSum,
                            bigNumber: $happyJugV3.playGame,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
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
                            count: $happyJugV3.personalBellCount,
                            color: .personalSummerLightGreen,
                            bigNumber: $happyJugV3.playGame,
                            numberofDicimal: 2,
                            minusBool: $happyJugV3.minusCheck
                        )
                        // チェリー
                        unitCountButtonVerticalDenominate(
                            title: "🍒",
                            count: $happyJugV3.personalCherryCount,
                            color: .personalSummerLightRed,
                            bigNumber: $happyJugV3.playGame,
                            numberofDicimal: 1,
                            minusBool: $happyJugV3.minusCheck
                        )
                    }
                    // 2段目
                    HStack {
                        // 単独BIG
                        unitCountButtonVerticalDenominate(
                            title: "単独BIG",
                            count: $happyJugV3.personalAloneBigCount,
                            color: .personalSummerLightRed,
                            bigNumber: $happyJugV3.playGame,
                            numberofDicimal: 0,
                            minusBool: $happyJugV3.minusCheck
                        )
                        // 🍒BIG
                        unitCountButtonVerticalDenominate(
                            title: "🍒BIG",
                            count: $happyJugV3.personalCherryBigCount,
                            color: .personalSpringLightYellow,
                            bigNumber: $happyJugV3.playGame,
                            numberofDicimal: 0,
                            minusBool: $happyJugV3.minusCheck,
                            flushColor: .yellow
                        )
                        // 単独REG
                        unitCountButtonVerticalDenominate(
                            title: "単独REG",
                            count: $happyJugV3.personalAloneRegCount,
                            color: .personalSummerLightBlue,
                            bigNumber: $happyJugV3.playGame,
                            numberofDicimal: 0,
                            minusBool: $happyJugV3.minusCheck
                        )
                        // 🍒REG
                        unitCountButtonVerticalDenominate(
                            title: "🍒REG",
                            count: $happyJugV3.personalCherryRegCount,
                            color: .personalSummerLightPurple,
                            bigNumber: $happyJugV3.playGame,
                            numberofDicimal: 0,
                            minusBool: $happyJugV3.minusCheck
                        )
                    }
                    // //// 結果
                    HStack {
                        // BIG合算
                        unitResultRatioDenomination2Line(
                            title: "BIG合算",
                            count: $happyJugV3.personalBigCountSum,
                            bigNumber: $happyJugV3.playGame,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // REG合算
                        unitResultRatioDenomination2Line(
                            title: "REG合算",
                            count: $happyJugV3.personalRegCountSum,
                            bigNumber: $happyJugV3.playGame,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // ボーナス合算
                        unitResultRatioDenomination2Line(
                            title: "ボーナス合算",
                            count: $happyJugV3.personalBonusCountSum,
                            bigNumber: $happyJugV3.playGame,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                    }
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "設定差情報",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ハッピージャグラーV3設定差",
                            image1: Image("happyJugV3Analysis")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(happyJugV3Ver2View95CiPersonal(happyJugV3: happyJugV3)))
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    happyJugV3ViewBayes(
//                        ver391: ver391,
                        happyJugV3: happyJugV3,
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
                    Text("\(happyJugV3.startGameInput)")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundStyle(Color.secondary)
                }
                // 現在
                unitTextFieldGamesInput(title: "現在", inputValue: $happyJugV3.currentGames)
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
                    Text("\(happyJugV3.playGame)")
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
                screenName: "ハッピージャグラーV3",
                screenClass: screenClass
            )
        }
        .autoGameCount(
            isOn: self.$isAutoCountOn,
            currentGames: self.$happyJugV3.currentGames,
            nextDate: self.$nextAutoCountDate,
            interval: common.autoGameInterval
        )
        // //// 画面の向き情報の取得部分
        .onAppear {
            // ビューが表示されるときにデバイスの向きを取得
            self.orientation = UIDevice.current.orientation
            // 向きがフラットでなければlastOrientationの値を更新
            if self.orientation.isFlat {
                
            }
            else {
                self.lastOrientation = self.orientation
            }
            if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                self.scrollViewHeight = self.scrollViewHeightLandscape
                self.spaceHeight = self.spaceHeightLandscape
            } else {
                self.scrollViewHeight = self.scrollViewHeightPortrait
                self.spaceHeight = self.spaceHeightPortrait
            }
            // デバイスの向きの変更を監視する
            NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                self.orientation = UIDevice.current.orientation
                // 向きがフラットでなければlastOrientationの値を更新
                if self.orientation.isFlat {
                    
                }
                else {
                    self.lastOrientation = self.orientation
                }
                if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                    self.scrollViewHeight = self.scrollViewHeightLandscape
                    self.spaceHeight = self.spaceHeightLandscape
                } else {
                    self.scrollViewHeight = self.scrollViewHeightPortrait
                    self.spaceHeight = self.spaceHeightPortrait
                }
            }
        }
        .onDisappear {
            // ビューが非表示になるときに監視を解除
            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        }
        .navigationTitle("実戦カウント")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // 自動G数カウント
                unitToolbarButtonAutoGameCount(
                    autoBool: self.$isAutoCountOn,
                    nextAutoCountDate: self.$nextAutoCountDate,
                )
                .popoverTip(commonTipAutoGameCount())
            }
            ToolbarItem(placement: .automatic) {
                // カウント入力
                unitButtonCountNumberInput(
                    inputView: AnyView(
                        happyJugV3SubViewCountInput(
                            happyJugV3: happyJugV3
                        )
                    )
                )
            }
            ToolbarItem(placement: .automatic) {
                // マイナスチェック
                unitButtonMinusCheck(minusCheck: $happyJugV3.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // リセットボタン
                unitButtonReset(isShowAlert: $isShowAlert, action: happyJugV3.resetCountData)
            }
        }
    }
}

#Preview {
    happyJugV3Ver2ViewJissenCount(
//        ver391: Ver391(),
        happyJugV3: HappyJugV3(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
