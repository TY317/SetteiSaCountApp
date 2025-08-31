//
//  karakuriViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/30.
//

import SwiftUI

struct karakuriViewBayes: View {
    @ObservedObject var ver380: Ver380
    @ObservedObject var karakuri: Karakuri
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.5, 98.7, 103.0, 108.1, 114.9]
    @State var makuaiEnable: Bool = true
    @State var stageEnable: Bool = true
    @State var screenEnable: Bool = true
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
                // 通常幕間
                unitToggleWithQuestion(enable: self.$makuaiEnable, title: "通常幕間確率") {
                    unitExView5body2image(
                        title: "通常幕間確率",
                        textBody1: "・スイカからの通常幕間確率を計算要素に加えます",
                    )
                }
                // AT中のステージ
                unitToggleWithQuestion(enable: self.$stageEnable, title: "AT中のステージ") {
                    unitExView5body2image(
                        title: "AT中のステージ",
                        textBody1: "AT開始時のステージ振分け\nステージ移行テーブル振分け\nを計算要素に加えます"
                    )
                }
                // AT終了画面
                unitToggleWithQuestion(enable: self.$screenEnable, title: "AT終了画面") {
                    unitExView5body2image(
                        title: "AT終了画面",
                        textBody1: "・確定系のみ反映させます"
                    )
                }
                // エンディング示唆
                unitToggleWithQuestion(enable: self.$endingEnable, title: "エンディング中の示唆") {
                    unitExView5body2image(
                        title: "エンディング中の示唆",
                        textBody1: "・エンディング中のレア役成立時のランプ色を計算要素に加えます",
                        textBody2: "・弱レア役成立時の振分け確率で計算します",
                    )
                }
            }
            
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver380.karakuriMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "からくりサーカス",
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
        // 通常幕間
        var logPostMakuai: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.makuaiEnable {
            logPostMakuai = logPostDenoBino(
                ratio: [3000,2500,2000,1500,1000],
                Count: karakuri.makuaiCount,
                bigNumber: karakuri.makuaiPlayGame
            )
        }
        // AT開始時のステージ
        var logPostStage: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.stageEnable {
            logPostStage = logPostPercentBino(
                ratio: [53,40,40,60,50],
                Count: karakuri.stageCountNarumi,
                bigNumber: karakuri.stageCountFirstSum
            )
        }
        // ステージテーブル
        var logPostTable: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.stageEnable {
            logPostTable = logPostPercentMulti(
                countList: [
                    karakuri.stageCountTable1,
                    karakuri.stageCountTable2,
                    karakuri.stageCountTable3,
                    karakuri.stageCountTable4,
                ],
                ratioList: [
                    [49,37,36,52,42],
                    [45,54,52,36,42],
                    [4,3,4,8,8],
                    [2,6,8,4,8],
                ],
                bigNumber: karakuri.stageCountTableSum
            )
        }
        // AT終了画面
        var logPostScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.screenEnable {
            // 2以上
            if karakuri.atScreenCountAjino > 0 {
                logPostScreen[0] = -Double.infinity
            }
            // ４以上
            if karakuri.atScreenCount3Person > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
            }
            // ６以上
            if karakuri.atScreenCountFran > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
                logPostScreen[2] = -Double.infinity
                logPostScreen[3] = -Double.infinity
            }
        }
        // エンディング
        var logPostEnding: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.endingEnable {
            logPostEnding = logPostPercentMulti(
                countList: [
                    karakuri.endingCountWhite,
                    karakuri.endingCountBlue,
                    karakuri.endingCountYellow,
                    karakuri.endingCountGreen,
                    karakuri.endingCountRed,
                    karakuri.endingCountPurple,
                    karakuri.endingCountRainbow,
                ],
                ratioList: [
                    [48,44,41,39,35],
                    [22,16,16,22,16],
                    [16,22,22,16,22],
                    [13,15,16,18,20],
                    [1,3,3,3,3],
                    [0,0,2,2,2],
                    [0,0,0,0,2],
                ],
                bigNumber: karakuri.endingCountSum
            )
        }
        
        // 事前確率の対数尤度
        let logPostBefore = logPostBeforeFunc(
            guess: selectedGuess(
                pattern: self.selectedBeforeGuessPattern
            )
        )
        
        // 判別要素の尤度合算
        let logPostSum: [Double] = arraySumDouble([
            logPostMakuai,
            logPostStage,
            logPostTable,
            logPostScreen,
            logPostEnding,
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
    karakuriViewBayes(
        ver380: Ver380(),
        karakuri: Karakuri(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
