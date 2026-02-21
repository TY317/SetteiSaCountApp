//
//  newKingHanaViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/21.
//

import SwiftUI

struct newKingHanaViewBayes: View {
    @ObservedObject var newKingHana: NewKingHana
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,6]   // その機種の設定段階
    let payoutList: [Double] = [97, 99.0, 101, 104, 108]
    @State var bigEnable: Bool = true
    @State var regEnable: Bool = true
    @State var bellEnable: Bool = true
    @State var bbSuikaEnable: Bool = true
    @State var bigLampEnable: Bool = true
    @State var regSideLampEnable: Bool = true
    
    // 全機種共通
    @EnvironmentObject var common: commonVar
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
            }
            
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: newKingHana.machineName,
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
                ratio: newKingHana.ratioFirstHitBig,
                Count: newKingHana.totalBigCount,
                bigNumber: newKingHana.currentGames
            )
        }
        // REG確率
        var logPostReg = [Double](repeating: 0, count: self.settingList.count)
        if self.regEnable {
            logPostReg = logPostDenoBino(
                ratio: newKingHana.ratioFirstHitReg,
                Count: newKingHana.totalRegCount,
                bigNumber: newKingHana.currentGames
            )
        }
        // ベル確率
        var logPostBell = [Double](repeating: 0, count: self.settingList.count)
        if self.bellEnable {
            // ベル逆算ONの場合
            if newKingHana.startBackCalculationEnable {
                logPostBell = logPostDenoBino(
                    ratio: newKingHana.ratioBell,
                    Count: newKingHana.totalBellCount,
                    bigNumber: newKingHana.currentGames
                )
            }
            // ベル逆算OFFの場合
            else {
                logPostBell = logPostDenoBino(
                    ratio: newKingHana.ratioBell,
                    Count: newKingHana.bellCount,
                    bigNumber: newKingHana.playGames
                )
            }
        }
        
        // トロフィー
        var logPostTrophy: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.over2Check {
            logPostTrophy[0] = -Double.infinity
        }
        if self.over4Check {
            logPostTrophy[0] = -Double.infinity
            logPostTrophy[1] = -Double.infinity
        }
        if self.over5Check {
            logPostTrophy[0] = -Double.infinity
            logPostTrophy[1] = -Double.infinity
            logPostTrophy[2] = -Double.infinity
        }
        if self.over6Check {
            logPostTrophy[0] = -Double.infinity
            logPostTrophy[1] = -Double.infinity
            logPostTrophy[2] = -Double.infinity
            logPostTrophy[3] = -Double.infinity
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
            
            logPostTrophy,
            logPostBefore,
        ])
        
        // 事後確率の算出
        let afterGuess = bayesResultRatioFunc(logPost: logPostSum)
        
        return afterGuess
    }
    
    // //// 選択した設定配分配列を返す
    func selectedGuess(pattern: String) -> [Int] {
        switch pattern {
        case bayes.guessPatternList[0]: return bayes.guess5Default
        case bayes.guessPatternList[1]: return bayes.guess5JugDefault
        case bayes.guessPatternList[2]: return bayes.guess5Evenly
        case bayes.guessPatternList[3]: return bayes.guess5Half
        case bayes.guessPatternList[4]: return bayes.guess5Quater
        case bayes.guessPatternList[5]: return self.guessCustom1
        case bayes.guessPatternList[6]: return self.guessCustom2
        case bayes.guessPatternList[7]: return self.guessCustom3
        default: return bayes.guess5Default
        }
    }
}

#Preview {
    newKingHanaViewBayes(
        newKingHana: NewKingHana(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
