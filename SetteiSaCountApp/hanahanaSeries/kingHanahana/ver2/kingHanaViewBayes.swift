//
//  kingHanaViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/13.
//

import SwiftUI

struct kingHanaViewBayes: View {
    @ObservedObject var ver391: Ver391
    @ObservedObject var kingHana: KingHana
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.0, 99.0, 101.0, 104.0, 107.0, 110.0]
    @State var bigEnable: Bool = true
    @State var regEnable: Bool = true
    @State var bellEnable: Bool = true
    @State var bbSuikaEnable: Bool = true
    @State var bigLampEnable: Bool = true
    @State var regSideLampEnable: Bool = true
    
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
    @State var selectedBeforeGuessPattern: String = "デフォルト"
    
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
                // REG確率
                unitToggleWithQuestion(enable: self.$regEnable, title: "REG確率")
                // ベル確率
                unitToggleWithQuestion(enable: self.$bellEnable, title: "ベル確率") {
                    unitExView5body2image(
                        title: "逆算したベルについて",
                        textBody1: "・打ち始めデータでベル逆算有効化がONの場合はベル逆算分も考慮した計算を行います"
                    )
                }
                // BB中のスイカ確率
                unitToggleWithQuestion(enable: self.$bbSuikaEnable, title: "BIG中のスイカ確率")
                // BIG後のランプ確率
                unitToggleWithQuestion(enable: self.$bigLampEnable, title: "BIG後のランプ")
                // REG中のサイドランプ
                unitToggleWithQuestion(enable: self.$regSideLampEnable, title: "REG中のサイドランプ")
            }
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver391.kingHanaMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "キングハナハナ",
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
        // BIG確率
        var logPostBig = [Double](repeating: 0, count: self.settingList.count)
        if self.bigEnable {
            logPostBig = logPostDenoBino(
                ratio: kingHana.denominateListBig,
                Count: kingHana.totalBigCount,
                bigNumber: kingHana.currentGames
            )
        }
        // REG確率
        var logPostReg = [Double](repeating: 0, count: self.settingList.count)
        if self.regEnable {
            logPostReg = logPostDenoBino(
                ratio: kingHana.denominateListReg,
                Count: kingHana.totalRegCount,
                bigNumber: kingHana.currentGames
            )
        }
        // ベル確率
        var logPostBell = [Double](repeating: 0, count: self.settingList.count)
        if self.bellEnable {
            // ベル逆算ONの場合
            if kingHana.startBackCalculationEnable {
                logPostBell = logPostDenoBino(
                    ratio: kingHana.denominateListBell,
                    Count: kingHana.totalBellCount,
                    bigNumber: kingHana.currentGames
                )
            }
            // ベル逆算OFFの場合
            else {
                logPostBell = logPostDenoBino(
                    ratio: kingHana.denominateListBell,
                    Count: kingHana.bellCount,
                    bigNumber: kingHana.playGames
                )
            }
        }
        // BIG中のスイカ
        var logPostBigSuiKa = [Double](repeating: 0, count: self.settingList.count)
        if self.bbSuikaEnable {
            logPostBigSuiKa = logPostDenoBino(
                ratio: kingHana.denominateListBbSuika,
                Count: kingHana.bbSuikaCount,
                bigNumber: kingHana.bigPlayGames
            )
        }
        // BIG後のランプ
        var logPostBigLamp = [Double](repeating: 0, count: self.settingList.count)
        if self.bigLampEnable {
            logPostBigLamp = logPostPercentMulti(
                countList: [
                    kingHana.bbLampBCount,
                    kingHana.bbLampYCount,
                    kingHana.bbLampGCount,
                    kingHana.bbLampRCount,
                ], ratioList: [
                    [3.6,4.1,4.3,4.9,5.4,5.8],
                    [2.9,3.0,3.5,3.9,4.1,4.6],
                    [1.9,2.1,2.3,2.5,2.7,3.1],
                    [1.3,1.4,1.5,1.6,1.8,1.9],
                ], bigNumber: kingHana.bigCount
            )
        }
        // REG中のサイドランプ
        var logPostRegLamp = [Double](repeating: 0, count: self.settingList.count)
        if self.regSideLampEnable {
            logPostRegLamp = logPostPercentMulti(
                countList: [
                    kingHana.rbLampBCount,
                    kingHana.rbLampYCount,
                    kingHana.rbLampGCount,
                    kingHana.rbLampRCount,
                ], ratioList: [
                    [36,23,33,22,31,25],
                    [24,35,22,32,21,25],
                    [24,17,27,18,29,25],
                    [16,25,18,28,19,25],
                ], bigNumber: kingHana.rbLampCountSum
            )
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
            logPostBigSuiKa,
            logPostBigLamp,
            logPostRegLamp,
            
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
    kingHanaViewBayes(
        ver391: Ver391(),
        kingHana: KingHana(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
