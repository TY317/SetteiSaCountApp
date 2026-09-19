//
//  girlsSSVer2ViewJissenCount.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/09.
//

import SwiftUI
import Combine

struct girlsSSVer2ViewJissenCount: View {
//    @ObservedObject var ver391: Ver391
    @ObservedObject var girlsSS: GirlsSS
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
                            count: $girlsSS.personalBellCount,
                            color: .personalSummerLightGreen,
                            bigNumber: $girlsSS.playGame,
                            numberofDicimal: 2,
                            minusBool: $girlsSS.minusCheck
                        )
                        // チェリー
                        unitCountButtonVerticalDenominate(
                            title: "🍒",
                            count: $girlsSS.personalCherryCount,
                            color: .personalSummerLightRed,
                            bigNumber: $girlsSS.playGame,
                            numberofDicimal: 1,
                            minusBool: $girlsSS.minusCheck
                        )
                    }
                    // 2段目
                    HStack {
                        // BIG
                        unitCountButtonVerticalDenominate(
                            title: "BIG",
                            count: $girlsSS.personalBigCountSum,
                            color: .personalSummerLightRed,
                            bigNumber: $girlsSS.playGame,
                            numberofDicimal: 0,
                            minusBool: $girlsSS.minusCheck
                        )
//                        // 単独BIG
//                        unitCountButtonVerticalDenominate(
//                            title: "単独BIG",
//                            count: $girlsSS.personalAloneBigCount,
//                            color: .personalSummerLightRed,
//                            bigNumber: $girlsSS.playGame,
//                            numberofDicimal: 0,
//                            minusBool: $girlsSS.minusCheck
//                        )
//                        // 🍒BIG
//                        unitCountButtonVerticalDenominate(
//                            title: "🍒BIG",
//                            count: $girlsSS.personalCherryBigCount,
//                            color: .personalSpringLightYellow,
//                            bigNumber: $girlsSS.playGame,
//                            numberofDicimal: 0,
//                            minusBool: $girlsSS.minusCheck,
//                            flushColor: .yellow
//                        )
                        // 単独REG
                        unitCountButtonVerticalDenominate(
                            title: "単独REG",
                            count: $girlsSS.personalAloneRegCount,
                            color: .personalSummerLightBlue,
                            bigNumber: $girlsSS.playGame,
                            numberofDicimal: 0,
                            minusBool: $girlsSS.minusCheck
                        )
                        // 🍒REG
                        unitCountButtonVerticalDenominate(
                            title: "🍒REG",
                            count: $girlsSS.personalCherryRegCount,
                            color: .personalSummerLightPurple,
                            bigNumber: $girlsSS.playGame,
                            numberofDicimal: 0,
                            minusBool: $girlsSS.minusCheck
                        )
                    }
                    // //// 結果
                    HStack {
//                        // BIG合算
//                        unitResultRatioDenomination2Line(
//                            title: "BIG合算",
//                            count: $girlsSS.personalBigCountSum,
//                            bigNumber: $girlsSS.playGame,
//                            numberofDicimal: 0,
//                            spacerBool: false
//                        )
                        // REG合算
                        unitResultRatioDenomination2Line(
                            title: "REG合算",
                            count: $girlsSS.personalRegCountSum,
                            bigNumber: $girlsSS.playGame,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // ボーナス合算
                        unitResultRatioDenomination2Line(
                            title: "ボーナス合算",
                            count: $girlsSS.personalBonusCountSum,
                            bigNumber: $girlsSS.playGame,
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
                            count: $girlsSS.personalBellCount,
                            color: .personalSummerLightGreen,
                            bigNumber: $girlsSS.playGame,
                            numberofDicimal: 2,
                            minusBool: $girlsSS.minusCheck
                        )
                        // チェリー
                        unitCountButtonVerticalDenominate(
                            title: "🍒",
                            count: $girlsSS.personalCherryCount,
                            color: .personalSummerLightRed,
                            bigNumber: $girlsSS.playGame,
                            numberofDicimal: 1,
                            minusBool: $girlsSS.minusCheck
                        )
                    }
                    // 2段目
                    HStack {
                        // BIG
                        unitCountButtonVerticalDenominate(
                            title: "BIG",
                            count: $girlsSS.personalBigCountSum,
                            color: .personalSummerLightRed,
                            bigNumber: $girlsSS.playGame,
                            numberofDicimal: 0,
                            minusBool: $girlsSS.minusCheck
                        )
//                        // 単独BIG
//                        unitCountButtonVerticalDenominate(
//                            title: "単独BIG",
//                            count: $girlsSS.personalAloneBigCount,
//                            color: .personalSummerLightRed,
//                            bigNumber: $girlsSS.playGame,
//                            numberofDicimal: 0,
//                            minusBool: $girlsSS.minusCheck
//                        )
//                        // 🍒BIG
//                        unitCountButtonVerticalDenominate(
//                            title: "🍒BIG",
//                            count: $girlsSS.personalCherryBigCount,
//                            color: .personalSpringLightYellow,
//                            bigNumber: $girlsSS.playGame,
//                            numberofDicimal: 0,
//                            minusBool: $girlsSS.minusCheck,
//                            flushColor: .yellow
//                        )
                        // 単独REG
                        unitCountButtonVerticalDenominate(
                            title: "単独REG",
                            count: $girlsSS.personalAloneRegCount,
                            color: .personalSummerLightBlue,
                            bigNumber: $girlsSS.playGame,
                            numberofDicimal: 0,
                            minusBool: $girlsSS.minusCheck
                        )
                        // 🍒REG
                        unitCountButtonVerticalDenominate(
                            title: "🍒REG",
                            count: $girlsSS.personalCherryRegCount,
                            color: .personalSummerLightPurple,
                            bigNumber: $girlsSS.playGame,
                            numberofDicimal: 0,
                            minusBool: $girlsSS.minusCheck
                        )
                    }
                    // //// 結果
                    HStack {
//                        // BIG合算
//                        unitResultRatioDenomination2Line(
//                            title: "BIG合算",
//                            count: $girlsSS.personalBigCountSum,
//                            bigNumber: $girlsSS.playGame,
//                            numberofDicimal: 0,
//                            spacerBool: false
//                        )
                        // REG合算
                        unitResultRatioDenomination2Line(
                            title: "REG合算",
                            count: $girlsSS.personalRegCountSum,
                            bigNumber: $girlsSS.playGame,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // ボーナス合算
                        unitResultRatioDenomination2Line(
                            title: "ボーナス合算",
                            count: $girlsSS.personalBonusCountSum,
                            bigNumber: $girlsSS.playGame,
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
                            title: "ジャグラーガールズSS設定差",
                            tableView: AnyView(girlsSSTableRatio(girlsSS: girlsSS))
//                            image1: Image("girlsSSAnalysis"),
//                            image2Title: "[5号機数値からの予測値]\n※ただの予測です。参考程度としてください",
//                            image2: Image("girlsSSYosoku")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(girlsSSVer2View95CiPersonal(girlsSS: girlsSS)))
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    girlsSSViewBayes(
//                        ver391: ver391,
                        girlsSS: girlsSS,
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
                    Text("\(girlsSS.startGameInput)")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundStyle(Color.secondary)
                }
                // 現在
                unitTextFieldGamesInput(title: "現在", inputValue: $girlsSS.currentGames)
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
                    Text("\(girlsSS.playGame)")
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
                screenName: "ジャグラーガールズSS",
                screenClass: screenClass
            )
        }
        .autoGameCount(
            isOn: self.$isAutoCountOn,
            currentGames: self.$girlsSS.currentGames,
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
                        girlsSSSubViewCountInput(
                            girlsSS: girlsSS
                        )
                    )
                )
            }
            ToolbarItem(placement: .automatic) {
                // マイナスチェック
                unitButtonMinusCheck(minusCheck: $girlsSS.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // リセットボタン
                unitButtonReset(isShowAlert: $isShowAlert, action: girlsSS.resetCountData)
            }
        }
    }
}

#Preview {
    girlsSSVer2ViewJissenCount(
//        ver391: Ver391(),
        girlsSS: GirlsSS(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
