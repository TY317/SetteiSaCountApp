//
//  gareiViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct gareiViewBayes: View {
    @ObservedObject var garei: Garei

    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.8, 98.9, 101, 104.4, 106.9, 110]

    // 全機種共通
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @State var guessCustom1: [Int] = []   // カスタム配分1用の入れ物
    @State var guessCustom2: [Int] = []   // カスタム配分2用の入れ物
    @State var guessCustom3: [Int] = []   // カスタム配分3用の入れ物
    @State var resultGuess: [Double] = []   // 計算結果の入れ物
    @State var isShowResult: Bool = false   // 結果シートの表示トリガー
    @State var selectedBeforeGuessPattern: String = "デフォルト"
    @State var koyakuEnable: Bool = false
    @State var chofukuEnable: Bool = false
    @State var bonusScreenEnable: Bool = true
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
                        textBody1: "・通常時ページでカウントした🍉と弱🍒の確率を計算要素に加えます",
                        textBody2: "・強🍒、弱チャンス目、強チャンス目は設定1以外の確率が非公開のため計算には使えません",
                    )
                }

                // CZ重複当選率
                unitToggleWithQuestion(enable: self.$chofukuEnable, title: "CZ重複当選率") {
                    unitExView5body2image(
                        title: "CZ重複当選率",
                        textBody1: "・通常時の弱🍒と強🍒からのCZ重複当選率を計算要素に加えます",
                        textBody2: "・通常時ページの「CZ重複当選」でカウントした回数と、各小役のカウント数から算出します",
                    )
                }

                // ボーナス終了画面
                unitToggleWithQuestion(enable: self.$bonusScreenEnable, title: "ボーナス終了画面") {
                    unitExView5body2image(
                        title: "ボーナス終了画面",
                        textBody1: "・確定系のみ反映させます"
                    )
                }

                // トロフィー
//                DisclosureGroup("トロフィー") {
//                    unitToggleWithQuestion(enable: self.$over2Check, title: "銅")
//                    unitToggleWithQuestion(enable: self.$over3Check, title: "銀")
//                    unitToggleWithQuestion(enable: self.$over4Check, title: "金")
//                    unitToggleWithQuestion(enable: self.$over5Check, title: "柄")
//                    unitToggleWithQuestion(enable: self.$over6Check, title: "虹")
//                }
            }

            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.gareiMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: garei.machineName,
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
        // （全設定の確率が判明している🍉と弱🍒のみ。役ごとの二項尤度を足す）
        var logPostKoyaku: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.koyakuEnable {
            let logPostSuika = logPostDenoBino(
                ratio: garei.ratioSuika,
                Count: garei.koyakuCountSuika,
                bigNumber: garei.gameNumberPlay
            )
            let logPostJakuCherry = logPostDenoBino(
                ratio: garei.ratioJakuCherry,
                Count: garei.koyakuCountJakuCherry,
                bigNumber: garei.gameNumberPlay
            )
            logPostKoyaku = arraySumDouble([
                logPostSuika,
                logPostJakuCherry,
            ])
        }

        // CZ重複当選率
        var logPostChofuku: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.chofukuEnable {
            let logPostChofukuJakuCherry = logPostPercentBino(
                ratio: garei.ratioChofukuJakuCherry,
                Count: garei.chofukuCountJakuCherry,
                bigNumber: garei.koyakuCountJakuCherry
            )
            let logPostChofukuKyoCherry = logPostPercentBino(
                ratio: garei.ratioChofukuKyoCherry,
                Count: garei.chofukuCountKyoCherry,
                bigNumber: garei.koyakuCountKyoCherry
            )
            logPostChofuku = arraySumDouble([
                logPostChofukuJakuCherry,
                logPostChofukuKyoCherry,
            ])
        }

        // ボーナス終了画面
        // 確定系（設定2 以上濃厚／設定4 以上濃厚／設定6 濃厚）のみ渡し、
        // デフォルトは残余バケットに吸収させる
        var logPostBonusScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.bonusScreenEnable {
            logPostBonusScreen = logPostPercentMulti(
                countList: [
                    garei.bonusScreenCount2,
                    garei.bonusScreenCount3,
                    garei.bonusScreenCount4,
                ],
                ratioList: [
                    garei.ratioBonusScreenOver2,
                    garei.ratioBonusScreenOver4,
                    garei.ratioBonusScreenOver6,
                ],
                bigNumber: garei.bonusScreenCountSum
            )
        }

        // トロフィー
        var logPostTrophy: [Double] = [Double](repeating: 0, count: self.settingList.count)

        // 事前確率の対数尤度
        let logPostBefore = logPostBeforeFunc(
            guess: selectedGuess(
                pattern: self.selectedBeforeGuessPattern
            )
        )

        // 判別要素の尤度合算
        let logPostSum: [Double] = arraySumDouble([
            logPostKoyaku,
            logPostChofuku,
            logPostBonusScreen,
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
    gareiViewBayes(
        garei: Garei(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
