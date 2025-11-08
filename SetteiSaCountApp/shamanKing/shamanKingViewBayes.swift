//
//  shamanKingViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/25.
//

import SwiftUI

struct shamanKingViewBayes: View {
    @ObservedObject var shamanKing: ShamanKing
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.5, 98.3, 100.2, 105.2, 109.2, 113.0]
    @State var commonBellEnable: Bool = true
    @State var jakuRareKokakuEnable: Bool = true
    @State var replayCount10Enable: Bool = true
    @State var czCharaEnable: Bool = true
    @State var gattaiBattleEnable: Bool = true
    @State var firstHitEnable: Bool = true
    @State var qualifyEnable: Bool = true
    
    
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
                // 共通ベルA確率
                unitToggleWithQuestion(enable: self.$commonBellEnable, title: "共通ベルA確率")
                // 弱レア役からの高確移行率
                unitToggleWithQuestion(enable: self.$jakuRareKokakuEnable, title: "弱レア役からの高確移行率")
                // リプレイカウンタ10選択率
                unitToggleWithQuestion(enable: self.$replayCount10Enable, title: "リプレイカウンタ10選択率"
                )
                // CZ当選時の対戦相手振分け
                unitToggleWithQuestion(enable: self.$czCharaEnable, title: "CZ当選時の対戦相手振分け")
                // 憑依合体バトルでの勝率
                unitToggleWithQuestion(enable: self.$gattaiBattleEnable, title: "憑依合体バトルでの勝率") {
                    unitExView5body2image(
                        title: "憑依合体バトルでの勝率",
                        textBody1: "・残りHPごとの勝率を計算要素に加えます"
                    )
                }
                // 初当り確率
                unitToggleWithQuestion(enable: self.$firstHitEnable, title: "初当り確率")
                // シャーマンファイト予選
                unitToggleWithQuestion(enable: self.$qualifyEnable, title: "ｼｬｰﾏﾝﾌｧｲﾄ予選撃破率") {
                    unitExView5body2image(
                        title: "シャーマンファイト予選撃破率",
                        textBody1: "・対戦相手ごとの撃破率を計算要素に加えます",
                    )
                }
            }
            
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.shamanKingMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: shamanKing.machineName,
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
        // 共通ベルA
        var logPostCommonBell: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.commonBellEnable {
            logPostCommonBell = logPostDenoBino(
                ratio: shamanKing.ratioCommonBell,
                Count: shamanKing.koyakuCountCommonBell,
                bigNumber: shamanKing.playGame
            )
        }
        // 弱レアからの高確移行
        var logPostJakuRareKokaku: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.jakuRareKokakuEnable {
            logPostJakuRareKokaku = logPostPercentBino(
                ratio: [3.9,4.3,5.1,6.6,8.2,10.2],
                Count: shamanKing.bonusKokakuCount,
                bigNumber: shamanKing.jakuRareCount
            )
        }
        // リプレイたカウンタ10
        var logPostRep10: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.replayCount10Enable {
            logPostRep10 = logPostPercentBino(
                ratio: [6.3,6.6,7.4,8.2,9.4,10.2],
                Count: shamanKing.replayCounterCountSuccesss,
                bigNumber: shamanKing.replayCounterReplayCount
            )
        }
        // CZキャラ
        var logPostCzChara595: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.czCharaEnable {
            logPostCzChara595 = logPostPercentMulti(
                countList: [
                    shamanKing.czCountUnder600Ren,
                    shamanKing.czCountUnder600Jun,
                    shamanKing.czCountUnder600Ryunosuke,
                    shamanKing.czCountUnder600Kokkuri,
                ], ratioList: [
                    shamanKing.ratioCzFuriwakeUnder600Ren,
                    shamanKing.ratioCzFuriwakeUnder600Jun,
                    shamanKing.ratioCzFuriwakeUnder600Ryunosuke,
                    shamanKing.ratioCzFuriwakeUnder600Kokkuri,
                ], bigNumber: shamanKing.czCountUnder600Sum
            )
        }
        var logPostCzChara1000: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.czCharaEnable {
            logPostCzChara1000 = logPostPercentMulti(
                countList: [
                    shamanKing.czCountOver600Ren,
                    shamanKing.czCountOver600Jun,
                    shamanKing.czCountOver600Ryunosuke,
                    shamanKing.czCountOver600Kokkuri,
                ], ratioList: [
                    shamanKing.ratioCzFuriwakeOver600Ren,
                    shamanKing.ratioCzFuriwakeOver600Jun,
                    shamanKing.ratioCzFuriwakeOver600Ryunosuke,
                    shamanKing.ratioCzFuriwakeOver600Kokkuri,
                ], bigNumber: shamanKing.czCountOver600Sum
            )
        }
        // 憑依合体バトル
        var logPostHyoi78: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.gattaiBattleEnable {
            logPostHyoi78 = logPostPercentBino(
                ratio: [3.1,3.5,4.3,5.5,7,8.6],
                Count: shamanKing.hyoiCount78Win,
                bigNumber: shamanKing.hyoiCount78Sum
            )
        }
        var logPostHyoi56: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.gattaiBattleEnable {
            logPostHyoi56 = logPostPercentBino(
                ratio: [6.6,7.4,8.2,9.8,11.3,13.3],
                Count: shamanKing.hyoiCount56Win,
                bigNumber: shamanKing.hyoiCount56Sum
            )
        }
        var logPostHyoi4: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.gattaiBattleEnable {
            logPostHyoi4 = logPostPercentBino(
                ratio: [25,25.4,25.8,27,28.1,29.7],
                Count: shamanKing.hyoiCount4Win,
                bigNumber: shamanKing.hyoiCount4Sum
            )
        }
        var logPostHyoi3: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.gattaiBattleEnable {
            logPostHyoi3 = logPostPercentBino(
                ratio: [40.2,40.6,41,42.2,43.8,45.3],
                Count: shamanKing.hyoiCount3Win,
                bigNumber: shamanKing.hyoiCount3Sum
            )
        }
        // 初当りボーナス
        var logPostFirstBonus: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostFirstBonus = logPostDenoBino(
                ratio: [288.8,280,268.4,248.1,227.6,207.1],
                Count: shamanKing.bonusCountSum,
                bigNumber: shamanKing.inputGame
            )
        }
        var logPostFirstAt: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostFirstAt = logPostDenoBino(
                ratio: [573.6,553.2,523,461.2,412.8,367.3],
                Count: shamanKing.inputShamanFightCount,
                bigNumber: shamanKing.inputGame
            )
        }
        
        // シャーマンファイト予選
        var logPostQualifyFaust: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.qualifyEnable {
            logPostQualifyFaust = logPostPercentBino(
                ratio: shamanKing.ratioQualifyFaust,
                Count: shamanKing.qualifyCountFaustHit,
                bigNumber: shamanKing.qualifyCountFaustOS
            )
        }
        var logPostQualifyRen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.qualifyEnable {
            logPostQualifyRen = logPostPercentBino(
                ratio: shamanKing.ratioQualifyRen,
                Count: shamanKing.qualifyCountRenHit,
                bigNumber: shamanKing.qualifyCountRenOS
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
            logPostCommonBell,
            logPostJakuRareKokaku,
            logPostRep10,
            logPostCzChara595,
            logPostCzChara1000,
            logPostHyoi78,
            logPostHyoi56,
            logPostHyoi4,
            logPostHyoi3,
            logPostFirstBonus,
            logPostFirstAt,
            logPostQualifyFaust,
            logPostQualifyRen,
            
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
    shamanKingViewBayes(
        shamanKing: ShamanKing(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
