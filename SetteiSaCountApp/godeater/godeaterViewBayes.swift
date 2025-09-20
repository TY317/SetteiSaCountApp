//
//  godeaterViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/30.
//

import SwiftUI

struct godeaterViewBayes: View {
//    @ObservedObject var ver380: Ver380
    @ObservedObject var godeater: Godeater
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.9, 98.9, 101.1, 105.6, 110.0, 114.9]
    @State var rareCzEnable: Bool = true
    @State var firstHitEnable: Bool = true
    @State var voiceEnable: Bool = true
    @State var screenEnable: Bool = true
    
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
                // レア役からのCZ当選率
                unitToggleWithQuestion(enable: self.$rareCzEnable, title: "レア役からのCZ当選率")
                // 初当り確率
                unitToggleWithQuestion(enable: self.$firstHitEnable, title: "初当り確率") {
                    unitExView5body2image(
                        title: "初当り確率",
                        textBody1: "・CZ、ATの初当り確率を計算要素に加えます"
                    )
                }
                // ボイス
                unitToggleWithQuestion(enable: self.$voiceEnable, title: "ストリーパート後のボイス") {
                    unitExView5body2image(
                        title: "ストーリーパート後のボイス",
                        textBody1: "・確定系のみ反映させます",
                    )
                }
                // AT終了画面
                unitToggleWithQuestion(enable: self.$screenEnable, title: "AT終了画面") {
                    unitExView5body2image(
                        title: "AT終了画面",
                        textBody1: "・確定系のみ反映させます",
                    )
                }
                // ケロットトロフィー
                DisclosureGroup("ケロットトロフィー") {
                    unitToggleWithQuestion(enable: self.$over2Check, title: "銅")
                    unitToggleWithQuestion(enable: self.$over3Check, title: "銀")
                    unitToggleWithQuestion(enable: self.$over4Check, title: "金")
                    unitToggleWithQuestion(enable: self.$over5Check, title: "ケロット柄")
                    unitToggleWithQuestion(enable: self.$over6Check, title: "虹")
                }
            }
            
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver380.godeaterMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ゴッドイーター リザレクション",
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
        // チャンス目CZ
        var logPostChanceCz: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.rareCzEnable {
            logPostChanceCz = logPostPercentBino(
                ratio: godeater.ratioChanceCzHit,
                Count: godeater.normalChanceCountCzHit,
                bigNumber: godeater.normalChanceCountSeiritu
            )
        }
        // 弱チェリ、スイカCZ
        var logPostCherrySuikaCz: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.rareCzEnable {
            logPostCherrySuikaCz = logPostPercentBino(
                ratio: godeater.ratioCherrySuikaCzHit,
                Count: godeater.normalCountCzHit,
                bigNumber: godeater.normalCountCherrySuikaSum
            )
        }
        
        // CZ初当り
        var logPostCz: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostCz = logPostDenoBino(
                ratio: [392.0,378.3,359.1,343.4,324.3,310.6],
                Count: godeater.czHitCount,
                bigNumber: godeater.playGame
            )
        }
        
        // AT初当り
        var logPostAt: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostAt = logPostDenoBino(
                ratio: [351.9,344.5,330.1,317.1,302.2,290.3],
                Count: godeater.atHitCount,
                bigNumber: godeater.playGame
            )
        }
        
        // ボイス
        var logPostVoice: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.voiceEnable {
            // 2,3否定
            if godeater.voiceYuCount > 0 {
                logPostVoice[1] = -Double.infinity
                logPostVoice[2] = -Double.infinity
            }
            // 偶数濃厚
            if godeater.voiceErinaCount > 0 {
                logPostVoice[0] = -Double.infinity
                logPostVoice[2] = -Double.infinity
                logPostVoice[4] = -Double.infinity
            }
            // 設定２以上
            if godeater.voiceRindoCount > 0 {
                logPostVoice[0] = -Double.infinity
            }
            // 設定５以上
            if godeater.voiceShioCount > 0 {
                logPostVoice[0] = -Double.infinity
                logPostVoice[1] = -Double.infinity
                logPostVoice[2] = -Double.infinity
                logPostVoice[3] = -Double.infinity
            }
        }
        
        // AT終了画面
        var logPostScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.screenEnable {
            // 2,3,4否定
            if godeater.screenCountYu > 0 {
                logPostScreen[1] = -Double.infinity
                logPostScreen[2] = -Double.infinity
                logPostScreen[3] = -Double.infinity
            }
            // 3以上濃厚
            if godeater.screenCountRindo > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
            }
            // ４以上濃厚
            if godeater.screenCountShio > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
                logPostScreen[2] = -Double.infinity
            }
            // 偶数濃厚
            if godeater.screenCountCafe > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[2] = -Double.infinity
                logPostScreen[4] = -Double.infinity
            }
            // ５以上濃厚
            if godeater.screenCountAll > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
                logPostScreen[2] = -Double.infinity
                logPostScreen[3] = -Double.infinity
            }
            // ６濃厚
            if godeater.screenCountMinichara > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
                logPostScreen[2] = -Double.infinity
                logPostScreen[3] = -Double.infinity
                logPostScreen[4] = -Double.infinity
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
            logPostChanceCz,
            logPostCherrySuikaCz,
            logPostCz,
            logPostAt,
            logPostVoice,
            logPostScreen,
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
    godeaterViewBayes(
//        ver380: Ver380(),
        godeater: Godeater(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
