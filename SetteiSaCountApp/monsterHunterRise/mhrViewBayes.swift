//
//  mhrViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/07.
//

import SwiftUI

struct mhrViewBayes: View {
//    @ObservedObject var ver390: Ver390
    @ObservedObject var mhr: Mhr
    
    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.9, 98.8, 100.3, 105.4, 110.1, 114.3]
    @State var riseZoneEnable: Bool = true
    @State var airuEnable: Bool = true
    @State var atEnable: Bool = true
    @State var bonusScreenEnable: Bool = true
    @State var atScreenEnable: Bool = true
    
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
                // ライズゾーン初当り
                unitToggleWithQuestion(enable: self.$riseZoneEnable, title: "ライズゾーン初当り確率")
                // アイルーだるま落とし
                unitToggleWithQuestion(enable: self.$airuEnable, title: "アイルーだるま落とし") {
                    unitExView5body2image(
                        title: "アイルーだるま落とし",
                        textBody1: "・規定リプレイ回数 80回以下の振り分けを計算要素に加えます",
                    )
                }
                // AT初当り
                unitToggleWithQuestion(enable: self.$atEnable, title: "AT初当り確率")
                // ボーナス確定画面
                unitToggleWithQuestion(enable: self.$bonusScreenEnable, title: "ボーナス確定画面") {
                    unitExView5body2image(
                        title: "ボーナス確定画面",
                        textBody1: "・確定系のみ反映させます",
                    )
                }
                // AT終了画面
                unitToggleWithQuestion(enable: self.$atScreenEnable, title: "AT終了画面") {
                    unitExView5body2image(
                        title: "AT終了画面",
                        textBody1: "・否定系、確定系のみ反映させます",
                    )
                }
                // エンタトロフィー
                DisclosureGroup("エンタトロフィー") {
                    unitToggleWithQuestion(enable: self.$over2Check, title: "銅")
                    unitToggleWithQuestion(enable: self.$over3Check, title: "銀")
                    unitToggleWithQuestion(enable: self.$over4Check, title: "金")
                    unitToggleWithQuestion(enable: self.$over5Check, title: "紅葉柄")
                    unitToggleWithQuestion(enable: self.$over6Check, title: "虹")
                }
            }
            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver390.mhrMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "モンスターハンター ライズ",
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
        // ライズゾーン
        var logPostRiseZone: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.riseZoneEnable {
            logPostRiseZone = logPostDenoBino(
                ratio: [76,75,73,72,69,68],
                Count: mhr.riseZoneCount,
                bigNumber: mhr.playGameSum
            )
        }
        // アイルー
        var logPostAiru: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.airuEnable {
            logPostAiru = logPostPercentBino(
                ratio: [25,27,31,39,44,45],
                Count: mhr.airuCountUnder80,
                bigNumber: mhr.airuCountSum
            )
        }
        // AT初当り
        var logPostAt: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.atEnable {
            logPostAt = logPostDenoBino(
                ratio: [310,301,291,256,237,231],
                Count: mhr.atHitCount,
                bigNumber: mhr.playGameSum
            )
        }
        // ボーナス確定画面
        var logPostBonusScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.bonusScreenEnable {
            if mhr.bonusScreenCount3Person > 0 {
                logPostBonusScreen[0] = -Double.infinity
                logPostBonusScreen[1] = -Double.infinity
                logPostBonusScreen[2] = -Double.infinity
            }
        }
        // AT終了画面
        var logPostAtScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.atScreenEnable {
            // ２否定
            if mhr.endScreenCountIoriYomogi > 0 {
                logPostAtScreen[1] = -Double.infinity
            }
            // ３否定
            if mhr.endScreenCountUtsushiFugen > 0 {
                logPostAtScreen[2] = -Double.infinity
            }
            // ５以上
            if mhr.endScreenCountAll > 0 {
                logPostAtScreen[0] = -Double.infinity
                logPostAtScreen[1] = -Double.infinity
                logPostAtScreen[2] = -Double.infinity
                logPostAtScreen[3] = -Double.infinity
            }
            // 6以上
            if mhr.endScreenCountHinoeMinotoEnta > 0 {
                logPostAtScreen[0] = -Double.infinity
                logPostAtScreen[1] = -Double.infinity
                logPostAtScreen[2] = -Double.infinity
                logPostAtScreen[3] = -Double.infinity
                logPostAtScreen[4] = -Double.infinity
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
            logPostRiseZone,
            logPostAiru,
            logPostAt,
            logPostBonusScreen,
            logPostAtScreen,
            
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
    mhrViewBayes(
//        ver390: Ver390(),
        mhr: Mhr(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
