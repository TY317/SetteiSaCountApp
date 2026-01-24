//
//  shakeViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/05.
//

import SwiftUI

struct shakeViewBayes: View {
    @ObservedObject var shake: Shake
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,5,6]   // その機種の設定段階
    let payoutList: [Double] = [98.6, 100.6, 103.0, 106.1]
    @State var firstHitEnable: Bool = true
    @State var idenBonusEnable: Bool = true
    @State var jacEnable: Bool = true
    @State var voiceEnable: Bool = true
    @State var screenEnable: Bool = true
    @State var koyakuEnable: Bool = true
    
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
                // 小役確率
                unitToggleWithQuestion(enable: self.$koyakuEnable, title: "小役確率") {
                    unitExView5body2image(
                        title: "小役確率",
                        textBody1: "・🔔、🍒、🍉確率を計算要素に加えます"
                    )
                }
                // ボーナス確率
                unitToggleWithQuestion(enable: self.$firstHitEnable, title: "ボーナス確率") {
                    unitExView5body2image(
                        title: "ボーナス確率",
                        textBody1: "・BIG、REG確率を計算要素に加えます"
                    )
                }
                // 特定契機のボーナス確率
                unitToggleWithQuestion(enable: self.$idenBonusEnable, title: "特定契機のボーナス確率") {
                    unitExView5body2image(
                        title: "特定契機のボーナス確率",
                        textBody1: "・🍉＋ナディアBIG、🔔＋REG、特殊役I＋ボーナスの確率を計算要素に加えます"
                    )
                }
                // REG中のボイス
                unitToggleWithQuestion(enable: self.$voiceEnable, title: "REG中のボイス") {
                    unitExView5body2image(
                        title: "REG中のボイス",
                        textBody1: "・確定系のみ反映させます"
                    )
                }
                // JAC種類の割合
                unitToggleWithQuestion(enable: self.$jacEnable, title: "JAC種類の割合")
                // BIG終了画面
                unitToggleWithQuestion(enable: self.$screenEnable, title: "BIG終了画面") {
                    unitExView5body2image(
                        title: "BIG終了画面",
                        textBody1: "・確定系のみ反映させます"
                    )
                }
                // コパンダトロフィー
                DisclosureGroup("コパンダトロフィー") {
                    unitToggleWithQuestion(enable: self.$over2Check, title: "銅")
                    unitToggleWithQuestion(enable: self.$over5Check, title: "イナズマ柄")
                    unitToggleWithQuestion(enable: self.$over6Check, title: "虹")
                }
            }
            
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.shakeMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: shake.machineName,
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
                    shake.koyakuCountBell,
                    shake.koyakuCountCherry,
                    shake.koyakuCountSuika,
                ], denoList: [
                    shake.ratioKoyakuBell,
                    shake.ratioKoyakuCherry,
                    shake.ratioKoyakuSuika,
                ], bigNumber: shake.gameNumberPlay
            )
        }
        // ボーナス確率
        var logPostBonus: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostBonus = logPostDenoMulti(
                countList: [
                    shake.bonusCountBig,
                    shake.bonusCountReg,
                ], denoList: [
                    shake.ratioBonusBig,
                    shake.ratioBonusReg,
                ], bigNumber: shake.normalGame
            )
        }
        // 特定契機のボーナス確率
        var logPostIdenBonus: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.idenBonusEnable {
            logPostIdenBonus = logPostDenoMulti(
                countList: [
                    shake.idenBonusCountSuika,
                    shake.idenBonusCountBell,
                    shake.idenBonusCountSpecialI,
                ], denoList: [
                    shake.ratioIdenBonusSuika,
                    shake.ratioIdenBonusBell,
                    shake.ratioIdenBonusSpecialI,
                ], bigNumber: shake.gameNumberPlay
            )
        }
        // ボイス
        var logPostVoice: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.voiceEnable {
            if shake.voiceCountOver5 > 0 {
                logPostVoice[0] = -Double.infinity
                logPostVoice[1] = -Double.infinity
            }
        }
        // JAC
        var logPostJac: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.jacEnable {
            logPostJac = logPostPercentMulti(
                countList: [
                    shake.jacCountEnd,
                    shake.jacCountContinue,
                ], ratioList: [
                    shake.ratioJackEnd,
                    shake.ratioJackContinue,
                ], bigNumber: shake.jacCountSum
            )
        }
        // 終了画面
        var logPostScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.screenEnable {
            if shake.screenCountOver6 > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
                logPostScreen[2] = -Double.infinity
            }
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
            logPostKoyaku,
            logPostBonus,
            logPostIdenBonus,
            logPostVoice,
            logPostJac,
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
    shakeViewBayes(
        shake: Shake(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
