//
//  mrJugViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/08.
//

import SwiftUI

struct mrJugViewBayes: View {
//    @ObservedObject var ver391: Ver391
    @ObservedObject var mrJug: MrJug
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.0, 98.0, 99.8, 102.7, 105.5, 107.3]
    @State var bigEnable: Bool = true
    @State var bigDetailEnable: Bool = true
    @State var regEnable: Bool = true
    @State var regDetailEnable: Bool = true
    @State var bellEnable: Bool = true
    
    // 全機種共通
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @State var guessCustom1: [Int] = []   // カスタム配分1用の入れ物
    @State var guessCustom2: [Int] = []   // カスタム配分2用の入れ物
    @State var guessCustom3: [Int] = []   // カスタム配分3用の入れ物
    @State var resultGuess: [Double] = []   // 計算結果の入れ物
    @State var isShowResult: Bool = false   // 結果シートの表示トリガー
    @State var over2Check: Bool = false   // 2以上濃厚
    @State var over3Check: Bool = false   // 3以上濃厚
    @State var over4Check: Bool = false   // 4以上濃厚
    @State var over5Check: Bool = false   // 5以上濃厚
    @State var over6Check: Bool = false   // 6以上濃厚
    @State var selectedBeforeGuessPattern: String = "ｼﾞｬｸﾞﾗｰﾃﾞﾌｫﾙﾄ"
    
    var body: some View {
        List {
            // //// STEP1
            bayesSubStep1Section(
                bayes: bayes,
                settingList: self.settingList,
                guessCustom1: self.$guessCustom1,
                guessCustom2: self.$guessCustom2,
                guessCustom3: self.$guessCustom3,
                selectedBeforeGuessPattern: self.$selectedBeforeGuessPattern,
            )
            // //// STEP2
            bayesSubStep2Section {
                // BIG確率
                unitToggleWithQuestion(enable: self.$bigEnable, title: "BIG確率")
                    .onChange(of: self.bigEnable) { oldValue, newValue in
                        if newValue == false {
                            self.bigDetailEnable = false
                        }
                    }
                // BIG詳細
                unitToggleWithQuestion(
                    enable: self.$bigDetailEnable,
                    title: "BIG当選契機も考慮"
                ) {
                    unitExView5body2image(
                        title: "BIG当選契機",
                        textBody1: "・ONの場合、自分の実戦分については単独・🍒重複の確率を考慮した計算をします",
                    )
                }
                .onChange(of: self.bigDetailEnable) { oldValue, newValue in
                    if newValue == true {
                        self.bigEnable = true
                    }
                }
                // REG確率
                unitToggleWithQuestion(enable: self.$regEnable, title: "REG確率")
                    .onChange(of: self.regEnable) { oldValue, newValue in
                        if newValue == false {
                            self.regDetailEnable = false
                        }
                    }
                // REG詳細
                unitToggleWithQuestion(
                    enable: self.$regDetailEnable,
                    title: "REG当選契機も考慮"
                ) {
                    unitExView5body2image(
                        title: "REG当選契機",
                        textBody1: "・ONの場合、自分の実戦分については単独・🍒重複の確率を考慮した計算をします",
                    )
                }
                .onChange(of: self.regDetailEnable) { oldValue, newValue in
                    if newValue == true {
                        self.regEnable = true
                    }
                }
                // ぶどう
                unitToggleWithQuestion(
                    enable: self.$bellEnable,
                    title: "ぶどう確率"
                ) {
                    unitExView5body2image(
                        title: "逆算したぶどうについて",
                        textBody1: "・打ち始めデータでぶどう逆算有効化がONの場合はぶどう逆算分も考慮した計算を行います"
                    )
                }
            }
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver391.mrJugMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ミスタージャグラー",
                screenClass: screenClass
            )
        }
        .navigationTitle("設定期待値")
        .navigationBarTitleDisplayMode(.inline)
        // //// 画面表示時の処理
        .bayesOnAppear(
            bayes: bayes,
            viewModel: viewModel,
            settingList: self.settingList,
            guessCustom1: self.$guessCustom1,
            guessCustom2: self.$guessCustom2,
            guessCustom3: self.$guessCustom3
        )
        // //// 計算結果シートの表示発火処理
        .onChange(of: viewModel.isAdDismissed) {
            if viewModel.isAdDismissed {
                self.isShowResult = true
            }
        }
        .sheet(isPresented: self.$isShowResult) {
            bayesResultView(
                settingList: self.settingList,
                resultGuess: self.resultGuess,
                payoutList: self.payoutList,
            )
                .presentationDetents([.large])
        }
        // //// ツールバー
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitToolbarButtonCustomSheet(
                    settingList: self.settingList,
                    bayes: bayes,
                    guessCustom1: self.$guessCustom1,
                    guessCustom2: self.$guessCustom2,
                    guessCustom3: self.$guessCustom3,
                    selectedBeforeGuessPattern: self.$selectedBeforeGuessPattern,
                )
            }
            ToolbarItem(placement: .automatic) {
                bayesInfoButtonBayes()
            }
        }
    }
    // //// 事後確率の算出
    private func bayesRatio() -> [Double] {
        // BIGの対数尤度
        var logPostBig = [Double](repeating: 0, count: self.settingList.count)
        if self.bigEnable {
            // Big詳細ONの場合
            if self.bigDetailEnable {
                // 前任者分
                let logPostBigStart = logPostDenoBino(
                    ratio: mrJug.denominateListBigSum,
                    Count: mrJug.startBigCountInput,
                    bigNumber: mrJug.startGameInput,
                )
                // 単独Big分
                let logPostBigAlone = logPostDenoBino(
                    ratio: mrJug.denominateListBigAlone,
                    Count: mrJug.personalAloneBigCount,
                    bigNumber: mrJug.playGame,
                )
                // チェリーBig分
                let logPostBigCherry = logPostDenoBino(
                    ratio: mrJug.denominateListBigCherry,
                    Count: mrJug.personalCherryBigCount,
                    bigNumber: mrJug.playGame,
                )
                // 3つを合算する
                logPostBig = arraySumDouble([
                    logPostBigStart,
                    logPostBigAlone,
                    logPostBigCherry,
                ])
                
            } else {
                // Big合算確率での対数尤度
                logPostBig = logPostDenoBino(
                    ratio: mrJug.denominateListBigSum,
                    Count: mrJug.totalBigCount,
                    bigNumber: mrJug.currentGames
                )
            }
        }
        
        // REGの対数尤度
        var logPostReg = [Double](repeating: 0, count: self.settingList.count)
        if self.regEnable {
            // REG詳細ONの場合
            if self.regDetailEnable {
                // 前任者分
                let logPostRegStart = logPostDenoBino(
                    ratio: mrJug.denominateListRegSum,
                    Count: mrJug.startRegCountInput,
                    bigNumber: mrJug.startGameInput,
                )
                // 単独REG分
                let logPostRegAlone = logPostDenoBino(
                    ratio: mrJug.denominateListRegAlone,
                    Count: mrJug.personalAloneRegCount,
                    bigNumber: mrJug.playGame,
                )
                // チェリーREG分
                let logPostRegCherry = logPostDenoBino(
                    ratio: mrJug.denominateListRegCherry,
                    Count: mrJug.personalCherryRegCount,
                    bigNumber: mrJug.playGame,
                )
                // 3つを合算する
                logPostReg = arraySumDouble([
                    logPostRegStart,
                    logPostRegAlone,
                    logPostRegCherry,
                ])
                
            } else {
                // REG合算確率での対数尤度
                logPostReg = logPostDenoBino(
                    ratio: mrJug.denominateListRegSum,
                    Count: mrJug.totalRegCount,
                    bigNumber: mrJug.currentGames
                )
            }
        }
        
        // ぶどうの対数尤度
        var logPostBell = [Double](repeating: 0, count: self.settingList.count)
        if self.bellEnable {
            // ぶどう逆算ONの場合
            if mrJug.startBackCalculationEnable {
                logPostBell = logPostDenoBino(
                    ratio: mrJug.denominateListBell,
                    Count: mrJug.totalBellCount,
                    bigNumber: mrJug.currentGames
                )
            }
            // ぶどう逆算OFFの場合
            else {
                logPostBell = logPostDenoBino(
                    ratio: mrJug.denominateListBell,
                    Count: mrJug.personalBellCount,
                    bigNumber: mrJug.playGame
                )
            }
        }
        
        // 事前確率の対数尤度
        let logPostBefore = logPostBeforeFunc(
            guess: selectedGuess(
//                pattern: bayes.selectedBeforeGuessPattern
                pattern: self.selectedBeforeGuessPattern
            )
        )
        
        // 判別要素の尤度合算
        let logPostSum: [Double] = arraySumDouble([
            logPostBig,
            logPostReg,
            logPostBell,
            logPostBefore,
        ])
        
        // 事後確率の算出
        let afterGuess = bayesResultRatioFunc(logPost: logPostSum)
        
        return afterGuess
    }
    
    // //// 選択した設定配分配列を返す
    func selectedGuess(pattern: String) -> [Int] {
        switch pattern {
        case bayes.guessPatternList[0]: return bayes.guess6Default
        case bayes.guessPatternList[1]: return bayes.guess6JugDefault
        case bayes.guessPatternList[2]: return bayes.guess6Evenly
        case bayes.guessPatternList[3]: return bayes.guess6Half
        case bayes.guessPatternList[4]: return bayes.guess6Quater
        case bayes.guessPatternList[5]: return self.guessCustom1
        case bayes.guessPatternList[6]: return self.guessCustom2
        case bayes.guessPatternList[7]: return self.guessCustom3
        default: return bayes.guess6Default
        }
    }
}

#Preview {
    mrJugViewBayes(
//        ver391: Ver391(),
        mrJug: MrJug(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
