//
//  imJugExVer2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/22.
//

import SwiftUI

// ///////////////////////
// 変数
// ///////////////////////
class ImJugEx: ObservableObject {
    // ////////////////////////
    // 見
    // ////////////////////////
    @AppStorage("imJugExKenBackCalculationEnable") var kenBackCalculationEnable: Bool = false {
        didSet {
            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
        }
    }
        @AppStorage("imJugExKenGameIput") var kenGameIput: Int = 0 {
            didSet {
                kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
            }
        }
            @AppStorage("imJugExKenBigCountInput") var kenBigCountInput: Int = 0 {
                didSet {
                    kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                    kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                }
            }
                @AppStorage("imJugExKenRegCountInput") var kenRegCountInput: Int = 0 {
                    didSet {
                        kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                    }
                }
                    @AppStorage("imJugExKenCoinDifferenceInput") var kenCoinDifferenceInput: Int = 0 {
                        didSet {
                            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        }
                    }
    @AppStorage("imJugExKenBonusCountSum") var kenBonusCountSum: Int = 0
    @AppStorage("imJugExKenBellBackCalculationCount") var kenBellBackCalculationCount: Int = 0
    
    func bellBackCalculate(game: Int, bigCount: Int, regCount: Int, coinDifference: Int) -> Int {
        // 各種確率の定義
        let replayDenominate = 7.298   // リプレイ確率
        let cherryDenominate: Double = 35.5   // チェリー確率
        let cherryGetRatio = 0.9   // チェリー奪取率
        let budonukiAverageGame = 1.31   // ぶどう抜き平均消化ゲーム数（1枚がけ）
        let budonukiAverageIn = 1.13   // ぶどう抜き平均IN枚数
        let budonukiAverageOut = 1.01   // ぶどう抜き平均OUT枚数
        let bigOut: Double = 252   // ビッグ獲得枚数
        let regOut: Double = 96   // REG獲得枚数
        let cherryOut: Double = 2   // チェリー払い出し枚数
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
    @AppStorage("imJugExStartBackCalculationEnable") var startBackCalculationEnable: Bool = false {
        didSet {
            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
        }
    }
        @AppStorage("imJugExStartGame") var startGameInput: Int = 0 {
            didSet {
                startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
            }
        }
            @AppStorage("imJugExStartBigCountInput") var startBigCountInput: Int = 0 {
                didSet {
                    startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                    startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                    totalBigCount = countSum(startBigCountInput, personalBigCount)
                }
            }
                @AppStorage("imJugExStartRegCountInput") var startRegCountInput: Int = 0 {
                    didSet {
                        startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                        totalRegCount = countSum(startRegCountInput, personalRegCountSum)
                    }
                }
                    @AppStorage("imJugExStartCoinDifferenceInput") var startCoinDifferenceInput: Int = 0 {
                        didSet {
                            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        }
                    }
    @AppStorage("imJugExStartBonusCountSum") var startBonusCountSum: Int = 0
    @AppStorage("imJugExStartBellBackCalculationCount") var startBellBackCalculationCount: Int = 0 {
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
    @AppStorage("imJugExBellCount") var personalBellCount = 0 {
        didSet {
            totalBellCount = countSum(startBellBackCalculationCount, personalBellCount)
        }
    }
    @AppStorage("imJugExBigCount") var personalBigCount = 0 {
        didSet {
            personalBonusCountSum = countSum(personalBigCount, personalAloneRegCount, personalCherryRegCount)
            totalBigCount = countSum(startBigCountInput, personalBigCount)
        }
    }
        @AppStorage("imJugExRegCountAlone") var personalAloneRegCount = 0 {
            didSet {
                personalBonusCountSum = countSum(personalBigCount, personalAloneRegCount, personalCherryRegCount)
                personalRegCountSum = countSum(personalAloneRegCount, personalCherryRegCount)
            }
        }
            @AppStorage("imJugExRegCountCherry") var personalCherryRegCount = 0 {
                didSet {
                    personalBonusCountSum = countSum(personalBigCount, personalAloneRegCount, personalCherryRegCount)
                    personalRegCountSum = countSum(personalAloneRegCount, personalCherryRegCount)
                }
            }
    @AppStorage("imJugExCurrentGame") var currentGames = 0 {
        didSet {
            playGame = currentGames - startGameInput
        }
    }
    @AppStorage("imJugExRegCountSum") var personalRegCountSum = 0 {
        didSet {
            totalRegCount = countSum(startRegCountInput, personalRegCountSum)
        }
    }
    @AppStorage("imJugExBonusCountSum") var personalBonusCountSum = 0
    @AppStorage("imJugExPlayGame") var playGame = 0
    
    func resetCountData() {
        personalBellCount = 0
        personalBigCount = 0
        personalAloneRegCount = 0
        personalCherryRegCount = 0
        currentGames = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 実戦 トータル結果
    // ////////////////////////
    @AppStorage("imJugExTotalBigCount") var totalBigCount = 0 {
        didSet {
            totalBonusCountSum = countSum(totalBigCount, totalRegCount)
        }
    }
        @AppStorage("imJugExTotalRegCount") var totalRegCount = 0 {
            didSet {
                totalBonusCountSum = countSum(totalBigCount, totalRegCount)
            }
        }
    @AppStorage("imJugExTotalBellCount") var totalBellCount = 0
    @AppStorage("imJugExTotalBonusCountSum") var totalBonusCountSum = 0
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("imJugExMinusCheck") var minusCheck: Bool = false
    @AppStorage("imJugExSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetKenDataInput()
        resetStartData()
        resetCountData()
    }
}


// //// メモリー1
class ImJugExMemory1: ObservableObject {
    @AppStorage("imJugExKenBackCalculationEnableMemory1") var kenBackCalculationEnable: Bool = false
    @AppStorage("imJugExKenGameIputMemory1") var kenGameIput: Int = 0
    @AppStorage("imJugExKenBigCountInputMemory1") var kenBigCountInput: Int = 0
    @AppStorage("imJugExKenRegCountInputMemory1") var kenRegCountInput: Int = 0
    @AppStorage("imJugExKenCoinDifferenceInputMemory1") var kenCoinDifferenceInput: Int = 0
    @AppStorage("imJugExKenBonusCountSumMemory1") var kenBonusCountSum: Int = 0
    @AppStorage("imJugExKenBellBackCalculationCountMemory1") var kenBellBackCalculationCount: Int = 0
    @AppStorage("imJugExStartBackCalculationEnableMemory1") var startBackCalculationEnable: Bool = false
    @AppStorage("imJugExStartGameMemory1") var startGameInput: Int = 0
    @AppStorage("imJugExStartBigCountInputMemory1") var startBigCountInput: Int = 0
    @AppStorage("imJugExStartRegCountInputMemory1") var startRegCountInput: Int = 0
    @AppStorage("imJugExStartCoinDifferenceInputMemory1") var startCoinDifferenceInput: Int = 0
    @AppStorage("imJugExStartBonusCountSumMemory1") var startBonusCountSum: Int = 0
    @AppStorage("imJugExStartBellBackCalculationCountMemory1") var startBellBackCalculationCount: Int = 0
    @AppStorage("imJugExBellCountMemory1") var personalBellCount = 0
    @AppStorage("imJugExBigCountMemory1") var personalBigCount = 0
    @AppStorage("imJugExRegCountAloneMemory1") var personalAloneRegCount = 0
    @AppStorage("imJugExRegCountCherryMemory1") var personalCherryRegCount = 0
    @AppStorage("imJugExCurrentGameMemory1") var currentGames = 0
    @AppStorage("imJugExRegCountSumMemory1") var personalRegCountSum = 0
    @AppStorage("imJugExBonusCountSumMemory1") var personalBonusCountSum = 0
    @AppStorage("imJugExPlayGameMemory1") var playGame = 0
    @AppStorage("imJugExTotalBigCountMemory1") var totalBigCount = 0
    @AppStorage("imJugExTotalRegCountMemory1") var totalRegCount = 0
    @AppStorage("imJugExTotalBellCountMemory1") var totalBellCount = 0
    @AppStorage("imJugExTotalBonusCountSumMemory1") var totalBonusCountSum = 0
    @AppStorage("imJugExMemoMemory1") var memo = ""
    @AppStorage("imJugExDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class ImJugExMemory2: ObservableObject {
    @AppStorage("imJugExKenBackCalculationEnableMemory2") var kenBackCalculationEnable: Bool = false
    @AppStorage("imJugExKenGameIputMemory2") var kenGameIput: Int = 0
    @AppStorage("imJugExKenBigCountInputMemory2") var kenBigCountInput: Int = 0
    @AppStorage("imJugExKenRegCountInputMemory2") var kenRegCountInput: Int = 0
    @AppStorage("imJugExKenCoinDifferenceInputMemory2") var kenCoinDifferenceInput: Int = 0
    @AppStorage("imJugExKenBonusCountSumMemory2") var kenBonusCountSum: Int = 0
    @AppStorage("imJugExKenBellBackCalculationCountMemory2") var kenBellBackCalculationCount: Int = 0
    @AppStorage("imJugExStartBackCalculationEnableMemory2") var startBackCalculationEnable: Bool = false
    @AppStorage("imJugExStartGameMemory2") var startGameInput: Int = 0
    @AppStorage("imJugExStartBigCountInputMemory2") var startBigCountInput: Int = 0
    @AppStorage("imJugExStartRegCountInputMemory2") var startRegCountInput: Int = 0
    @AppStorage("imJugExStartCoinDifferenceInputMemory2") var startCoinDifferenceInput: Int = 0
    @AppStorage("imJugExStartBonusCountSumMemory2") var startBonusCountSum: Int = 0
    @AppStorage("imJugExStartBellBackCalculationCountMemory2") var startBellBackCalculationCount: Int = 0
    @AppStorage("imJugExBellCountMemory2") var personalBellCount = 0
    @AppStorage("imJugExBigCountMemory2") var personalBigCount = 0
    @AppStorage("imJugExRegCountAloneMemory2") var personalAloneRegCount = 0
    @AppStorage("imJugExRegCountCherryMemory2") var personalCherryRegCount = 0
    @AppStorage("imJugExCurrentGameMemory2") var currentGames = 0
    @AppStorage("imJugExRegCountSumMemory2") var personalRegCountSum = 0
    @AppStorage("imJugExBonusCountSumMemory2") var personalBonusCountSum = 0
    @AppStorage("imJugExPlayGameMemory2") var playGame = 0
    @AppStorage("imJugExTotalBigCountMemory2") var totalBigCount = 0
    @AppStorage("imJugExTotalRegCountMemory2") var totalRegCount = 0
    @AppStorage("imJugExTotalBellCountMemory2") var totalBellCount = 0
    @AppStorage("imJugExTotalBonusCountSumMemory2") var totalBonusCountSum = 0
    @AppStorage("imJugExMemoMemory2") var memo = ""
    @AppStorage("imJugExDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class ImJugExMemory3: ObservableObject {
    @AppStorage("imJugExKenBackCalculationEnableMemory3") var kenBackCalculationEnable: Bool = false
    @AppStorage("imJugExKenGameIputMemory3") var kenGameIput: Int = 0
    @AppStorage("imJugExKenBigCountInputMemory3") var kenBigCountInput: Int = 0
    @AppStorage("imJugExKenRegCountInputMemory3") var kenRegCountInput: Int = 0
    @AppStorage("imJugExKenCoinDifferenceInputMemory3") var kenCoinDifferenceInput: Int = 0
    @AppStorage("imJugExKenBonusCountSumMemory3") var kenBonusCountSum: Int = 0
    @AppStorage("imJugExKenBellBackCalculationCountMemory3") var kenBellBackCalculationCount: Int = 0
    @AppStorage("imJugExStartBackCalculationEnableMemory3") var startBackCalculationEnable: Bool = false
    @AppStorage("imJugExStartGameMemory3") var startGameInput: Int = 0
    @AppStorage("imJugExStartBigCountInputMemory3") var startBigCountInput: Int = 0
    @AppStorage("imJugExStartRegCountInputMemory3") var startRegCountInput: Int = 0
    @AppStorage("imJugExStartCoinDifferenceInputMemory3") var startCoinDifferenceInput: Int = 0
    @AppStorage("imJugExStartBonusCountSumMemory3") var startBonusCountSum: Int = 0
    @AppStorage("imJugExStartBellBackCalculationCountMemory3") var startBellBackCalculationCount: Int = 0
    @AppStorage("imJugExBellCountMemory3") var personalBellCount = 0
    @AppStorage("imJugExBigCountMemory3") var personalBigCount = 0
    @AppStorage("imJugExRegCountAloneMemory3") var personalAloneRegCount = 0
    @AppStorage("imJugExRegCountCherryMemory3") var personalCherryRegCount = 0
    @AppStorage("imJugExCurrentGameMemory3") var currentGames = 0
    @AppStorage("imJugExRegCountSumMemory3") var personalRegCountSum = 0
    @AppStorage("imJugExBonusCountSumMemory3") var personalBonusCountSum = 0
    @AppStorage("imJugExPlayGameMemory3") var playGame = 0
    @AppStorage("imJugExTotalBigCountMemory3") var totalBigCount = 0
    @AppStorage("imJugExTotalRegCountMemory3") var totalRegCount = 0
    @AppStorage("imJugExTotalBellCountMemory3") var totalBellCount = 0
    @AppStorage("imJugExTotalBonusCountSumMemory3") var totalBonusCountSum = 0
    @AppStorage("imJugExMemoMemory3") var memo = ""
    @AppStorage("imJugExDateMemory3") var dateDouble = 0.0
}


struct imJugExVer2ViewTop: View {
    @ObservedObject var imJugEx = ImJugEx()
    @State var isShowAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    
                } header: {
                    unitLabelMachineTopTitle(machineName: "アイムジャグラーEX")
                }
                
                // //// 見
                Section {
                    // データ入力
                    NavigationLink(destination: imJugExVer2ViewKenDataInput()) {
                        unitLabelMenu(
                            imageSystemName: "magnifyingglass",
                            textBody: "データ確認"
                        )
                    }
                } header: {
                    Text("見")
                        .fontWeight(.bold)
                        .font(.headline)
                }
                
                // //// 実戦
                Section {
                    // データ入力
                    NavigationLink(destination: imJugExVer2ViewJissenStartData()) {
                        unitLabelMenu(
                            imageSystemName: "airplane.departure",
                            textBody: "打ち始めデータ"
                        )
                    }
                    // 実戦カウント
                    NavigationLink(destination: imJugExVer2ViewJissenCount()) {
                        unitLabelMenu(
                            imageSystemName: "arcade.stick.and.arrow.down",
                            textBody: "実戦カウント"
                        )
                    }
                    // トータル結果確認
                    NavigationLink(destination: imJugExVer2ViewJissenTotalDataCheck()) {
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
                NavigationLink(destination: imJugExVer2View95CiTotal()) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(imJugExSubViewLoadMemory()))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(imJugExSubViewSaveMemory()))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: imJugEx.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct imJugExSubViewSaveMemory: View {
    @ObservedObject var imJugEx = ImJugEx()
    @ObservedObject var imJugExMemory1 = ImJugExMemory1()
    @ObservedObject var imJugExMemory2 = ImJugExMemory2()
    @ObservedObject var imJugExMemory3 = ImJugExMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "マイジャグラー5",
            selectedMemory: $imJugEx.selectedMemory,
            memoMemory1: $imJugExMemory1.memo,
            dateDoubleMemory1: $imJugExMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $imJugExMemory2.memo,
            dateDoubleMemory2: $imJugExMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $imJugExMemory3.memo,
            dateDoubleMemory3: $imJugExMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        imJugExMemory1.kenBackCalculationEnable = imJugEx.kenBackCalculationEnable
        imJugExMemory1.kenGameIput = imJugEx.kenGameIput
        imJugExMemory1.kenBigCountInput = imJugEx.kenBigCountInput
        imJugExMemory1.kenRegCountInput = imJugEx.kenRegCountInput
        imJugExMemory1.kenCoinDifferenceInput = imJugEx.kenCoinDifferenceInput
        imJugExMemory1.kenBonusCountSum = imJugEx.kenBonusCountSum
        imJugExMemory1.kenBellBackCalculationCount = imJugEx.kenBellBackCalculationCount
        imJugExMemory1.startBackCalculationEnable = imJugEx.startBackCalculationEnable
        imJugExMemory1.startGameInput = imJugEx.startGameInput
        imJugExMemory1.startBigCountInput = imJugEx.startBigCountInput
        imJugExMemory1.startRegCountInput = imJugEx.startRegCountInput
        imJugExMemory1.startCoinDifferenceInput = imJugEx.startCoinDifferenceInput
        imJugExMemory1.startBonusCountSum = imJugEx.startBonusCountSum
        imJugExMemory1.startBellBackCalculationCount = imJugEx.startBellBackCalculationCount
        imJugExMemory1.personalBellCount = imJugEx.personalBellCount
        imJugExMemory1.personalBigCount = imJugEx.personalBigCount
        imJugExMemory1.personalAloneRegCount = imJugEx.personalAloneRegCount
        imJugExMemory1.personalCherryRegCount = imJugEx.personalCherryRegCount
        imJugExMemory1.currentGames = imJugEx.currentGames
        imJugExMemory1.personalRegCountSum = imJugEx.personalRegCountSum
        imJugExMemory1.personalBonusCountSum = imJugEx.personalBonusCountSum
        imJugExMemory1.playGame = imJugEx.playGame
        imJugExMemory1.totalBigCount = imJugEx.totalBigCount
        imJugExMemory1.totalRegCount = imJugEx.totalRegCount
        imJugExMemory1.totalBellCount = imJugEx.totalBellCount
        imJugExMemory1.totalBonusCountSum = imJugEx.totalBonusCountSum
    }
    func saveMemory2() {
        imJugExMemory2.kenBackCalculationEnable = imJugEx.kenBackCalculationEnable
        imJugExMemory2.kenGameIput = imJugEx.kenGameIput
        imJugExMemory2.kenBigCountInput = imJugEx.kenBigCountInput
        imJugExMemory2.kenRegCountInput = imJugEx.kenRegCountInput
        imJugExMemory2.kenCoinDifferenceInput = imJugEx.kenCoinDifferenceInput
        imJugExMemory2.kenBonusCountSum = imJugEx.kenBonusCountSum
        imJugExMemory2.kenBellBackCalculationCount = imJugEx.kenBellBackCalculationCount
        imJugExMemory2.startBackCalculationEnable = imJugEx.startBackCalculationEnable
        imJugExMemory2.startGameInput = imJugEx.startGameInput
        imJugExMemory2.startBigCountInput = imJugEx.startBigCountInput
        imJugExMemory2.startRegCountInput = imJugEx.startRegCountInput
        imJugExMemory2.startCoinDifferenceInput = imJugEx.startCoinDifferenceInput
        imJugExMemory2.startBonusCountSum = imJugEx.startBonusCountSum
        imJugExMemory2.startBellBackCalculationCount = imJugEx.startBellBackCalculationCount
        imJugExMemory2.personalBellCount = imJugEx.personalBellCount
        imJugExMemory2.personalBigCount = imJugEx.personalBigCount
        imJugExMemory2.personalAloneRegCount = imJugEx.personalAloneRegCount
        imJugExMemory2.personalCherryRegCount = imJugEx.personalCherryRegCount
        imJugExMemory2.currentGames = imJugEx.currentGames
        imJugExMemory2.personalRegCountSum = imJugEx.personalRegCountSum
        imJugExMemory2.personalBonusCountSum = imJugEx.personalBonusCountSum
        imJugExMemory2.playGame = imJugEx.playGame
        imJugExMemory2.totalBigCount = imJugEx.totalBigCount
        imJugExMemory2.totalRegCount = imJugEx.totalRegCount
        imJugExMemory2.totalBellCount = imJugEx.totalBellCount
        imJugExMemory2.totalBonusCountSum = imJugEx.totalBonusCountSum
    }
    func saveMemory3() {
        imJugExMemory3.kenBackCalculationEnable = imJugEx.kenBackCalculationEnable
        imJugExMemory3.kenGameIput = imJugEx.kenGameIput
        imJugExMemory3.kenBigCountInput = imJugEx.kenBigCountInput
        imJugExMemory3.kenRegCountInput = imJugEx.kenRegCountInput
        imJugExMemory3.kenCoinDifferenceInput = imJugEx.kenCoinDifferenceInput
        imJugExMemory3.kenBonusCountSum = imJugEx.kenBonusCountSum
        imJugExMemory3.kenBellBackCalculationCount = imJugEx.kenBellBackCalculationCount
        imJugExMemory3.startBackCalculationEnable = imJugEx.startBackCalculationEnable
        imJugExMemory3.startGameInput = imJugEx.startGameInput
        imJugExMemory3.startBigCountInput = imJugEx.startBigCountInput
        imJugExMemory3.startRegCountInput = imJugEx.startRegCountInput
        imJugExMemory3.startCoinDifferenceInput = imJugEx.startCoinDifferenceInput
        imJugExMemory3.startBonusCountSum = imJugEx.startBonusCountSum
        imJugExMemory3.startBellBackCalculationCount = imJugEx.startBellBackCalculationCount
        imJugExMemory3.personalBellCount = imJugEx.personalBellCount
        imJugExMemory3.personalBigCount = imJugEx.personalBigCount
        imJugExMemory3.personalAloneRegCount = imJugEx.personalAloneRegCount
        imJugExMemory3.personalCherryRegCount = imJugEx.personalCherryRegCount
        imJugExMemory3.currentGames = imJugEx.currentGames
        imJugExMemory3.personalRegCountSum = imJugEx.personalRegCountSum
        imJugExMemory3.personalBonusCountSum = imJugEx.personalBonusCountSum
        imJugExMemory3.playGame = imJugEx.playGame
        imJugExMemory3.totalBigCount = imJugEx.totalBigCount
        imJugExMemory3.totalRegCount = imJugEx.totalRegCount
        imJugExMemory3.totalBellCount = imJugEx.totalBellCount
        imJugExMemory3.totalBonusCountSum = imJugEx.totalBonusCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct imJugExSubViewLoadMemory: View {
    @ObservedObject var imJugEx = ImJugEx()
    @ObservedObject var imJugExMemory1 = ImJugExMemory1()
    @ObservedObject var imJugExMemory2 = ImJugExMemory2()
    @ObservedObject var imJugExMemory3 = ImJugExMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "マイジャグラー5",
            selectedMemory: $imJugEx.selectedMemory,
            memoMemory1: imJugExMemory1.memo,
            dateDoubleMemory1: imJugExMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: imJugExMemory2.memo,
            dateDoubleMemory2: imJugExMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: imJugExMemory3.memo,
            dateDoubleMemory3: imJugExMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        imJugEx.kenBackCalculationEnable = imJugExMemory1.kenBackCalculationEnable
        imJugEx.kenGameIput = imJugExMemory1.kenGameIput
        imJugEx.kenBigCountInput = imJugExMemory1.kenBigCountInput
        imJugEx.kenRegCountInput = imJugExMemory1.kenRegCountInput
        imJugEx.kenCoinDifferenceInput = imJugExMemory1.kenCoinDifferenceInput
        imJugEx.kenBonusCountSum = imJugExMemory1.kenBonusCountSum
        imJugEx.kenBellBackCalculationCount = imJugExMemory1.kenBellBackCalculationCount
        imJugEx.startBackCalculationEnable = imJugExMemory1.startBackCalculationEnable
        imJugEx.startGameInput = imJugExMemory1.startGameInput
        imJugEx.startBigCountInput = imJugExMemory1.startBigCountInput
        imJugEx.startRegCountInput = imJugExMemory1.startRegCountInput
        imJugEx.startCoinDifferenceInput = imJugExMemory1.startCoinDifferenceInput
        imJugEx.startBonusCountSum = imJugExMemory1.startBonusCountSum
        imJugEx.startBellBackCalculationCount = imJugExMemory1.startBellBackCalculationCount
        imJugEx.personalBellCount = imJugExMemory1.personalBellCount
        imJugEx.personalBigCount = imJugExMemory1.personalBigCount
        imJugEx.personalAloneRegCount = imJugExMemory1.personalAloneRegCount
        imJugEx.personalCherryRegCount = imJugExMemory1.personalCherryRegCount
        imJugEx.currentGames = imJugExMemory1.currentGames
        imJugEx.personalRegCountSum = imJugExMemory1.personalRegCountSum
        imJugEx.personalBonusCountSum = imJugExMemory1.personalBonusCountSum
        imJugEx.playGame = imJugExMemory1.playGame
        imJugEx.totalBigCount = imJugExMemory1.totalBigCount
        imJugEx.totalRegCount = imJugExMemory1.totalRegCount
        imJugEx.totalBellCount = imJugExMemory1.totalBellCount
        imJugEx.totalBonusCountSum = imJugExMemory1.totalBonusCountSum
    }
    func loadMemory2() {
        imJugEx.kenBackCalculationEnable = imJugExMemory2.kenBackCalculationEnable
        imJugEx.kenGameIput = imJugExMemory2.kenGameIput
        imJugEx.kenBigCountInput = imJugExMemory2.kenBigCountInput
        imJugEx.kenRegCountInput = imJugExMemory2.kenRegCountInput
        imJugEx.kenCoinDifferenceInput = imJugExMemory2.kenCoinDifferenceInput
        imJugEx.kenBonusCountSum = imJugExMemory2.kenBonusCountSum
        imJugEx.kenBellBackCalculationCount = imJugExMemory2.kenBellBackCalculationCount
        imJugEx.startBackCalculationEnable = imJugExMemory2.startBackCalculationEnable
        imJugEx.startGameInput = imJugExMemory2.startGameInput
        imJugEx.startBigCountInput = imJugExMemory2.startBigCountInput
        imJugEx.startRegCountInput = imJugExMemory2.startRegCountInput
        imJugEx.startCoinDifferenceInput = imJugExMemory2.startCoinDifferenceInput
        imJugEx.startBonusCountSum = imJugExMemory2.startBonusCountSum
        imJugEx.startBellBackCalculationCount = imJugExMemory2.startBellBackCalculationCount
        imJugEx.personalBellCount = imJugExMemory2.personalBellCount
        imJugEx.personalBigCount = imJugExMemory2.personalBigCount
        imJugEx.personalAloneRegCount = imJugExMemory2.personalAloneRegCount
        imJugEx.personalCherryRegCount = imJugExMemory2.personalCherryRegCount
        imJugEx.currentGames = imJugExMemory2.currentGames
        imJugEx.personalRegCountSum = imJugExMemory2.personalRegCountSum
        imJugEx.personalBonusCountSum = imJugExMemory2.personalBonusCountSum
        imJugEx.playGame = imJugExMemory2.playGame
        imJugEx.totalBigCount = imJugExMemory2.totalBigCount
        imJugEx.totalRegCount = imJugExMemory2.totalRegCount
        imJugEx.totalBellCount = imJugExMemory2.totalBellCount
        imJugEx.totalBonusCountSum = imJugExMemory2.totalBonusCountSum
    }
    func loadMemory3() {
        imJugEx.kenBackCalculationEnable = imJugExMemory3.kenBackCalculationEnable
        imJugEx.kenGameIput = imJugExMemory3.kenGameIput
        imJugEx.kenBigCountInput = imJugExMemory3.kenBigCountInput
        imJugEx.kenRegCountInput = imJugExMemory3.kenRegCountInput
        imJugEx.kenCoinDifferenceInput = imJugExMemory3.kenCoinDifferenceInput
        imJugEx.kenBonusCountSum = imJugExMemory3.kenBonusCountSum
        imJugEx.kenBellBackCalculationCount = imJugExMemory3.kenBellBackCalculationCount
        imJugEx.startBackCalculationEnable = imJugExMemory3.startBackCalculationEnable
        imJugEx.startGameInput = imJugExMemory3.startGameInput
        imJugEx.startBigCountInput = imJugExMemory3.startBigCountInput
        imJugEx.startRegCountInput = imJugExMemory3.startRegCountInput
        imJugEx.startCoinDifferenceInput = imJugExMemory3.startCoinDifferenceInput
        imJugEx.startBonusCountSum = imJugExMemory3.startBonusCountSum
        imJugEx.startBellBackCalculationCount = imJugExMemory3.startBellBackCalculationCount
        imJugEx.personalBellCount = imJugExMemory3.personalBellCount
        imJugEx.personalBigCount = imJugExMemory3.personalBigCount
        imJugEx.personalAloneRegCount = imJugExMemory3.personalAloneRegCount
        imJugEx.personalCherryRegCount = imJugExMemory3.personalCherryRegCount
        imJugEx.currentGames = imJugExMemory3.currentGames
        imJugEx.personalRegCountSum = imJugExMemory3.personalRegCountSum
        imJugEx.personalBonusCountSum = imJugExMemory3.personalBonusCountSum
        imJugEx.playGame = imJugExMemory3.playGame
        imJugEx.totalBigCount = imJugExMemory3.totalBigCount
        imJugEx.totalRegCount = imJugExMemory3.totalRegCount
        imJugEx.totalBellCount = imJugExMemory3.totalBellCount
        imJugEx.totalBonusCountSum = imJugExMemory3.totalBonusCountSum
    }
}


#Preview {
    imJugExVer2ViewTop()
}
