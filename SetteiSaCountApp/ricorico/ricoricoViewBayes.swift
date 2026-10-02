//
//  ricoricoViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ricoricoViewBayes: View {
    @ObservedObject var ricorico: Ricorico

    // 機種ごとに見直し
    let settingList: [Int] = [1, 2, 3, 4, 5, 6]   // その機種の設定段階
    let payoutList: [Double] = [97.9, 98.9, 101.3, 106.1, 110.4, 114.6]

    // 全機種共通
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @State var guessCustom1: [Int] = []   // カスタム配分1用の入れ物
    @State var guessCustom2: [Int] = []   // カスタム配分2用の入れ物
    @State var guessCustom3: [Int] = []   // カスタム配分3用の入れ物
    @State var resultGuess: [Double] = []   // 計算結果の入れ物
    @State var isShowResult: Bool = false   // 結果シートの表示トリガー
    @State var commonBellEnable: Bool = true
    @State var henkan150GEnable: Bool = true
    @State var firstHitCzEnable: Bool = true
    @State var firstHitAtEnable: Bool = true
    @State var screenEnable: Bool = true
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
                // 共通ベル確率
                unitToggleWithQuestion(enable: self.$commonBellEnable, title: "共通ベル確率")

                // 150G 変換高確移行
                unitToggleWithQuestion(enable: self.$henkan150GEnable, title: "150G 変換高確移行")

                // CZ初当り確率
                unitToggleWithQuestion(enable: self.$firstHitCzEnable, title: "CZ初当り確率") {
                    unitExView5body2image(
                        title: "CZ初当り確率",
                        textBody1: "・バトルCZと幼少期CZをそれぞれの確率で計算要素に加えます",
                    )
                }

                // AT初当り確率
                unitToggleWithQuestion(enable: self.$firstHitAtEnable, title: "AT初当り確率")

                // 終了画面
                unitToggleWithQuestion(enable: self.$screenEnable, title: "終了画面") {
                    unitExView5body2image(
                        title: "終了画面",
                        textBody1: "・確定系のみ反映させます"
                    )
                }


                // トロフィー
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
        .resetBadgeOnAppear($common.ricoricoMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ricorico.machineName,
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
        // CZ初当り確率（バトルCZ／幼少期CZ。同時には当選しないので多項で計算）
        var logPostFirstHitCz: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitCzEnable {
            logPostFirstHitCz = logPostDenoMulti(
                countList: [
                    ricorico.firstHitCountBattleCz,
                    ricorico.firstHitCountYoshokiCz,
                ],
                denoList: [
                    ricorico.ratioFirstHitBattleCz,
                    ricorico.ratioFirstHitYoshokiCz,
                ],
                bigNumber: ricorico.normalGame
            )
        }

        // 共通ベル確率
        var logPostCommonBell: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.commonBellEnable {
            logPostCommonBell = logPostDenoBino(
                ratio: ricorico.ratioCommonBell,
                Count: ricorico.commonBellCount,
                bigNumber: ricorico.gameNumberPlay
            )
        }

        // 150G 変換高確移行
        var logPostHenkan150G: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.henkan150GEnable {
            logPostHenkan150G = logPostPercentBino(
                ratio: ricorico.ratioHenkan150G,
                Count: ricorico.henkan150GCountHit,
                bigNumber: ricorico.henkan150GCountSum
            )
        }

        // AT初当り確率
        var logPostFirstHitAt: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitAtEnable {
            logPostFirstHitAt = logPostDenoBino(
                ratio: ricorico.ratioFirstHitAt,
                Count: ricorico.firstHitCountAt,
                bigNumber: ricorico.normalGame
            )
        }

        // 終了画面
        // 確定系（設定2 以上濃厚／設定4 以上濃厚／設定6 濃厚）のみ渡し、
        // デフォルトと高設定示唆 弱・強は残余バケットに吸収させる
        // ラッシュ後とWラッシュ後は振分けが同じ前提で同一カウントに統一している
        // （別振分けと判明したら wScreenCount 系で2本立てに戻す）
        var logPostScreen: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.screenEnable {
            logPostScreen = logPostPercentMulti(
                countList: [
                    ricorico.screenCount4,
                    ricorico.screenCount5,
                    ricorico.screenCount6,
                ],
                ratioList: [
                    ricorico.ratioScreenOver2,
                    ricorico.ratioScreenOver4,
                    ricorico.ratioScreenOver6,
                ],
                bigNumber: ricorico.screenCountSum
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
            logPostCommonBell,
            logPostHenkan150G,
            logPostFirstHitCz,
            logPostFirstHitAt,
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
    ricoricoViewBayes(
        ricorico: Ricorico(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
