//
//  thunderViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/14.
//

import SwiftUI

struct thunderViewBayes: View {
    @ObservedObject var thunder: Thunder
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,5,6]   // その機種の設定段階
    let payoutList: [Double] = [100.5, 102.0, 105.0, 108.1]
    @State var koyakuEnable: Bool = true
    @State var firstEnable: Bool = true
    @State var btLoopEnable: Bool = true
    @State var bbKoyakuEnable: Bool = true
    
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
                // 小役確率
                unitToggleWithQuestion(enable: self.$koyakuEnable, title: "小役確率")
                // 初当り確立
                unitToggleWithQuestion(enable: self.$firstEnable, title: "初当り確率") {
                    unitExView5body2image(
                        title: "初当り確率",
                        textBody1: "・BIG,REG確率を計算要素に加えます"
                    )
                }
                // BTループ率
                unitToggleWithQuestion(enable: self.$btLoopEnable, title: "BTループ率")
                // BB中小役確率
                unitToggleWithQuestion(enable: self.$bbKoyakuEnable, title: "BB中小役確率")
            }
            
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.thunderMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: thunder.machineName,
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
        // 小役確率
        var logPostKoyaku: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.koyakuEnable {
            logPostKoyaku = logPostDenoMulti(
                countList: [
                    thunder.normalKoyakuCountBellA,
                    thunder.normalKoyakuCountBellB,
                    thunder.normalKoyakuCountSuika,
                    thunder.normalKoyakuCountCherryB,
                ], denoList: [
                    thunder.ratioBellA,
                    thunder.ratioBellB,
                    thunder.ratioSuika,
                    thunder.ratioCherryB,
                ], bigNumber: thunder.playGame
            )
        }
        
        // ボーナス確率
        var logPostBonus: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstEnable {
            logPostBonus = logPostDenoMulti(
                countList: [
                    thunder.totalBig,
                    thunder.totalReg,
                ], denoList: [
                    thunder.ratioBig,
                    thunder.ratioReg,
                ], bigNumber: thunder.totalGame
            )
        }
        
        // BTループ率
        var logPostBtLoop: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.btLoopEnable {
            logPostBtLoop = logPostPercentBino(
                ratio: thunder.ratioBtLoop,
                Count: thunder.btRedSeven,
                bigNumber: thunder.playBig
            )
        }
        
        // BB中小役確率
        var logPostBbKoyaku: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.bbKoyakuEnable {
            logPostBbKoyaku = logPostDenoMulti(
                countList: [
                    thunder.bbCountBellB,
                    thunder.bbCountBellC,
                    thunder.bbCountReach,
                ], denoList: [
                    thunder.ratioBbBellB,
                    thunder.ratioBbBellC,
                    thunder.ratioBbReach,
                ], bigNumber: thunder.bbGame
            )
        }
        
        // トロフィー
        var logPostTrophy: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.over2Check {
            logPostTrophy[0] = -Double.infinity
        }
        if self.over5Check {
            logPostTrophy[0] = -Double.infinity
            logPostTrophy[1] = -Double.infinity
        }
        if self.over6Check {
            logPostTrophy[0] = -Double.infinity
            logPostTrophy[1] = -Double.infinity
            logPostTrophy[2] = -Double.infinity
        }
        
        // 事前確率の対数尤度
        let logPostBefore = logPostBeforeFunc(
            guess: selectedGuess(
                pattern: self.selectedBeforeGuessPattern
            )
        )
        
        // 判別要素の尤度合算
        let logPostSum: [Double] = arraySumDouble([
            logPostKoyaku,
            logPostBonus,
            logPostBtLoop,
            logPostBbKoyaku,
            
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
        case bayes.guessPatternList[0]: return bayes.guess4Default
        case bayes.guessPatternList[1]: return bayes.guess4JugDefault
        case bayes.guessPatternList[2]: return bayes.guess4Evenly
        case bayes.guessPatternList[3]: return bayes.guess4Half
        case bayes.guessPatternList[4]: return bayes.guess4Quater
        case bayes.guessPatternList[5]: return self.guessCustom1
        case bayes.guessPatternList[6]: return self.guessCustom2
        case bayes.guessPatternList[7]: return self.guessCustom3
        default: return bayes.guess6Default
        }
    }
}

#Preview {
    thunderViewBayes(
        thunder: Thunder(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
