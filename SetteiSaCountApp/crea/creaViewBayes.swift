//
//  creaViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/24.
//

import SwiftUI

struct creaViewBayes: View {
    @ObservedObject var crea: Crea
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [98.1, 99.2, 101.2, 103.7, 106.6, 112.3]
    @State var bonusEnable: Bool = true
    @State var regCardEnable: Bool = true
    @State var btHazureEnable: Bool = true
    @State var koyakuEnable: Bool = true
    @State var chofukuEnable: Bool = true
    
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
                // 小役確率
                unitToggleWithQuestion(enable: self.$koyakuEnable, title: "小役確率") {
                    unitExView5body2image(
                        title: "小役確率",
                        textBody1: "🔔、チャンス目、🍒、🍉、滑り🍉、ピラミッドの出現確率を計算要素に加えます",
                    )
                }
                // 重複確率
                unitToggleWithQuestion(enable: self.$chofukuEnable, title: "重複当選確率") {
                    unitExView5body2image(
                        title: "重複当選確率",
                        textBody1: "チャンス目、🍒、🍉、滑り🍉での重複当選確率を計算要素に加えます",
                    )
                }
                // 初当り確率
                unitToggleWithQuestion(enable: self.$bonusEnable, title: "ボーナス確率") {
                    unitExView5body2image(
                        title: "ボーナス確率",
                        textBody1: "・BIG、REG確率を計算要素に加えます",
                    )
                }
                // REG中のカード
                unitToggleWithQuestion(enable: self.$regCardEnable, title: "REG中のカード") {
                    unitExView5body2image(
                        title: "REG中のカード",
                        textBody1: "・確定系のみ反映させます",
                    )
                }
                // BT中のハズレ
                unitToggleWithQuestion(enable: self.$btHazureEnable, title: "BT中のハズレ")
                // サミートロフィー
                DisclosureGroup("コパンダトロフィー") {
                    unitToggleWithQuestion(enable: self.$over2Check, title: "銅")
                    unitToggleWithQuestion(enable: self.$over3Check, title: "銀")
                    unitToggleWithQuestion(enable: self.$over4Check, title: "金")
                    unitToggleWithQuestion(enable: self.$over5Check, title: "イナズマ柄")
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
                screenName: crea.machineName,
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
        // 小役確率
        var logPostKoyaku: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.koyakuEnable {
            logPostKoyaku = logPostDenoMulti(
                countList: [
                    crea.koyakuCountBell,
                    crea.koyakuCountChance,
                    crea.koyakuCountCherry,
                    crea.koyakuCountSuika,
                    crea.koyakuCountSuberiSuika,
                    crea.koyakuCountPylamid,
                ], denoList: [
                    crea.ratioKoyakuBell,
                    crea.ratioKoyakuChance,
                    crea.ratioKoyakuCherry,
                    crea.ratioKoyakuSuika,
                    crea.ratioKoyakuSuberiSuika,
                    crea.ratioKoyakuPylamid,
                ], bigNumber: crea.gameNumberPlay
            )
        }
        // 重複当選確率
        var logPostChofukuChance: [Double] = [Double](repeating: 0, count: self.settingList.count)
        var logPostChofukuCherry: [Double] = [Double](repeating: 0, count: self.settingList.count)
        var logPostChofukuSuika: [Double] = [Double](repeating: 0, count: self.settingList.count)
        var logPostChofukuSuberiSuika: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.chofukuEnable {
            logPostChofukuChance = logPostPercentBino(
                ratio: crea.ratioChofukuChance,
                Count: crea.chofukuCountChance,
                bigNumber: crea.koyakuCountChance
            )
            logPostChofukuCherry = logPostPercentBino(
                ratio: crea.ratioChofukuCherry,
                Count: crea.chofukuCountCherry,
                bigNumber: crea.koyakuCountCherry
            )
            logPostChofukuSuika = logPostPercentBino(
                ratio: crea.ratioChofukuSuika,
                Count: crea.chofukuCountSuika,
                bigNumber: crea.koyakuCountSuika
            )
            logPostChofukuSuberiSuika = logPostPercentBino(
                ratio: crea.ratioChofukuSuberiSuika,
                Count: crea.chofukuCountSuberiSuika,
                bigNumber: crea.koyakuCountSuberiSuika
            )
        }
        // ボーナス確率
        var logPostBonus: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.bonusEnable {
            logPostBonus = logPostDenoMulti(
                countList: [
                    crea.bonusCountBig,
                    crea.bonusCountReg,
                ], denoList: [
                    crea.ratioBonusBig,
                    crea.ratioBonusReg,
                ], bigNumber: crea.gameNumberCurrent
            )
        }
        // REG中のカード
        var logPostRegCard: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.regCardEnable {
            if crea.regCardCountOver4 > 0 {
                logPostRegCard[0] = -Double.infinity
                logPostRegCard[1] = -Double.infinity
                logPostRegCard[2] = -Double.infinity
            }
            if crea.regCardCountOver6 > 0 {
                logPostRegCard[0] = -Double.infinity
                logPostRegCard[1] = -Double.infinity
                logPostRegCard[2] = -Double.infinity
                logPostRegCard[3] = -Double.infinity
                logPostRegCard[4] = -Double.infinity
            }
        }
        // BT中のハズレ
        var logPostBtHazure: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.btHazureEnable {
            logPostBtHazure = logPostDenoBino(
                ratio: crea.ratioBtHazure,
                Count: crea.btHazure,
                bigNumber: crea.btGame
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
            logPostKoyaku,
            logPostChofukuChance,
            logPostChofukuCherry,
            logPostChofukuSuika,
            logPostChofukuSuberiSuika,
            logPostBonus,
            logPostRegCard,
            logPostBtHazure,
            
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
    creaViewBayes(
        crea: Crea(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
