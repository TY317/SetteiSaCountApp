//
//  mhrsbViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct mhrsbViewBayes: View {
    @ObservedObject var mhrsb: Mhrsb

    // 機種ごとに見直し
    let settingList: [Int] = [1, 2, 3, 4, 5, 6]   // その機種の設定段階
    let payoutList: [Double] = [97.5, 98.8, 100.8, 105.2, 108.4, 112.4]
    @State var firstHitCzEnable: Bool = true
    @State var firstHitAtEnable: Bool = true
    @State var screenEnable: Bool = true
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
                // ここに小役確率など機種固有の判別要素トグルを後で追加する
                // CZ初当り確率
                unitToggleWithQuestion(enable: self.$firstHitCzEnable, title: "CZ初当り確率") {
                    unitExView5body2image(
                        title: "CZ初当り確率",
                        textBody1: "・ブレイクゾーン（BZ）とアイルー福引の当選率を判別要素として反映させます"
                    )
                }

                // AT初当り確率
                unitToggleWithQuestion(enable: self.$firstHitAtEnable, title: "AT初当り確率")

                // AT終了画面
                unitToggleWithQuestion(enable: self.$screenEnable, title: "AT終了画面") {
                    unitExView5body2image(
                        title: "AT終了画面",
                        textBody1: "・確定系のみ反映させます"
                    )
                }

                // エンディング
                unitToggleWithQuestion(enable: self.$endingEnable, title: "エンディング") {
                    unitExView5body2image(
                        title: "エンディング",
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
        .resetBadgeOnAppear($common.mhrsbMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: mhrsb.machineName,
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

        // CZ初当り確率（BZ・アイルー福引。1ゲームごとに BZ／福引／それ以外 の多項として計算）
        var logPostFirstHitCz: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitCzEnable {
            logPostFirstHitCz = logPostDenoMulti(
                countList: [
                    mhrsb.firstHitCountBz,
                    mhrsb.firstHitCountFukubiki,
                ],
                denoList: [
                    mhrsb.ratioFirstHitBz,
                    mhrsb.ratioFirstHitFukubiki,
                ],
                bigNumber: mhrsb.normalGame
            )
        }

        // AT初当り確率
        var logPostFirstHitAt: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitAtEnable {
            logPostFirstHitAt = logPostDenoBino(
                ratio: mhrsb.ratioFirstHitAt,
                Count: mhrsb.firstHitCountAt,
                bigNumber: mhrsb.normalGame
            )
        }

        // AT終了画面
        // 確定系（設定2・3否定、設定2・5以上濃厚、設定6濃厚）のみ渡し、示唆系は残余バケットに吸収させる
        var logPostScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.screenEnable {
            logPostScreen = logPostPercentMulti(
                countList: [
                    mhrsb.screenCount5,
                    mhrsb.screenCount6,
                    mhrsb.screenCount7,
                    mhrsb.screenCount8,
                    mhrsb.screenCount9,
                ],
                ratioList: [
                    mhrsb.ratioScreenNegate2,
                    mhrsb.ratioScreenNegate3,
                    mhrsb.ratioScreenOver2,
                    mhrsb.ratioScreenOver5,
                    mhrsb.ratioScreenOver6,
                ],
                bigNumber: mhrsb.screenCountSum
            )
        }

        // エンディング
        // 確定系（設定2・3・4・5以上濃厚、設定6濃厚）のみ渡し、示唆系は残余バケットに吸収させる
        var logPostEnding: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.endingEnable {
            logPostEnding = logPostPercentMulti(
                countList: [
                    mhrsb.endingCount5,
                    mhrsb.endingCount6,
                    mhrsb.endingCount7,
                    mhrsb.endingCount8,
                    mhrsb.endingCount9,
                ],
                ratioList: [
                    mhrsb.ratioEndingOver2,
                    mhrsb.ratioEndingOver3,
                    mhrsb.ratioEndingOver4,
                    mhrsb.ratioEndingOver5,
                    mhrsb.ratioEndingOver6,
                ],
                bigNumber: mhrsb.endingCountSum
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
            logPostFirstHitCz,
            logPostFirstHitAt,
            logPostScreen,
            logPostEnding,
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
    mhrsbViewBayes(
        mhrsb: Mhrsb(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
