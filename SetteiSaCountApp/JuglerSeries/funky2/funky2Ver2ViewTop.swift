//
//  funky2Ver2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/09.
//

import SwiftUI
import FirebaseAnalytics

struct funky2Ver2ViewTop: View {
    @StateObject var funky2 = Funky2()
    @State var isShowAlert: Bool = false
    @StateObject var funky2Memory1 = Funky2Memory1()
    @StateObject var funky2Memory2 = Funky2Memory2()
    @StateObject var funky2Memory3 = Funky2Memory3()
    @ObservedObject var bayes: Bayes
    @StateObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    
                } header: {
                    unitLabelMachineTopTitle(machineName: "ファンキージャグラー2")
                }
                
                // //// 見
                Section {
                    // データ入力
                    NavigationLink(destination: funky2Ver2ViewKenDataInput(funky2: funky2)) {
                        unitLabelMenu(
                            imageSystemName: "magnifyingglass",
                            textBody: "データ確認"
                        )
                    }
                    
                    // 島データ
                    NavigationLink(destination: funky2ViewShimaData(
                        funky2: funky2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "waveform.path.ecg.magnifyingglass",
                            textBody: "島データ確認",
                            badgeStatus: common.funky2MenuShimaBadge,
                        )
                    }
                } header: {
                    unitHeaderLabelKen()
//                    HStack {
//                        Text("見")
//                            .fontWeight(.bold)
//                            .font(.headline)
//                        unitToolbarButtonQuestion {
//                            unitExView5body2image(
//                                title: "見",
//                                textBody1: "・空き台のデータ確認にご利用下さい",
//                                textBody2: "・データ確認：ぶどう・ベル逆算値はこちらで確認。そのまま打ち始めデータとして登録も可能です",
//                                textBody3: "・島データ確認：複数台の合算値はこちらで確認",
//                            )
//                        }
//                    }
                }
//                .popoverTip(tipUnitJugHanaCommonKenView())
                // //// 実戦
                Section {
                    // データ入力
                    NavigationLink(destination: funky2Ver2ViewJissenStartData(funky2: funky2)) {
                        unitLabelMenu(
                            imageSystemName: "airplane.departure",
                            textBody: "打ち始めデータ"
                        )
                    }
                    // 実戦カウント
                    NavigationLink(destination: funky2Ver2ViewJissenCount(
                        funky2: funky2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "arcade.stick.and.arrow.down",
                            textBody: "実戦カウント"
                        )
                    }
                    // トータル結果確認
                    NavigationLink(destination: funky2Ver2ViewJissenTotalDataCheck(
                        funky2: funky2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "airplane.arrival",
                            textBody: "総合結果確認"
                        )
                    }
                } header: {
                    Text("実戦")
                        .fontWeight(.bold)
                        .font(.headline)
                }
                // 設定推測グラフ
                NavigationLink(destination: funky2Ver2View95CiTotal(funky2: funky2)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 設定期待値計算
                NavigationLink(destination: funky2ViewBayes(
                    funky2: funky2,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
//                        badgeStatus: ver391.funky2MenuBayesBadge,
                    )
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/3961")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎ KITA DENSHI")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.funky2MachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ファンキージャグラー2",
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(funky2SubViewLoadMemory(
                        funky2: funky2,
                        funky2Memory1: funky2Memory1,
                        funky2Memory2: funky2Memory2,
                        funky2Memory3: funky2Memory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(funky2SubViewSaveMemory(
                        funky2: funky2,
                        funky2Memory1: funky2Memory1,
                        funky2Memory2: funky2Memory2,
                        funky2Memory3: funky2Memory3
                    )))
                }
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: funky2.resetAll, message: "この機種のデータを全てリセットします")
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct funky2SubViewSaveMemory: View {
    @ObservedObject var funky2: Funky2
    @ObservedObject var funky2Memory1: Funky2Memory1
    @ObservedObject var funky2Memory2: Funky2Memory2
    @ObservedObject var funky2Memory3: Funky2Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "ファンキージャグラー2",
            selectedMemory: $funky2.selectedMemory,
            memoMemory1: $funky2Memory1.memo,
            dateDoubleMemory1: $funky2Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $funky2Memory2.memo,
            dateDoubleMemory2: $funky2Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $funky2Memory3.memo,
            dateDoubleMemory3: $funky2Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        funky2Memory1.kenBackCalculationEnable = funky2.kenBackCalculationEnable
        funky2Memory1.kenGameIput = funky2.kenGameIput
        funky2Memory1.kenBigCountInput = funky2.kenBigCountInput
        funky2Memory1.kenRegCountInput = funky2.kenRegCountInput
        funky2Memory1.kenCoinDifferenceInput = funky2.kenCoinDifferenceInput
        funky2Memory1.kenBonusCountSum = funky2.kenBonusCountSum
        funky2Memory1.kenBellBackCalculationCount = funky2.kenBellBackCalculationCount
        funky2Memory1.startBackCalculationEnable = funky2.startBackCalculationEnable
        funky2Memory1.startGameInput = funky2.startGameInput
        funky2Memory1.startBigCountInput = funky2.startBigCountInput
        funky2Memory1.startRegCountInput = funky2.startRegCountInput
        funky2Memory1.startCoinDifferenceInput = funky2.startCoinDifferenceInput
        funky2Memory1.startBonusCountSum = funky2.startBonusCountSum
        funky2Memory1.startBellBackCalculationCount = funky2.startBellBackCalculationCount
        funky2Memory1.personalBellCount = funky2.personalBellCount
        funky2Memory1.personalAloneBigCount = funky2.personalAloneBigCount
        funky2Memory1.personalCherryBigCount = funky2.personalCherryBigCount
        funky2Memory1.personalBigCountSum = funky2.personalBigCountSum
        funky2Memory1.personalAloneRegCount = funky2.personalAloneRegCount
        funky2Memory1.personalCherryRegCount = funky2.personalCherryRegCount
        funky2Memory1.currentGames = funky2.currentGames
        funky2Memory1.personalRegCountSum = funky2.personalRegCountSum
        funky2Memory1.personalBonusCountSum = funky2.personalBonusCountSum
        funky2Memory1.playGame = funky2.playGame
        funky2Memory1.totalBigCount = funky2.totalBigCount
        funky2Memory1.totalRegCount = funky2.totalRegCount
        funky2Memory1.totalBellCount = funky2.totalBellCount
        funky2Memory1.totalBonusCountSum = funky2.totalBonusCountSum
    }
    func saveMemory2() {
        funky2Memory2.kenBackCalculationEnable = funky2.kenBackCalculationEnable
        funky2Memory2.kenGameIput = funky2.kenGameIput
        funky2Memory2.kenBigCountInput = funky2.kenBigCountInput
        funky2Memory2.kenRegCountInput = funky2.kenRegCountInput
        funky2Memory2.kenCoinDifferenceInput = funky2.kenCoinDifferenceInput
        funky2Memory2.kenBonusCountSum = funky2.kenBonusCountSum
        funky2Memory2.kenBellBackCalculationCount = funky2.kenBellBackCalculationCount
        funky2Memory2.startBackCalculationEnable = funky2.startBackCalculationEnable
        funky2Memory2.startGameInput = funky2.startGameInput
        funky2Memory2.startBigCountInput = funky2.startBigCountInput
        funky2Memory2.startRegCountInput = funky2.startRegCountInput
        funky2Memory2.startCoinDifferenceInput = funky2.startCoinDifferenceInput
        funky2Memory2.startBonusCountSum = funky2.startBonusCountSum
        funky2Memory2.startBellBackCalculationCount = funky2.startBellBackCalculationCount
        funky2Memory2.personalBellCount = funky2.personalBellCount
        funky2Memory2.personalAloneBigCount = funky2.personalAloneBigCount
        funky2Memory2.personalCherryBigCount = funky2.personalCherryBigCount
        funky2Memory2.personalBigCountSum = funky2.personalBigCountSum
        funky2Memory2.personalAloneRegCount = funky2.personalAloneRegCount
        funky2Memory2.personalCherryRegCount = funky2.personalCherryRegCount
        funky2Memory2.currentGames = funky2.currentGames
        funky2Memory2.personalRegCountSum = funky2.personalRegCountSum
        funky2Memory2.personalBonusCountSum = funky2.personalBonusCountSum
        funky2Memory2.playGame = funky2.playGame
        funky2Memory2.totalBigCount = funky2.totalBigCount
        funky2Memory2.totalRegCount = funky2.totalRegCount
        funky2Memory2.totalBellCount = funky2.totalBellCount
        funky2Memory2.totalBonusCountSum = funky2.totalBonusCountSum
    }
    func saveMemory3() {
        funky2Memory3.kenBackCalculationEnable = funky2.kenBackCalculationEnable
        funky2Memory3.kenGameIput = funky2.kenGameIput
        funky2Memory3.kenBigCountInput = funky2.kenBigCountInput
        funky2Memory3.kenRegCountInput = funky2.kenRegCountInput
        funky2Memory3.kenCoinDifferenceInput = funky2.kenCoinDifferenceInput
        funky2Memory3.kenBonusCountSum = funky2.kenBonusCountSum
        funky2Memory3.kenBellBackCalculationCount = funky2.kenBellBackCalculationCount
        funky2Memory3.startBackCalculationEnable = funky2.startBackCalculationEnable
        funky2Memory3.startGameInput = funky2.startGameInput
        funky2Memory3.startBigCountInput = funky2.startBigCountInput
        funky2Memory3.startRegCountInput = funky2.startRegCountInput
        funky2Memory3.startCoinDifferenceInput = funky2.startCoinDifferenceInput
        funky2Memory3.startBonusCountSum = funky2.startBonusCountSum
        funky2Memory3.startBellBackCalculationCount = funky2.startBellBackCalculationCount
        funky2Memory3.personalBellCount = funky2.personalBellCount
        funky2Memory3.personalAloneBigCount = funky2.personalAloneBigCount
        funky2Memory3.personalCherryBigCount = funky2.personalCherryBigCount
        funky2Memory3.personalBigCountSum = funky2.personalBigCountSum
        funky2Memory3.personalAloneRegCount = funky2.personalAloneRegCount
        funky2Memory3.personalCherryRegCount = funky2.personalCherryRegCount
        funky2Memory3.currentGames = funky2.currentGames
        funky2Memory3.personalRegCountSum = funky2.personalRegCountSum
        funky2Memory3.personalBonusCountSum = funky2.personalBonusCountSum
        funky2Memory3.playGame = funky2.playGame
        funky2Memory3.totalBigCount = funky2.totalBigCount
        funky2Memory3.totalRegCount = funky2.totalRegCount
        funky2Memory3.totalBellCount = funky2.totalBellCount
        funky2Memory3.totalBonusCountSum = funky2.totalBonusCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct funky2SubViewLoadMemory: View {
    @ObservedObject var funky2: Funky2
    @ObservedObject var funky2Memory1: Funky2Memory1
    @ObservedObject var funky2Memory2: Funky2Memory2
    @ObservedObject var funky2Memory3: Funky2Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "ファンキージャグラー2",
            selectedMemory: $funky2.selectedMemory,
            memoMemory1: funky2Memory1.memo,
            dateDoubleMemory1: funky2Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: funky2Memory2.memo,
            dateDoubleMemory2: funky2Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: funky2Memory3.memo,
            dateDoubleMemory3: funky2Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        funky2.kenBackCalculationEnable = funky2Memory1.kenBackCalculationEnable
        funky2.kenGameIput = funky2Memory1.kenGameIput
        funky2.kenBigCountInput = funky2Memory1.kenBigCountInput
        funky2.kenRegCountInput = funky2Memory1.kenRegCountInput
        funky2.kenCoinDifferenceInput = funky2Memory1.kenCoinDifferenceInput
        funky2.kenBonusCountSum = funky2Memory1.kenBonusCountSum
        funky2.kenBellBackCalculationCount = funky2Memory1.kenBellBackCalculationCount
        funky2.startBackCalculationEnable = funky2Memory1.startBackCalculationEnable
        funky2.startGameInput = funky2Memory1.startGameInput
        funky2.startBigCountInput = funky2Memory1.startBigCountInput
        funky2.startRegCountInput = funky2Memory1.startRegCountInput
        funky2.startCoinDifferenceInput = funky2Memory1.startCoinDifferenceInput
        funky2.startBonusCountSum = funky2Memory1.startBonusCountSum
        funky2.startBellBackCalculationCount = funky2Memory1.startBellBackCalculationCount
        funky2.personalBellCount = funky2Memory1.personalBellCount
        funky2.personalAloneBigCount = funky2Memory1.personalAloneBigCount
        funky2.personalCherryBigCount = funky2Memory1.personalCherryBigCount
        funky2.personalBigCountSum = funky2Memory1.personalBigCountSum
        funky2.personalAloneRegCount = funky2Memory1.personalAloneRegCount
        funky2.personalCherryRegCount = funky2Memory1.personalCherryRegCount
        funky2.currentGames = funky2Memory1.currentGames
        funky2.personalRegCountSum = funky2Memory1.personalRegCountSum
        funky2.personalBonusCountSum = funky2Memory1.personalBonusCountSum
        funky2.playGame = funky2Memory1.playGame
        funky2.totalBigCount = funky2Memory1.totalBigCount
        funky2.totalRegCount = funky2Memory1.totalRegCount
        funky2.totalBellCount = funky2Memory1.totalBellCount
        funky2.totalBonusCountSum = funky2Memory1.totalBonusCountSum
    }
    func loadMemory2() {
        funky2.kenBackCalculationEnable = funky2Memory2.kenBackCalculationEnable
        funky2.kenGameIput = funky2Memory2.kenGameIput
        funky2.kenBigCountInput = funky2Memory2.kenBigCountInput
        funky2.kenRegCountInput = funky2Memory2.kenRegCountInput
        funky2.kenCoinDifferenceInput = funky2Memory2.kenCoinDifferenceInput
        funky2.kenBonusCountSum = funky2Memory2.kenBonusCountSum
        funky2.kenBellBackCalculationCount = funky2Memory2.kenBellBackCalculationCount
        funky2.startBackCalculationEnable = funky2Memory2.startBackCalculationEnable
        funky2.startGameInput = funky2Memory2.startGameInput
        funky2.startBigCountInput = funky2Memory2.startBigCountInput
        funky2.startRegCountInput = funky2Memory2.startRegCountInput
        funky2.startCoinDifferenceInput = funky2Memory2.startCoinDifferenceInput
        funky2.startBonusCountSum = funky2Memory2.startBonusCountSum
        funky2.startBellBackCalculationCount = funky2Memory2.startBellBackCalculationCount
        funky2.personalBellCount = funky2Memory2.personalBellCount
        funky2.personalAloneBigCount = funky2Memory2.personalAloneBigCount
        funky2.personalCherryBigCount = funky2Memory2.personalCherryBigCount
        funky2.personalBigCountSum = funky2Memory2.personalBigCountSum
        funky2.personalAloneRegCount = funky2Memory2.personalAloneRegCount
        funky2.personalCherryRegCount = funky2Memory2.personalCherryRegCount
        funky2.currentGames = funky2Memory2.currentGames
        funky2.personalRegCountSum = funky2Memory2.personalRegCountSum
        funky2.personalBonusCountSum = funky2Memory2.personalBonusCountSum
        funky2.playGame = funky2Memory2.playGame
        funky2.totalBigCount = funky2Memory2.totalBigCount
        funky2.totalRegCount = funky2Memory2.totalRegCount
        funky2.totalBellCount = funky2Memory2.totalBellCount
        funky2.totalBonusCountSum = funky2Memory2.totalBonusCountSum
    }
    func loadMemory3() {
        funky2.kenBackCalculationEnable = funky2Memory3.kenBackCalculationEnable
        funky2.kenGameIput = funky2Memory3.kenGameIput
        funky2.kenBigCountInput = funky2Memory3.kenBigCountInput
        funky2.kenRegCountInput = funky2Memory3.kenRegCountInput
        funky2.kenCoinDifferenceInput = funky2Memory3.kenCoinDifferenceInput
        funky2.kenBonusCountSum = funky2Memory3.kenBonusCountSum
        funky2.kenBellBackCalculationCount = funky2Memory3.kenBellBackCalculationCount
        funky2.startBackCalculationEnable = funky2Memory3.startBackCalculationEnable
        funky2.startGameInput = funky2Memory3.startGameInput
        funky2.startBigCountInput = funky2Memory3.startBigCountInput
        funky2.startRegCountInput = funky2Memory3.startRegCountInput
        funky2.startCoinDifferenceInput = funky2Memory3.startCoinDifferenceInput
        funky2.startBonusCountSum = funky2Memory3.startBonusCountSum
        funky2.startBellBackCalculationCount = funky2Memory3.startBellBackCalculationCount
        funky2.personalBellCount = funky2Memory3.personalBellCount
        funky2.personalAloneBigCount = funky2Memory3.personalAloneBigCount
        funky2.personalCherryBigCount = funky2Memory3.personalCherryBigCount
        funky2.personalBigCountSum = funky2Memory3.personalBigCountSum
        funky2.personalAloneRegCount = funky2Memory3.personalAloneRegCount
        funky2.personalCherryRegCount = funky2Memory3.personalCherryRegCount
        funky2.currentGames = funky2Memory3.currentGames
        funky2.personalRegCountSum = funky2Memory3.personalRegCountSum
        funky2.personalBonusCountSum = funky2Memory3.personalBonusCountSum
        funky2.playGame = funky2Memory3.playGame
        funky2.totalBigCount = funky2Memory3.totalBigCount
        funky2.totalRegCount = funky2Memory3.totalRegCount
        funky2.totalBellCount = funky2Memory3.totalBellCount
        funky2.totalBonusCountSum = funky2Memory3.totalBonusCountSum
    }
}

#Preview {
    funky2Ver2ViewTop(
//        ver391: Ver391(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
