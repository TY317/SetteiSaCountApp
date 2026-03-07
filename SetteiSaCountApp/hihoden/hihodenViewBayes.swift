//
//  hihodenViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/13.
//

import SwiftUI

struct hihodenViewBayes: View {
    @ObservedObject var hihoden: Hihoden
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.8, 99.0, 101.5, 105.1, 110.1, 114.7]
    @State var koyakuEnable: Bool = true
    @State var firstHitEnable: Bool = true
    @State var bonusHazureEnable: Bool = true
    @State var charaEnable: Bool = true
    @State var chanceKokakuEnable: Bool = true
    @State var legendAfterKokakuMissEnable: Bool = true
    
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
                // 🍒確率
                unitToggleWithQuestion(enable: self.$koyakuEnable, title: "🍒確率")
                // チャンス目からの高確率
                unitToggleWithQuestion(enable: self.$chanceKokakuEnable, title: "チャンス目からの高確率")
                // 初当り
                unitToggleWithQuestion(enable: self.$firstHitEnable, title: "初当り確率")
                unitToggleWithQuestion(enable: self.$bonusHazureEnable, title: "ボーナス中ハズレ確率")
                
                // キャラ紹介
                unitToggleWithQuestion(enable: self.$charaEnable, title: "REG中キャラ紹介") {
                    unitExView5body2image(
                        title: "REG中キャラ紹介",
                        textBody1: "・否定系、確定系のみ反映させます"
                    )
                }
                
                // 高確率失敗後の伝説モード移行率
                unitToggleWithQuestion(enable: self.$legendAfterKokakuMissEnable, title: "高確率失敗後の伝説モード移行率")
                
                // コパンダトロフィー
                DisclosureGroup("コパンダトロフィー") {
                    unitToggleWithQuestion(enable: self.$over2Check, title: "銅")
                    unitToggleWithQuestion(enable: self.$over3Check, title: "銀")
                    unitToggleWithQuestion(enable: self.$over4Check, title: "金")
                    unitToggleWithQuestion(enable: self.$over5Check, title: "イナズマ柄")
                    unitToggleWithQuestion(enable: self.$over6Check, title: "虹")
                }
            }
            
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hihodenMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hihoden.machineName,
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
        // チェリー確率
        var logPostCherry: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.koyakuEnable {
            logPostCherry = logPostDenoBino(
                ratio: hihoden.ratioKoyakuCherry,
                Count: hihoden.koyakuCountCherry,
                bigNumber: hihoden.totalGame
            )
        }
        // チャンス目からの高確率
        var logPostChanceKokaku: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.chanceKokakuEnable {
            logPostChanceKokaku = logPostPercentBino(
                ratio: hihoden.ratioChanceKokaku,
                Count: hihoden.chanceKokakuCount,
                bigNumber: hihoden.koyakuCountChance
            )
        }
        // 初当り確率
        var logPostFirstHit: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostFirstHit = logPostDenoBino(
                ratio: hihoden.ratioFirstHit,
                Count: hihoden.firstHitCount,
                bigNumber: hihoden.normalGame,
            )
        }
        // ボーナス中ハズレ確率
        var logPostBonusMiss: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.bonusHazureEnable {
            logPostBonusMiss = logPostDenoBino(
                ratio: hihoden.ratioBonusHazure,
                Count: hihoden.bonusHazureCount,
                bigNumber: hihoden.bonusGame,
            )
        }
        // REG中キャラ紹介
        var logPostChara: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.charaEnable {
            if hihoden.charaCountNegate2 > 0 {
                logPostChara[1] = -Double.infinity
            }
            if hihoden.charaCountNegate3 > 0 {
                logPostChara[2] = -Double.infinity
            }
            if hihoden.charaCountNegate4 > 0 {
                logPostChara[3] = -Double.infinity
            }
            if hihoden.charaCountOver2 > 0 {
                logPostChara[0] = -Double.infinity
            }
            if hihoden.charaCountOver4 > 0 {
                logPostChara[0] = -Double.infinity
                logPostChara[1] = -Double.infinity
                logPostChara[2] = -Double.infinity
            }
            if hihoden.charaCountOver5 > 0 {
                logPostChara[0] = -Double.infinity
                logPostChara[1] = -Double.infinity
                logPostChara[2] = -Double.infinity
                logPostChara[3] = -Double.infinity
            }
            if hihoden.charaCountOver6 > 0 {
                logPostChara[0] = -Double.infinity
                logPostChara[1] = -Double.infinity
                logPostChara[2] = -Double.infinity
                logPostChara[3] = -Double.infinity
                logPostChara[4] = -Double.infinity
            }
        }
        
        // 高確率失敗後の伝説モード移行率
        var logPostLegendAfterMiss: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.legendAfterKokakuMissEnable {
            logPostLegendAfterMiss = logPostPercentBino(
                ratio: hihoden.ratioLegendAfterChanceMiss,
                Count: hihoden.legendCountKokakuMissHit,
                bigNumber: hihoden.legendCountKokakuMissSum
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
            logPostCherry,
            logPostChanceKokaku,
            logPostFirstHit,
            logPostBonusMiss,
            logPostChara,
            logPostLegendAfterMiss,
            
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
    hihodenViewBayes(
        hihoden: Hihoden(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
