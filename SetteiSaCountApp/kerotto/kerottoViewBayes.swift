//
//  kerottoViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct kerottoViewBayes: View {
    @ObservedObject var kerotto: Kerotto

    // 機種ごとに見直し
    let settingList: [Int] = [1, 2, 3, 4, 5, 6]   // その機種の設定段階
    let payoutList: [Double] = [98.2, 99.1, 101.1, 104.5, 107, 111]
    @State var firstHitBonusEnable: Bool = true
    @State var bonusRWEnable: Bool = true
    @State var bigScreenEnable: Bool = true

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
                // ボーナス初当り確率
                unitToggleWithQuestion(enable: self.$firstHitBonusEnable, title: "ボーナス初当り確率")
                // ボーナス赤白比率
                unitToggleWithQuestion(enable: self.$bonusRWEnable, title: "ボーナス赤白比率")
                // BIG終了画面
                unitToggleWithQuestion(enable: self.$bigScreenEnable, title: "BIG終了画面") {
                    unitExView5body2image(
                        title: "BIG終了画面",
                        textBody1: "・確定系のみ反映させます",
                    )
                }

                // トロフィー
                DisclosureGroup("ケロットトロフィー") {
                    unitToggleWithQuestion(enable: self.$over2Check, title: "銅")
                    unitToggleWithQuestion(enable: self.$over3Check, title: "銀")
                    unitToggleWithQuestion(enable: self.$over4Check, title: "金")
                    unitToggleWithQuestion(enable: self.$over5Check, title: "ケロット柄")
                    unitToggleWithQuestion(enable: self.$over6Check, title: "虹")
                }
            }

            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kerottoMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kerotto.machineName,
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
        // ボーナス初当り確率
        var logPostFirstHitBonus: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitBonusEnable {
            logPostFirstHitBonus = logPostDenoMulti(
                countList: [kerotto.firstHitCountSBBSum, kerotto.firstHitCountBBSum, kerotto.firstHitCountREGSum],
                denoList: [kerotto.ratioFirstHitSbb, kerotto.ratioFirstHitBb, kerotto.ratioFirstHitReg],
                bigNumber: kerotto.gameNumberPlay
            )
        }
        // ボーナス赤白比率
        var logPostBonusRW: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.bonusRWEnable {
            logPostBonusRW = logPostPercentBino(
                ratio: kerotto.ratioFirstHitRed,
                Count: kerotto.firstHitCountRSum,
                bigNumber: kerotto.firstHitCountAllSum
            )
        }
        // BIG終了画面
        var logPostBigScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.bigScreenEnable {
            logPostBigScreen = logPostPercentMulti(
                countList: [kerotto.screenCount5, kerotto.screenCount6, kerotto.screenCount7],
                ratioList: [kerotto.ratioScreenOver2, kerotto.ratioScreenOver4, kerotto.ratioScreenOver5],
                bigNumber: kerotto.screenCountSum
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
            logPostFirstHitBonus,
            logPostBonusRW,
            logPostBigScreen,
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
    kerottoViewBayes(
        kerotto: Kerotto(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
