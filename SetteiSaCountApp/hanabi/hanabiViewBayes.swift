//
//  hanabiViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/02.
//

import SwiftUI

struct hanabiViewBayes: View {
    @ObservedObject var hanabi: Hanabi
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,5,6]   // その機種の設定段階
    let payoutList: [Double] = [100.2, 102.0, 104.6, 108.0]
    @State var firstEnable: Bool = true
    @State var normalKoyakuEnable: Bool = true
    @State var rtHazureEnable: Bool = true
    @State var bbKoyakuEnable: Bool = true
    @State var rbKoyakuEnable: Bool = true
    @State var repChallengeEnable: Bool = true
    @State var repGameEnable: Bool = true
    
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
                // 初当り確立
                unitToggleWithQuestion(enable: self.$firstEnable, title: "初当り確率") {
                    unitExView5body2image(
                        title: "初当り確率",
                        textBody1: "・BIG,REG確率を計算要素に加えます"
                    )
                }
                
                // 通常中小役確率
                unitToggleWithQuestion(enable: self.$normalKoyakuEnable, title: "通常中小役確率") {
                    unitExView5body2image(
                        title: "通常中小役確率",
                        textBody1: "・以下の通常中小役確率を計算要素に加えます",
                        textBody2: "風鈴A\n風鈴B\n氷A\nチェリーA2\nチェリーB"
                    )
                }
                
                // RTハズレ確率
                unitToggleWithQuestion(enable: self.$rtHazureEnable, title: "RT中ハズレ確率") {
                    unitExView5body2image(
                        title: "RT中ハズレ確率",
                        textBody1: "・花火チャレンジ中、花火GAME中のハズレ確率を計算要素に加えます"
                    )
                }
                
                // BB中小役確率
                unitToggleWithQuestion(enable: self.$bbKoyakuEnable, title: "BB中小役確率") {
                    unitExView5body2image(
                        title: "BB中小役確率",
                        textBody1: "・BB中の風鈴A・B、バラケ目確率を計算要素に加えます"
                    )
                }
                
                // RB中小役確率
                unitToggleWithQuestion(enable: self.$rbKoyakuEnable, title: "RB中小役確率") {
                    unitExView5body2image(
                        title: "RB中小役確率",
                        textBody1: "・RB中の1枚役、バラケ目確率を計算要素に加えます"
                    )
                }
                
                // 花火チャレンジ中 通常リプレイ確率
                unitToggleWithQuestion(enable: self.$repChallengeEnable, title: "花火ﾁｬﾚﾝｼﾞ中 通常リプレイ確率")
                
                // 花火GAME中 RTリプレイ確率
                unitToggleWithQuestion(enable: self.$repGameEnable, title: "花火GAME中 RTリプレイ確率")
            }
            
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hanabiMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hanabi.machineName,
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
        // ボーナス確率
        var logPostBonus: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstEnable {
            logPostBonus = logPostDenoMulti(
                countList: [
                    hanabi.totalBig,
                    hanabi.totalReg,
                ], denoList: [
                    hanabi.ratioBig,
                    hanabi.ratioReg,
                ], bigNumber: hanabi.totalGame
            )
        }
        
        // 小役確率
        var logPostNormalKoyaku: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.normalKoyakuEnable {
            logPostNormalKoyaku = logPostDenoMulti(
                countList: [
                    hanabi.normalKoyakuCountBellA,
                    hanabi.normalKoyakuCountBellB,
                    hanabi.normalKoyakuCountKohriA,
                    hanabi.normalKoyakuCountCherryA2,
                    hanabi.normalKoyakuCountCherryB,
                ], denoList: [
                    hanabi.ratioBellA,
                    hanabi.ratioBellB,
                    hanabi.ratioKohriA,
                    hanabi.ratioCherryA2,
                    hanabi.ratioCherryB,
                ], bigNumber: hanabi.playGame
            )
        }
        
        // RT中ハズレ確率
        var logPostRtHazureChallenge: [Double] = [Double](repeating: 0, count: self.settingList.count)
        var logPostRtHazureGame: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.rtHazureEnable {
            logPostRtHazureChallenge = logPostDenoBino(
                ratio: hanabi.ratioHazureChallenge,
                Count: hanabi.hazureCountChallenge,
                bigNumber: hanabi.challengeGame
            )
            logPostRtHazureGame = logPostDenoBino(
                ratio: hanabi.ratioHazureGame,
                Count: hanabi.hazureCountGame,
                bigNumber: hanabi.hanabiGame,
            )
        }
        
        // BB中小役
        var logPostBbKoyaku: [Double] = [Double](repeating: 0, count: self.settingList.count)
//        var logPostBbKoyakuA: [Double] = [Double](repeating: 0, count: self.settingList.count)
//        var logPostBbKoyakuB: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.bbKoyakuEnable {
            logPostBbKoyaku = logPostDenoMulti(
                countList: [
                    hanabi.bbCountBellA,
                    hanabi.bbCountBellB,
                    hanabi.bbCountBarake,
                ], denoList: [
                    hanabi.ratioBbBellA,
                    hanabi.ratioBbBellB,
                    hanabi.ratioBbBarake,
                ], bigNumber: hanabi.bbCountGame
            )
//            logPostBbKoyakuA = logPostDenoBino(
//                ratio: hanabi.ratioBbBellA,
//                Count: hanabi.bbCountBellA,
//                bigNumber: hanabi.bbCountGame
//            )
//            logPostBbKoyakuB = logPostDenoBino(
//                ratio: hanabi.ratioBbBellB,
//                Count: hanabi.bbCountBellB,
//                bigNumber: hanabi.bbCountGame
//            )
        }
        
        // RB中小役確率
        var logPostRbKoyaku: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.rbKoyakuEnable {
            logPostRbKoyaku = logPostDenoMulti(
                countList: [
                    hanabi.rbCount1Mai,
                    hanabi.rbCountBarake,
                ], denoList: [
                    hanabi.ratioRb1Mai,
                    hanabi.ratioRbBarake,
                ], bigNumber: hanabi.rbCountGame
            )
        }
        
        // 花火チャレンジ中　通常リプレイ確率
        var logPostRepChallenge: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.repChallengeEnable {
            logPostRepChallenge = logPostDenoBino(
                ratio: hanabi.ratioChallengeReplayNormal,
                Count: hanabi.replayCountChallenge,
                bigNumber: hanabi.challengeGame
            )
        }
        
        // 花火チャレンジ中　通常リプレイ確率
        var logPostRepGame: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.repGameEnable {
            logPostRepGame = logPostDenoBino(
                ratio: hanabi.ratioGameReplayRt,
                Count: hanabi.replayCountGame,
                bigNumber: hanabi.hanabiGame
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
            logPostBonus,
            logPostNormalKoyaku,
            logPostRtHazureChallenge,
            logPostRtHazureGame,
            logPostBbKoyaku,
//            logPostBbKoyakuA,
//            logPostBbKoyakuB,
            logPostRbKoyaku,
            logPostRepChallenge,
            logPostRepGame,
            
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
    hanabiViewBayes(
        hanabi: Hanabi(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
