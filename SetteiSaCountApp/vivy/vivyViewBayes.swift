//
//  vivyViewBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct vivyViewBayes: View {
    @ObservedObject var vivy: Vivy

    // 機種ごとに見直し
    let settingList: [Int] = [1, 2, 3, 4, 5, 6]   // その機種の設定段階
    let payoutList: [Double] = [97.7, 98.7, 100.2, 104.7, 108.3, 112.8]

    // 全機種共通
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @State var guessCustom1: [Int] = []   // カスタム配分1用の入れ物
    @State var guessCustom2: [Int] = []   // カスタム配分2用の入れ物
    @State var guessCustom3: [Int] = []   // カスタム配分3用の入れ物
    @State var resultGuess: [Double] = []   // 計算結果の入れ物
    @State var isShowResult: Bool = false   // 結果シートの表示トリガー
    @State var accelPromoteEnable: Bool = true
    @State var firstHitAtEnable: Bool = true
    @State var charaEnable: Bool = true
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
                // アクセスチャンス昇格 継続回数
                unitToggleWithQuestion(enable: self.$accelPromoteEnable, title: "アクセスチャンス昇格")
                // AT初当り確率
                unitToggleWithQuestion(enable: self.$firstHitAtEnable, title: "AT初当り確率")
                // エンディング ミニキャラ
                unitToggleWithQuestion(enable: self.$charaEnable, title: "エンディング ミニキャラ") {
                    unitExView5body2image(
                        title: "エンディング ミニキャラ",
                        textBody1: "・ミニキャラ1体の出現時の振分けを反映させます",
                        textBody2: "・2体以上出現時（設定N以上濃厚）はトロフィー欄などで反映してください",
                    )
                }

                // トロフィー
                DisclosureGroup("コパンダトロフィー") {
                    unitToggleWithQuestion(enable: self.$over2Check, title: "銅")
                    unitToggleWithQuestion(enable: self.$over3Check, title: "銀")
                    unitToggleWithQuestion(enable: self.$over4Check, title: "金")
                    unitToggleWithQuestion(enable: self.$over5Check, title: "イナズマ柄")
                    unitToggleWithQuestion(enable: self.$over6Check, title: "虹")
                }
            }

            // //// STEP3
            bayesSubStep3Section(viewModel: viewModel) {
                self.resultGuess = bayesRatio()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.vivyMenuBayesBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: vivy.machineName,
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

        // アクセスチャンス昇格 継続回数
        // 突入時の1回の抽選を「その回まで昇格しなかった場合の昇格率」に分解して各回の二項尤度を足す
        // （各回の条件付き確率の積が1回分の同時確率と一致するため、二重計上にならない）
        var logPostAccelPromote: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.accelPromoteEnable {
            logPostAccelPromote = arraySumDouble([
                logPostPercentBino(
                    ratio: vivy.ratioAccelPromote[0],
                    Count: vivy.accelPromoteCountHit1,
                    bigNumber: vivy.accelPromoteCountSum1
                ),
                logPostPercentBino(
                    ratio: vivy.ratioAccelPromote[1],
                    Count: vivy.accelPromoteCountHit2,
                    bigNumber: vivy.accelPromoteCountSum2
                ),
                logPostPercentBino(
                    ratio: vivy.ratioAccelPromote[2],
                    Count: vivy.accelPromoteCountHit3,
                    bigNumber: vivy.accelPromoteCountSum3
                ),
                logPostPercentBino(
                    ratio: vivy.ratioAccelPromote[3],
                    Count: vivy.accelPromoteCountHit4,
                    bigNumber: vivy.accelPromoteCountSum4
                ),
            ])
        }
        // AT初当り確率
        var logPostFirstHitAt: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.firstHitAtEnable {
            logPostFirstHitAt = logPostDenoBino(
                ratio: vivy.ratioFirstHitAt,
                Count: vivy.activeFirstHitCountAt,
                bigNumber: vivy.activeNormalGame
            )
        }

        // エンディング ミニキャラ（全キャラの振分けが判明しているので全カテゴリを渡す）
        var logPostChara: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.charaEnable {
            logPostChara = logPostPercentMulti(
                countList: [
                    vivy.charaCount1,
                    vivy.charaCount2,
                    vivy.charaCount3,
                    vivy.charaCount4,
                    vivy.charaCount5,
                    vivy.charaCount6,
                ],
                ratioList: vivy.ratioCharaNormalizedList,
                bigNumber: vivy.charaCountSum
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
            logPostAccelPromote,
            logPostFirstHitAt,
            logPostChara,
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
    vivyViewBayes(
        vivy: Vivy(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
