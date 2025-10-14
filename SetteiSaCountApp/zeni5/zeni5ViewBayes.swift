//
//  zeni5ViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/14.
//

import SwiftUI

struct zeni5ViewBayes: View {
    @ObservedObject var zeni5: Zeni5
    
    // 機種ごとに見直し
    let settingList: [Int] = [2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.9, 99.0, 103.2, 107.1, 112.1]
    @State var firstHitEnable: Bool = true
    @State var screenenable: Bool = true
    @State var kakureNagiEnable: Bool = true
    
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
                // 初当り
                unitToggleWithQuestion(enable: self.$firstHitEnable, title: "初当り確率")
                // 終了画面
                unitToggleWithQuestion(enable: self.$screenenable, title: "ボーナス終了画面") {
                    unitExView5body2image(
                        title: "ボーナス終了画面",
                        textBody1: "・確定系のみ反映させます"
                    )
                }
                // 隠れ凪
                DisclosureGroup("隠れ凪") {
                    unitToggleWithQuestion(enable: self.$over3Check, title: "緑")
                    unitToggleWithQuestion(enable: self.$over4Check, title: "赤")
                    unitToggleWithQuestion(enable: self.$over5Check, title: "銀")
                    unitToggleWithQuestion(enable: self.$over6Check, title: "金")
                }
            }
            
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($common.zeni5MenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: zeni5.machineName,
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
        // 初当り
        var logPostFirstHitAt: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostFirstHitAt = logPostDenoBino(
                ratio: zeni5.ratioFirstHit,
                Count: zeni5.firstHitCount,
                bigNumber: zeni5.normalGame
            )
        }
        // ボーナス終了画面
        var logPostScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.screenenable {
            if zeni5.screenCountOver3 > 0 {
                logPostScreen[0] = -Double.infinity
            }
            if zeni5.screenCountOver4 > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
            }
            if zeni5.screenCountOver5 > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
                logPostScreen[2] = -Double.infinity
            }
            if zeni5.screenCountOver6 > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
                logPostScreen[2] = -Double.infinity
                logPostScreen[3] = -Double.infinity
            }
        }
        
        // トロフィー
        var logPostTrophy: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.over3Check {
            logPostTrophy[0] = -Double.infinity
        }
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
//                pattern: bayes.selectedBeforeGuessPattern
                pattern: self.selectedBeforeGuessPattern
            )
        )
        
        // 判別要素の尤度合算
        let logPostSum: [Double] = arraySumDouble([
            logPostFirstHitAt,
            
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
    zeni5ViewBayes(
        zeni5: Zeni5(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
