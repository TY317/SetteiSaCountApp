//
//  magiaViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/07.
//

import SwiftUI

struct magiaViewBayes: View {
    @ObservedObject var ver390: Ver390
    @ObservedObject var magia: Magia
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.6, 98.9, 102.0, 106.0, 110.4, 114.9]
    @State var suikaCzEnable: Bool = true
    @State var modeEnable: Bool = true
    @State var firstHitEnable: Bool = true
    @State var uwasaEnable: Bool = true
    @State var episodeEnable: Bool = true
    @State var bigScreenEnable: Bool = true
    @State var storyEnable: Bool = true
    @State var kokakuStartEnable: Bool = true
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
                // スイカからのCZ
                unitToggleWithQuestion(enable: self.$suikaCzEnable, title: "スイカからのCZ当選率") {
                    unitExView5body2image(
                        title: "スイカからのCZ当選率",
                        textBody1: "・さなモード以外滞在時の当選率を前提に計算します",
                    )
                }
                // 魔法少女モード
                unitToggleWithQuestion(enable: self.$modeEnable, title: "魔法少女モード関連") {
                    unitExView5body2image(
                        title: "魔法少女関連",
                        textBody1: "・AT終了後の移行率、いろはからの昇格率を計算要素に加えます",
                        textBody2: "・見抜けないケースも多いと思いますので気になる場合はOFFで計算して下さい",
                    )
                }
                // 初当り確率
                unitToggleWithQuestion(enable: self.$firstHitEnable, title: "初当り確率") {
                    unitExView5body2image(
                        title: "初当り確率",
                        textBody1: "・ボーナス合算、ATの初当り確率を計算要素に加えます",
                    )
                }
                // ウワサバトル発展時のAT当選率
                unitToggleWithQuestion(enable: self.$uwasaEnable, title: "ウワサバトル発展時のAT当選率") {
                    unitExView5body2image(
                        title: "ウワサバトル発展時のAT当選率",
                        textBody1: "・みたまボーナス中のウワサバトル発展時のAT当選率を計算要素に加えます",
                        textBody2: "・報酬レベル3の当選率を前提に計算します",
                    )
                }
                // エピソード振り分け
                unitToggleWithQuestion(enable: self.$episodeEnable, title: "エピソード振分け")
                // BIG終了画面
                unitToggleWithQuestion(enable: self.$bigScreenEnable, title: "BIG終了画面") {
                    unitExView5body2image(
                        title: "BIG終了画面",
                        textBody1: "・確定系のみ反映させます",
                    )
                }
                // ストーリーの順番
                unitToggleWithQuestion(enable: self.$storyEnable, title: "ストーリーの順番") {
                    unitExView5body2image(
                        title: "ストーリーの順番",
                        textBody1: "・否定系、確定系のみ反映させます",
                    )
                }
                // 高確スタート確率
                unitToggleWithQuestion(enable: self.$kokakuStartEnable, title: "高確スタート確率") {
                    unitExView5body2image(
                        title: "高確スタート確率",
                        textBody1: "・ビッグ後、AT後の高確スタート確率を計算要素に加えます",
                    )
                }
                // エンディング
                unitToggleWithQuestion(enable: self.$endingEnable, title: "エンディング中の示唆") {
                    unitExView5body2image(
                        title: "エンディング中の示唆",
                        textBody1: "・否定系、確定系のみ反映させます",
                    )
                }
                // ユニバプレート
                DisclosureGroup("ユニバプレート") {
                    unitToggleWithQuestion(enable: self.$over2Check, title: "銅")
                    unitToggleWithQuestion(enable: self.$over3Check, title: "銀")
                    unitToggleWithQuestion(enable: self.$over4Check, title: "金")
                    unitToggleWithQuestion(enable: self.$over5Check, title: "花火柄")
                    unitToggleWithQuestion(enable: self.$over6Check, title: "虹")
                }
            }
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver390.magiaMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "マギアレコード",
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
        // スイカからのCZ
        var logPostSuikaCz: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.suikaCzEnable {
            logPostSuikaCz = logPostPercentBino(
                ratio: magia.ratioSuikaCz,
                Count: magia.suikaCzCountCz,
                bigNumber: magia.suikaCzCountSuika
            )
        }
        // 魔法少女モード AT後の開始モード振り分け
        var logPostModeStart: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.modeEnable {
            logPostModeStart = logPostPercentMulti(
                countList: [
                    magia.mgmTransferCountIroha,
                    magia.mgmTransferCountYachiyo,
                    magia.mgmTransferCountTsuruno,
                    magia.mgmTransferCountSana,
                    magia.mgmTransferCountFerishia,
                    magia.mgmTransferCountKuroe,
                ], ratioList: [
                    magia.ratioMgmTransferIroha,
                    [5.5,6.3,6.3,9.4,9.4,10.9],
                    [5.5,5.5,7.8,7.8,10.9,10.9],
                    [5.5,6.3,6.3,9.4,9.4,10.9],
                    [5.5,5.5,7.8,7.8,10.9,10.9],
                    [3.1,3.1,3.5,3.9,4.7,6.3],
                ], bigNumber: magia.mgmTransferCountSum
            )
        }
        // 魔法少女モード いろはからの昇格
        var logPostModeRise: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.modeEnable {
            logPostModeRise = logPostPercentMulti(
                countList: [
                    magia.mgmRisingCountIroha,
                    magia.mgmRisingCountYachiyo,
                    magia.mgmRisingCountTsuruno,
                    magia.mgmRisingCountSana,
                    magia.mgmRisingCountFerishia,
                    magia.mgmRisingCountKuroe,
                ], ratioList: [
                    [77.7,77.7,74.2,70.3,66.4,64.1],
                    [4.7,4.7,4.7,6.3,6.3,7],
                    [3.9,3.9,5.5,5.5,7,7],
                    [4.7,4.7,4.7,6.3,6.3,7],
                    [3.9,3.9,5.5,5.5,7,7],
                    [5.1,5.1,5.5,6.3,7,7.8],
                ], bigNumber: magia.mgmRisingCountSum
            )
        }
        // 初当り
        var logPostFirstHit: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostFirstHit = logPostDenoMulti(
                countList: [
                    magia.bonusCountSum,
                    magia.atCount,
                ], denoList: [
                    magia.ratioBonus,
                    magia.ratioAt,
                ], bigNumber: magia.normalPlayGame
            )
        }
        // ウワサバトル
        var logPostUwasa: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.uwasaEnable {
            logPostUwasa = logPostPercentBino(
                ratio: magia.ratioMitamaLevel3,
                Count: magia.mitamaAtCountHit,
                bigNumber: magia.mitamaAtCountSum
            )
        }
        // エピソード振り分け
        var logPostEpisode: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.episodeEnable {
            logPostEpisode = logPostPercentMulti(
                countList: [
                    magia.episodeCountYachiyo,
                    magia.episodeCountTsuruno,
                    magia.episodeCountSana,
                    magia.episodeCountFerishia,
                    magia.episodeCountKuroe,
                ], ratioList: [
                    magia.ratioEpisodeYachiyo,
                    magia.ratioEpisodeTsuruno,
                    magia.ratioEpisodeSana,
                    magia.ratioEpisodeFerishia,
                    magia.ratioEpisodeKuroe,
                ], bigNumber: magia.episodeCountSum
            )
        }
        // BIG終了画面
        var logPostBigScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.bigScreenEnable {
            // 2以上
            if magia.bigScreenCountOver2 > 0 {
                logPostBigScreen[0] = -Double.infinity
            }
            // 4以上
            if magia.bigScreenCountOver4 > 0 {
                logPostBigScreen[0] = -Double.infinity
                logPostBigScreen[1] = -Double.infinity
                logPostBigScreen[2] = -Double.infinity
            }
            // 5以上
            if magia.bigScreenCountOver5 > 0 {
                logPostBigScreen[0] = -Double.infinity
                logPostBigScreen[1] = -Double.infinity
                logPostBigScreen[2] = -Double.infinity
                logPostBigScreen[3] = -Double.infinity
            }
            // 6以上
            if magia.bigScreenCountOver6 > 0 {
                logPostBigScreen[0] = -Double.infinity
                logPostBigScreen[1] = -Double.infinity
                logPostBigScreen[2] = -Double.infinity
                logPostBigScreen[3] = -Double.infinity
                logPostBigScreen[4] = -Double.infinity
            }
        }
        // ストーリー順番
        var logPostStory: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.storyEnable {
            // 1否定
            if magia.storyOrderCountNegate1 > 0 {
                logPostStory[0] = -Double.infinity
            }
            // 2否定
            if magia.storyOrderCountNegate2 > 0 {
                logPostStory[1] = -Double.infinity
            }
            // 3否定
            if magia.storyOrderCountNegate3 > 0 {
                logPostStory[2] = -Double.infinity
            }
            // 1否定
            if magia.storyOrderCountNegate1High > 0 {
                logPostStory[0] = -Double.infinity
            }
            // 5以上
            if magia.storyOrderCountOver5 > 0 {
                logPostStory[0] = -Double.infinity
                logPostStory[1] = -Double.infinity
                logPostStory[2] = -Double.infinity
                logPostStory[3] = -Double.infinity
            }
        }
        // 高確スタート ビッグ
        var logPostKokakuStartBig: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.kokakuStartEnable {
            logPostKokakuStartBig = logPostPercentBino(
                ratio: magia.ratioKokakuStartAfterBonusTotal,
                Count: magia.kokakuStartAfterBonusCountHit,
                bigNumber: magia.kokakuStartAfterBonusCountSum
            )
        }
        // 高確スタート ビッグ
        var logPostKokakuStartAt: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.kokakuStartEnable {
            logPostKokakuStartAt = logPostPercentBino(
                ratio: magia.ratioKokakuStartAfterAtTotal,
                Count: magia.kokakuStartAfterAtCountHit,
                bigNumber: magia.kokakuStartAfterAtCountSum
            )
        }
        // エンディング
        var logPostEnding: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.endingEnable {
            // 2否定
            if magia.endingCountNegate2 > 0 {
                logPostEnding[1] = -Double.infinity
            }
            // 3否定
            if magia.endingCountNegate3 > 0 {
                logPostEnding[2] = -Double.infinity
            }
            // 4否定
            if magia.endingCountNegate4 > 0 {
                logPostEnding[3] = -Double.infinity
            }
            // 1否定
            if magia.endingCountNegate1High > 0 {
                logPostEnding[0] = -Double.infinity
            }
            // 4否定＆高設定示唆
            if magia.endingCountNegate4High > 0 {
                logPostEnding[3] = -Double.infinity
            }
            // 4以上
            if magia.endingCountOver4 > 0 {
                logPostEnding[0] = -Double.infinity
                logPostEnding[1] = -Double.infinity
                logPostEnding[2] = -Double.infinity
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
            logPostSuikaCz,
            logPostModeStart,
            logPostModeRise,
            logPostFirstHit,
            logPostUwasa,
            logPostEpisode,
            logPostBigScreen,
            logPostStory,
            logPostKokakuStartBig,
            logPostKokakuStartAt,
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
    magiaViewBayes(
        ver390: Ver390(),
        magia: Magia(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
