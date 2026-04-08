//
//  jormungandViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/04.
//

import SwiftUI

struct jormungandViewBayes: View {
    @ObservedObject var jormungand: Jormungand
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.8, 98.8, 100.9, 104.7, 109.6, 113.9]
    @State var firstHitCzEnable: Bool = true
    @State var firstHitAtEnable: Bool = true
    @State var rareCzEnable: Bool = true
    @State var tenjoEnable: Bool = true
    
    
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
                // レア役からのCZ当選率
                unitToggleWithQuestion(enable: self.$rareCzEnable, title: "レア役からのCZ当選率") {
                    unitExView5body2image(
                        title: "レア役からのCZ当選率",
                        textBody1: "・通常時の当選率をもとに計算します"
                    )
                }
                // 天井短縮率
                unitToggleWithQuestion(enable: self.$tenjoEnable, title: "天井短縮率")
                // 初当り確率
                unitToggleWithQuestion(enable: self.$firstHitCzEnable, title: "CZ初当り確率")
                // 初当り確率
                unitToggleWithQuestion(enable: self.$firstHitAtEnable, title: "AT初当り確率")
                
            }
            
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.jormungandMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: jormungand.machineName,
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
        // レア役からのCZ当選率
        var logPostRareCzChance: [Double] = [Double](repeating: 0, count: self.settingList.count)
        var logPostRareCzKyoCherry: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.rareCzEnable {
            logPostRareCzChance = logPostPercentBino(
                ratio: jormungand.ratioRareCzNormalChance,
                Count: jormungand.rareCzCountChanceHit,
                bigNumber: jormungand.rareCzCountChance,
            )
            logPostRareCzKyoCherry = logPostPercentBino(
                ratio: jormungand.ratioRareCzNormalKyoCherry,
                Count: jormungand.rareCzCountKyoCherryHit,
                bigNumber: jormungand.rareCzCountKyoCherry,
            )
        }
        
        // 天井短縮率
        var logPostTenjo: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.tenjoEnable {
            logPostTenjo = logPostPercentBino(
                ratio: jormungand.ratioTenjoCut,
                Count: jormungand.tenjoCountHit,
                bigNumber: jormungand.tenjoCountSum
            )
        }
        
        // 初当り確率
        var logPostFirstHitCz: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitCzEnable {
            logPostFirstHitCz = logPostDenoBino(
                ratio: jormungand.ratioFirstHitCz,
                Count: jormungand.firstHitCountCz,
                bigNumber: jormungand.normalGame
            )
        }
        
        // AT初当り確率
        var logPostFirstHitAt: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitAtEnable {
            logPostFirstHitAt = logPostDenoBino(
                ratio: jormungand.ratioFirstHitAt,
                Count: jormungand.firstHitCountAt,
                bigNumber: jormungand.normalGame
            )
        }
        
        // トロフィー
        var logPostTrophy: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.over2Check {
            logPostTrophy[0] = -Double.infinity
        }
        if self.over3Check {
            logPostTrophy[0] = -Double.infinity
            logPostTrophy[1] = -Double.infinity
        }
        if self.over4Check {
            logPostTrophy[0] = -Double.infinity
            logPostTrophy[1] = -Double.infinity
            logPostTrophy[2] = -Double.infinity
        }
        if self.over5Check {
            logPostTrophy[0] = -Double.infinity
            logPostTrophy[1] = -Double.infinity
            logPostTrophy[2] = -Double.infinity
            logPostTrophy[3] = -Double.infinity
        }
        if self.over6Check {
            logPostTrophy[0] = -Double.infinity
            logPostTrophy[1] = -Double.infinity
            logPostTrophy[2] = -Double.infinity
            logPostTrophy[3] = -Double.infinity
            logPostTrophy[4] = -Double.infinity
        }
        
        // 事前確率の対数尤度
        let logPostBefore = logPostBeforeFunc(
            guess: selectedGuess(
                pattern: self.selectedBeforeGuessPattern
            )
        )
        
        // 判別要素の尤度合算
        let logPostSum: [Double] = arraySumDouble([
            logPostRareCzChance,
            logPostRareCzKyoCherry,
            logPostTenjo,
            logPostFirstHitCz,
            logPostFirstHitAt,
            
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
    jormungandViewBayes(
        jormungand: Jormungand(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
