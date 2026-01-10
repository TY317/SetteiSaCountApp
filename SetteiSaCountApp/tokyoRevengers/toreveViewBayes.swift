//
//  toreveViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/05.
//

import SwiftUI

struct toreveViewBayes: View {
    @ObservedObject var toreve: Toreve
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.8, 98.8, 101.4, 106.3, 111.2, 114.9]
    @State var firstHitEnable: Bool = true
    @State var screenEnable: Bool = true
    @State var chanceCzEnable: Bool = true
    @State var revengeEnable: Bool = true
    @State var atRiseEnable: Bool = true
    @State var bellEnable: Bool = true
    @State var furiwakeEnable: Bool = true
    @State var stockEnable: Bool = true
    
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
                // 共通ベル
                unitToggleWithQuestion(enable: self.$bellEnable, title: "共通ベル確率")
                // チャンス目からのCZ当選率
                unitToggleWithQuestion(enable: self.$chanceCzEnable, title: "チャンス目からのCZ当選率")
                // 初当り確率
                unitToggleWithQuestion(enable: self.$firstHitEnable, title: "初当り確率") {
                    unitExView5body2image(
                        title: "初当り確率",
                        textBody1: "・東卍チャンス、東卍ラッシュ、ミッドナイトモード、稀咲陰謀の初当り確率を計算要素に加えます",
                    )
                }
                // モードごとの振分け確率
                unitToggleWithQuestion(enable: self.$furiwakeEnable, title: "モードごとの初当り種類振分け") {
                    unitExView5body2image(
                        title: "モードごとの初当り種類振分け",
                        textBody1: "・モードA,チャンス・天国での東卍ラッシュ・東卍チャンスの振分け確率を計算要素に加えます"
                    )
                }
//                .popoverTip(tipVer3131ToreveBayes())
                // 東卍チャンス　昇格
                unitToggleWithQuestion(enable: self.$atRiseEnable, title: "東卍チャンス中のAT昇格率") {
                    unitExView5body2image(
                        title: "東卍チャンス中のAT昇格率",
                        textBody1: "・弱🍒・🍉からのAT昇格率を計算要素に加えます"
                    )
                }
                // 東卍ラッシュ　セットストック振分け
                unitToggleWithQuestion(enable: self.$stockEnable, title: "セットストック振分け")
                // 終了画面
                unitToggleWithQuestion(enable: self.$screenEnable, title: "終了画面") {
                    unitExView5body2image(
                        title: "終了画面",
                        textBody1: "・確定系のみ反映させます",
                    )
                }
                // リベンジ
                unitToggleWithQuestion(enable: self.$revengeEnable, title: "リベンジ") {
                    unitExView5body2image(
                        title: "リベンジ",
                        textBody1: "・決戦前夜後のノイズ発生率、東卍チャンス後のリベンジ発生率を計算要素に加えます"
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
        .resetBadgeOnAppear($common.toreveMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: toreve.machineName,
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
        // 初当り確率
        var logPostFirstHit: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostFirstHit = logPostDenoMulti(
                countList: [
                    toreve.tomanChallengeCount,
                    toreve.tomanRushCount,
                ], denoList: [
                    toreve.ratioTomanChallenge,
                    toreve.ratioTomanRush,
                ], bigNumber: toreve.normalGame
            )
        }
        var logPostMidNight: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostMidNight = logPostDenoBino(
                ratio: toreve.ratioCzMidNight,
                Count: toreve.czCountMidNight,
                bigNumber: toreve.normalGame
            )
        }
        // 綺咲陰謀
        var logPostKisaki: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitEnable {
            logPostKisaki = logPostDenoBino(
                ratio: toreve.ratioCzKisaki,
                Count: toreve.czCountKisaki,
                bigNumber: toreve.normalGame
            )
        }
        // チャンス目からのCZ当選率
        var logPostChanceCz: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.chanceCzEnable {
            logPostChanceCz = logPostPercentBino(
                ratio: toreve.ratioNormalChanceMidNight,
                Count: toreve.chanceCzCountCzHit,
                bigNumber: toreve.chanceCzCountChance
            )
        }
        // 終了画面
        var logPostScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.screenEnable {
            if toreve.screenCount7 > 0 {
                logPostScreen[0] = -Double.infinity
            }
            if toreve.screenCount8 > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
            }
            if toreve.screenCount4 > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
                logPostScreen[2] = -Double.infinity
            }
            if toreve.screenCount9 > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
                logPostScreen[2] = -Double.infinity
                logPostScreen[3] = -Double.infinity
            }
            if toreve.screenCount10 > 0 {
                logPostScreen[0] = -Double.infinity
                logPostScreen[1] = -Double.infinity
                logPostScreen[2] = -Double.infinity
                logPostScreen[3] = -Double.infinity
                logPostScreen[4] = -Double.infinity
            }
        }
        // リベンジ 決戦前夜３、４周期
        var logPostRevengeZenya34: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.revengeEnable {
            logPostRevengeZenya34 = logPostPercentBino(
                ratio: toreve.ratioRevengeZenya34NoizeHit,
                Count: toreve.revengeCountZenya34NoizeHit,
                bigNumber: toreve.revengeCountZenya34Sum
            )
        }
        // リベンジ 決戦前夜５周期
        var logPostRevengeZenya5: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.revengeEnable {
            logPostRevengeZenya5 = logPostPercentBino(
                ratio: toreve.ratioRevengeZenya5NoizeHit,
                Count: toreve.revengeCountZenya5NoizeHit,
                bigNumber: toreve.revengeCountZenya5Sum
            )
        }
        // リベンジ 東卍チャンス2スルー
        var logPostRevengeChance2: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.revengeEnable {
            logPostRevengeChance2 = logPostPercentBino(
                ratio: toreve.ratioRevengeChance2RevengeHit,
                Count: toreve.revengeCountChance2Hit,
                bigNumber: toreve.revengeCountChance2Sum
            )
        }
        // リベンジ 東卍チャンス3スルー
        var logPostRevengeChance3: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.revengeEnable {
            logPostRevengeChance3 = logPostPercentBino(
                ratio: toreve.ratioRevengeChance3RevengeHit,
                Count: toreve.revengeCountChance3Hit,
                bigNumber: toreve.revengeCountChance3Sum
            )
        }
        // AT昇格率
        var logPostAtRise: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.atRiseEnable {
            logPostAtRise = logPostPercentBino(
                ratio: toreve.ratioAtRiseJakuRare,
                Count: toreve.atRiseCountManjiRise,
                bigNumber: toreve.atRiseCountManji
            )
        }
        // 共通ベル
        var logPostCommonBell: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.bellEnable {
            logPostCommonBell = logPostDenoBino(
                ratio: toreve.ratioBell,
                Count: toreve.bellCount,
                bigNumber: toreve.gameNumberPlay
            )
        }
        // 初当り種類振分け
        var logPostFuriwakeModeA: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.furiwakeEnable {
            logPostFuriwakeModeA = logPostPercentBino(
                ratio: toreve.ratioModeARush,
                Count: toreve.furiwakeCountModeARush,
                bigNumber: toreve.furiwakeCountModeASum
            )
        }
        var logPostFuriwakeHeaven: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.furiwakeEnable {
            logPostFuriwakeHeaven = logPostPercentBino(
                ratio: toreve.ratioHeavenRush,
                Count: toreve.furiwakeCountHeavenRush,
                bigNumber: toreve.furiwakeCountHeavenSum
            )
        }
        
        // セットストック
        var logPostSetStock: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.stockEnable {
            logPostSetStock = logPostPercentMulti(
                countList: [
                    toreve.setStockCountNone,
                    toreve.setStockCount1,
                    toreve.setStockCount2,
                    toreve.setStockCount3,
                ], ratioList: [
                    toreve.ratioStockNone,
                    toreve.ratioStock1,
                    toreve.ratioStock2,
                    toreve.ratioStock3,
                ], bigNumber: toreve.setStockCountSum
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
            logPostFirstHit,
            logPostScreen,
            logPostKisaki,
            logPostChanceCz,
            logPostMidNight,
            logPostRevengeZenya34,
            logPostRevengeZenya5,
            logPostRevengeChance2,
            logPostRevengeChance3,
            logPostAtRise,
            logPostCommonBell,
            logPostFuriwakeModeA,
            logPostFuriwakeHeaven,
            logPostSetStock,
            
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
    toreveViewBayes(
        toreve: Toreve(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
