//
//  darlingViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/06.
//

import SwiftUI

struct darlingViewBayes: View {
//    @ObservedObject var ver390: Ver390
    @ObservedObject var darling: Darling
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.8, 98.9, 100.6, 105.4, 110.5, 114.5]
    @State var franksEnable: Bool = true
    @State var firstHitEnable: Bool = true
    @State var czStartLevel: Bool = true
    @State var czFinalLevel: Bool = true
    @State var endingEnable: Bool = true
    
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
                // フランクス高確移行率
                unitToggleWithQuestion(enable: self.$franksEnable, title: "フランクス高確移行率") {
                    unitExView5body2image(
                        title: "フランクス高確移行率",
                        textBody1: "・通常時のチェリー、チャンス目からのフランクス高確移行率を計算要素に加えます",
                    )
                }
                // 初当り確率
                unitToggleWithQuestion(enable: self.$firstHitEnable, title: "初当り確率") {
                    unitExView5body2image(
                        title: "初当り確率",
                        textBody1: "・CZ、ボーナス、ボーナス高確率の初当り確率を計算要素に加えます"
                    )
                }
                // CZ 初期レベルの振分け
                unitToggleWithQuestion(enable: self.$czStartLevel, title: "CZ 初期レベルの振分け")
                // CZ 最終レベル別の当選率
                unitToggleWithQuestion(enable: self.$czFinalLevel, title: "CZ 最終レベル別の当選率")
                // エンディング
                unitToggleWithQuestion(enable: self.$endingEnable, title: "エンディング示唆") {
                    unitExView5body2image(
                        title: "エンディング示唆",
                        textBody1: "・確定系のみ反映させます",
                    )
                }
                // ナミちゃんトロフィー
                DisclosureGroup("ナミちゃんトロフィー") {
                    unitToggleWithQuestion(enable: self.$over2Check, title: "銅")
                    unitToggleWithQuestion(enable: self.$over3Check, title: "銀")
                    unitToggleWithQuestion(enable: self.$over4Check, title: "金")
                    unitToggleWithQuestion(enable: self.$over5Check, title: "フランクス柄")
                    unitToggleWithQuestion(enable: self.$over6Check, title: "虹")
                }
            }
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver390.darlingMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: darling.machineName,
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
        // フランクス高確チェリー
        var logPostFranksCherry: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.franksEnable {
            logPostFranksCherry = logPostPercentBino(
                ratio: darling.ratioKokakuCherry,
                Count: darling.kokakuCountCherryHit,
                bigNumber: darling.kokakuCountCherrySum
            )
        }
        // フランクス高確チャンス目
        var logPostFranksChance: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.franksEnable {
            logPostFranksChance = logPostPercentBino(
                ratio: darling.ratioKokakuChance,
                Count: darling.kokakuCountChanceHit,
                bigNumber: darling.kokakuCountChanceSum
            )
        }
        //  CZ初当り
        var logPostCz: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostCz = logPostDenoBino(
                ratio: darling.ratioCz,
                Count: darling.czCount,
                bigNumber: darling.normalGame
            )
        }
        // ボーナス初当り
        var logPostBonus: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostBonus = logPostDenoBino(
                ratio: darling.ratioBonus,
                Count: darling.bonusCount,
                bigNumber: darling.normalGame
            )
        }
        // ボーナス高確初当り
        var logPostBonusKokaku: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostBonusKokaku = logPostDenoBino(
                ratio: darling.ratioKokaku,
                Count: darling.kokakuCount,
                bigNumber: darling.normalGame
            )
        }
        // CZ 初期レベル
        var logPostStartLevel: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.czStartLevel {
            logPostStartLevel = logPostPercentMulti(
                countList: [
                    darling.czLevelCountWhite,
                    darling.czLevelCountBlue,
                    darling.czLevelCountYellow,
                    darling.czLevelCountGreen,
                    darling.czLevelCountRed,
                ], ratioList: [
                    darling.ratioCzLevelWhite,
                    darling.ratioCzLevelBlue,
                    darling.ratioCzLevelYellow,
                    darling.ratioCzLevelGreen,
                    darling.ratioCzLevelRed,
                ], bigNumber: darling.czLevelCountSum
            )
        }
        // 最終レベル　白
        var logPostFLWhite: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.czFinalLevel {
            logPostFLWhite = logPostPercentBino(
                ratio: darling.ratioCzFLWhite,
                Count: darling.czFLCountWhiteHit,
                bigNumber: darling.czFLCountWhiteSum
            )
        }
        // 最終レベル　青
        var logPostFLBlue: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.czFinalLevel {
            logPostFLBlue = logPostPercentBino(
                ratio: darling.ratioCzFLBlue,
                Count: darling.czFLCountBlueHit,
                bigNumber: darling.czFLCountBlueSum
            )
        }
        // 最終レベル　黄色
        var logPostFLYellow: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.czFinalLevel {
            logPostFLYellow = logPostPercentBino(
                ratio: darling.ratioCzFLYellow,
                Count: darling.czFLCountYellowHit,
                bigNumber: darling.czFLCountYellowSum
            )
        }
        // 最終レベル　緑
        var logPostFLGreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.czFinalLevel {
            logPostFLGreen = logPostPercentBino(
                ratio: darling.ratioCzFLGreen,
                Count: darling.czFLCountGreenHit,
                bigNumber: darling.czFLCountGreenSum
            )
        }
        // 最終レベル　赤
        var logPostFLRed: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.czFinalLevel {
            logPostFLRed = logPostPercentBino(
                ratio: darling.ratioCzFLRed,
                Count: darling.czFLCountRedHit,
                bigNumber: darling.czFLCountRedSum
            )
        }
        // エンディング
        var logPostEnding: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.endingEnable {
            if darling.endingCountOver2 > 0 {
                logPostEnding[0] = -Double.infinity
            }
            if darling.endingCountOver6 > 0 {
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
            logPostFranksCherry,
            logPostFranksChance,
            logPostCz,
            logPostBonus,
            logPostBonusKokaku,
            logPostStartLevel,
            logPostFLWhite,
            logPostFLBlue,
            logPostFLYellow,
            logPostFLGreen,
            logPostFLRed,
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
    darlingViewBayes(
//        ver390: Ver390(),
        darling: Darling(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
