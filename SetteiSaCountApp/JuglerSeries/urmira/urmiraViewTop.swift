//
//  urmiraViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/01.
//

import SwiftUI

struct urmiraViewTop: View {
    @EnvironmentObject var common: commonVar
    @StateObject var urmira = Urmira()
    @State var isShowAlert: Bool = false
    @StateObject var urmiraMemory1 = UrmiraMemory1()
    @StateObject var urmiraMemory2 = UrmiraMemory2()
    @StateObject var urmiraMemory3 = UrmiraMemory3()
    @ObservedObject var bayes: Bayes
    @StateObject var viewModel: InterstitialViewModel
    var body: some View {
        NavigationStack {
            List {
                Section {
                    
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: urmira.machineName,
                        titleFont: .title2,
                    )
                }
                
                // //// 見
                Section {
                    // データ入力
                    NavigationLink(destination: urmiraVer2ViewKenDataInput(urmira: urmira)) {
                        unitLabelMenu(
                            imageSystemName: "magnifyingglass",
                            textBody: "データ確認"
                        )
                    }
                    
                    // 島データ
                    NavigationLink(destination: urmiraViewShimaData(
                        urmira: urmira,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "waveform.path.ecg.magnifyingglass",
                            textBody: "島データ確認",
                            badgeStatus: common.urmiraMenuShimaBadge,
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
                    NavigationLink(destination: urmiraVer2ViewJissenStartData(urmira: urmira)) {
                        unitLabelMenu(
                            imageSystemName: "airplane.departure",
                            textBody: "打ち始めデータ"
                        )
                    }
                    // 実戦カウント
                    NavigationLink(destination: urmiraViewJissenCount(
                        urmira: urmira,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "arcade.stick.and.arrow.down",
                            textBody: "実戦カウント"
                        )
                    }
                    // トータル結果確認
                    NavigationLink(destination: urmiraViewJissenTotalDataCheck(
                        urmira: urmira,
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
                NavigationLink(destination: urmiraView95CiTotal(urmira: urmira)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 設定期待値計算
                NavigationLink(destination: urmiraViewBayes(
                    urmira: urmira,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                    )
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4683")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎ KITA DENSHI")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.urmiraMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: urmira.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(urmiraSubViewLoadMemory(
                        urmira: urmira,
                        urmiraMemory1: urmiraMemory1,
                        urmiraMemory2: urmiraMemory2,
                        urmiraMemory3: urmiraMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(urmiraSubViewSaveMemory(
                        urmira: urmira,
                        urmiraMemory1: urmiraMemory1,
                        urmiraMemory2: urmiraMemory2,
                        urmiraMemory3: urmiraMemory3
                    )))
                }
//                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: urmira.resetAll, message: "この機種のデータを全てリセットします")
//                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct urmiraSubViewSaveMemory: View {
    @ObservedObject var urmira: Urmira
    @ObservedObject var urmiraMemory1: UrmiraMemory1
    @ObservedObject var urmiraMemory2: UrmiraMemory2
    @ObservedObject var urmiraMemory3: UrmiraMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: urmira.machineName,
            selectedMemory: $urmira.selectedMemory,
            memoMemory1: $urmiraMemory1.memo,
            dateDoubleMemory1: $urmiraMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $urmiraMemory2.memo,
            dateDoubleMemory2: $urmiraMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $urmiraMemory3.memo,
            dateDoubleMemory3: $urmiraMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        urmiraMemory1.kenBackCalculationEnable = urmira.kenBackCalculationEnable
        urmiraMemory1.kenGameIput = urmira.kenGameIput
        urmiraMemory1.kenBigCountInput = urmira.kenBigCountInput
        urmiraMemory1.kenRegCountInput = urmira.kenRegCountInput
        urmiraMemory1.kenCoinDifferenceInput = urmira.kenCoinDifferenceInput
        urmiraMemory1.kenBonusCountSum = urmira.kenBonusCountSum
        urmiraMemory1.kenBellBackCalculationCount = urmira.kenBellBackCalculationCount
        urmiraMemory1.startBackCalculationEnable = urmira.startBackCalculationEnable
        urmiraMemory1.startGameInput = urmira.startGameInput
        urmiraMemory1.startBigCountInput = urmira.startBigCountInput
        urmiraMemory1.startRegCountInput = urmira.startRegCountInput
        urmiraMemory1.startCoinDifferenceInput = urmira.startCoinDifferenceInput
        urmiraMemory1.startBonusCountSum = urmira.startBonusCountSum
        urmiraMemory1.startBellBackCalculationCount = urmira.startBellBackCalculationCount
        urmiraMemory1.personalBellCount = urmira.personalBellCount
        urmiraMemory1.personalAloneBigCount = urmira.personalAloneBigCount
        urmiraMemory1.personalCherryBigCount = urmira.personalCherryBigCount
        urmiraMemory1.personalBigCountSum = urmira.personalBigCountSum
        urmiraMemory1.personalAloneRegCount = urmira.personalAloneRegCount
        urmiraMemory1.personalCherryRegCount = urmira.personalCherryRegCount
        urmiraMemory1.currentGames = urmira.currentGames
        urmiraMemory1.personalRegCountSum = urmira.personalRegCountSum
        urmiraMemory1.personalBonusCountSum = urmira.personalBonusCountSum
        urmiraMemory1.playGame = urmira.playGame
        urmiraMemory1.totalBigCount = urmira.totalBigCount
        urmiraMemory1.totalRegCount = urmira.totalRegCount
        urmiraMemory1.totalBellCount = urmira.totalBellCount
        urmiraMemory1.totalBonusCountSum = urmira.totalBonusCountSum
        urmiraMemory1.personalCherryCount = urmira.personalCherryCount
    }
    func saveMemory2() {
        urmiraMemory2.kenBackCalculationEnable = urmira.kenBackCalculationEnable
        urmiraMemory2.kenGameIput = urmira.kenGameIput
        urmiraMemory2.kenBigCountInput = urmira.kenBigCountInput
        urmiraMemory2.kenRegCountInput = urmira.kenRegCountInput
        urmiraMemory2.kenCoinDifferenceInput = urmira.kenCoinDifferenceInput
        urmiraMemory2.kenBonusCountSum = urmira.kenBonusCountSum
        urmiraMemory2.kenBellBackCalculationCount = urmira.kenBellBackCalculationCount
        urmiraMemory2.startBackCalculationEnable = urmira.startBackCalculationEnable
        urmiraMemory2.startGameInput = urmira.startGameInput
        urmiraMemory2.startBigCountInput = urmira.startBigCountInput
        urmiraMemory2.startRegCountInput = urmira.startRegCountInput
        urmiraMemory2.startCoinDifferenceInput = urmira.startCoinDifferenceInput
        urmiraMemory2.startBonusCountSum = urmira.startBonusCountSum
        urmiraMemory2.startBellBackCalculationCount = urmira.startBellBackCalculationCount
        urmiraMemory2.personalBellCount = urmira.personalBellCount
        urmiraMemory2.personalAloneBigCount = urmira.personalAloneBigCount
        urmiraMemory2.personalCherryBigCount = urmira.personalCherryBigCount
        urmiraMemory2.personalBigCountSum = urmira.personalBigCountSum
        urmiraMemory2.personalAloneRegCount = urmira.personalAloneRegCount
        urmiraMemory2.personalCherryRegCount = urmira.personalCherryRegCount
        urmiraMemory2.currentGames = urmira.currentGames
        urmiraMemory2.personalRegCountSum = urmira.personalRegCountSum
        urmiraMemory2.personalBonusCountSum = urmira.personalBonusCountSum
        urmiraMemory2.playGame = urmira.playGame
        urmiraMemory2.totalBigCount = urmira.totalBigCount
        urmiraMemory2.totalRegCount = urmira.totalRegCount
        urmiraMemory2.totalBellCount = urmira.totalBellCount
        urmiraMemory2.totalBonusCountSum = urmira.totalBonusCountSum
        urmiraMemory2.personalCherryCount = urmira.personalCherryCount
    }
    func saveMemory3() {
        urmiraMemory3.kenBackCalculationEnable = urmira.kenBackCalculationEnable
        urmiraMemory3.kenGameIput = urmira.kenGameIput
        urmiraMemory3.kenBigCountInput = urmira.kenBigCountInput
        urmiraMemory3.kenRegCountInput = urmira.kenRegCountInput
        urmiraMemory3.kenCoinDifferenceInput = urmira.kenCoinDifferenceInput
        urmiraMemory3.kenBonusCountSum = urmira.kenBonusCountSum
        urmiraMemory3.kenBellBackCalculationCount = urmira.kenBellBackCalculationCount
        urmiraMemory3.startBackCalculationEnable = urmira.startBackCalculationEnable
        urmiraMemory3.startGameInput = urmira.startGameInput
        urmiraMemory3.startBigCountInput = urmira.startBigCountInput
        urmiraMemory3.startRegCountInput = urmira.startRegCountInput
        urmiraMemory3.startCoinDifferenceInput = urmira.startCoinDifferenceInput
        urmiraMemory3.startBonusCountSum = urmira.startBonusCountSum
        urmiraMemory3.startBellBackCalculationCount = urmira.startBellBackCalculationCount
        urmiraMemory3.personalBellCount = urmira.personalBellCount
        urmiraMemory3.personalAloneBigCount = urmira.personalAloneBigCount
        urmiraMemory3.personalCherryBigCount = urmira.personalCherryBigCount
        urmiraMemory3.personalBigCountSum = urmira.personalBigCountSum
        urmiraMemory3.personalAloneRegCount = urmira.personalAloneRegCount
        urmiraMemory3.personalCherryRegCount = urmira.personalCherryRegCount
        urmiraMemory3.currentGames = urmira.currentGames
        urmiraMemory3.personalRegCountSum = urmira.personalRegCountSum
        urmiraMemory3.personalBonusCountSum = urmira.personalBonusCountSum
        urmiraMemory3.playGame = urmira.playGame
        urmiraMemory3.totalBigCount = urmira.totalBigCount
        urmiraMemory3.totalRegCount = urmira.totalRegCount
        urmiraMemory3.totalBellCount = urmira.totalBellCount
        urmiraMemory3.totalBonusCountSum = urmira.totalBonusCountSum
        urmiraMemory3.personalCherryCount = urmira.personalCherryCount
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct urmiraSubViewLoadMemory: View {
    @ObservedObject var urmira: Urmira
    @ObservedObject var urmiraMemory1: UrmiraMemory1
    @ObservedObject var urmiraMemory2: UrmiraMemory2
    @ObservedObject var urmiraMemory3: UrmiraMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: urmira.machineName,
            selectedMemory: $urmira.selectedMemory,
            memoMemory1: urmiraMemory1.memo,
            dateDoubleMemory1: urmiraMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: urmiraMemory2.memo,
            dateDoubleMemory2: urmiraMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: urmiraMemory3.memo,
            dateDoubleMemory3: urmiraMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        urmira.kenBackCalculationEnable = urmiraMemory1.kenBackCalculationEnable
        urmira.kenGameIput = urmiraMemory1.kenGameIput
        urmira.kenBigCountInput = urmiraMemory1.kenBigCountInput
        urmira.kenRegCountInput = urmiraMemory1.kenRegCountInput
        urmira.kenCoinDifferenceInput = urmiraMemory1.kenCoinDifferenceInput
        urmira.kenBonusCountSum = urmiraMemory1.kenBonusCountSum
        urmira.kenBellBackCalculationCount = urmiraMemory1.kenBellBackCalculationCount
        urmira.startBackCalculationEnable = urmiraMemory1.startBackCalculationEnable
        urmira.startGameInput = urmiraMemory1.startGameInput
        urmira.startBigCountInput = urmiraMemory1.startBigCountInput
        urmira.startRegCountInput = urmiraMemory1.startRegCountInput
        urmira.startCoinDifferenceInput = urmiraMemory1.startCoinDifferenceInput
        urmira.startBonusCountSum = urmiraMemory1.startBonusCountSum
        urmira.startBellBackCalculationCount = urmiraMemory1.startBellBackCalculationCount
        urmira.personalBellCount = urmiraMemory1.personalBellCount
        urmira.personalAloneBigCount = urmiraMemory1.personalAloneBigCount
        urmira.personalCherryBigCount = urmiraMemory1.personalCherryBigCount
        urmira.personalBigCountSum = urmiraMemory1.personalBigCountSum
        urmira.personalAloneRegCount = urmiraMemory1.personalAloneRegCount
        urmira.personalCherryRegCount = urmiraMemory1.personalCherryRegCount
        urmira.currentGames = urmiraMemory1.currentGames
        urmira.personalRegCountSum = urmiraMemory1.personalRegCountSum
        urmira.personalBonusCountSum = urmiraMemory1.personalBonusCountSum
        urmira.playGame = urmiraMemory1.playGame
        urmira.totalBigCount = urmiraMemory1.totalBigCount
        urmira.totalRegCount = urmiraMemory1.totalRegCount
        urmira.totalBellCount = urmiraMemory1.totalBellCount
        urmira.totalBonusCountSum = urmiraMemory1.totalBonusCountSum
        urmira.personalCherryCount = urmiraMemory1.personalCherryCount
    }
    func loadMemory2() {
        urmira.kenBackCalculationEnable = urmiraMemory2.kenBackCalculationEnable
        urmira.kenGameIput = urmiraMemory2.kenGameIput
        urmira.kenBigCountInput = urmiraMemory2.kenBigCountInput
        urmira.kenRegCountInput = urmiraMemory2.kenRegCountInput
        urmira.kenCoinDifferenceInput = urmiraMemory2.kenCoinDifferenceInput
        urmira.kenBonusCountSum = urmiraMemory2.kenBonusCountSum
        urmira.kenBellBackCalculationCount = urmiraMemory2.kenBellBackCalculationCount
        urmira.startBackCalculationEnable = urmiraMemory2.startBackCalculationEnable
        urmira.startGameInput = urmiraMemory2.startGameInput
        urmira.startBigCountInput = urmiraMemory2.startBigCountInput
        urmira.startRegCountInput = urmiraMemory2.startRegCountInput
        urmira.startCoinDifferenceInput = urmiraMemory2.startCoinDifferenceInput
        urmira.startBonusCountSum = urmiraMemory2.startBonusCountSum
        urmira.startBellBackCalculationCount = urmiraMemory2.startBellBackCalculationCount
        urmira.personalBellCount = urmiraMemory2.personalBellCount
        urmira.personalAloneBigCount = urmiraMemory2.personalAloneBigCount
        urmira.personalCherryBigCount = urmiraMemory2.personalCherryBigCount
        urmira.personalBigCountSum = urmiraMemory2.personalBigCountSum
        urmira.personalAloneRegCount = urmiraMemory2.personalAloneRegCount
        urmira.personalCherryRegCount = urmiraMemory2.personalCherryRegCount
        urmira.currentGames = urmiraMemory2.currentGames
        urmira.personalRegCountSum = urmiraMemory2.personalRegCountSum
        urmira.personalBonusCountSum = urmiraMemory2.personalBonusCountSum
        urmira.playGame = urmiraMemory2.playGame
        urmira.totalBigCount = urmiraMemory2.totalBigCount
        urmira.totalRegCount = urmiraMemory2.totalRegCount
        urmira.totalBellCount = urmiraMemory2.totalBellCount
        urmira.totalBonusCountSum = urmiraMemory2.totalBonusCountSum
        urmira.personalCherryCount = urmiraMemory2.personalCherryCount
    }
    func loadMemory3() {
        urmira.kenBackCalculationEnable = urmiraMemory3.kenBackCalculationEnable
        urmira.kenGameIput = urmiraMemory3.kenGameIput
        urmira.kenBigCountInput = urmiraMemory3.kenBigCountInput
        urmira.kenRegCountInput = urmiraMemory3.kenRegCountInput
        urmira.kenCoinDifferenceInput = urmiraMemory3.kenCoinDifferenceInput
        urmira.kenBonusCountSum = urmiraMemory3.kenBonusCountSum
        urmira.kenBellBackCalculationCount = urmiraMemory3.kenBellBackCalculationCount
        urmira.startBackCalculationEnable = urmiraMemory3.startBackCalculationEnable
        urmira.startGameInput = urmiraMemory3.startGameInput
        urmira.startBigCountInput = urmiraMemory3.startBigCountInput
        urmira.startRegCountInput = urmiraMemory3.startRegCountInput
        urmira.startCoinDifferenceInput = urmiraMemory3.startCoinDifferenceInput
        urmira.startBonusCountSum = urmiraMemory3.startBonusCountSum
        urmira.startBellBackCalculationCount = urmiraMemory3.startBellBackCalculationCount
        urmira.personalBellCount = urmiraMemory3.personalBellCount
        urmira.personalAloneBigCount = urmiraMemory3.personalAloneBigCount
        urmira.personalCherryBigCount = urmiraMemory3.personalCherryBigCount
        urmira.personalBigCountSum = urmiraMemory3.personalBigCountSum
        urmira.personalAloneRegCount = urmiraMemory3.personalAloneRegCount
        urmira.personalCherryRegCount = urmiraMemory3.personalCherryRegCount
        urmira.currentGames = urmiraMemory3.currentGames
        urmira.personalRegCountSum = urmiraMemory3.personalRegCountSum
        urmira.personalBonusCountSum = urmiraMemory3.personalBonusCountSum
        urmira.playGame = urmiraMemory3.playGame
        urmira.totalBigCount = urmiraMemory3.totalBigCount
        urmira.totalRegCount = urmiraMemory3.totalRegCount
        urmira.totalBellCount = urmiraMemory3.totalBellCount
        urmira.totalBonusCountSum = urmiraMemory3.totalBonusCountSum
        urmira.personalCherryCount = urmiraMemory3.personalCherryCount
    }
}

#Preview {
    urmiraViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
