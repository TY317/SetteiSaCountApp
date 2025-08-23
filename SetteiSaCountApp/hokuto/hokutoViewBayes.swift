//
//  hokutoViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/19.
//

import SwiftUI

struct hokutoViewBayes: View {
    @ObservedObject var ver380: Ver380
    @ObservedObject var hokuto: Hokuto
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [98.0, 98.9, 105.7, 110.0, 113.0]
    @State var normalBellEnable: Bool = true
    @State var normalRareEnable: Bool = true
    @State var firstHitEnable: Bool = true
    @State var bbBellEnable: Bool = true
    @State var voiceEnable: Bool = true
    
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
                // 平行ベル確率
                unitToggleWithQuestion(enable: self.$normalBellEnable, title: "通常時の平行ベル確率") {
                    unitExView5body2image(
                        title: "通常時の平行ベル確率",
                        textBody1: "・通常時の中段平行ベルの出現確率を計算要素に加えます",
                    )
                }
                // レア役確率
                unitToggleWithQuestion(enable: self.$normalRareEnable, title: "レア役確率") {
                    unitExView5body2image(
                        title: "レア役確率",
                        textBody1: "・🍉合算確率と中段🍒確率を計算要素に加えます"
                    )
                }
                // バトルボーナス初当り確率
                unitToggleWithQuestion(enable: self.$firstHitEnable, title: "バトルボーナス初当り確率")
                // 平行ベル確率
                unitToggleWithQuestion(enable: self.$bbBellEnable, title: "BB中の平行ベル確率") {
                    unitExView5body2image(
                        title: "BB中の平行ベル確率",
                        textBody1: "・バトルボーナス中の中段平行ベルの出現確率を計算要素に加えます",
                    )
                }
                // BB後のボイス
                unitToggleWithQuestion(enable: self.$voiceEnable, title: "バトルボーナス後のボイス")
                // サミートロフィー
                DisclosureGroup("サミートロフィー") {
                    unitToggleWithQuestion(enable: self.$over4Check, title: "金")
                    unitToggleWithQuestion(enable: self.$over5Check, title: "キリン柄")
                    unitToggleWithQuestion(enable: self.$over6Check, title: "虹")
                }
            }
            
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver380.hokutoMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "スマスロ北斗の拳",
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
        // 通常時ベル
        var logPostNormalBell: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.normalBellEnable {
            logPostNormalBell = logPostDenoBino(
                ratio: [170,152.5,135,117.5,100],
                Count: hokuto.normalBellHorizontalCount,
                bigNumber: hokuto.normalPlayGame
            )
        }
        // レア役確率
        // スイカ
        var logPostSuika: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.normalRareEnable {
            logPostSuika = logPostDenoBino(
                ratio: [86.1,85.7,82.6,78.3,76.1],
                Count: hokuto.rareCountSuikaSum,
                bigNumber: hokuto.totalGame
            )
        }
        // 中段チェリー
        var logPostCherry: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.normalRareEnable {
            logPostCherry = logPostDenoBino(
                ratio: [210.1,204.8,199.8,195,190.5],
                Count: hokuto.rareCount2Cherry,
                bigNumber: hokuto.totalGame
            )
        }
        // バトルボーナス初当り
        var logPostFirstHit: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostFirstHit = logPostDenoBino(
                ratio: [383.4,370.5,297.8,258.7,235.1],
                Count: hokuto.bbHitCount,
                bigNumber: hokuto.bbGameSum
            )
        }
        // BB中の中段ベル
        var logPostBbBell: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.bbBellEnable {
            logPostBbBell = logPostDenoBino(
                ratio: [400,357.5,315,272.5,230],
                Count: hokuto.bbBellHorizontalCount,
                bigNumber: hokuto.bbPlayGame
            )
        }
        // ボイス
        var logPostVoice: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.voiceEnable {
            logPostVoice = logPostPercentMulti(
                countList: [
                    hokuto.voiceDefaultCount,
                    hokuto.voiceShinCount,
                    hokuto.voiceSauzaCount,
                    hokuto.voiceJagiCount,
                    hokuto.voiceAmibaCount,
                ],
                ratioList: [
                    [84.7,83.3,74,73,71],
                    [5.7,6.1,6.3,6.7,7.2],
                    [5.0,5.3,6.3,6.7,7.2],
                    [3.4,3.8,6.3,6.7,7.2],
                    [1.2,1.5,6.3,6.7,7.2],
                ],
                bigNumber: hokuto.voiceCountSum
            )
            // ケン
            if hokuto.voiceKenCount > 0 {
                logPostVoice[0] = -Double.infinity
                logPostVoice[1] = -Double.infinity
            }
            // ユリア
            if hokuto.voiceYuriaCount > 0 {
                logPostVoice[0] = -Double.infinity
                logPostVoice[1] = -Double.infinity
                logPostVoice[2] = -Double.infinity
            }
        }
        
        // トロフィー
        var logPostTrophy: [Double] = [Double](repeating: 0, count: self.settingList.count)
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
                pattern: self.selectedBeforeGuessPattern
            )
        )
        
        // 判別要素の尤度合算
        let logPostSum: [Double] = arraySumDouble([
            logPostNormalBell,
            logPostSuika,
            logPostCherry,
            logPostFirstHit,
            logPostBbBell,
            logPostVoice,
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
    hokutoViewBayes(
        ver380: Ver380(),
        hokuto: Hokuto(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
