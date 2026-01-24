//
//  mt5ViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/13.
//

import SwiftUI

struct mt5ViewBayes: View {
//    @ObservedObject var ver370: Ver370
    @ObservedObject var mt5: Mt5
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.9, 98.9, 104.5, 110.2, 114.9]
    @State var koyakuEnable: Bool = true
    @State var gekisoEnable: Bool = true
    @State var rivalEnable: Bool = true
    @State var blackMedalEnable: Bool = true
    @State var aoshimaScreenEnable: Bool = true
    @State var rareItemEnable: Bool = true
    
    // 全機種共通
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
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
                // ５枚役
                unitToggleWithQuestion(enable: self.$koyakuEnable, title: "5枚役")
                // 激走チャージ
                unitToggleWithQuestion(enable: self.$gekisoEnable, title: "激走チャージ後のセリフ")
                // 激走チャージ　アイテム獲得率
                unitToggleWithQuestion(enable: self.$rareItemEnable, title: "激走チャージ アイテム獲得率") {
                    unitExView5body2image(
                        title: "アイテム獲得率",
                        textBody1: "・激走チャージ中の弱🍒・🍉、弱チャンス目、強チャンス目でのアイテム獲得率を計算要素に加えます",
                    )
                }
                // ライバルモード
                unitToggleWithQuestion(enable: self.$rivalEnable, title: "ライバルモード")
                // 黒メダル
                unitToggleWithQuestion(enable: self.$blackMedalEnable, title: "黒メダル出現率")
                // 青島SGラウンド開始画面
                unitToggleWithQuestion(
                    enable: self.$aoshimaScreenEnable,
                    title: "青島SGラウンド開始画面",
                ) {
                    unitExView5body2image(
                        title: "ラウンド開始画面",
                        textBody1: "・ドレスの出現率と＆波多野の有無を計算要素として加えます",
                        textBody2: "・全て継続ストックありの確率を前提に計算します",
                    )
                }
                // ケロットトロフィー
                DisclosureGroup("ケロットトロフィー") {
                    unitToggleWithQuestion(enable: self.$over2Check, title: "銅トロフィー")
                    unitToggleWithQuestion(enable: self.$over4Check, title: "金トロフィー")
                    unitToggleWithQuestion(enable: self.$over5Check, title: "ケロット柄トロフィー")
                    unitToggleWithQuestion(enable: self.$over6Check, title: "虹トロフィー")
                }
            }
            
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.mt5MenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "モンキーターン5",
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
        // 5枚役の対数尤度
        var logPost5maiyaku = [Double](repeating: 0, count: self.settingList.count)
        if self.koyakuEnable {
            logPost5maiyaku = logPostDenoBino(
                ratio: [38,36,30,24,22],
                Count: mt5.coin5Count,
                bigNumber: mt5.playGame
            )
        }
        // 激走チャージセリフの対数尤度
        var logPostGekiso = [Double](repeating: 0, count: self.settingList.count)
        if self.gekisoEnable {
            logPostGekiso = logPostPercentBino(
                ratio: [50,40,40,70,40],
                Count: mt5.hatanoACount,
                bigNumber: mt5.hatanoCountSum
            )
        }
        // 激走チャージ　アイテム獲得率
        var logPostRareItemJakuRare = [Double](repeating: 0, count: self.settingList.count)
        var logPostRareItemJakuChance = [Double](repeating: 0, count: self.settingList.count)
        var logPostRareItemKyoChance = [Double](repeating: 0, count: self.settingList.count)
        if self.rareItemEnable {
            logPostRareItemJakuRare = logPostPercentBino(
                ratio: mt5.ratioRareItemJakuCherrySuika,
                Count: mt5.rareItemCountJakuRareHit,
                bigNumber: mt5.rareItemCountJakuRareSum
            )
            logPostRareItemJakuChance = logPostPercentBino(
                ratio: mt5.ratioRareItemJakuChance,
                Count: mt5.rareItemCountJakuChanceHit,
                bigNumber: mt5.rareItemCountJakuChance
            )
            logPostRareItemKyoChance = logPostPercentBino(
                ratio: mt5.ratioRareItemKyoChance,
                Count: mt5.rareItemCountKyoChanceHit,
                bigNumber: mt5.rareItemCountKyoChance
            )
        }
        
        // ライバルモードの対数尤度
        var logPostRival = [Double](repeating: 0, count: self.settingList.count)
        if self.rivalEnable {
            let atCount = (mt5.atCountPlus1-1)<0 ? 0 : (mt5.atCountPlus1-1)
            logPostRival = logPostPercentMulti(
                countList: [
                    mt5.rivalGamoCount,
                    mt5.rivalHamaokaCount,
                    mt5.rivalEnokiCount,
                ],
                ratioList: [
                    [7.8,8.6,10.9,14.1,15.6],
                    [7.8,8.2,9.4,10.5,10.9],
                    [7.8,8.2,9.4,10.5,10.9],
                ],
//                bigNumber: mt5.atCountPlus1
                bigNumber: atCount
            )
        }
        
        // 黒メダルの対数尤度
        var logPostMedal = [Double](repeating: 0, count: self.settingList.count)
        if self.blackMedalEnable {
            logPostMedal = logPostPercentBino(
                ratio: [1.2,1.5,4,4.5,4.5],
                Count: mt5.blackMedalCount,
                bigNumber: mt5.atCount
            )
        }
        
        // 青島SGラウンド開始画面
        var logPostScreen = [Double](repeating: 0, count: self.settingList.count)
        if self.aoshimaScreenEnable {
            // ドレス分の計算
            logPostScreen = logPostPercentBino(
                ratio: [20,25,35,41,41],
                Count: mt5.AoshimaSGDressCount,
                bigNumber: mt5.AoshimaSGCountSum
            )
            // &波多野が１以上なら１、２、４を-infにしておく
            if mt5.AoshimaSGHatanoCount > 0 {
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
            logPost5maiyaku,
            logPostGekiso,
            logPostRareItemJakuRare,
            logPostRareItemJakuChance,
            logPostRareItemKyoChance,
            logPostRival,
            logPostMedal,
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
    mt5ViewBayes(
//        ver370: Ver370(),
        mt5: Mt5(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
