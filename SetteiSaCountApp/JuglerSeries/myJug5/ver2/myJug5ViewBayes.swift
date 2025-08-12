//
//  myJug5ViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/10.
//

import SwiftUI

struct myJug5ViewBayes: View {
    @ObservedObject var myJug5: MyJug5
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    // //// 設定判別要素の設定
    @State var bigEnable: Bool = true
    @State var regEnable: Bool = true
    @State var regDetailEnable: Bool = true
    @State var bellEnable: Bool = true
    
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @State var guessCustom1: [Int] = []   // カスタム配分1用の入れ物
    @State var guessCustom2: [Int] = []   // カスタム配分2用の入れ物
    @State var guessCustom3: [Int] = []   // カスタム配分3用の入れ物
    @State var resultGuess: [Double] = []   // 計算結果の入れ物
    @State var isShowResult: Bool = false   // 結果シートの表示トリガー
    var body: some View {
        List {
            // //// STEP1
            bayesSubStep1Section(
                bayes: bayes,
                guessCustom1: self.$guessCustom1,
                guessCustom2: self.$guessCustom2,
                guessCustom3: self.$guessCustom3,
            )
            
            // //// STEP2
            bayesSubStep2Section {
                // BIG確率
                unitToggleWithQuestion(enable: self.$bigEnable, title: "BIG確率")
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
        // //// 画面表示時の処理
        .onAppear {
            // 広告をロードしとく
            Task {
                await viewModel.loadAd()
            }
            // カスタム配分を配列にしとく
            self.guessCustom1 = decodeIntArrayFromString(stringData: bayes.guess6Custom1JSON)
            self.guessCustom2 = decodeIntArrayFromString(stringData: bayes.guess6Custom2JSON)
            self.guessCustom3 = decodeIntArrayFromString(stringData: bayes.guess6Custom3JSON)
        }
        .onChange(of: viewModel.isAdDismissed) {
            if viewModel.isAdDismissed {
                self.isShowResult = true
            }
        }
        .sheet(isPresented: self.$isShowResult) {
            bayesResultView(
                resultGuess: self.resultGuess,
                payoutList: [97,98,99.9,102.8,105.3,109.4],
            )
                .presentationDetents([.large])
        }
        .navigationTitle("設定期待値")
        .navigationBarTitleDisplayMode(.inline)
        // //// ツールバー
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitToolbarButtonCustomSheet(
                    bayes: bayes,
                    guessCustom1: self.$guessCustom1,
                    guessCustom2: self.$guessCustom2,
                    guessCustom3: self.$guessCustom3
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
            logPostBig = logPostDenoBino(
                ratio: myJug5.denominateListBigSum,
                Count: myJug5.totalBigCount,
                bigNumber: myJug5.currentGames
            )
        }
        
        // REGの対数尤度
        var logPostReg = [Double](repeating: 0, count: self.settingList.count)
        if self.regEnable {
            // REG詳細ONの場合
            if self.regDetailEnable {
                // 前任者分
                let logPostRegStart = logPostDenoBino(
                    ratio: myJug5.denominateListRegSum,
                    Count: myJug5.startRegCountInput,
                    bigNumber: myJug5.startGameInput,
                )
                // 単独REG分
                let logPostRegAlone = logPostDenoBino(
                    ratio: myJug5.denominateListRegAlone,
                    Count: myJug5.personalAloneRegCount,
                    bigNumber: myJug5.playGame,
                )
                // チェリーREG分
                let logPostRegCherry = logPostDenoBino(
                    ratio: myJug5.denominateListRegCherry,
                    Count: myJug5.personalCherryRegCount,
                    bigNumber: myJug5.playGame,
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
                    ratio: myJug5.denominateListRegSum,
                    Count: myJug5.totalRegCount,
                    bigNumber: myJug5.currentGames
                )
            }
        }
        
        // ぶどうの対数尤度
        var logPostBell = [Double](repeating: 0, count: self.settingList.count)
        if self.bellEnable {
            // ぶどう逆算ONの場合
            if myJug5.startBackCalculationEnable {
                logPostBell = logPostDenoBino(
                    ratio: myJug5.denominateListBell,
                    Count: myJug5.totalBellCount,
                    bigNumber: myJug5.currentGames
                )
            }
            // ぶどう逆算OFFの場合
            else {
                logPostBell = logPostDenoBino(
                    ratio: myJug5.denominateListBell,
                    Count: myJug5.personalBellCount,
                    bigNumber: myJug5.playGame
                )
            }
        }
        
        // 事前確率の対数尤度
        let logPostBefore = logPostBeforeFunc(
            guess: selectedGuess(
                pattern: bayes.selectedBeforeGuessPattern
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
    myJug5ViewBayes(
        myJug5: MyJug5(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
