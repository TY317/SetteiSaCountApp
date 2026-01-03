//
//  mushotenViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/03.
//

import SwiftUI

struct mushotenViewBayes: View {
    @ObservedObject var mushoten: Mushoten
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.7, 99.1, 100.9, 105.4, 109.5, 113.7]
    @State var hitogamiEnable: Bool = true
    @State var czEnable: Bool = true
    @State var firstHitEnable: Bool = true
    @State var storyEnable: Bool = true
    
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
                // ヒトガミの空間 当選率
                unitToggleWithQuestion(enable: self.$hitogamiEnable, title: "ヒトガミの空間での当選率")
                // CZ確率
                unitToggleWithQuestion(enable: self.$czEnable, title: "CZ確率")
                // 初当り確率
                unitToggleWithQuestion(enable: self.$firstHitEnable, title: "初当り確率") {
                    unitExView5body2image(
                        title: "初当り確率",
                        textBody1: "・ボーナス合算、ATの初当り確率を計算要素に加えます"
                    )
                }
                // 魔術ボーナス 話数示唆
                unitToggleWithQuestion(enable: self.$storyEnable, title: "魔術ボーナス 話数示唆") {
                    unitExView5body2image(
                        title: "話数示唆",
                        textBody1: "・確定系のみ反映させます"
                    )
                }
                // ケロットトロフィー
                DisclosureGroup("ギンちゃんトロフィー") {
                    unitToggleWithQuestion(enable: self.$over2Check, title: "銅")
                    unitToggleWithQuestion(enable: self.$over3Check, title: "銀")
                    unitToggleWithQuestion(enable: self.$over4Check, title: "金")
                    unitToggleWithQuestion(enable: self.$over5Check, title: "虎柄")
                    unitToggleWithQuestion(enable: self.$over6Check, title: "虹")
                }
            }
            
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.mushotenMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: mushoten.machineName,
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
        var logPostHitogami: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.hitogamiEnable {
            logPostHitogami = logPostPercentBino(
                ratio: mushoten.ratioHitogamiHit,
                Count: mushoten.hitogamiCountHit,
                bigNumber: mushoten.hitogamiCountMove
            )
        }
        
        // CZ確率
        var logPostCz: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.czEnable {
            logPostCz = logPostDenoBino(
                ratio: mushoten.ratioCz,
                Count: mushoten.czCount,
                bigNumber: mushoten.gameNumberPlay
            )
        }
        
        // 初当り
        var logPostFirstHitBonus: [Double] = [Double](repeating: 0, count: self.settingList.count)
        var logPostFirstHitAt: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostFirstHitBonus = logPostDenoBino(
                ratio: mushoten.ratioFirstHitBonusSum,
                Count: mushoten.firstHitCountBonusSum,
                bigNumber: mushoten.normalGame
            )
            logPostFirstHitAt = logPostDenoBino(
                ratio: mushoten.ratioFirstHitAt,
                Count: mushoten.firstHitCountAt,
                bigNumber: mushoten.normalGame
            )
        }
        
        // 話数示唆
        var logPostStory: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.storyEnable {
            if mushoten.storyCountOver2 > 0 {
                logPostStory[0] = -Double.infinity
            }
            if mushoten.storyCountOver4 > 0 {
                logPostStory[0] = -Double.infinity
                logPostStory[1] = -Double.infinity
                logPostStory[2] = -Double.infinity
            }
            if mushoten.storyCountOver6 > 0 {
                logPostStory[0] = -Double.infinity
                logPostStory[1] = -Double.infinity
                logPostStory[2] = -Double.infinity
                logPostStory[3] = -Double.infinity
                logPostStory[4] = -Double.infinity
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
            logPostHitogami,
            logPostCz,
            logPostFirstHitBonus,
            logPostFirstHitAt,
            logPostStory,
            
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
    mushotenViewBayes(
        mushoten: Mushoten(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
