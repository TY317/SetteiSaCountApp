//
//  newOni3ViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/11.
//

import SwiftUI

struct newOni3ViewBayes: View {
    @ObservedObject var newOni3: NewOni3
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.5, 98.3, 100.2, 105.2, 109.2, 113.0]
    @State var firstHitEnable: Bool = true
    @State var screenEnable: Bool = true
    @State var oniBonusEnable: Bool = true
    @State var endingEnable: Bool = true
    
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
                // 初当り
                unitToggleWithQuestion(enable: self.$firstHitEnable, title: "初当り確率")
                // 鬼ボーナス
                unitToggleWithQuestion(enable: self.$oniBonusEnable, title: "鬼ボーナス中のキャラ") {
                    unitExView5body2image(
                        title: "鬼ボーナス中のキャラ",
                        textBody1: "・確定系のみ反映させます"
                    )
                }
                // AT終了画面
                unitToggleWithQuestion(enable: self.$screenEnable, title: "AT終了画面") {
                    unitExView5body2image(
                        title: "AT終了画面",
                        textBody1: "・確定系のみ反映させます"
                    )
                }
                // エンディング
                unitToggleWithQuestion(enable: self.$endingEnable, title: "エンディング中のボイス") {
                    unitExView5body2image(
                        title: "エンディング中のボイス",
                        textBody1: "・確定系、否定系のみ反映させます",
                    )
                }
            }
            
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($common.newOni3MenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: newOni3.machineName,
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
        // 初当り
        var logPostFirstHitAt: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostFirstHitAt = logPostDenoBino(
                ratio: newOni3.ratioFirstHitAt,
                Count: newOni3.firstHitCountAt,
                bigNumber: newOni3.normalGame
            )
        }
        // 鬼ボーナス
        var logPostOniBonus: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.oniBonusEnable {
            if newOni3.personFinalCountOver2 > 0 {
                logPostOniBonus[0] = -Double.infinity
            }
            if newOni3.personFinalCountOver3 > 0 {
                logPostOniBonus[0] = -Double.infinity
                logPostOniBonus[1] = -Double.infinity
            }
            if newOni3.personFinalCountOver4 > 0 {
                logPostOniBonus[0] = -Double.infinity
                logPostOniBonus[1] = -Double.infinity
                logPostOniBonus[2] = -Double.infinity
            }
            if newOni3.personFinalCountOver5 > 0 {
                logPostOniBonus[0] = -Double.infinity
                logPostOniBonus[1] = -Double.infinity
                logPostOniBonus[2] = -Double.infinity
                logPostOniBonus[3] = -Double.infinity
            }
            if newOni3.personFinalCountOver6 > 0 {
                logPostOniBonus[0] = -Double.infinity
                logPostOniBonus[1] = -Double.infinity
                logPostOniBonus[2] = -Double.infinity
                logPostOniBonus[3] = -Double.infinity
                logPostOniBonus[4] = -Double.infinity
            }
        }
        // AT終了画面
        var logPostScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.screenEnable {
            if newOni3.screenCountOver2 > 0 {
                logPostScreen[0] = -Double.infinity
            }
            if newOni3.screenCountOver3 > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
            }
            if newOni3.screenCountOver4 > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
                logPostScreen[2] = -Double.infinity
            }
            if newOni3.screenCountOver5 > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
                logPostScreen[2] = -Double.infinity
                logPostScreen[3] = -Double.infinity
            }
            if newOni3.screenCountOver6 > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
                logPostScreen[2] = -Double.infinity
                logPostScreen[3] = -Double.infinity
                logPostScreen[4] = -Double.infinity
            }
        }
        // エンディング
        var logPostEnding: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.endingEnable {
            if newOni3.endingCountNegate2 > 0 {
                logPostEnding[1] = -Double.infinity
            }
            if newOni3.endingCountNegate3 > 0 {
                logPostEnding[2] = -Double.infinity
            }
            if newOni3.endingCountNegate4 > 0 {
                logPostEnding[3] = -Double.infinity
            }
            if newOni3.endingCountOver2 > 0 {
                logPostEnding[0] = -Double.infinity
            }
            if newOni3.endingCountOver3 > 0 {
                logPostEnding[0] = -Double.infinity
                logPostEnding[1] = -Double.infinity
            }
            if newOni3.endingCountOver4 > 0 {
                logPostEnding[0] = -Double.infinity
                logPostEnding[1] = -Double.infinity
                logPostEnding[2] = -Double.infinity
            }
            if newOni3.endingCountOver5 > 0 {
                logPostEnding[0] = -Double.infinity
                logPostEnding[1] = -Double.infinity
                logPostEnding[2] = -Double.infinity
                logPostEnding[3] = -Double.infinity
            }
            if newOni3.endingCountOver6 > 0 {
                logPostEnding[0] = -Double.infinity
                logPostEnding[1] = -Double.infinity
                logPostEnding[2] = -Double.infinity
                logPostEnding[3] = -Double.infinity
                logPostEnding[4] = -Double.infinity
            }
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
            logPostFirstHitAt,
            logPostOniBonus,
            logPostScreen,
            logPostEnding,
            
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
    newOni3ViewBayes(
        newOni3: NewOni3(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
