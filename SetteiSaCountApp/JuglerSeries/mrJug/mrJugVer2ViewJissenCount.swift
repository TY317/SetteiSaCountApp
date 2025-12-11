//
//  mrJugVer2ViewJissenCount.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/08.
//

import SwiftUI

struct mrJugVer2ViewJissenCount: View {
//    @ObservedObject var ver391: Ver391
    @ObservedObject var mrJug: MrJug
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
    private let autoCountTimer = Timer.publish(every: 4.1, on: .main, in: .common).autoconnect()
    
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
                            count: $mrJug.personalBellCount,
                            color: .personalSummerLightGreen,
                            bigNumber: $mrJug.playGame,
                            numberofDicimal: 2,
                            minusBool: $mrJug.minusCheck
                        )
//                        // BIG
//                        unitCountButtonVerticalDenominate(
//                            title: "BIG",
//                            count: $mrJug.personalBigCountSum,
//                            color: .personalSummerLightRed,
//                            bigNumber: $mrJug.playGame,
//                            numberofDicimal: 0,
//                            minusBool: $mrJug.minusCheck
//                        )
                        // 単独BIG
                        unitCountButtonVerticalDenominate(
                            title: "単独BIG",
                            count: $mrJug.personalAloneBigCount,
                            color: .personalSummerLightRed,
                            bigNumber: $mrJug.playGame,
                            numberofDicimal: 0,
                            minusBool: $mrJug.minusCheck
                        )
                        // 🍒BIG
                        unitCountButtonVerticalDenominate(
                            title: "🍒BIG",
                            count: $mrJug.personalCherryBigCount,
                            color: .personalSpringLightYellow,
                            bigNumber: $mrJug.playGame,
                            numberofDicimal: 0,
                            minusBool: $mrJug.minusCheck,
                            flushColor: .yellow
                        )
//                        // REG
//                        unitCountButtonVerticalDenominate(
//                            title: "REG",
//                            count: $mrJug.personalRegCountSum,
//                            color: .personalSummerLightBlue,
//                            bigNumber: $mrJug.playGame,
//                            numberofDicimal: 0,
//                            minusBool: $mrJug.minusCheck
//                        )
                        // 単独REG
                        unitCountButtonVerticalDenominate(
                            title: "単独REG",
                            count: $mrJug.personalAloneRegCount,
                            color: .personalSummerLightBlue,
                            bigNumber: $mrJug.playGame,
                            numberofDicimal: 0,
                            minusBool: $mrJug.minusCheck
                        )
                        // 🍒REG
                        unitCountButtonVerticalDenominate(
                            title: "🍒REG",
                            count: $mrJug.personalCherryRegCount,
                            color: .personalSummerLightPurple,
                            bigNumber: $mrJug.playGame,
                            numberofDicimal: 0,
                            minusBool: $mrJug.minusCheck
                        )
                    }
                    // //// 結果
                    HStack {
                        // BIG合算
                        unitResultRatioDenomination2Line(
                            title: "BIG合算",
                            count: $mrJug.personalBigCountSum,
                            bigNumber: $mrJug.playGame,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // REG合算
                        unitResultRatioDenomination2Line(
                            title: "REG合算",
                            count: $mrJug.personalRegCountSum,
                            bigNumber: $mrJug.playGame,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
//                        Spacer()
                        // ボーナス合算
                        unitResultRatioDenomination2Line(
                            title: "ボーナス合算",
                            count: $mrJug.personalBonusCountSum,
                            bigNumber: $mrJug.playGame,
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
                            count: $mrJug.personalBellCount,
                            color: .personalSummerLightGreen,
                            bigNumber: $mrJug.playGame,
                            numberofDicimal: 2,
                            minusBool: $mrJug.minusCheck
                        )
//                        // BIG
//                        unitCountButtonVerticalDenominate(
//                            title: "BIG",
//                            count: $mrJug.personalBigCountSum,
//                            color: .personalSummerLightRed,
//                            bigNumber: $mrJug.playGame,
//                            numberofDicimal: 0,
//                            minusBool: $mrJug.minusCheck
//                        )
//                        // REG
//                        unitCountButtonVerticalDenominate(
//                            title: "REG",
//                            count: $mrJug.personalRegCountSum,
//                            color: .personalSummerLightBlue,
//                            bigNumber: $mrJug.playGame,
//                            numberofDicimal: 0,
//                            minusBool: $mrJug.minusCheck
//                        )
                    }
                    // 2段目
                    HStack {
                        // 単独BIG
                        unitCountButtonVerticalDenominate(
                            title: "単独BIG",
                            count: $mrJug.personalAloneBigCount,
                            color: .personalSummerLightRed,
                            bigNumber: $mrJug.playGame,
                            numberofDicimal: 0,
                            minusBool: $mrJug.minusCheck
                        )
                        // 🍒BIG
                        unitCountButtonVerticalDenominate(
                            title: "🍒BIG",
                            count: $mrJug.personalCherryBigCount,
                            color: .personalSpringLightYellow,
                            bigNumber: $mrJug.playGame,
                            numberofDicimal: 0,
                            minusBool: $mrJug.minusCheck,
                            flushColor: .yellow
                        )
                        // 単独REG
                        unitCountButtonVerticalDenominate(
                            title: "単独REG",
                            count: $mrJug.personalAloneRegCount,
                            color: .personalSummerLightBlue,
                            bigNumber: $mrJug.playGame,
                            numberofDicimal: 0,
                            minusBool: $mrJug.minusCheck
                        )
                        // 🍒REG
                        unitCountButtonVerticalDenominate(
                            title: "🍒REG",
                            count: $mrJug.personalCherryRegCount,
                            color: .personalSummerLightPurple,
                            bigNumber: $mrJug.playGame,
                            numberofDicimal: 0,
                            minusBool: $mrJug.minusCheck
                        )
                    }
                    // //// 結果
                    HStack {
                        // BIG合算
                        unitResultRatioDenomination2Line(
                            title: "BIG合算",
                            count: $mrJug.personalBigCountSum,
                            bigNumber: $mrJug.playGame,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // REG合算
                        unitResultRatioDenomination2Line(
                            title: "REG合算",
                            count: $mrJug.personalRegCountSum,
                            bigNumber: $mrJug.playGame,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
//                        Spacer()
                        // ボーナス合算
                        unitResultRatioDenomination2Line(
                            title: "ボーナス合算",
                            count: $mrJug.personalBonusCountSum,
                            bigNumber: $mrJug.playGame,
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
                            title: "ミスタージャグラー設定差",
                            tableView: AnyView(mrJugSubViewTableRatio(mrJug: mrJug))
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(mrJugVer2View95CiPersonal(mrJug: mrJug)))
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    mrJugViewBayes(
//                        ver391: ver391,
                        mrJug: mrJug,
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
                    Text("\(mrJug.startGameInput)")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundStyle(Color.secondary)
                }
                // 現在
                unitTextFieldGamesInput(title: "現在", inputValue: $mrJug.currentGames)
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
                    Text("\(mrJug.playGame)")
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
                screenName: "ミスタージャグラー",
                screenClass: screenClass
            )
        }
        .autoGameCount(
            isOn: self.$isAutoCountOn,
            currentGames: self.$mrJug.currentGames,
            nextDate: self.$nextAutoCountDate,
            interval: 4.1
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
                        mrJugSubViewCountInput(
                            mrJug: mrJug
                        )
                    )
                )
            }
            ToolbarItem(placement: .automatic) {
                // マイナスチェック
                unitButtonMinusCheck(minusCheck: $mrJug.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // リセットボタン
                unitButtonReset(isShowAlert: $isShowAlert, action: mrJug.resetCountData)
            }
        }
    }
}

#Preview {
    mrJugVer2ViewJissenCount(
//        ver391: Ver391(),
        mrJug: MrJug(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
