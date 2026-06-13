//
//  rioAceViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/03.
//

import SwiftUI

struct rioAceViewBayes: View {
    @ObservedObject var rioAce: RioAce
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.7, 98.7, 100.5, 105.1, 109.1, 112.1]
    @State var firstHitNoirRoomEnable: Bool = true
    @State var firstHitBonusAtEnable: Bool = true
    @State var kiteiReplayEnable: Bool = true
    @State var aceModeEnable: Bool = true
    @State var rinaSignEnable: Bool = true
    
    
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
                // 規定リプレイからの当選率
                unitToggleWithQuestion(enable: self.$kiteiReplayEnable, title: "規定リプレイからの当選率")
                // エースモード突入率
                unitToggleWithQuestion(enable: self.$aceModeEnable, title: "エースモード突入率")
                // 初当り確率
                unitToggleWithQuestion(enable: self.$firstHitNoirRoomEnable, title: "ノワールルーム初当り確率")
                unitToggleWithQuestion(enable: self.$firstHitBonusAtEnable, title: "ボーナス・AT初当り確率") {
                    unitExView5body2image(
                        title: "ボーナス・AT初当り確率",
                        textBody1: "・直撃ボーナス以外と直撃ボーナス確率をそれぞれ計算要素に加えます"
                    )
                }
                // リナサイン出現率
                unitToggleWithQuestion(enable: self.$rinaSignEnable, title: "リナサイン出現率")
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
        .resetBadgeOnAppear($common.rioAceMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: rioAce.machineName,
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
        // 規定リプレイからの当選率
        var logPostKiteiReplay: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.kiteiReplayEnable {
            logPostKiteiReplay = logPostPercentBino(
                ratio: rioAce.ratioKiteiReplayHit,
                Count: rioAce.kiteiReplayHit,
                bigNumber: rioAce.kiteiReplay
            )
        }
        // ノワールルーム初当り確率
        var logPostFirstHitNoirRoom: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitNoirRoomEnable {
            logPostFirstHitNoirRoom = logPostDenoBino(
                ratio: rioAce.ratioFirstHitNoirRoom,
                Count: rioAce.firstHitCountNoirRoom,
                bigNumber: rioAce.normalGame
            )
        }
        
        // ボーナス・AT初当り
        var logPostFirstHit: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitBonusAtEnable {
            logPostFirstHit = logPostDenoMulti(
                countList: [
                    rioAce.firstHitCountWithoutDirect,
                    rioAce.firstHitCountDirectBonus,
                ], denoList: [
                    rioAce.ratioFirstHitWithoutDirect,
                    rioAce.ratioFirstHitDirectBonus,
                ], bigNumber: rioAce.normalGame
            )
        }
        
        // エースモード突入率
        var logPostAceMode: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.aceModeEnable {
            logPostAceMode = logPostPercentBino(
                ratio: rioAce.ratioAceMode,
                Count: rioAce.aceModeCountHit,
                bigNumber: rioAce.aceModeCountSum
            )
        }
        
        // リナサイン
        var logPostRinaSign: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.rinaSignEnable {
            logPostRinaSign = logPostPercentBino(
                ratio: rioAce.ratioRinaSign,
                Count: rioAce.screenCountRina,
                bigNumber: rioAce.screenCountSum
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
            logPostKiteiReplay,
            logPostFirstHitNoirRoom,
            logPostFirstHit,
            logPostAceMode,
            logPostRinaSign,
            
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
    rioAceViewBayes(
        rioAce: RioAce(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
