//
//  enenViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/13.
//

import SwiftUI

struct enenViewBayes: View {
    @ObservedObject var ver391: Ver391
    @ObservedObject var enen: Enen
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.7, 99.2, 104.4, 110.1, 114.9]
    @State var rareBonusEnable: Bool = true
    @State var regCharaEnable: Bool = true
    @State var regScreenEnable: Bool = true
    @State var shadowEnable: Bool = true
    @State var bigScreenEnable: Bool = true
    @State var adoraEnable: Bool = true
    
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
                // レア役からのボーナス当選率
                unitToggleWithQuestion(enable: self.$rareBonusEnable, title: "レア役からのボーナス当選率")
                // REG中のキャラ振分け
                unitToggleWithQuestion(enable: self.$regCharaEnable, title: "REG中のキャラ振分け")
                // REG終了画面
                unitToggleWithQuestion(enable: self.$regScreenEnable, title: "REG終了画面")
                // 伝道者の影中の当選率
                unitToggleWithQuestion(enable: self.$shadowEnable, title: "伝道者の影") {
                    unitExView5body2image(
                        title: "伝道者の影",
                        textBody1: "・伝道者の影中の十字目変換、弱レア役からのボーナス当選率を計算要素に加えます",
                    )
                }
                // 炎炎ボーナス終了画面
                unitToggleWithQuestion(enable: self.$bigScreenEnable, title: "炎炎ボーナス終了画面")
                // アドラバースト
                unitToggleWithQuestion(enable: self.$adoraEnable, title: "アドラバースト") {
                    unitExView5body2image(
                        title: "アドラバースト",
                        textBody1: "・炎炎JAC開始画面の振り分けを計算要素に加えます",
                    )
                }
            }
            
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver391.enenMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: enen.machineName,
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
        // レア役当選　十字目
        var logPostRareJuji: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.rareBonusEnable {
            logPostRareJuji = logPostPercentBino(
                ratio: enen.ratioRareBonusJuji,
                Count: enen.rareBonusCountJujiHit,
                bigNumber: enen.rareBonusCountJuji,
            )
        }
        // レア役当選　強チェリー
        var logPostRareCherry: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.rareBonusEnable {
            logPostRareCherry = logPostPercentBino(
                ratio: enen.ratioRareBonusKyoCherry,
                Count: enen.rareBonusCountKyoCherryHit,
                bigNumber: enen.rareBonusCountKyoCherry,
            )
        }
        // REG中のキャラ
        var logPostRegChara: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.regCharaEnable {
            logPostRegChara = logPostPercentMulti(
                countList: [
                    enen.charaCountDefault,
                    enen.charaCount25Sisa,
                    enen.charaCount146Sisa,
                    enen.charaCountNegate1,
                    enen.charaCountNegate2,
                    enen.charaCountNegate4,
                    enen.charaCountNegate5,
                    enen.charaCountOver4,
                    enen.charaCountOver5,
                    enen.charaCountOver6,
                ], ratioList: [
                    [44,42,40,31,28],
                    [12,20,12,25,15],
                    [20,12,20,15,25],
                    [0,10,8,9,7],
                    [13,0,12,5,8],
                    [9,10,0,12,4],
                    [2,6,6,0,9],
                    [0,0,2,2,2],
                    [0,0,0,1,1],
                    [0,0,0,0,1],
                ], bigNumber: enen.charaCountSum
            )
        }
        // REG終了画面
        var logPostRegScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.regScreenEnable {
            logPostRegScreen = logPostPercentMulti(
                countList: [
                    enen.regScreenCountDefault,
                    enen.regScreenCountHighJaku,
                    enen.regScreenCountHighKyo,
                    enen.regScreenCountOver4,
                    enen.regScreenCountOver5,
                    enen.regScreenCountOver6,
                ], ratioList: [
                    enen.ratioRegScreenDefault,
                    enen.ratioRegScreenHighJaku,
                    enen.ratioRegScreenHighKyo,
                    enen.ratioRegScreenOver4,
                    enen.ratioRegScreenOver5,
                    enen.ratioRegScreenOver6,
                ], bigNumber: enen.regScreenCountSum
            )
        }
        // 伝道者の影 十字目
        var logPostShadowJuji: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.shadowEnable {
            logPostShadowJuji = logPostPercentBino(
                ratio: enen.ratioDendoshaJuji,
                Count: enen.dendoshaCountJujiHit,
                bigNumber: enen.dendoshaCountJuji
            )
        }
        // 伝道者の影　弱レア
        var logPostShadowJakuRare: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.shadowEnable {
            logPostShadowJakuRare = logPostPercentBino(
                ratio: enen.ratioDendoshaJakuRare,
                Count: enen.dendoshaCountJakuRareHit,
                bigNumber: enen.dendoshaCountJakuRare
            )
        }
        // 炎炎ボーナス終了画面
        var logPostBigScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.bigScreenEnable {
            logPostBigScreen = logPostPercentMulti(
                countList: [
                    enen.bigScreenCountDefault,
                        enen.bigScreenCountHighJaku,
                        enen.bigScreenCountHighKyo,
                        enen.bigScreenCountOver4,
                        enen.bigScreenCountOver5,
                        enen.bigScreenCountOver6,
                ], ratioList: [
                    enen.ratioBigScreenDefault,
                    enen.ratioBigScreenHighJaku,
                    enen.ratioBigScreenHighKyo,
                    enen.ratioBigScreenOver4,
                    enen.ratioBigScreenOver5,
                    enen.ratioBigScreenOver6,
                ], bigNumber: enen.bigScreenCountSum
            )
        }
        // アドラバースト
        var logPostAdora: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.adoraEnable {
            logPostAdora = logPostPercentMulti(
                countList: [
                    enen.adoraCount25Sisa,
                        enen.adoraCount146Sisa,
                        enen.adoraCountOver2,
                        enen.adoraCount146Fix,
                        enen.adoraCountOver4,
                        enen.adoraCountOver5,
                ], ratioList: [
                    enen.ratioAdora25Sisa,
                        enen.ratioAdora146Sisa,
                        enen.ratioAdoraOver2,
                        enen.ratioAdora146Fix,
                        enen.ratioAdoraOver4,
                        enen.ratioAdoraOver5,
                ], bigNumber: enen.adoraCountSum
            )
        }
        // トロフィー
//        var logPostTrophy: [Double] = [Double](repeating: 0, count: self.settingList.count)
//        if self.over2Check {
//            logPostTrophy[0] = -Double.infinity
//        }
//        if self.over4Check {
//            logPostTrophy[0] = -Double.infinity
//            logPostTrophy[1] = -Double.infinity
//        }
//        if self.over5Check {
//            logPostTrophy[0] = -Double.infinity
//            logPostTrophy[1] = -Double.infinity
//            logPostTrophy[2] = -Double.infinity
//        }
//        if self.over6Check {
//            logPostTrophy[0] = -Double.infinity
//            logPostTrophy[1] = -Double.infinity
//            logPostTrophy[2] = -Double.infinity
//            logPostTrophy[3] = -Double.infinity
//        }
        
        // 事前確率の対数尤度
        let logPostBefore = logPostBeforeFunc(
            guess: selectedGuess(
                pattern: self.selectedBeforeGuessPattern
            )
        )
        
        // 判別要素の尤度合算
        let logPostSum: [Double] = arraySumDouble([
            logPostRareJuji,
            logPostRareCherry,
            logPostRegChara,
            logPostRegScreen,
            logPostShadowJuji,
            logPostShadowJakuRare,
            logPostBigScreen,
            logPostAdora,
//            logPostTrophy,
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
    enenViewBayes(
        ver391: Ver391(),
        enen: Enen(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
