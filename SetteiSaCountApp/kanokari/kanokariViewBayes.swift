//
//  kanokariViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct kanokariViewBayes: View {
    @ObservedObject var kanokari: Kanokari

    // 機種ごとに見直し
    let settingList: [Int] = [1, 2, 3, 4, 5, 6]   // その機種の設定段階
    let payoutList: [Double] = [97.7, 98.7, 101.0, 105.5, 110.4, 114.9]
    @State var firstHitCzEnable: Bool = true
    @State var firstHitBonusEnable: Bool = true
    @State var screenEnable: Bool = true
    @State var rbCharaEnable: Bool = true

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

                // CZ確率
                unitToggleWithQuestion(enable: self.$firstHitCzEnable, title: "CZ確率")

                // 初当り確率
                unitToggleWithQuestion(enable: self.$firstHitBonusEnable, title: "初当り確率")

                // 終了画面
                unitToggleWithQuestion(enable: self.$screenEnable, title: "終了画面") {
                    unitExView5body2image(
                        title: "終了画面",
                        textBody1: "・確定系のみ反映させます"
                    )
                }

                // RB中 キャラ紹介シナリオ
                unitToggleWithQuestion(enable: self.$rbCharaEnable, title: "RB中 キャラ紹介シナリオ") {
                    unitExView5body2image(
                        title: "RB中 キャラ紹介シナリオ",
                        textBody1: "・確定系のみ反映させます"
                    )
                }

//                // トロフィー
//                DisclosureGroup("トロフィー") {
//
//                }
            }

            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kanokariMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kanokari.machineName,
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

        // CZ確率
        var logPostFirstHitCz: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitCzEnable {
            logPostFirstHitCz = logPostDenoBino(
                ratio: kanokari.ratioFirstHitCz,
                Count: kanokari.firstHitCountCz,
                bigNumber: kanokari.normalGame
            )
        }

        // 初当り確率
        var logPostFirstHitBonus: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitBonusEnable {
            logPostFirstHitBonus = logPostDenoBino(
                ratio: kanokari.ratioFirstHitBonus,
                Count: kanokari.firstHitCountBonus,
                bigNumber: kanokari.normalGame
            )
        }

        // 終了画面
        // 確定系（赤枠／紫枠／銀枠／金枠）のみ渡し、示唆系は残余バケットに吸収させる
        var logPostScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.screenEnable {
            logPostScreen = logPostPercentMulti(
                countList: [
                    kanokari.screenCount4,
                    kanokari.screenCount5,
                    kanokari.screenCount6,
                    kanokari.screenCount7,
                ],
                ratioList: [
                    kanokari.ratioScreenOver2,
                    kanokari.ratioScreenOver4,
                    kanokari.ratioScreenOver5,
                    kanokari.ratioScreenOver6,
                ],
                bigNumber: kanokari.screenCountSum
            )
        }

        // RB中 キャラ紹介シナリオ
        // 確定系（設定1〜5否定、設定2〜5以上濃厚、設定6濃厚）のみ渡し、示唆系は残余バケットに吸収させる
        var logPostRbChara: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.rbCharaEnable {
            logPostRbChara = logPostPercentMulti(
                countList: [
                    kanokari.rbCharaCountNegate1,
                    kanokari.rbCharaCountNegate2,
                    kanokari.rbCharaCountNegate3,
                    kanokari.rbCharaCountNegate4,
                    kanokari.rbCharaCountNegate5,
                    kanokari.rbCharaCountOver2,
                    kanokari.rbCharaCountOver3,
                    kanokari.rbCharaCountOver4,
                    kanokari.rbCharaCountOver5,
                    kanokari.rbCharaCountOver6,
                ],
                ratioList: [
                    kanokari.ratioRbCharaNegate1,
                    kanokari.ratioRbCharaNegate2,
                    kanokari.ratioRbCharaNegate3,
                    kanokari.ratioRbCharaNegate4,
                    kanokari.ratioRbCharaNegate5,
                    kanokari.ratioRbCharaOver2,
                    kanokari.ratioRbCharaOver3,
                    kanokari.ratioRbCharaOver4,
                    kanokari.ratioRbCharaOver5,
                    kanokari.ratioRbCharaOver6,
                ],
                bigNumber: kanokari.rbCharaCountSum
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
            logPostFirstHitCz,
            logPostFirstHitBonus,
            logPostScreen,
            logPostRbChara,
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
    kanokariViewBayes(
        kanokari: Kanokari(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
