//
//  goJug3Ver2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/23.
//

import SwiftUI
import FirebaseAnalytics


// ///////////////////////
// 変数
// ///////////////////////
class GoJug3: ObservableObject {
    // ////////////////////////
    // 確率値
    // ////////////////////////
    let denominateListBell: [Double] = [
        6.25,
        6.20,
        6.15,
        6.07,
        6.00,
        5.92
    ]
    
    let denominateListBigSum: [Double] = [
        259,
        258,
        257,
        254,
        247,
        235
    ]
    
    let denominateListRegSum: [Double] = [
        354,
        333,
        306,
        269,
        247,
        235
    ]
    
    let denominateListBonusSum: [Double] = [
        150,
        145,
        140,
        131,
        124,
        117
    ]
    // ////////////////////////
    // 見
    // ////////////////////////
    @AppStorage("goJug3KenBackCalculationEnable") var kenBackCalculationEnable: Bool = false {
        didSet {
            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
        }
    }
        @AppStorage("goJug3KenGameIput") var kenGameIput: Int = 0 {
            didSet {
                kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
            }
        }
            @AppStorage("goJug3KenBigCountInput") var kenBigCountInput: Int = 0 {
                didSet {
                    kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                    kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                }
            }
                @AppStorage("goJug3KenRegCountInput") var kenRegCountInput: Int = 0 {
                    didSet {
                        kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                    }
                }
                    @AppStorage("goJug3KenCoinDifferenceInput") var kenCoinDifferenceInput: Int = 0 {
                        didSet {
                            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        }
                    }
    @AppStorage("goJug3KenBonusCountSum") var kenBonusCountSum: Int = 0
    @AppStorage("goJug3KenBellBackCalculationCount") var kenBellBackCalculationCount: Int = 0
    
    func bellBackCalculate(game: Int, bigCount: Int, regCount: Int, coinDifference: Int) -> Int {
        // 各種確率の定義
        let replayDenominate = 7.298   // リプレイ確率
        let cherryDenominate: Double = 33.0   // チェリー確率
        let cherryGetRatio = 0.9   // チェリー奪取率
        let budonukiAverageGame = 1.31   // ぶどう抜き平均消化ゲーム数（1枚がけ）
        let budonukiAverageIn = 1.13   // ぶどう抜き平均IN枚数
        let budonukiAverageOut = 1.01   // ぶどう抜き平均OUT枚数
        let bigOut: Double = 240   // ビッグ獲得枚数
        let regOut: Double = 96   // REG獲得枚数
        let cherryOut: Double = 4   // チェリー払い出し枚数
        let bellOut: Double = 8   // ぶどう・ベル払い出し枚数
        
        // //// ゲーム数の内訳算出
        let budonukiGame = Double(bigCount + regCount) * budonukiAverageGame / 3
        let replayGame = (Double(game) - budonukiGame) / replayDenominate
        let normalGame = Double(game) - replayGame - budonukiGame
        
        // //// IN枚数の計算
        let budonukiIn = Double(bigCount + regCount) * budonukiAverageIn
        let normalGameIn = normalGame * 3
        let inTotal = budonukiIn + normalGameIn
        
        // //// OUT枚数の計算
        let budonukiOut = Double(bigCount + regCount) * budonukiAverageOut
        let bigOutTotal = Double(bigCount) * bigOut
        let regOutTotal = Double(regCount) * regOut
        let cherryOutTotal = (Double(game) - budonukiGame) / cherryDenominate * cherryOut * cherryGetRatio
        let outTotalWithoutBell = budonukiOut + bigOutTotal + regOutTotal + cherryOutTotal
        
        // //// ぶどう抜き逆算値の算出
        let bellOutTotal = Double(coinDifference) - outTotalWithoutBell + inTotal
        let bellBackCalculateCount = Int(bellOutTotal / bellOut)
        
        return bellBackCalculateCount
    }
    
    func kenToStartRecord() {
        resetStartData()
        resetCountData()
        startBackCalculationEnable = kenBackCalculationEnable
        startGameInput = kenGameIput
        startBigCountInput = kenBigCountInput
        startRegCountInput = kenRegCountInput
        startCoinDifferenceInput = kenCoinDifferenceInput
        currentGames = kenGameIput
    }
    
    func resetKenDataInput() {
        kenGameIput = 0
        kenBigCountInput = 0
        kenRegCountInput = 0
        kenCoinDifferenceInput = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 実戦 打ち始めデータ
    // ////////////////////////
    @AppStorage("goJug3StartBackCalculationEnable") var startBackCalculationEnable: Bool = false {
        didSet {
            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
        }
    }
        @AppStorage("goJug3StartGame") var startGameInput: Int = 0 {
            didSet {
                startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                playGame = currentGames - startGameInput
            }
        }
            @AppStorage("goJug3StartBigCountInput") var startBigCountInput: Int = 0 {
                didSet {
                    startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                    startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                    totalBigCount = countSum(startBigCountInput, personalBigCount)
                }
            }
                @AppStorage("goJug3StartRegCountInput") var startRegCountInput: Int = 0 {
                    didSet {
                        startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                        totalRegCount = countSum(startRegCountInput, personalRegCountSum)
                    }
                }
                    @AppStorage("goJug3StartCoinDifferenceInput") var startCoinDifferenceInput: Int = 0 {
                        didSet {
                            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        }
                    }
    @AppStorage("goJug3StartBonusCountSum") var startBonusCountSum: Int = 0
    @AppStorage("goJug3StartBellBackCalculationCount") var startBellBackCalculationCount: Int = 0 {
        didSet {
            totalBellCount = countSum(startBellBackCalculationCount, personalBellCount)
        }
    }
    
    func resetStartData() {
        startGameInput = 0
        startBigCountInput = 0
        startRegCountInput = 0
        startCoinDifferenceInput = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 実戦 カウント
    // ////////////////////////
    // //// 自分の実戦分
    @AppStorage("goJug3BellCount") var personalBellCount = 0 {
        didSet {
            totalBellCount = countSum(startBellBackCalculationCount, personalBellCount)
        }
    }
    @AppStorage("goJug3BigCount") var personalBigCount = 0 {
        didSet {
            personalBonusCountSum = countSum(personalBigCount, personalRegCountSum)
            totalBigCount = countSum(startBigCountInput, personalBigCount)
        }
    }
//        @AppStorage("goJug3AloneRegCount") var personalAloneRegCount = 0 {
//            didSet {
//                personalBonusCountSum = countSum(personalBigCount, personalAloneRegCount, personalCherryRegCount)
//                personalRegCountSum = countSum(personalAloneRegCount, personalCherryRegCount)
//            }
//        }
//            @AppStorage("goJug3CherryRegCount") var personalCherryRegCount = 0 {
//                didSet {
//                    personalBonusCountSum = countSum(personalBigCount, personalAloneRegCount, personalCherryRegCount)
//                    personalRegCountSum = countSum(personalAloneRegCount, personalCherryRegCount)
//                }
//            }
    @AppStorage("goJug3CurrentGame") var currentGames = 0 {
        didSet {
            playGame = currentGames - startGameInput
        }
    }
    @AppStorage("goJug3RegCount") var personalRegCountSum = 0 {
        didSet {
            personalBonusCountSum = countSum(personalBigCount, personalRegCountSum)
            totalRegCount = countSum(startRegCountInput, personalRegCountSum)
        }
    }
    @AppStorage("goJug3BonusCountSum") var personalBonusCountSum = 0
    @AppStorage("goJug3PlayGame") var playGame = 0
    
    func resetCountData() {
        personalBellCount = 0
        personalBigCount = 0
        personalRegCountSum = 0
        currentGames = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 実戦 トータル結果
    // ////////////////////////
    @AppStorage("goJug3TotalBigCount") var totalBigCount = 0 {
        didSet {
            totalBonusCountSum = countSum(totalBigCount, totalRegCount)
        }
    }
        @AppStorage("goJug3TotalRegCount") var totalRegCount = 0 {
            didSet {
                totalBonusCountSum = countSum(totalBigCount, totalRegCount)
            }
        }
    @AppStorage("goJug3TotalBellCount") var totalBellCount = 0
    @AppStorage("goJug3TotalBonusCountSum") var totalBonusCountSum = 0
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "ゴーゴージャグラー3"
    @AppStorage("goJug3MinusCheck") var minusCheck: Bool = false
    @AppStorage("goJug3SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetKenDataInput()
        resetStartData()
        resetCountData()
    }
    
    // ////////
    // 島合算
    // ////////
    @AppStorage("goJug3ShimaGames") var shimaGames: Int = 0
    @AppStorage("goJug3ShimaBigs") var shimaBigs: Int = 0
    @AppStorage("goJug3ShimaRegs") var shimaRegs: Int = 0
    @AppStorage("goJug3ShimaBonusSum") var shimaBonusSum: Int = 0
}


// //// メモリー1
class GoJug3Memory1: ObservableObject {
    @AppStorage("goJug3KenBackCalculationEnableMemory1") var kenBackCalculationEnable: Bool = false
    @AppStorage("goJug3KenGameIputMemory1") var kenGameIput: Int = 0
    @AppStorage("goJug3KenBigCountInputMemory1") var kenBigCountInput: Int = 0
    @AppStorage("goJug3KenRegCountInputMemory1") var kenRegCountInput: Int = 0
    @AppStorage("goJug3KenCoinDifferenceInputMemory1") var kenCoinDifferenceInput: Int = 0
    @AppStorage("goJug3KenBonusCountSumMemory1") var kenBonusCountSum: Int = 0
    @AppStorage("goJug3KenBellBackCalculationCountMemory1") var kenBellBackCalculationCount: Int = 0
    @AppStorage("goJug3StartBackCalculationEnableMemory1") var startBackCalculationEnable: Bool = false
    @AppStorage("goJug3StartGameMemory1") var startGameInput: Int = 0
    @AppStorage("goJug3StartBigCountInputMemory1") var startBigCountInput: Int = 0
    @AppStorage("goJug3StartRegCountInputMemory1") var startRegCountInput: Int = 0
    @AppStorage("goJug3StartCoinDifferenceInputMemory1") var startCoinDifferenceInput: Int = 0
    @AppStorage("goJug3StartBonusCountSumMemory1") var startBonusCountSum: Int = 0
    @AppStorage("goJug3StartBellBackCalculationCountMemory1") var startBellBackCalculationCount: Int = 0
    @AppStorage("goJug3BellCountMemory1") var personalBellCount = 0
    @AppStorage("goJug3BigCountMemory1") var personalBigCount = 0
    @AppStorage("goJug3CurrentGameMemory1") var currentGames = 0
    @AppStorage("goJug3RegCountAloneMemory1") var personalRegCountSum = 0
    @AppStorage("goJug3BonusCountSumMemory1") var personalBonusCountSum = 0
    @AppStorage("goJug3PlayGameMemory1") var playGame = 0
    @AppStorage("goJug3TotalBigCountMemory1") var totalBigCount = 0
    @AppStorage("goJug3TotalRegCountMemory1") var totalRegCount = 0
    @AppStorage("goJug3TotalBellCountMemory1") var totalBellCount = 0
    @AppStorage("goJug3TotalBonusCountSumMemory1") var totalBonusCountSum = 0
    @AppStorage("goJug3MemoMemory1") var memo = ""
    @AppStorage("goJug3DateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class GoJug3Memory2: ObservableObject {
    @AppStorage("goJug3KenBackCalculationEnableMemory2") var kenBackCalculationEnable: Bool = false
    @AppStorage("goJug3KenGameIputMemory2") var kenGameIput: Int = 0
    @AppStorage("goJug3KenBigCountInputMemory2") var kenBigCountInput: Int = 0
    @AppStorage("goJug3KenRegCountInputMemory2") var kenRegCountInput: Int = 0
    @AppStorage("goJug3KenCoinDifferenceInputMemory2") var kenCoinDifferenceInput: Int = 0
    @AppStorage("goJug3KenBonusCountSumMemory2") var kenBonusCountSum: Int = 0
    @AppStorage("goJug3KenBellBackCalculationCountMemory2") var kenBellBackCalculationCount: Int = 0
    @AppStorage("goJug3StartBackCalculationEnableMemory2") var startBackCalculationEnable: Bool = false
    @AppStorage("goJug3StartGameMemory2") var startGameInput: Int = 0
    @AppStorage("goJug3StartBigCountInputMemory2") var startBigCountInput: Int = 0
    @AppStorage("goJug3StartRegCountInputMemory2") var startRegCountInput: Int = 0
    @AppStorage("goJug3StartCoinDifferenceInputMemory2") var startCoinDifferenceInput: Int = 0
    @AppStorage("goJug3StartBonusCountSumMemory2") var startBonusCountSum: Int = 0
    @AppStorage("goJug3StartBellBackCalculationCountMemory2") var startBellBackCalculationCount: Int = 0
    @AppStorage("goJug3BellCountMemory2") var personalBellCount = 0
    @AppStorage("goJug3BigCountMemory2") var personalBigCount = 0
    @AppStorage("goJug3CurrentGameMemory2") var currentGames = 0
    @AppStorage("goJug3RegCountAloneMemory2") var personalRegCountSum = 0
    @AppStorage("goJug3BonusCountSumMemory2") var personalBonusCountSum = 0
    @AppStorage("goJug3PlayGameMemory2") var playGame = 0
    @AppStorage("goJug3TotalBigCountMemory2") var totalBigCount = 0
    @AppStorage("goJug3TotalRegCountMemory2") var totalRegCount = 0
    @AppStorage("goJug3TotalBellCountMemory2") var totalBellCount = 0
    @AppStorage("goJug3TotalBonusCountSumMemory2") var totalBonusCountSum = 0
    @AppStorage("goJug3MemoMemory2") var memo = ""
    @AppStorage("goJug3DateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class GoJug3Memory3: ObservableObject {
    @AppStorage("goJug3KenBackCalculationEnableMemory3") var kenBackCalculationEnable: Bool = false
    @AppStorage("goJug3KenGameIputMemory3") var kenGameIput: Int = 0
    @AppStorage("goJug3KenBigCountInputMemory3") var kenBigCountInput: Int = 0
    @AppStorage("goJug3KenRegCountInputMemory3") var kenRegCountInput: Int = 0
    @AppStorage("goJug3KenCoinDifferenceInputMemory3") var kenCoinDifferenceInput: Int = 0
    @AppStorage("goJug3KenBonusCountSumMemory3") var kenBonusCountSum: Int = 0
    @AppStorage("goJug3KenBellBackCalculationCountMemory3") var kenBellBackCalculationCount: Int = 0
    @AppStorage("goJug3StartBackCalculationEnableMemory3") var startBackCalculationEnable: Bool = false
    @AppStorage("goJug3StartGameMemory3") var startGameInput: Int = 0
    @AppStorage("goJug3StartBigCountInputMemory3") var startBigCountInput: Int = 0
    @AppStorage("goJug3StartRegCountInputMemory3") var startRegCountInput: Int = 0
    @AppStorage("goJug3StartCoinDifferenceInputMemory3") var startCoinDifferenceInput: Int = 0
    @AppStorage("goJug3StartBonusCountSumMemory3") var startBonusCountSum: Int = 0
    @AppStorage("goJug3StartBellBackCalculationCountMemory3") var startBellBackCalculationCount: Int = 0
    @AppStorage("goJug3BellCountMemory3") var personalBellCount = 0
    @AppStorage("goJug3BigCountMemory3") var personalBigCount = 0
    @AppStorage("goJug3CurrentGameMemory3") var currentGames = 0
    @AppStorage("goJug3RegCountAloneMemory3") var personalRegCountSum = 0
    @AppStorage("goJug3BonusCountSumMemory3") var personalBonusCountSum = 0
    @AppStorage("goJug3PlayGameMemory3") var playGame = 0
    @AppStorage("goJug3TotalBigCountMemory3") var totalBigCount = 0
    @AppStorage("goJug3TotalRegCountMemory3") var totalRegCount = 0
    @AppStorage("goJug3TotalBellCountMemory3") var totalBellCount = 0
    @AppStorage("goJug3TotalBonusCountSumMemory3") var totalBonusCountSum = 0
    @AppStorage("goJug3MemoMemory3") var memo = ""
    @AppStorage("goJug3DateMemory3") var dateDouble = 0.0
}

struct goJug3Ver2ViewTop: View {
//    @ObservedObject var ver391: Ver391
//    @ObservedObject var goJug3 = GoJug3()
    @StateObject var goJug3 = GoJug3()
    @State var isShowAlert: Bool = false
    @StateObject var goJug3Memory1 = GoJug3Memory1()
    @StateObject var goJug3Memory2 = GoJug3Memory2()
    @StateObject var goJug3Memory3 = GoJug3Memory3()
    @ObservedObject var bayes: Bayes
    @StateObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    
                } header: {
                    unitLabelMachineTopTitle(machineName: "ゴーゴージャグラー3")
                }
                
                // //// 見
                Section {
                    // データ入力
                    NavigationLink(destination: goJug3Ver2ViewKenDataInput(goJug3: goJug3)) {
                        unitLabelMenu(
                            imageSystemName: "magnifyingglass",
                            textBody: "データ確認"
                        )
                    }
                    
                    // 島データ
                    NavigationLink(destination: goJug3ViewShimaData(
                        goJug3: goJug3,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "waveform.path.ecg.magnifyingglass",
                            textBody: "島データ確認",
                            badgeStatus: common.goJug3MenuShimaBadge,
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
                    NavigationLink(destination: goJug3Ver2ViewJissenStartData(goJug3: goJug3)) {
                        unitLabelMenu(
                            imageSystemName: "airplane.departure",
                            textBody: "打ち始めデータ"
                        )
                    }
                    // 実戦カウント
                    NavigationLink(destination: goJug3Ver2ViewJissenCount(
//                        ver391: ver391,
                        goJug3: goJug3,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "arcade.stick.and.arrow.down",
                            textBody: "実戦カウント"
                        )
                    }
                    // トータル結果確認
                    NavigationLink(destination: goJug3Ver2ViewJissenTotalDataCheck(
//                        ver391: ver391,
                        goJug3: goJug3,
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
//                .popoverTip(tipUnitJugHanaCommonJissenView())
                // 設定推測グラフ
                NavigationLink(destination: goJug3Ver2View95CiTotal(goJug3: goJug3)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 設定期待値計算
                NavigationLink(destination: goJug3ViewBayes(
//                    ver391: ver391,
                    goJug3: goJug3,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
//                        badgeStatus: ver391.goJug3MenuBayesBadge,
                    )
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4375")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎ KITA DENSHI")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.goJug3MachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ゴーゴージャグラー3",
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(goJug3SubViewLoadMemory(
                        goJug3: goJug3,
                        goJug3Memory1: goJug3Memory1,
                        goJug3Memory2: goJug3Memory2,
                        goJug3Memory3: goJug3Memory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(goJug3SubViewSaveMemory(
                        goJug3: goJug3,
                        goJug3Memory1: goJug3Memory1,
                        goJug3Memory2: goJug3Memory2,
                        goJug3Memory3: goJug3Memory3
                    )))
                }
//                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: goJug3.resetAll, message: "この機種のデータを全てリセットします")
//                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct goJug3SubViewSaveMemory: View {
    @ObservedObject var goJug3: GoJug3
    @ObservedObject var goJug3Memory1: GoJug3Memory1
    @ObservedObject var goJug3Memory2: GoJug3Memory2
    @ObservedObject var goJug3Memory3: GoJug3Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "ゴーゴージャグラー3",
            selectedMemory: $goJug3.selectedMemory,
            memoMemory1: $goJug3Memory1.memo,
            dateDoubleMemory1: $goJug3Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $goJug3Memory2.memo,
            dateDoubleMemory2: $goJug3Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $goJug3Memory3.memo,
            dateDoubleMemory3: $goJug3Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        goJug3Memory1.kenBackCalculationEnable = goJug3.kenBackCalculationEnable
        goJug3Memory1.kenGameIput = goJug3.kenGameIput
        goJug3Memory1.kenBigCountInput = goJug3.kenBigCountInput
        goJug3Memory1.kenRegCountInput = goJug3.kenRegCountInput
        goJug3Memory1.kenCoinDifferenceInput = goJug3.kenCoinDifferenceInput
        goJug3Memory1.kenBonusCountSum = goJug3.kenBonusCountSum
        goJug3Memory1.kenBellBackCalculationCount = goJug3.kenBellBackCalculationCount
        goJug3Memory1.startBackCalculationEnable = goJug3.startBackCalculationEnable
        goJug3Memory1.startGameInput = goJug3.startGameInput
        goJug3Memory1.startBigCountInput = goJug3.startBigCountInput
        goJug3Memory1.startRegCountInput = goJug3.startRegCountInput
        goJug3Memory1.startCoinDifferenceInput = goJug3.startCoinDifferenceInput
        goJug3Memory1.startBonusCountSum = goJug3.startBonusCountSum
        goJug3Memory1.startBellBackCalculationCount = goJug3.startBellBackCalculationCount
        goJug3Memory1.personalBellCount = goJug3.personalBellCount
        goJug3Memory1.personalBigCount = goJug3.personalBigCount
        goJug3Memory1.currentGames = goJug3.currentGames
        goJug3Memory1.personalRegCountSum = goJug3.personalRegCountSum
        goJug3Memory1.personalBonusCountSum = goJug3.personalBonusCountSum
        goJug3Memory1.playGame = goJug3.playGame
        goJug3Memory1.totalBigCount = goJug3.totalBigCount
        goJug3Memory1.totalRegCount = goJug3.totalRegCount
        goJug3Memory1.totalBellCount = goJug3.totalBellCount
        goJug3Memory1.totalBonusCountSum = goJug3.totalBonusCountSum
    }
    func saveMemory2() {
        goJug3Memory2.kenBackCalculationEnable = goJug3.kenBackCalculationEnable
        goJug3Memory2.kenGameIput = goJug3.kenGameIput
        goJug3Memory2.kenBigCountInput = goJug3.kenBigCountInput
        goJug3Memory2.kenRegCountInput = goJug3.kenRegCountInput
        goJug3Memory2.kenCoinDifferenceInput = goJug3.kenCoinDifferenceInput
        goJug3Memory2.kenBonusCountSum = goJug3.kenBonusCountSum
        goJug3Memory2.kenBellBackCalculationCount = goJug3.kenBellBackCalculationCount
        goJug3Memory2.startBackCalculationEnable = goJug3.startBackCalculationEnable
        goJug3Memory2.startGameInput = goJug3.startGameInput
        goJug3Memory2.startBigCountInput = goJug3.startBigCountInput
        goJug3Memory2.startRegCountInput = goJug3.startRegCountInput
        goJug3Memory2.startCoinDifferenceInput = goJug3.startCoinDifferenceInput
        goJug3Memory2.startBonusCountSum = goJug3.startBonusCountSum
        goJug3Memory2.startBellBackCalculationCount = goJug3.startBellBackCalculationCount
        goJug3Memory2.personalBellCount = goJug3.personalBellCount
        goJug3Memory2.personalBigCount = goJug3.personalBigCount
        goJug3Memory2.currentGames = goJug3.currentGames
        goJug3Memory2.personalRegCountSum = goJug3.personalRegCountSum
        goJug3Memory2.personalBonusCountSum = goJug3.personalBonusCountSum
        goJug3Memory2.playGame = goJug3.playGame
        goJug3Memory2.totalBigCount = goJug3.totalBigCount
        goJug3Memory2.totalRegCount = goJug3.totalRegCount
        goJug3Memory2.totalBellCount = goJug3.totalBellCount
        goJug3Memory2.totalBonusCountSum = goJug3.totalBonusCountSum
    }
    func saveMemory3() {
        goJug3Memory3.kenBackCalculationEnable = goJug3.kenBackCalculationEnable
        goJug3Memory3.kenGameIput = goJug3.kenGameIput
        goJug3Memory3.kenBigCountInput = goJug3.kenBigCountInput
        goJug3Memory3.kenRegCountInput = goJug3.kenRegCountInput
        goJug3Memory3.kenCoinDifferenceInput = goJug3.kenCoinDifferenceInput
        goJug3Memory3.kenBonusCountSum = goJug3.kenBonusCountSum
        goJug3Memory3.kenBellBackCalculationCount = goJug3.kenBellBackCalculationCount
        goJug3Memory3.startBackCalculationEnable = goJug3.startBackCalculationEnable
        goJug3Memory3.startGameInput = goJug3.startGameInput
        goJug3Memory3.startBigCountInput = goJug3.startBigCountInput
        goJug3Memory3.startRegCountInput = goJug3.startRegCountInput
        goJug3Memory3.startCoinDifferenceInput = goJug3.startCoinDifferenceInput
        goJug3Memory3.startBonusCountSum = goJug3.startBonusCountSum
        goJug3Memory3.startBellBackCalculationCount = goJug3.startBellBackCalculationCount
        goJug3Memory3.personalBellCount = goJug3.personalBellCount
        goJug3Memory3.personalBigCount = goJug3.personalBigCount
        goJug3Memory3.currentGames = goJug3.currentGames
        goJug3Memory3.personalRegCountSum = goJug3.personalRegCountSum
        goJug3Memory3.personalBonusCountSum = goJug3.personalBonusCountSum
        goJug3Memory3.playGame = goJug3.playGame
        goJug3Memory3.totalBigCount = goJug3.totalBigCount
        goJug3Memory3.totalRegCount = goJug3.totalRegCount
        goJug3Memory3.totalBellCount = goJug3.totalBellCount
        goJug3Memory3.totalBonusCountSum = goJug3.totalBonusCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct goJug3SubViewLoadMemory: View {
    @ObservedObject var goJug3: GoJug3
    @ObservedObject var goJug3Memory1: GoJug3Memory1
    @ObservedObject var goJug3Memory2: GoJug3Memory2
    @ObservedObject var goJug3Memory3: GoJug3Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "ゴーゴージャグラー3",
            selectedMemory: $goJug3.selectedMemory,
            memoMemory1: goJug3Memory1.memo,
            dateDoubleMemory1: goJug3Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: goJug3Memory2.memo,
            dateDoubleMemory2: goJug3Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: goJug3Memory3.memo,
            dateDoubleMemory3: goJug3Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        goJug3.kenBackCalculationEnable = goJug3Memory1.kenBackCalculationEnable
        goJug3.kenGameIput = goJug3Memory1.kenGameIput
        goJug3.kenBigCountInput = goJug3Memory1.kenBigCountInput
        goJug3.kenRegCountInput = goJug3Memory1.kenRegCountInput
        goJug3.kenCoinDifferenceInput = goJug3Memory1.kenCoinDifferenceInput
        goJug3.kenBonusCountSum = goJug3Memory1.kenBonusCountSum
        goJug3.kenBellBackCalculationCount = goJug3Memory1.kenBellBackCalculationCount
        goJug3.startBackCalculationEnable = goJug3Memory1.startBackCalculationEnable
        goJug3.startGameInput = goJug3Memory1.startGameInput
        goJug3.startBigCountInput = goJug3Memory1.startBigCountInput
        goJug3.startRegCountInput = goJug3Memory1.startRegCountInput
        goJug3.startCoinDifferenceInput = goJug3Memory1.startCoinDifferenceInput
        goJug3.startBonusCountSum = goJug3Memory1.startBonusCountSum
        goJug3.startBellBackCalculationCount = goJug3Memory1.startBellBackCalculationCount
        goJug3.personalBellCount = goJug3Memory1.personalBellCount
        goJug3.personalBigCount = goJug3Memory1.personalBigCount
        goJug3.currentGames = goJug3Memory1.currentGames
        goJug3.personalRegCountSum = goJug3Memory1.personalRegCountSum
        goJug3.personalBonusCountSum = goJug3Memory1.personalBonusCountSum
        goJug3.playGame = goJug3Memory1.playGame
        goJug3.totalBigCount = goJug3Memory1.totalBigCount
        goJug3.totalRegCount = goJug3Memory1.totalRegCount
        goJug3.totalBellCount = goJug3Memory1.totalBellCount
        goJug3.totalBonusCountSum = goJug3Memory1.totalBonusCountSum
    }
    func loadMemory2() {
        goJug3.kenBackCalculationEnable = goJug3Memory2.kenBackCalculationEnable
        goJug3.kenGameIput = goJug3Memory2.kenGameIput
        goJug3.kenBigCountInput = goJug3Memory2.kenBigCountInput
        goJug3.kenRegCountInput = goJug3Memory2.kenRegCountInput
        goJug3.kenCoinDifferenceInput = goJug3Memory2.kenCoinDifferenceInput
        goJug3.kenBonusCountSum = goJug3Memory2.kenBonusCountSum
        goJug3.kenBellBackCalculationCount = goJug3Memory2.kenBellBackCalculationCount
        goJug3.startBackCalculationEnable = goJug3Memory2.startBackCalculationEnable
        goJug3.startGameInput = goJug3Memory2.startGameInput
        goJug3.startBigCountInput = goJug3Memory2.startBigCountInput
        goJug3.startRegCountInput = goJug3Memory2.startRegCountInput
        goJug3.startCoinDifferenceInput = goJug3Memory2.startCoinDifferenceInput
        goJug3.startBonusCountSum = goJug3Memory2.startBonusCountSum
        goJug3.startBellBackCalculationCount = goJug3Memory2.startBellBackCalculationCount
        goJug3.personalBellCount = goJug3Memory2.personalBellCount
        goJug3.personalBigCount = goJug3Memory2.personalBigCount
        goJug3.currentGames = goJug3Memory2.currentGames
        goJug3.personalRegCountSum = goJug3Memory2.personalRegCountSum
        goJug3.personalBonusCountSum = goJug3Memory2.personalBonusCountSum
        goJug3.playGame = goJug3Memory2.playGame
        goJug3.totalBigCount = goJug3Memory2.totalBigCount
        goJug3.totalRegCount = goJug3Memory2.totalRegCount
        goJug3.totalBellCount = goJug3Memory2.totalBellCount
        goJug3.totalBonusCountSum = goJug3Memory2.totalBonusCountSum
    }
    func loadMemory3() {
        goJug3.kenBackCalculationEnable = goJug3Memory3.kenBackCalculationEnable
        goJug3.kenGameIput = goJug3Memory3.kenGameIput
        goJug3.kenBigCountInput = goJug3Memory3.kenBigCountInput
        goJug3.kenRegCountInput = goJug3Memory3.kenRegCountInput
        goJug3.kenCoinDifferenceInput = goJug3Memory3.kenCoinDifferenceInput
        goJug3.kenBonusCountSum = goJug3Memory3.kenBonusCountSum
        goJug3.kenBellBackCalculationCount = goJug3Memory3.kenBellBackCalculationCount
        goJug3.startBackCalculationEnable = goJug3Memory3.startBackCalculationEnable
        goJug3.startGameInput = goJug3Memory3.startGameInput
        goJug3.startBigCountInput = goJug3Memory3.startBigCountInput
        goJug3.startRegCountInput = goJug3Memory3.startRegCountInput
        goJug3.startCoinDifferenceInput = goJug3Memory3.startCoinDifferenceInput
        goJug3.startBonusCountSum = goJug3Memory3.startBonusCountSum
        goJug3.startBellBackCalculationCount = goJug3Memory3.startBellBackCalculationCount
        goJug3.personalBellCount = goJug3Memory3.personalBellCount
        goJug3.personalBigCount = goJug3Memory3.personalBigCount
        goJug3.currentGames = goJug3Memory3.currentGames
        goJug3.personalRegCountSum = goJug3Memory3.personalRegCountSum
        goJug3.personalBonusCountSum = goJug3Memory3.personalBonusCountSum
        goJug3.playGame = goJug3Memory3.playGame
        goJug3.totalBigCount = goJug3Memory3.totalBigCount
        goJug3.totalRegCount = goJug3Memory3.totalRegCount
        goJug3.totalBellCount = goJug3Memory3.totalBellCount
        goJug3.totalBonusCountSum = goJug3Memory3.totalBonusCountSum
    }
}

#Preview {
    goJug3Ver2ViewTop(
//        ver391: Ver391(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
