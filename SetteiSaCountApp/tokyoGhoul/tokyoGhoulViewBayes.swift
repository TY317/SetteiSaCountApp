//
//  tokyoGhoulViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/18.
//

import SwiftUI

struct tokyoGhoulViewBayes: View {
//    @ObservedObject var ver380: Ver380
    @ObservedObject var tokyoGhoul: TokyoGhoul
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.5, 99.0, 101.6, 105.6, 110.3, 114.9]
    @State var firstHitEnable: Bool = true
    @State var under100Enable: Bool = true
    @State var tsukiyamaEnable: Bool = true
    @State var screenEnable: Bool = true
    @State var endingEnable: Bool = true
    @State var superHighEnable: Bool = true
    
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
                // 初当り
                unitToggleWithQuestion(enable: self.$firstHitEnable, title: "初当り確率") {
                    unitExView5body2image(
                        title: "初当り確率",
                        textBody1: "・CZ REMINISCENCE",
                        textBody2: "・CZ 大喰いの利世",
                        textBody3: "・エピソードボーナス",
                        textBody4: "・AT",
                        textBody5: "の初当り確率を計算要素に加えます",
                    )
                }
                // 100G以内当選率
//                unitToggleWithQuestion(enable: self.$under100Enable, title: "100G以内当選率")
                unitToggleWithQuestion(enable: self.$under100Enable, title: "引き戻し当選率")
                // 月山招待状
                unitToggleWithQuestion(enable: self.$tsukiyamaEnable, title: "月山招待状") {
                    unitExView5body2image(
                        title: "月山招待状",
                        textBody1: "・設定否定系、確定系のみ反映させます"
                    )
                }
                // 精神世界保証G数
                unitToggleWithQuestion(enable: self.$superHighEnable, title: "精神世界 保証G数振分け")
                // AT終了画面
                unitToggleWithQuestion(enable: self.$screenEnable, title: "AT終了画面") {
                    unitExView5body2image(
                        title: "AT終了画面",
                        textBody1: "・設定否定系、確定系のみ反映させます"
                    )
                }
                // エンディング
                unitToggleWithQuestion(enable: self.$endingEnable, title: "エンディングカード") {
                    unitExView5body2image(
                        title: "エンディングカード",
                        textBody1: "・設定否定系、確定系のみ反映させます"
                    )
                }
                // ケロットトロフィー
                DisclosureGroup("ナミちゃんトロフィー") {
                    unitToggleWithQuestion(enable: self.$over2Check, title: "銅")
                    unitToggleWithQuestion(enable: self.$over3Check, title: "銀")
                    unitToggleWithQuestion(enable: self.$over4Check, title: "金")
                    unitToggleWithQuestion(enable: self.$over5Check, title: "特殊柄")
                    unitToggleWithQuestion(enable: self.$over6Check, title: "虹")
                }
            }
            
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver380.tokyoGhoulMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "東京喰種",
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
        // レミニセンスの対数尤度
        var logPostRemini = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostRemini = logPostDenoBino(
                ratio: [300.5, 295.1, 287.6, 276.7, 262.7, 251.2],
                Count: tokyoGhoul.czCountRemini,
                bigNumber: tokyoGhoul.playGameSum
            )
        }
        // リゼの対数尤度
        var logPostRise = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostRise = logPostDenoBino(
                ratio: [2079.1, 1906.5, 1722.8, 1478.9, 1226.6, 1074.9],
                Count: tokyoGhoul.czCountRise,
                bigNumber: tokyoGhoul.playGameSum
            )
        }
        // エピソードボーナスの対数尤度
        var logPostEpisode: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostEpisode = logPostDenoBino(
                ratio: [6620.2, 5879.7, 5114.5, 4062.5, 3166.7, 2639.5],
                Count: tokyoGhoul.czCountEpisode,
                bigNumber: tokyoGhoul.playGameSum
            )
        }
        // ATの対数尤度
        var logPostAt: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostAt = logPostDenoBino(
                ratio: [394.4, 380.5, 357.0, 325.9, 291.2, 261.3],
                Count: tokyoGhoul.atCount,
                bigNumber: tokyoGhoul.playGameSum
            )
        }
        // 100G以内の当選率
        var logPost100G: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.under100Enable {
//            logPost100G = logPostPercentBino(
//                ratio: [19.58, 21.04, 23.15, 26.37, 31.96, 36.01],
//                Count: tokyoGhoul.under100CountHit,
//                bigNumber: tokyoGhoul.firstHitCountSum,
//            )
            logPost100G = logPostPercentBino(
                ratio: tokyoGhoul.ratioComeBack,
                Count: tokyoGhoul.comeBackCountHit,
                bigNumber: tokyoGhoul.comeBackCountSum
            )
        }
        // 月山招待状の尤度
        var logPostTsukiyama: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.tsukiyamaEnable {
            // 設定1否定
            if tokyoGhoul.tsukiyamaCountNot1 > 0 {
                logPostTsukiyama[0] = -Double.infinity
            }
            // 設定2否定
            if tokyoGhoul.tsukiyamaCountNot2 > 0 {
                logPostTsukiyama[1] = -Double.infinity
            }
            // 設定3否定
            if tokyoGhoul.tsukiyamaCountNot3 > 0 {
                logPostTsukiyama[2] = -Double.infinity
            }
            // 設定4否定
            if tokyoGhoul.tsukiyamaCountNot4 > 0 {
                logPostTsukiyama[3] = -Double.infinity
            }
            // 設定4以上濃厚
            if tokyoGhoul.tsukiyamaCountOver4 > 0 {
                logPostTsukiyama[0] = -Double.infinity
                logPostTsukiyama[1] = -Double.infinity
                logPostTsukiyama[2] = -Double.infinity
            }
            // 設定6以上濃厚
            if tokyoGhoul.tsukiyamaCountOver6 > 0 {
                logPostTsukiyama[0] = -Double.infinity
                logPostTsukiyama[1] = -Double.infinity
                logPostTsukiyama[2] = -Double.infinity
                logPostTsukiyama[3] = -Double.infinity
                logPostTsukiyama[4] = -Double.infinity
            }
        }
        // AT終了画面の尤度
        var logPostScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.screenEnable {
            // 1否定
            if tokyoGhoul.screenCountNot1 > 0 {
                logPostScreen[0] = -Double.infinity
            }
            // ４以上
            if tokyoGhoul.screenCountOver4 > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
                logPostScreen[2] = -Double.infinity
            }
            // 6以上
            if tokyoGhoul.screenCountOver6 > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
                logPostScreen[2] = -Double.infinity
                logPostScreen[3] = -Double.infinity
                logPostScreen[4] = -Double.infinity
            }
        }
        // エンディングの尤度
        var logPostEnding: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.endingEnable {
            // 設定1 否定
            if tokyoGhoul.endingCountExcept1 > 0 {
                logPostEnding[0] = -Double.infinity
            }
            // 設定2 否定
            if tokyoGhoul.endingCountExcept2 > 0 {
                logPostEnding[1] = -Double.infinity
            }
            // 設定3 否定
            if tokyoGhoul.endingCountExcept3 > 0 {
                logPostEnding[2] = -Double.infinity
            }
            // 設定4 否定
            if tokyoGhoul.endingCountExcept4 > 0 {
                logPostEnding[3] = -Double.infinity
            }
            // 設定3以上
            if tokyoGhoul.endingCountOver3 > 0 {
                logPostEnding[0] = -Double.infinity
                logPostEnding[1] = -Double.infinity
            }
            // 設定4以上
            if tokyoGhoul.endingCountOver4 > 0 {
                logPostEnding[0] = -Double.infinity
                logPostEnding[1] = -Double.infinity
                logPostEnding[2] = -Double.infinity
            }
            // 設定5以上
            if tokyoGhoul.endingCountOver5 > 0 {
                logPostEnding[0] = -Double.infinity
                logPostEnding[1] = -Double.infinity
                logPostEnding[2] = -Double.infinity
                logPostEnding[3] = -Double.infinity
            }
            // 設定6以上
            if tokyoGhoul.endingCountOver6 > 0 {
                logPostEnding[0] = -Double.infinity
                logPostEnding[1] = -Double.infinity
                logPostEnding[2] = -Double.infinity
                logPostEnding[3] = -Double.infinity
                logPostEnding[4] = -Double.infinity
            }
        }
        
        // 精神世界
        var logPostSuperHigh: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.superHighEnable {
            logPostSuperHigh = logPostPercentMulti(
                countList: [
                    tokyoGhoul.superHighCountGame13,
                    tokyoGhoul.superHighCountGame23,
                    tokyoGhoul.superHighCountGame33,
                ], ratioList: [
                    tokyoGhoul.ratioSuperHighGame13,
                    tokyoGhoul.ratioSuperHighGame23,
                    tokyoGhoul.ratioSuperHighGame33,
                ], bigNumber: tokyoGhoul.superHighCountSum
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
            logPostRemini,
            logPostRise,
            logPostEpisode,
            logPostAt,
            logPost100G,
            logPostTsukiyama,
            logPostScreen,
            logPostEnding,
            logPostTrophy,
            logPostBefore,
            logPostSuperHigh,
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
    tokyoGhoulViewBayes(
//        ver380: Ver380(),
        tokyoGhoul: TokyoGhoul(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
