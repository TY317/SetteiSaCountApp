//
//  VVVViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/13.
//

import SwiftUI

struct VVVViewBayes: View {
    @ObservedObject var ver391: Ver391
    @ObservedObject var VVVendScreen: VVVendScreenVar
    @ObservedObject var VVVmarie: VVVmarieVar
    @ObservedObject var VVVharakiri: VVVharakiriVar
    @ObservedObject var vvv: vvvCzHistory
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.3, 98.3, 100.8, 103.2, 107.9, 114.9]
    @State var kakumeiRatioEnable: Bool = true
    @State var screenEnable: Bool = true
    @State var marieEnable: Bool = true
    @State var driveEnable: Bool = true
    
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
                // 革命・決戦比率
                unitToggleWithQuestion(enable: self.$kakumeiRatioEnable, title: "革命・決戦比率") {
                    unitExView5body2image(
                        title: "革命・決戦比率",
                        textBody1: "・設定1で1:1、設定6で2:1と仮定して計算を行います",
                    )
                }
                // 終了画面
                unitToggleWithQuestion(enable: self.$screenEnable, title: "CZ,ボーナス終了画面")
                // マリエ覚醒
                unitToggleWithQuestion(enable: self.$marieEnable, title: "マリエ覚醒確率")
                // ドライブ確率
                unitToggleWithQuestion(enable: self.$driveEnable, title: "ハラキリドライブ確率") {
                    unitExView5body2image(
                        title: "ハラキリドライブ確率",
                        textBody1: "・設定1で1/12.5、設定6で1/4と仮定して計算を行います",
                    )
                }
            }
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver391.VVVMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "革命機ヴァルヴレイヴ",
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
        // 革命・決戦比率
        var logPostKakumeiRatio = [Double](repeating: 0, count: self.settingList.count)
        if self.kakumeiRatioEnable {
            logPostKakumeiRatio = logPostPercentBino(
                ratio: [50.0,53.3,56.6,60.0,63.3,66.6],
                Count: vvv.kakumeiCount,
                bigNumber: vvv.bonusCountSum
            )
        }
        // 終了画面
        var logPostScreen = [Double](repeating: 0, count: self.settingList.count)
        if self.screenEnable {
            logPostScreen = logPostPercentMulti(
                countList: [
                    VVVendScreen.w2Count,
                    VVVendScreen.w3Count,
                    VVVendScreen.w4Count,
                    VVVendScreen.pManCount,
                    VVVendScreen.pMizugiCount,
                    VVVendScreen.r5Count,
                    VVVendScreen.r6Count,
                    VVVendScreen.gCount,
                ], ratioList: [
                    [79.0,77.0,75.0,75.0,75.0,74.0],
                    [10.0,8.0,10.0,5.0,10.0,5.0],
                    [8,10,7,10,5,10],
                    [2,2,4,4,4,4],
                    [1,1,2,2,2,3],
                    [0.0,2.0,2.0,2.0,2.0,2.0],
                    [0,0,0,2.0,2.0,1.0],
                    [0,0,0,0,0,1.0],
                ], bigNumber: VVVendScreen.screenCountSum
            )
        }
        // マリエ覚醒
        var logPostMarie = [Double](repeating: 0, count: self.settingList.count)
        if self.marieEnable {
            logPostMarie = logPostPercentBino(
                ratio: [5.0,6.0,7.0,9.0,10.0,13.0],
                Count: VVVmarie.marieCount,
                bigNumber: vvv.kakumeiCount
            )
        }
        // ハラキリドライブ確率
        var logPostDrive = [Double](repeating: 0, count: self.settingList.count)
        if self.driveEnable {
            logPostDrive = logPostDenoBino(
                ratio: [12.5,10.8,9.1,7.4,5.7,4.0],
                Count: VVVharakiri.totalDriveSum,
                bigNumber: VVVharakiri.totalSum
            )
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
            logPostKakumeiRatio,
            logPostScreen,
            logPostMarie,
            logPostDrive,
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
    VVVViewBayes(
        ver391: Ver391(),
        VVVendScreen: VVVendScreenVar(),
        VVVmarie: VVVmarieVar(),
        VVVharakiri: VVVharakiriVar(),
        vvv: vvvCzHistory(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
