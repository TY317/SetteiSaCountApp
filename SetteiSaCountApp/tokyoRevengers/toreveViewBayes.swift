//
//  toreveViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/05.
//

import SwiftUI

struct toreveViewBayes: View {
    @ObservedObject var toreve: Toreve
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.8, 98.8, 101.4, 106.3, 111.2, 114.9]
    @State var firstHitEnable: Bool = true
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
                // 初当り確率
                unitToggleWithQuestion(enable: self.$firstHitEnable, title: "初当り確率") {
                    unitExView5body2image(
                        title: "初当り確率",
                        textBody1: "・東卍チャンス、東卍ラッシュの初当り確率を計算要素に加えます",
                    )
                }
                // 終了画面
                unitToggleWithQuestion(enable: self.$screenEnable, title: "終了画面") {
                    unitExView5body2image(
                        title: "終了画面",
                        textBody1: "・確定系のみ反映させます",
                    )
                }
                // サミートロフィー
                DisclosureGroup("サミートロフィー") {
                    unitToggleWithQuestion(enable: self.$over2Check, title: "銅")
                    unitToggleWithQuestion(enable: self.$over3Check, title: "銀")
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
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: toreve.machineName,
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
        // 初当り確率
        var logPostFirstHit: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostFirstHit = logPostDenoMulti(
                countList: [
                    toreve.tomanChallengeCount,
                    toreve.tomanRushCount,
                ], denoList: [
                    toreve.ratioTomanChallenge,
                    toreve.ratioTomanRush,
                ], bigNumber: toreve.normalGame
            )
        }
        // 終了画面
        var logPostScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.screenEnable {
            if toreve.screenCount7 > 0 {
                logPostScreen[0] = -Double.infinity
            }
            if toreve.screenCount8 > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
            }
            if toreve.screenCount4 > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
                logPostScreen[2] = -Double.infinity
            }
            if toreve.screenCount9 > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
                logPostScreen[2] = -Double.infinity
                logPostScreen[3] = -Double.infinity
            }
            if toreve.screenCount10 > 0 {
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
            logPostFirstHit,
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
    toreveViewBayes(
        toreve: Toreve(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
