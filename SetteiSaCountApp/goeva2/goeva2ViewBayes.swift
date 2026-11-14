//
//  goeva2ViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct goeva2ViewBayes: View {
    @ObservedObject var goeva2: Goeva2

    // 機種ごとに見直し
    let settingList: [Int] = [1, 2, 3, 4, 5, 6]   // その機種の設定段階
    let payoutList: [Double] = [97.7, 98.9, 101.2, 105.8, 110.6, 114.9]

    // 全機種共通
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @State var guessCustom1: [Int] = []   // カスタム配分1用の入れ物
    @State var guessCustom2: [Int] = []   // カスタム配分2用の入れ物
    @State var guessCustom3: [Int] = []   // カスタム配分3用の入れ物
    @State var resultGuess: [Double] = []   // 計算結果の入れ物
    @State var isShowResult: Bool = false   // 結果シートの表示トリガー
    @State var suikaCzEnable: Bool = true
    @State var firstHitBonusEnable: Bool = true
    @State var firstHitAtEnable: Bool = true
    @State var gesshokuEnable: Bool = true
    @State var screenEnable: Bool = true
    @State var voiceEnable: Bool = true
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
                // スイカ成立時のCZ当選率
                unitToggleWithQuestion(enable: self.$suikaCzEnable, title: "🍉からのCZ当選率")
                // ボーナス初当り確率
                unitToggleWithQuestion(enable: self.$firstHitBonusEnable, title: "ボーナス初当り確率")
                // AT初当り確率
                unitToggleWithQuestion(enable: self.$firstHitAtEnable, title: "AT初当り確率")
                unitToggleWithQuestion(enable: self.$gesshokuEnable, title: "月蝕変異の発生率")
                // 終了画面
                unitToggleWithQuestion(enable: self.$screenEnable, title: "終了画面") {
                    unitExView5body2image(
                        title: "終了画面",
                        textBody1: "・確定系のみ反映させます"
                    )
                }
                // エンディング ボイス
                unitToggleWithQuestion(enable: self.$voiceEnable, title: "エンディング ボイス") {
                    unitExView5body2image(
                        title: "エンディング ボイス",
                        textBody1: "・確定系のみ反映させます"
                    )
                }

//                // トロフィー
//                DisclosureGroup("トロフィー") {
//                }
            }

            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.goeva2MenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: goeva2.machineName,
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
        // スイカ成立時のCZ当選率
        var logPostSuikaCz: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.suikaCzEnable {
            logPostSuikaCz = logPostPercentBino(
                ratio: goeva2.ratioSuikaCz,
                Count: goeva2.suikaCzCount,
                bigNumber: goeva2.suikaCount
            )
        }

        // ボーナス初当り確率
        var logPostFirstHitBonus: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitBonusEnable {
            logPostFirstHitBonus = logPostDenoBino(
                ratio: goeva2.ratioFirstHitBonus,
                Count: goeva2.activeFirstHitCountBonus,
                bigNumber: goeva2.activeNormalGame
            )
        }

        // AT初当り確率
        var logPostFirstHitAt: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitAtEnable {
            logPostFirstHitAt = logPostDenoBino(
                ratio: goeva2.ratioFirstHitAt,
                Count: goeva2.activeFirstHitCountAt,
                bigNumber: goeva2.activeNormalGame
            )
        }

        // 月蝕変異の発生率
        var logPostGesshoku: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.gesshokuEnable {
            logPostGesshoku = logPostDenoBino(
                ratio: goeva2.ratioGesshoku,
                Count: goeva2.activeGesshokuCount,
                bigNumber: goeva2.activeNormalGame
            )
        }

        // 終了画面
        // 確定系（設定1・3否定、設定2・4否定、設定2/4/5以上濃厚、設定6濃厚）のみ渡し、示唆系は残余バケットに吸収させる
        var logPostScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.screenEnable {
            logPostScreen = logPostPercentMulti(
                countList: [
                    goeva2.screenCount5,
                    goeva2.screenCount6,
                    goeva2.screenCount7,
                    goeva2.screenCount8,
                    goeva2.screenCount9,
                    goeva2.screenCount10,
                ],
                ratioList: [
                    goeva2.ratioScreenNegate13,
                    goeva2.ratioScreenNegate24,
                    goeva2.ratioScreenOver2,
                    goeva2.ratioScreenOver4,
                    goeva2.ratioScreenOver5,
                    goeva2.ratioScreenOver6,
                ],
                bigNumber: goeva2.screenCountSum
            )
        }

        // エンディング ボイス
        // 確定系（設定2/4/5以上濃厚、設定6濃厚）のみ渡し、示唆系は残余バケットに吸収させる
        var logPostVoice: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.voiceEnable {
            logPostVoice = logPostPercentMulti(
                countList: [
                    goeva2.voiceCount5,
                    goeva2.voiceCount6,
                    goeva2.voiceCount7,
                    goeva2.voiceCount8,
                ],
                ratioList: [
                    goeva2.ratioVoiceOver2,
                    goeva2.ratioVoiceOver4,
                    goeva2.ratioVoiceOver5,
                    goeva2.ratioVoiceOver6,
                ],
                bigNumber: goeva2.voiceCountSum
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
            logPostSuikaCz,
            logPostFirstHitBonus,
            logPostFirstHitAt,
            logPostGesshoku,
            logPostScreen,
            logPostVoice,
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
    goeva2ViewBayes(
        goeva2: Goeva2(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
