//
//  newKingHanaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/16.
//

import SwiftUI

struct newKingHanaViewTop: View {
    @StateObject var newKingHana = NewKingHana()
    @State var isShowAlert: Bool = false
    @StateObject var newKingHanaMemory1 = NewKingHanaMemory1()
    @StateObject var newKingHanaMemory2 = NewKingHanaMemory2()
    @StateObject var newKingHanaMemory3 = NewKingHanaMemory3()
    @ObservedObject var bayes: Bayes
    @StateObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: newKingHana.machineName
                    )
                }
                
                // //// 見
                Section {
                    // データ入力
                    NavigationLink(destination: newKingHanaViewKenDataInput(
                        newKingHana: newKingHana
                    )) {
                        unitLabelMenu(
                            imageSystemName: "magnifyingglass",
                            textBody: "データ確認"
                        )
                    }
                    
                    // 島データ
                    NavigationLink(destination: newKingHanaViewShimaData(
                        newKingHana: newKingHana,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "waveform.path.ecg.magnifyingglass",
                            textBody: "島データ確認",
                            badgeStatus: common.newKingHanaMenuShimaBadge,
                        )
                    }
                } header: {
                    unitHeaderLabelKen()
                }
                
                // //// 実戦
                Section {
                    // データ入力
                    NavigationLink(destination: newKingHanaViewJissenStartData(
                        newKingHana: newKingHana
                    )) {
                        unitLabelMenu(
                            imageSystemName: "airplane.departure",
                            textBody: "打ち始めデータ"
                        )
                    }
                    // 実戦カウント
                    NavigationLink(destination: newKingHanaViewJissenCount(
                        newKingHana: newKingHana,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "arcade.stick.and.arrow.down",
                            textBody: "実戦カウント"
                        )
                    }
                    // トータル結果確認
                    NavigationLink(destination: newKingHanaViewJissenTotalDataCheck(
                        newKingHana: newKingHana,
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
                NavigationLink(destination: newKingHanaView95CiTotal(
                    newKingHana: newKingHana
                )) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 設定期待値計算
                NavigationLink(destination: newKingHanaViewBayes(
                    newKingHana: newKingHana,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                    )
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4912")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©PIONEER")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.newKingHanaMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: newKingHana.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(newKingHanaSubViewLoadMemory(
                    newKingHana: newKingHana,
                    newKingHanaMemory1: newKingHanaMemory1,
                    newKingHanaMemory2: newKingHanaMemory2,
                    newKingHanaMemory3: newKingHanaMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(newKingHanaSubViewSaveMemory(
                    newKingHana: newKingHana,
                    newKingHanaMemory1: newKingHanaMemory1,
                    newKingHanaMemory2: newKingHanaMemory2,
                    newKingHanaMemory3: newKingHanaMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: newKingHana.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct newKingHanaSubViewSaveMemory: View {
    @ObservedObject var newKingHana: NewKingHana
    @ObservedObject var newKingHanaMemory1: NewKingHanaMemory1
    @ObservedObject var newKingHanaMemory2: NewKingHanaMemory2
    @ObservedObject var newKingHanaMemory3: NewKingHanaMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: newKingHana.machineName,
            selectedMemory: $newKingHana.selectedMemory,
            memoMemory1: $newKingHanaMemory1.memo,
            dateDoubleMemory1: $newKingHanaMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $newKingHanaMemory2.memo,
            dateDoubleMemory2: $newKingHanaMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $newKingHanaMemory3.memo,
            dateDoubleMemory3: $newKingHanaMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        newKingHanaMemory1.kenBackCalculationEnable = newKingHana.kenBackCalculationEnable
        newKingHanaMemory1.kenGameIput = newKingHana.kenGameIput
        newKingHanaMemory1.kenBigCountInput = newKingHana.kenBigCountInput
        newKingHanaMemory1.kenRegCountInput = newKingHana.kenRegCountInput
        newKingHanaMemory1.kenCoinDifferenceInput = newKingHana.kenCoinDifferenceInput
        newKingHanaMemory1.kenBonusCountSum = newKingHana.kenBonusCountSum
        newKingHanaMemory1.kenBellBackCalculationCount = newKingHana.kenBellBackCalculationCount
        newKingHanaMemory1.startBackCalculationEnable = newKingHana.startBackCalculationEnable
        newKingHanaMemory1.startGameInput = newKingHana.startGameInput
        newKingHanaMemory1.startBigCountInput = newKingHana.startBigCountInput
        newKingHanaMemory1.startRegCountInput = newKingHana.startRegCountInput
        newKingHanaMemory1.startCoinDifferenceInput = newKingHana.startCoinDifferenceInput
        newKingHanaMemory1.startBonusCountSum = newKingHana.startBonusCountSum
        newKingHanaMemory1.startBellBackCalculationCount = newKingHana.startBellBackCalculationCount
        newKingHanaMemory1.bellCount = newKingHana.bellCount
        newKingHanaMemory1.bigCount = newKingHana.bigCount
        newKingHanaMemory1.regCount = newKingHana.regCount
        newKingHanaMemory1.currentGames = newKingHana.currentGames
        newKingHanaMemory1.bonusSum = newKingHana.bonusSum
        newKingHanaMemory1.playGames = newKingHana.playGames
        newKingHanaMemory1.bbSuikaCount = newKingHana.bbSuikaCount
        newKingHanaMemory1.bigPlayGames = newKingHana.bigPlayGames
        newKingHanaMemory1.sideLampCountBlue = newKingHana.sideLampCountBlue
        newKingHanaMemory1.sideLampCountYellow = newKingHana.sideLampCountYellow
        newKingHanaMemory1.sideLampCountGreen = newKingHana.sideLampCountGreen
        newKingHanaMemory1.sideLampCountRed = newKingHana.sideLampCountRed
        newKingHanaMemory1.sideLampCountSum = newKingHana.sideLampCountSum
        newKingHanaMemory1.sideLampCountKisu = newKingHana.sideLampCountKisu
        newKingHanaMemory1.sideLampCountGusu = newKingHana.sideLampCountGusu
        newKingHanaMemory1.bigTopLampCountBlue = newKingHana.bigTopLampCountBlue
        newKingHanaMemory1.bigTopLampCountYellow = newKingHana.bigTopLampCountYellow
        newKingHanaMemory1.bigTopLampCountGreen = newKingHana.bigTopLampCountGreen
        newKingHanaMemory1.bigTopLampCountPurple = newKingHana.bigTopLampCountPurple
        newKingHanaMemory1.bigTopLampCountSum = newKingHana.bigTopLampCountSum
        newKingHanaMemory1.regSuikaCount = newKingHana.regSuikaCount
        newKingHanaMemory1.regPlayGames = newKingHana.regPlayGames
        newKingHanaMemory1.totalBigCount = newKingHana.totalBigCount
        newKingHanaMemory1.totalRegCount = newKingHana.totalRegCount
        newKingHanaMemory1.totalBellCount = newKingHana.totalBellCount
        newKingHanaMemory1.totalBonusCountSum = newKingHana.totalBonusCountSum
        newKingHanaMemory1.shimaGames = newKingHana.shimaGames
        newKingHanaMemory1.shimaBigs = newKingHana.shimaBigs
        newKingHanaMemory1.shimaRegs = newKingHana.shimaRegs
        newKingHanaMemory1.shimaBonusSum = newKingHana.shimaBonusSum
    }
    func saveMemory2() {
        newKingHanaMemory2.kenBackCalculationEnable = newKingHana.kenBackCalculationEnable
        newKingHanaMemory2.kenGameIput = newKingHana.kenGameIput
        newKingHanaMemory2.kenBigCountInput = newKingHana.kenBigCountInput
        newKingHanaMemory2.kenRegCountInput = newKingHana.kenRegCountInput
        newKingHanaMemory2.kenCoinDifferenceInput = newKingHana.kenCoinDifferenceInput
        newKingHanaMemory2.kenBonusCountSum = newKingHana.kenBonusCountSum
        newKingHanaMemory2.kenBellBackCalculationCount = newKingHana.kenBellBackCalculationCount
        newKingHanaMemory2.startBackCalculationEnable = newKingHana.startBackCalculationEnable
        newKingHanaMemory2.startGameInput = newKingHana.startGameInput
        newKingHanaMemory2.startBigCountInput = newKingHana.startBigCountInput
        newKingHanaMemory2.startRegCountInput = newKingHana.startRegCountInput
        newKingHanaMemory2.startCoinDifferenceInput = newKingHana.startCoinDifferenceInput
        newKingHanaMemory2.startBonusCountSum = newKingHana.startBonusCountSum
        newKingHanaMemory2.startBellBackCalculationCount = newKingHana.startBellBackCalculationCount
        newKingHanaMemory2.bellCount = newKingHana.bellCount
        newKingHanaMemory2.bigCount = newKingHana.bigCount
        newKingHanaMemory2.regCount = newKingHana.regCount
        newKingHanaMemory2.currentGames = newKingHana.currentGames
        newKingHanaMemory2.bonusSum = newKingHana.bonusSum
        newKingHanaMemory2.playGames = newKingHana.playGames
        newKingHanaMemory2.bbSuikaCount = newKingHana.bbSuikaCount
        newKingHanaMemory2.bigPlayGames = newKingHana.bigPlayGames
        newKingHanaMemory2.sideLampCountBlue = newKingHana.sideLampCountBlue
        newKingHanaMemory2.sideLampCountYellow = newKingHana.sideLampCountYellow
        newKingHanaMemory2.sideLampCountGreen = newKingHana.sideLampCountGreen
        newKingHanaMemory2.sideLampCountRed = newKingHana.sideLampCountRed
        newKingHanaMemory2.sideLampCountSum = newKingHana.sideLampCountSum
        newKingHanaMemory2.sideLampCountKisu = newKingHana.sideLampCountKisu
        newKingHanaMemory2.sideLampCountGusu = newKingHana.sideLampCountGusu
        newKingHanaMemory2.bigTopLampCountBlue = newKingHana.bigTopLampCountBlue
        newKingHanaMemory2.bigTopLampCountYellow = newKingHana.bigTopLampCountYellow
        newKingHanaMemory2.bigTopLampCountGreen = newKingHana.bigTopLampCountGreen
        newKingHanaMemory2.bigTopLampCountPurple = newKingHana.bigTopLampCountPurple
        newKingHanaMemory2.bigTopLampCountSum = newKingHana.bigTopLampCountSum
        newKingHanaMemory2.regSuikaCount = newKingHana.regSuikaCount
        newKingHanaMemory2.regPlayGames = newKingHana.regPlayGames
        newKingHanaMemory2.totalBigCount = newKingHana.totalBigCount
        newKingHanaMemory2.totalRegCount = newKingHana.totalRegCount
        newKingHanaMemory2.totalBellCount = newKingHana.totalBellCount
        newKingHanaMemory2.totalBonusCountSum = newKingHana.totalBonusCountSum
        newKingHanaMemory2.shimaGames = newKingHana.shimaGames
        newKingHanaMemory2.shimaBigs = newKingHana.shimaBigs
        newKingHanaMemory2.shimaRegs = newKingHana.shimaRegs
        newKingHanaMemory2.shimaBonusSum = newKingHana.shimaBonusSum
    }
    func saveMemory3() {
        newKingHanaMemory3.kenBackCalculationEnable = newKingHana.kenBackCalculationEnable
        newKingHanaMemory3.kenGameIput = newKingHana.kenGameIput
        newKingHanaMemory3.kenBigCountInput = newKingHana.kenBigCountInput
        newKingHanaMemory3.kenRegCountInput = newKingHana.kenRegCountInput
        newKingHanaMemory3.kenCoinDifferenceInput = newKingHana.kenCoinDifferenceInput
        newKingHanaMemory3.kenBonusCountSum = newKingHana.kenBonusCountSum
        newKingHanaMemory3.kenBellBackCalculationCount = newKingHana.kenBellBackCalculationCount
        newKingHanaMemory3.startBackCalculationEnable = newKingHana.startBackCalculationEnable
        newKingHanaMemory3.startGameInput = newKingHana.startGameInput
        newKingHanaMemory3.startBigCountInput = newKingHana.startBigCountInput
        newKingHanaMemory3.startRegCountInput = newKingHana.startRegCountInput
        newKingHanaMemory3.startCoinDifferenceInput = newKingHana.startCoinDifferenceInput
        newKingHanaMemory3.startBonusCountSum = newKingHana.startBonusCountSum
        newKingHanaMemory3.startBellBackCalculationCount = newKingHana.startBellBackCalculationCount
        newKingHanaMemory3.bellCount = newKingHana.bellCount
        newKingHanaMemory3.bigCount = newKingHana.bigCount
        newKingHanaMemory3.regCount = newKingHana.regCount
        newKingHanaMemory3.currentGames = newKingHana.currentGames
        newKingHanaMemory3.bonusSum = newKingHana.bonusSum
        newKingHanaMemory3.playGames = newKingHana.playGames
        newKingHanaMemory3.bbSuikaCount = newKingHana.bbSuikaCount
        newKingHanaMemory3.bigPlayGames = newKingHana.bigPlayGames
        newKingHanaMemory3.sideLampCountBlue = newKingHana.sideLampCountBlue
        newKingHanaMemory3.sideLampCountYellow = newKingHana.sideLampCountYellow
        newKingHanaMemory3.sideLampCountGreen = newKingHana.sideLampCountGreen
        newKingHanaMemory3.sideLampCountRed = newKingHana.sideLampCountRed
        newKingHanaMemory3.sideLampCountSum = newKingHana.sideLampCountSum
        newKingHanaMemory3.sideLampCountKisu = newKingHana.sideLampCountKisu
        newKingHanaMemory3.sideLampCountGusu = newKingHana.sideLampCountGusu
        newKingHanaMemory3.bigTopLampCountBlue = newKingHana.bigTopLampCountBlue
        newKingHanaMemory3.bigTopLampCountYellow = newKingHana.bigTopLampCountYellow
        newKingHanaMemory3.bigTopLampCountGreen = newKingHana.bigTopLampCountGreen
        newKingHanaMemory3.bigTopLampCountPurple = newKingHana.bigTopLampCountPurple
        newKingHanaMemory3.bigTopLampCountSum = newKingHana.bigTopLampCountSum
        newKingHanaMemory3.regSuikaCount = newKingHana.regSuikaCount
        newKingHanaMemory3.regPlayGames = newKingHana.regPlayGames
        newKingHanaMemory3.totalBigCount = newKingHana.totalBigCount
        newKingHanaMemory3.totalRegCount = newKingHana.totalRegCount
        newKingHanaMemory3.totalBellCount = newKingHana.totalBellCount
        newKingHanaMemory3.totalBonusCountSum = newKingHana.totalBonusCountSum
        newKingHanaMemory3.shimaGames = newKingHana.shimaGames
        newKingHanaMemory3.shimaBigs = newKingHana.shimaBigs
        newKingHanaMemory3.shimaRegs = newKingHana.shimaRegs
        newKingHanaMemory3.shimaBonusSum = newKingHana.shimaBonusSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct newKingHanaSubViewLoadMemory: View {
    @ObservedObject var newKingHana: NewKingHana
    @ObservedObject var newKingHanaMemory1: NewKingHanaMemory1
    @ObservedObject var newKingHanaMemory2: NewKingHanaMemory2
    @ObservedObject var newKingHanaMemory3: NewKingHanaMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: newKingHana.machineName,
            selectedMemory: $newKingHana.selectedMemory,
            memoMemory1: newKingHanaMemory1.memo,
            dateDoubleMemory1: newKingHanaMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: newKingHanaMemory2.memo,
            dateDoubleMemory2: newKingHanaMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: newKingHanaMemory3.memo,
            dateDoubleMemory3: newKingHanaMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        newKingHana.kenBackCalculationEnable = newKingHanaMemory1.kenBackCalculationEnable
        newKingHana.kenGameIput = newKingHanaMemory1.kenGameIput
        newKingHana.kenBigCountInput = newKingHanaMemory1.kenBigCountInput
        newKingHana.kenRegCountInput = newKingHanaMemory1.kenRegCountInput
        newKingHana.kenCoinDifferenceInput = newKingHanaMemory1.kenCoinDifferenceInput
        newKingHana.kenBonusCountSum = newKingHanaMemory1.kenBonusCountSum
        newKingHana.kenBellBackCalculationCount = newKingHanaMemory1.kenBellBackCalculationCount
        newKingHana.startBackCalculationEnable = newKingHanaMemory1.startBackCalculationEnable
        newKingHana.startGameInput = newKingHanaMemory1.startGameInput
        newKingHana.startBigCountInput = newKingHanaMemory1.startBigCountInput
        newKingHana.startRegCountInput = newKingHanaMemory1.startRegCountInput
        newKingHana.startCoinDifferenceInput = newKingHanaMemory1.startCoinDifferenceInput
        newKingHana.startBonusCountSum = newKingHanaMemory1.startBonusCountSum
        newKingHana.startBellBackCalculationCount = newKingHanaMemory1.startBellBackCalculationCount
        newKingHana.bellCount = newKingHanaMemory1.bellCount
        newKingHana.bigCount = newKingHanaMemory1.bigCount
        newKingHana.regCount = newKingHanaMemory1.regCount
        newKingHana.currentGames = newKingHanaMemory1.currentGames
        newKingHana.bonusSum = newKingHanaMemory1.bonusSum
        newKingHana.playGames = newKingHanaMemory1.playGames
        newKingHana.bbSuikaCount = newKingHanaMemory1.bbSuikaCount
        newKingHana.bigPlayGames = newKingHanaMemory1.bigPlayGames
        newKingHana.sideLampCountBlue = newKingHanaMemory1.sideLampCountBlue
        newKingHana.sideLampCountYellow = newKingHanaMemory1.sideLampCountYellow
        newKingHana.sideLampCountGreen = newKingHanaMemory1.sideLampCountGreen
        newKingHana.sideLampCountRed = newKingHanaMemory1.sideLampCountRed
        newKingHana.sideLampCountSum = newKingHanaMemory1.sideLampCountSum
        newKingHana.sideLampCountKisu = newKingHanaMemory1.sideLampCountKisu
        newKingHana.sideLampCountGusu = newKingHanaMemory1.sideLampCountGusu
        newKingHana.bigTopLampCountBlue = newKingHanaMemory1.bigTopLampCountBlue
        newKingHana.bigTopLampCountYellow = newKingHanaMemory1.bigTopLampCountYellow
        newKingHana.bigTopLampCountGreen = newKingHanaMemory1.bigTopLampCountGreen
        newKingHana.bigTopLampCountPurple = newKingHanaMemory1.bigTopLampCountPurple
        newKingHana.bigTopLampCountSum = newKingHanaMemory1.bigTopLampCountSum
        newKingHana.regSuikaCount = newKingHanaMemory1.regSuikaCount
        newKingHana.regPlayGames = newKingHanaMemory1.regPlayGames
        newKingHana.totalBigCount = newKingHanaMemory1.totalBigCount
        newKingHana.totalRegCount = newKingHanaMemory1.totalRegCount
        newKingHana.totalBellCount = newKingHanaMemory1.totalBellCount
        newKingHana.totalBonusCountSum = newKingHanaMemory1.totalBonusCountSum
        newKingHana.shimaGames = newKingHanaMemory1.shimaGames
        newKingHana.shimaBigs = newKingHanaMemory1.shimaBigs
        newKingHana.shimaRegs = newKingHanaMemory1.shimaRegs
        newKingHana.shimaBonusSum = newKingHanaMemory1.shimaBonusSum
    }
    func loadMemory2() {
        newKingHana.kenBackCalculationEnable = newKingHanaMemory2.kenBackCalculationEnable
        newKingHana.kenGameIput = newKingHanaMemory2.kenGameIput
        newKingHana.kenBigCountInput = newKingHanaMemory2.kenBigCountInput
        newKingHana.kenRegCountInput = newKingHanaMemory2.kenRegCountInput
        newKingHana.kenCoinDifferenceInput = newKingHanaMemory2.kenCoinDifferenceInput
        newKingHana.kenBonusCountSum = newKingHanaMemory2.kenBonusCountSum
        newKingHana.kenBellBackCalculationCount = newKingHanaMemory2.kenBellBackCalculationCount
        newKingHana.startBackCalculationEnable = newKingHanaMemory2.startBackCalculationEnable
        newKingHana.startGameInput = newKingHanaMemory2.startGameInput
        newKingHana.startBigCountInput = newKingHanaMemory2.startBigCountInput
        newKingHana.startRegCountInput = newKingHanaMemory2.startRegCountInput
        newKingHana.startCoinDifferenceInput = newKingHanaMemory2.startCoinDifferenceInput
        newKingHana.startBonusCountSum = newKingHanaMemory2.startBonusCountSum
        newKingHana.startBellBackCalculationCount = newKingHanaMemory2.startBellBackCalculationCount
        newKingHana.bellCount = newKingHanaMemory2.bellCount
        newKingHana.bigCount = newKingHanaMemory2.bigCount
        newKingHana.regCount = newKingHanaMemory2.regCount
        newKingHana.currentGames = newKingHanaMemory2.currentGames
        newKingHana.bonusSum = newKingHanaMemory2.bonusSum
        newKingHana.playGames = newKingHanaMemory2.playGames
        newKingHana.bbSuikaCount = newKingHanaMemory2.bbSuikaCount
        newKingHana.bigPlayGames = newKingHanaMemory2.bigPlayGames
        newKingHana.sideLampCountBlue = newKingHanaMemory2.sideLampCountBlue
        newKingHana.sideLampCountYellow = newKingHanaMemory2.sideLampCountYellow
        newKingHana.sideLampCountGreen = newKingHanaMemory2.sideLampCountGreen
        newKingHana.sideLampCountRed = newKingHanaMemory2.sideLampCountRed
        newKingHana.sideLampCountSum = newKingHanaMemory2.sideLampCountSum
        newKingHana.sideLampCountKisu = newKingHanaMemory2.sideLampCountKisu
        newKingHana.sideLampCountGusu = newKingHanaMemory2.sideLampCountGusu
        newKingHana.bigTopLampCountBlue = newKingHanaMemory2.bigTopLampCountBlue
        newKingHana.bigTopLampCountYellow = newKingHanaMemory2.bigTopLampCountYellow
        newKingHana.bigTopLampCountGreen = newKingHanaMemory2.bigTopLampCountGreen
        newKingHana.bigTopLampCountPurple = newKingHanaMemory2.bigTopLampCountPurple
        newKingHana.bigTopLampCountSum = newKingHanaMemory2.bigTopLampCountSum
        newKingHana.regSuikaCount = newKingHanaMemory2.regSuikaCount
        newKingHana.regPlayGames = newKingHanaMemory2.regPlayGames
        newKingHana.totalBigCount = newKingHanaMemory2.totalBigCount
        newKingHana.totalRegCount = newKingHanaMemory2.totalRegCount
        newKingHana.totalBellCount = newKingHanaMemory2.totalBellCount
        newKingHana.totalBonusCountSum = newKingHanaMemory2.totalBonusCountSum
        newKingHana.shimaGames = newKingHanaMemory2.shimaGames
        newKingHana.shimaBigs = newKingHanaMemory2.shimaBigs
        newKingHana.shimaRegs = newKingHanaMemory2.shimaRegs
        newKingHana.shimaBonusSum = newKingHanaMemory2.shimaBonusSum
    }
    func loadMemory3() {
        newKingHana.kenBackCalculationEnable = newKingHanaMemory3.kenBackCalculationEnable
        newKingHana.kenGameIput = newKingHanaMemory3.kenGameIput
        newKingHana.kenBigCountInput = newKingHanaMemory3.kenBigCountInput
        newKingHana.kenRegCountInput = newKingHanaMemory3.kenRegCountInput
        newKingHana.kenCoinDifferenceInput = newKingHanaMemory3.kenCoinDifferenceInput
        newKingHana.kenBonusCountSum = newKingHanaMemory3.kenBonusCountSum
        newKingHana.kenBellBackCalculationCount = newKingHanaMemory3.kenBellBackCalculationCount
        newKingHana.startBackCalculationEnable = newKingHanaMemory3.startBackCalculationEnable
        newKingHana.startGameInput = newKingHanaMemory3.startGameInput
        newKingHana.startBigCountInput = newKingHanaMemory3.startBigCountInput
        newKingHana.startRegCountInput = newKingHanaMemory3.startRegCountInput
        newKingHana.startCoinDifferenceInput = newKingHanaMemory3.startCoinDifferenceInput
        newKingHana.startBonusCountSum = newKingHanaMemory3.startBonusCountSum
        newKingHana.startBellBackCalculationCount = newKingHanaMemory3.startBellBackCalculationCount
        newKingHana.bellCount = newKingHanaMemory3.bellCount
        newKingHana.bigCount = newKingHanaMemory3.bigCount
        newKingHana.regCount = newKingHanaMemory3.regCount
        newKingHana.currentGames = newKingHanaMemory3.currentGames
        newKingHana.bonusSum = newKingHanaMemory3.bonusSum
        newKingHana.playGames = newKingHanaMemory3.playGames
        newKingHana.bbSuikaCount = newKingHanaMemory3.bbSuikaCount
        newKingHana.bigPlayGames = newKingHanaMemory3.bigPlayGames
        newKingHana.sideLampCountBlue = newKingHanaMemory3.sideLampCountBlue
        newKingHana.sideLampCountYellow = newKingHanaMemory3.sideLampCountYellow
        newKingHana.sideLampCountGreen = newKingHanaMemory3.sideLampCountGreen
        newKingHana.sideLampCountRed = newKingHanaMemory3.sideLampCountRed
        newKingHana.sideLampCountSum = newKingHanaMemory3.sideLampCountSum
        newKingHana.sideLampCountKisu = newKingHanaMemory3.sideLampCountKisu
        newKingHana.sideLampCountGusu = newKingHanaMemory3.sideLampCountGusu
        newKingHana.bigTopLampCountBlue = newKingHanaMemory3.bigTopLampCountBlue
        newKingHana.bigTopLampCountYellow = newKingHanaMemory3.bigTopLampCountYellow
        newKingHana.bigTopLampCountGreen = newKingHanaMemory3.bigTopLampCountGreen
        newKingHana.bigTopLampCountPurple = newKingHanaMemory3.bigTopLampCountPurple
        newKingHana.bigTopLampCountSum = newKingHanaMemory3.bigTopLampCountSum
        newKingHana.regSuikaCount = newKingHanaMemory3.regSuikaCount
        newKingHana.regPlayGames = newKingHanaMemory3.regPlayGames
        newKingHana.totalBigCount = newKingHanaMemory3.totalBigCount
        newKingHana.totalRegCount = newKingHanaMemory3.totalRegCount
        newKingHana.totalBellCount = newKingHanaMemory3.totalBellCount
        newKingHana.totalBonusCountSum = newKingHanaMemory3.totalBonusCountSum
        newKingHana.shimaGames = newKingHanaMemory3.shimaGames
        newKingHana.shimaBigs = newKingHanaMemory3.shimaBigs
        newKingHana.shimaRegs = newKingHanaMemory3.shimaRegs
        newKingHana.shimaBonusSum = newKingHanaMemory3.shimaBonusSum
    }
}

#Preview {
    newKingHanaViewTop(
        newKingHana: NewKingHana(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel()
    )
    .environmentObject(commonVar())
}
