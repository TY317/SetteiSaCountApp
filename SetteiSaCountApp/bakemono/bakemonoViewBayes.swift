//
//  bakemonoViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/30.
//

import SwiftUI

struct bakemonoViewBayes: View {
    @ObservedObject var bakemono: Bakemono
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.9, 98.9, 100.9, 105.0, 107.8, 112.1]
    @State var firstHitEnable: Bool = true
    @State var screenHitEnable: Bool = true
    @State var jakuCherryAtEnable: Bool = true
    @State var suikaEnable: Bool = true
    @State var rareCzEnable: Bool = true
    
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
                // スイカ確率
                unitToggleWithQuestion(enable: self.$suikaEnable, title: "スイカ確率")
//                    .popoverTip(tipVer3170bakemonoBayes())
                // レア役からのCZ当選率
                unitToggleWithQuestion(enable: self.$rareCzEnable, title: "レア役からのCZ当選率") {
                    unitExView5body2image(
                        title: "レア役からのCZ当選率",
                        textBody1: "・通常滞在時の🍉からの当選率、強🍒・チャンス目からの当選率を計算要素に加えます",
                    )
                }
                // 初当り確率
                unitToggleWithQuestion(enable: self.$firstHitEnable, title: "AT初当り確率")
                // 弱チェリーからのAT直撃率
                unitToggleWithQuestion(enable: self.$jakuCherryAtEnable, title: "弱🍒からのAT直撃率")
                // AT終了画面
                unitToggleWithQuestion(enable: self.$screenHitEnable, title: "AT終了画面") {
                    unitExView5body2image(
                        title: "AT終了画面",
                        textBody1: "・確定系のみ反映させます"
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
        // //// バッジのリセット
        .resetBadgeOnAppear($common.bakemonoMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: bakemono.machineName,
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
        // スイカ確率
        var logPostSuika: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.suikaEnable {
            logPostSuika = logPostDenoBino(
                ratio: bakemono.ratioSuika,
                Count: bakemono.koyakuCountSuika,
                bigNumber: bakemono.totalGame
            )
        }
        // レア役からのCZ
        var logPostRareCzSuika: [Double] = [Double](repeating: 0, count: self.settingList.count)
        var logPostRareCzKyoRare: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.rareCzEnable {
            logPostRareCzSuika = logPostPercentBino(
                ratio: bakemono.ratioNormalCzSuika,
                Count: bakemono.rareCzCountSuikaHit,
                bigNumber: bakemono.rareCzCountSuika
            )
            logPostRareCzKyoRare = logPostPercentBino(
                ratio: bakemono.ratioNormalCzKyoCerryChance,
                Count: bakemono.rareCzCountKyoRareHit,
                bigNumber: bakemono.rareCzCountKyoRareSum
            )
        }
        // 初当り確率
        var logPostFirstHit: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostFirstHit = logPostDenoBino(
                ratio: bakemono.ratioAtFirstHit,
                Count: bakemono.firstHitCountAt,
                bigNumber: bakemono.normalGame
            )
        }
        // 弱チェリーからのAT直撃
        var logPostJakuCherryAt: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.jakuCherryAtEnable {
            logPostJakuCherryAt = logPostPercentBino(
                ratio: bakemono.ratioJakuCherryAt,
                Count: bakemono.jakuCherryAtCount,
                bigNumber: bakemono.koyakuCountJakuCherry
            )
        }
        // AT終了画面
        var logPostScreenEnd: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.screenHitEnable {
            if bakemono.screenCount7 > 0 {
                logPostScreenEnd[0] = -Double.infinity
                logPostScreenEnd[2] = -Double.infinity
                logPostScreenEnd[4] = -Double.infinity
            }
            if bakemono.screenCount8 > 0 {
                logPostScreenEnd[0] = -Double.infinity
                logPostScreenEnd[1] = -Double.infinity
                logPostScreenEnd[3] = -Double.infinity
            }
            if bakemono.screenCount9 > 0 {
                logPostScreenEnd[0] = -Double.infinity
                logPostScreenEnd[1] = -Double.infinity
                logPostScreenEnd[2] = -Double.infinity
            }
            if bakemono.screenCount10 > 0 {
                logPostScreenEnd[0] = -Double.infinity
                logPostScreenEnd[1] = -Double.infinity
                logPostScreenEnd[2] = -Double.infinity
                logPostScreenEnd[3] = -Double.infinity
            }
            if bakemono.screenCount11 > 0 {
                logPostScreenEnd[0] = -Double.infinity
                logPostScreenEnd[1] = -Double.infinity
                logPostScreenEnd[2] = -Double.infinity
                logPostScreenEnd[3] = -Double.infinity
                logPostScreenEnd[4] = -Double.infinity
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
            logPostSuika,
            logPostFirstHit,
            logPostJakuCherryAt,
            logPostScreenEnd,
            logPostRareCzSuika,
            logPostRareCzKyoRare,
            
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
    bakemonoViewBayes(
        bakemono: Bakemono(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
