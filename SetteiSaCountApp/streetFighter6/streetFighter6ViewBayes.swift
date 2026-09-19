//
//  streetFighter6ViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct streetFighter6ViewBayes: View {
    @ObservedObject var streetFighter6: StreetFighter6

    // 機種ごとに見直し
    let settingList: [Int] = [1,2,3,4,5,6]   // その機種の設定段階
    let payoutList: [Double] = [97.4, 98.4, 100.4, 103.2, 106.1, 110]
    @State var firstHitFbEnable: Bool = true
    @State var firstHitBonusEnable: Bool = true
    @State var screenEnable: Bool = true
    @State var continueEnable: Bool = true
    @State var endingEnable: Bool = true

    // 全機種共通
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @State var guessCustom1: [Int] = []   // カスタム配分1用の入れ物
    @State var guessCustom2: [Int] = []   // カスタム配分2用の入れ物
    @State var guessCustom3: [Int] = []   // カスタム配分3用の入れ物
    @State var resultGuess: [Double] = []   // 計算結果の入れ物
    @State var isShowResult: Bool = false   // 結果シートの表示トリガー
        @State var over2Check: Bool = false
        @State var over3Check: Bool = false
        @State var over4Check: Bool = false
        @State var over5Check: Bool = false
        @State var over6Check: Bool = false
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
                // ここに小役確率など機種固有の判別要素トグルを後で追加する
                // FB初当り確率
                unitToggleWithQuestion(enable: self.$firstHitFbEnable, title: "FB初当り確率")
                // ボーナス初当り確率
                unitToggleWithQuestion(enable: self.$firstHitBonusEnable, title: "ボーナス初当り確率")
                // 終了画面
                unitToggleWithQuestion(enable: self.$screenEnable, title: "終了画面") {
                    unitExView5body2image(
                        title: "終了画面",
                        textBody1: "・確定系のみ反映させます"
                    )
                }
                // コンティニューチャンス
                unitToggleWithQuestion(enable: self.$continueEnable, title: "コンティニューチャンス") {
                    unitExView5body2image(
                        title: "コンティニューチャンス",
                        textBody1: "・ベル、リプレイ成立時の成功率を計算要素に加えます",
                    )
                }
                // エンディング ボイス
                unitToggleWithQuestion(enable: self.$endingEnable, title: "エンディング ボイス") {
                    unitExView5body2image(
                        title: "エンディング ボイス",
                        textBody1: "・確定系のみ反映させます"
                    )
                }

                // トロフィー
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
        .resetBadgeOnAppear($common.streetFighter6MenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: streetFighter6.machineName,
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
        // ここに小役確率など機種固有の対数尤度を後で追加し、下の logPostSum に足す

        // FB初当り確率
        var logPostFirstHitFb: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitFbEnable {
            logPostFirstHitFb = logPostDenoBino(
                ratio: streetFighter6.ratioFirstHitFb,
                Count: streetFighter6.firstHitCountFb,
                bigNumber: streetFighter6.normalGame
            )
        }

        // ボーナス初当り確率
        var logPostFirstHitBonus: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitBonusEnable {
            logPostFirstHitBonus = logPostDenoBino(
                ratio: streetFighter6.ratioFirstHitBonus,
                Count: streetFighter6.firstHitCountBonus,
                bigNumber: streetFighter6.normalGame
            )
        }

        // 終了画面
        // 確定系3画面のみ渡し、示唆系は残余バケットに吸収させる
        var logPostScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.screenEnable {
            logPostScreen = logPostPercentMulti(
                countList: [
                    streetFighter6.screenCount6,
                    streetFighter6.screenCount7,
                    streetFighter6.screenCount8,
                ],
                ratioList: [
                    streetFighter6.ratioScreenOver2,
                    streetFighter6.ratioScreenOver4,
                    streetFighter6.ratioScreenOver6,
                ],
                bigNumber: streetFighter6.screenCountSum
            )
        }

        // エンディング ボイス
        // 確定系「シゴロー」のみ反映（単一事象なので二項）
        var logPostEnding: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.endingEnable {
            logPostEnding = logPostPercentBino(
                ratio: streetFighter6.ratioEndingOver4,
                Count: streetFighter6.endingCount5,
                bigNumber: streetFighter6.endingCountSum
            )
        }

        // コンティニューチャンス
        // ベル・リプレイ成立を試行回数、成功を当選回数とした二項尤度
        var logPostContinue: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.continueEnable {
            logPostContinue = logPostPercentBino(
                ratio: streetFighter6.ratioContinueBellReplay,
                Count: streetFighter6.continueBellReplayCountHit,
                bigNumber: streetFighter6.continueBellReplayCountSum
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
            logPostFirstHitFb,
            logPostFirstHitBonus,
            logPostScreen,
            logPostEnding,
            logPostContinue,
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
    streetFighter6ViewBayes(
        streetFighter6: StreetFighter6(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
