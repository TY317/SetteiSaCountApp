//
//  kaguyaViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/06.
//

import SwiftUI

struct kaguyaViewBayes: View {
    @ObservedObject var ver390: Ver390
    @ObservedObject var kaguya: KaguyaSama
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.7, 98.8, 101.2, 105.8, 110.8, 114.9]
    @State var charaEnable: Bool = true
    @State var screenEnable: Bool = true
    @State var endingEnable: Bool = true
    
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
                // REGキャラ紹介の振分け
                unitToggleWithQuestion(enable: self.$charaEnable, title: "REGキャラ紹介の振分け")
                // ボーナス終了画面
                unitToggleWithQuestion(enable: self.$screenEnable, title: "ボーナス終了画面")
                // エンディング
                unitToggleWithQuestion(enable: self.$endingEnable, title: "エンディング") {
                    unitExView5body2image(
                        title: "エンディング",
                        textBody1: "・エピソードの振り分けを計算要素に加えます",
                    )
                }
            }
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver390.kaguyaMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "かぐや様は告らせたい",
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
        // REGキャラ紹介
        var logPostChara: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.charaEnable {
            logPostChara = logPostPercentMulti(
                countList: [
                    kaguya.regCharaCountDefault,
                    kaguya.regCharaCountKei,
                    kaguya.regCharaCountHayasaka,
                    kaguya.regCharaCountPapa,
                    kaguya.regCharaCountRainbow,
                ], ratioList: [
                    [61,56,56,46,46,46],
                    [10,10,10,15,15,15],
                    [0,5,5,5,5,5],
                    [0,0,0,5,5,5],
                    [0,0,0,0.1,0.1,0.1]
                ], bigNumber: kaguya.regCharaCountSum
            )
        }
        // ボーナス終了画面
        var logPostScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.screenEnable {
            logPostScreen = logPostPercentMulti(
                countList: [
                    kaguya.screenCountDefault,
                    kaguya.screenCountRedNekomimi,
                    kaguya.screenCountPurple2Men,
                    kaguya.screenCountSilverAdult,
                    kaguya.screenCountSilverDeformed,
                    kaguya.screenCountGoldWedding,
                ], ratioList: [
                    [96,92,92,90,90,89],
                    [1,2,2,2,2,2],
                    [0,3,3,3,3,3],
                    [0,0,0,1,1,1],
                    [0,0,0,1,1,1],
                    [0,0,0,0,0,1],
                ], bigNumber: kaguya.screenCountSum
            )
        }
        // エンディング
        var logPostEnding: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.endingEnable {
            logPostEnding = logPostPercentMulti(
                countList: [
                    kaguya.endingCountBaloon,
                    kaguya.endingCountKoiNoYukue,
                    kaguya.endingCountShirogane,
                    kaguya.endingCountKaguya,
                ], ratioList: [
                    [48,48,44,44,42,42],
                    [32,32,29,29,28,28],
                    [5,15,7,20,7,23],
                    [15,5,20,7,23,7]
                ], bigNumber: kaguya.endingCountSum
            )
        }
        // トロフィー
//        var logPostTrophy: [Double] = [Double](repeating: 0, count: self.settingList.count)
//        if self.over2Check {
//            logPostTrophy[0] = -Double.infinity
//        }
//        if self.over3Check {
//            logPostTrophy[0] = -Double.infinity
//            logPostTrophy[1] = -Double.infinity
//        }
//        if self.over4Check {
//            logPostTrophy[0] = -Double.infinity
//            logPostTrophy[1] = -Double.infinity
//            logPostTrophy[2] = -Double.infinity
//        }
//        if self.over5Check {
//            logPostTrophy[0] = -Double.infinity
//            logPostTrophy[1] = -Double.infinity
//            logPostTrophy[2] = -Double.infinity
//            logPostTrophy[3] = -Double.infinity
//        }
//        if self.over6Check {
//            logPostTrophy[0] = -Double.infinity
//            logPostTrophy[1] = -Double.infinity
//            logPostTrophy[2] = -Double.infinity
//            logPostTrophy[3] = -Double.infinity
//            logPostTrophy[4] = -Double.infinity
//        }
        
        // 事前確率の対数尤度
        let logPostBefore = logPostBeforeFunc(
            guess: selectedGuess(
                pattern: self.selectedBeforeGuessPattern
            )
        )
        
        // 判別要素の尤度合算
        let logPostSum: [Double] = arraySumDouble([
            logPostChara,
            logPostScreen,
            logPostEnding,
            
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
    kaguyaViewBayes(
        ver390: Ver390(),
        kaguya: KaguyaSama(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
