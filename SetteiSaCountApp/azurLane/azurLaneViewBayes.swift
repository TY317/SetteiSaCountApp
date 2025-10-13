//
//  azurLaneViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/24.
//

import SwiftUI

struct azurLaneViewBayes: View {
    @ObservedObject var azurLane: AzurLane
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.9, 98.6, 100.7, 105.3, 110.6, 114.9]
    @State var jakuRareEnable: Bool = true
    @State var firstHitEnable: Bool = true
    @State var screenEnable: Bool = true
    @State var startModeEnable: Bool = true
    @State var akashiEnable: Bool = true
    @State var kagaEnable: Bool = true
    
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
                // 弱レア役確率
                unitToggleWithQuestion(enable: self.$jakuRareEnable, title: "小役確率") {
                    unitExView5body2image(
                        title: "小役確率",
                        textBody1: "・共通🔔、弱🍒、弱🍉の出現確率を計算要素に加えます",
                    )
                }
                // 初当り確率
                unitToggleWithQuestion(enable: self.$firstHitEnable, title: "初当り確率") {
                    unitExView5body2image(
                        title: "初当り確率",
                        textBody1: "・ボーナス、AT初当り確率を計算要素に加えます",
                    )
                }
                // 加賀バトル
                unitToggleWithQuestion(enable: self.$kagaEnable, title: "加賀バトル") {
                    unitExView5body2image(
                        title: "加賀バトル",
                        textBody1: "シナリオ振り分けを計算要素に加えます"
                    )
                }
                // 明石チャレンジ
                unitToggleWithQuestion(enable: self.$akashiEnable, title: "明石チャレンジ") {
                    unitExView5body2image(
                        title: "明石チャレンジ",
                        textBody1: "・告知ゲーム数の振分けを計算要素に加えます",
                    )
                }
                // 終了画面
                unitToggleWithQuestion(enable: self.$screenEnable, title: "ボーナス,AT終了画面") {
                    unitExView5body2image(
                        title: "終了画面",
                        textBody1: "・終了画面の振り分けを計算要素に加えます"
                    )
                }
                // AT後の高確スタート
                unitToggleWithQuestion(enable: self.$startModeEnable, title: "AT後の高確スタート")
                // 玉ちゃんトロフィー
                DisclosureGroup("玉ちゃんトロフィー") {
                    unitToggleWithQuestion(enable: self.$over2Check, title: "銅")
                    unitToggleWithQuestion(enable: self.$over3Check, title: "銀")
                    unitToggleWithQuestion(enable: self.$over4Check, title: "金")
                    unitToggleWithQuestion(enable: self.$over5Check, title: "ゼブラ柄")
                    unitToggleWithQuestion(enable: self.$over6Check, title: "虹")
                }
            }
            
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.azurLaneMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: azurLane.machineName,
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
//        // 弱チェリー
//        var logPostJakuCherry: [Double] = [Double](repeating: 0, count: self.settingList.count)
//        if self.jakuRareEnable {
//            logPostJakuCherry = logPostDenoBino(
//                ratio: azurLane.ratioJakuCherry,
//                Count: azurLane.koyakuCountJakuCherry,
//                bigNumber: azurLane.gameNumberPlay
//            )
//        }
//        // 弱スイカ
//        var logPostJakuSuika: [Double] = [Double](repeating: 0, count: self.settingList.count)
//        if self.jakuRareEnable {
//            logPostJakuSuika = logPostDenoBino(
//                ratio: azurLane.ratioJakuSuika,
//                Count: azurLane.koyakuCountJakuSuika,
//                bigNumber: azurLane.gameNumberPlay
//            )
//        }
        // 小役確率
        var logPostKoyaku: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.jakuRareEnable {
            logPostKoyaku = logPostDenoMulti(
                countList: [
                    azurLane.koyakuCountCommonBell,
                    azurLane.koyakuCountJakuCherry,
                    azurLane.koyakuCountJakuSuika,
                ], denoList: [
                    azurLane.ratioCommonBell,
                    azurLane.ratioJakuCherry,
                    azurLane.ratioJakuSuika,
                ], bigNumber: azurLane.gameNumberPlay
            )
        }
        // 白７確率
        var logPostBonusWhite: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostBonusWhite = logPostDenoBino(
                ratio: azurLane.ratioBonusWhite,
                Count: azurLane.bonusCountWhite,
                bigNumber: azurLane.gameNormalNumberPlay
            )
        }
        // 白７確率
        var logPostBonusBlue: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostBonusBlue = logPostDenoBino(
                ratio: azurLane.ratioBonusBlue,
                Count: azurLane.bonusCountBlue,
                bigNumber: azurLane.gameNormalNumberPlay
            )
        }
//        // ボーナス初当り
//        var logPostBonus: [Double] = [Double](repeating: 0, count: self.settingList.count)
//        if self.firstHitEnable {
//            logPostBonus = logPostDenoBino(
//                ratio: azurLane.ratioBonus,
//                Count: azurLane.bonusCount,
//                bigNumber: azurLane.gameNormalNumberPlay
//            )
//        }
        // AT初当り
        var logPostAt: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostAt = logPostDenoBino(
                ratio: azurLane.ratioAt,
                Count: azurLane.atCount,
                bigNumber: azurLane.gameNormalNumberPlay
            )
        }
        // 明石チャレンジ
        var logPostAkashi: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.akashiEnable {
            logPostAkashi = logPostPercentMulti(
                countList: [
                    azurLane.akashiCountKisu,
                    azurLane.akashiCountGusu,
                    azurLane.akashiCountLast,
                ], ratioList: [
                    azurLane.ratioAkashiKisu,
                    azurLane.ratioAkashiGusu,
                    azurLane.ratioAkashiLast,
                ], bigNumber: azurLane.akashiCountSum
            )
        }
        // 終了画面
        var logPostScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.screenEnable {
//            // ２以上
//            if azurLane.screenCountOver2 > 0 {
//                logPostScreen[0] = -Double.infinity
//            }
//            // 4以上
//            if azurLane.screenCountOver4 > 0 {
//                logPostScreen[0] = -Double.infinity
//                logPostScreen[1] = -Double.infinity
//                logPostScreen[2] = -Double.infinity
//            }
//            // 6以上
//            if azurLane.screenCountOver6 > 0 {
//                logPostScreen[0] = -Double.infinity
//                logPostScreen[1] = -Double.infinity
//                logPostScreen[2] = -Double.infinity
//                logPostScreen[3] = -Double.infinity
//                logPostScreen[4] = -Double.infinity
//            }
            logPostScreen = logPostPercentMulti(
                countList: [
                    azurLane.screenCountDefault,
                    azurLane.screenCountDefaultGusu,
                    azurLane.screenCountHighJaku,
                    azurLane.screenCountHighKyo,
                    azurLane.screenCountOver2,
                    azurLane.screenCountOver4,
                    azurLane.screenCountOver6,
                ], ratioList: [
                    azurLane.ratioScreenDefaultKisu,
                    azurLane.ratioScreenDefaultGusu,
                    azurLane.ratioScreenHighJaku,
                    azurLane.ratioScreenHighKyo,
                    azurLane.ratioScreenOver2,
                    azurLane.ratioScreenOver4,
                    azurLane.ratioScreenOver6,
                ], bigNumber: azurLane.screenCountSetteiSum
            )
        }
        // AT後の高確スタート
        var logPostStartMode: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.startModeEnable {
            logPostStartMode = logPostPercentMulti(
                countList: [
                    azurLane.startModeCountHigh,
                    azurLane.startModeCountChoHigh,
                ],
                ratioList: [
                    azurLane.ratioStartHigh,
                    azurLane.ratioStartChoHigh,
                ],
                bigNumber: azurLane.startModeCountSum
            )
        }
        // 加賀バトル
        var logPostKaga: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.kagaEnable {
            logPostKaga = logPostPercentMulti(
                countList: [
                    azurLane.kagaCountDefault,
                    azurLane.kagaCountDefaultGusu,
                    azurLane.kagaCountKisu,
                    azurLane.kagaCountGusu,
                    azurLane.kagaCount46sisa,
                    azurLane.kagaCount56sisa,
                ], ratioList: [
                    azurLane.ratioKagaDefaultKisu,
                    azurLane.ratioKagaDefaultGusu,
                    azurLane.ratioKagaKisu,
                    azurLane.ratioKagaGusu,
                    azurLane.ratioKaga46Sisa,
                    azurLane.ratioKaga56Sisa,
                ], bigNumber: azurLane.kagaCountSum
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
//            logPostJakuCherry,
//            logPostJakuSuika,
            logPostKoyaku,
            logPostBonusWhite,
            logPostBonusBlue,
//            logPostBonus,
            logPostAt,
            logPostAkashi,
            logPostScreen,
            logPostStartMode,
            logPostTrophy,
            logPostBefore,
            logPostKaga
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
    azurLaneViewBayes(
        azurLane: AzurLane(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
