//
//  kingHanaVer2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/26.
//

import SwiftUI
import FirebaseAnalytics


// ///////////////////////
// 変数
// ///////////////////////
class KingHana: ObservableObject {
    // ////////////////////////
    // 確率値
    // ////////////////////////
    let denominateListBell: [Double] = [
        7.18,
        7.18,
        7.18,
        7.02,
        6.97,
        6.92
    ]
    let denominateListBig: [Double] = [
        292,
        280,
        268,
        257,
        244,
        232
    ]
    let denominateListReg: [Double] = [
        489,
        452,
        420,
        390,
        360,
        332
    ]
    let denominateListBonusSum: [Double] = [
        183,
        172,
        163,
        154,
        145,
        136
    ]
    let denominateListBbSuika: [Double] = [
        48,
        44,
        42,
        40,
        35,
        32
    ]
    let percentListBbLamp: [Double] = [
        10.9,
        12.8,
        13.3,
        15.1,
        15.4,
        16.9
    ]
    let percentListRbLampKisuSisa: [Double] = [
        60,
        40,
        60,
        40,
        60,
        50
    ]
    // ////////////////////////
    // 見
    // ////////////////////////
    @AppStorage("kingHanaKenBackCalculationEnable") var kenBackCalculationEnable: Bool = false {
        didSet {
            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
        }
    }
        @AppStorage("kingHanaKenGameIput") var kenGameIput: Int = 0 {
            didSet {
                kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
            }
        }
            @AppStorage("kingHanaKenBigCountInput") var kenBigCountInput: Int = 0 {
                didSet {
                    kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                    kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                }
            }
                @AppStorage("kingHanaKenRegCountInput") var kenRegCountInput: Int = 0 {
                    didSet {
                        kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                    }
                }
                    @AppStorage("kingHanaKenCoinDifferenceInput") var kenCoinDifferenceInput: Int = 0 {
                        didSet {
                            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        }
                    }
    @AppStorage("kingHanaKenBonusCountSum") var kenBonusCountSum: Int = 0
    @AppStorage("kingHanaKenBellBackCalculationCount") var kenBellBackCalculationCount: Int = 0
    
    func bellBackCalculate(game: Int, bigCount: Int, regCount: Int, coinDifference: Int) -> Int {
        // 各種確率の定義
        let replayDenominate = 7.298   // リプレイ確率
        let cherryDenominate: Double = 48.0   // チェリー確率
        let suikaDenominate: Double = 160.0   // スイカ確率
        let cherryGetRatio = 0.9   // チェリー奪取率
        let suikaGetRatio: Double = 0.7   // ベル奪取率
        let bigOut: Double = 260   // ビッグ獲得枚数
        let regOut: Double = 120   // REG獲得枚数
        let cherryOut: Double = 4   // チェリー払い出し枚数
        let bellOut: Double = 9   // ぶどう・ベル払い出し枚数
        let suikaOut: Double = 6   // スイカ払い出し枚数
        
        // //// ゲーム数の内訳算出
        let replayGame = Double(game) / replayDenominate
        let normalGame = Double(game) - replayGame
        
        // //// IN枚数の計算
        let normalGameIn = normalGame * 3
        let inTotal = normalGameIn
        
        // //// OUT枚数の計算
        let bigOutTotal = Double(bigCount) * bigOut
        let regOutTotal = Double(regCount) * regOut
        let cherryOutTotal = Double(game) / cherryDenominate * cherryOut * cherryGetRatio
        let suikaOutTotal = Double(game) / suikaDenominate * suikaOut * suikaGetRatio
        let outTotalWithoutBell = bigOutTotal + regOutTotal + cherryOutTotal + suikaOutTotal
        
        // //// ぶどう抜き逆算値の算出
        let bellOutTotal = Double(coinDifference) - outTotalWithoutBell + inTotal
        let bellBackCalculateCount = Int(bellOutTotal / bellOut)
        
        return bellBackCalculateCount
    }
    
    func kenToStartRecord() {
        resetStartData()
        hanaReset()
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
    @AppStorage("kingHanaStartBackCalculationEnable") var startBackCalculationEnable: Bool = false {
        didSet {
            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
        }
    }
        @AppStorage("kingHanaStartGames") var startGameInput: Int = 0 {
            didSet {
                startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                playGames = currentGames - startGameInput
            }
        }
            @AppStorage("kingHanaStartBigCountInput") var startBigCountInput: Int = 0 {
                didSet {
                    startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                    startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                    totalBigCount = countSum(startBigCountInput, bigCount)
                }
            }
                @AppStorage("kingHanaStartRegCountInput") var startRegCountInput: Int = 0 {
                    didSet {
                        startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                        totalRegCount = countSum(startRegCountInput, regCount)
                    }
                }
                    @AppStorage("kingHanaStartCoinDifferenceInput") var startCoinDifferenceInput: Int = 0 {
                        didSet {
                            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        }
                    }
    @AppStorage("kingHanaStartBonusCountSum") var startBonusCountSum: Int = 0
    @AppStorage("kingHanaStartBellBackCalculationCount") var startBellBackCalculationCount: Int = 0 {
        didSet {
            totalBellCount = countSum(startBellBackCalculationCount, bellCount)
        }
    }
    
    func resetStartData() {
        startGameInput = 0
        startBigCountInput = 0
        startRegCountInput = 0
        startCoinDifferenceInput = 0
        minusCheck = false
    }
    
    // /////////////////
    // 実戦カウント
    // /////////////////
    @AppStorage("kingHanaBellCount") var bellCount = 0 {
        didSet {
            totalBellCount = countSum(startBellBackCalculationCount, bellCount)
        }
    }
    @AppStorage("kingHanaBigCount") var bigCount = 0 {
        didSet {
            totalBonus = countSum(bigCount, regCount)
            bigPlayGames = BigPlayGames(big: bigCount)
            totalBigCount = countSum(startBigCountInput, bigCount)
        }
    }
    @AppStorage("kingHanaRegCount") var regCount = 0 {
        didSet {
            totalBonus = countSum(bigCount, regCount)
            totalRegCount = countSum(startRegCountInput, regCount)
        }
    }
    @AppStorage("kingHanaBBSuikaCount") var bbSuikaCount = 0
    @AppStorage("kingHanaBBLampBCount") var bbLampBCount = 0 {
        didSet {
            bbLampCountSum = countSum(bbLampBCount, bbLampYCount, bbLampGCount, bbLampRCount)
        }
    }
    @AppStorage("kingHanaBBLampYCount") var bbLampYCount = 0 {
        didSet {
            bbLampCountSum = countSum(bbLampBCount, bbLampYCount, bbLampGCount, bbLampRCount)
        }
    }
    @AppStorage("kingHanaBBLampGCount") var bbLampGCount = 0 {
        didSet {
            bbLampCountSum = countSum(bbLampBCount, bbLampYCount, bbLampGCount, bbLampRCount)
        }
    }
    @AppStorage("kingHanaBBLampRCount") var bbLampRCount = 0 {
        didSet {
            bbLampCountSum = countSum(bbLampBCount, bbLampYCount, bbLampGCount, bbLampRCount)
        }
    }
    @AppStorage("kingHanaRbLampBCount") var rbLampBCount = 0 {
        didSet {
            rbLampCountSum = countSum(rbLampBCount, rbLampYCount, rbLampGCount, rbLampRCount)
            rbLampKisuCountSum = countSum(rbLampBCount, rbLampGCount)
        }
    }
    @AppStorage("kingHanaRbLampYCount") var rbLampYCount = 0 {
        didSet {
            rbLampCountSum = countSum(rbLampBCount, rbLampYCount, rbLampGCount, rbLampRCount)
            rbLampGusuCountSum = countSum(rbLampYCount, rbLampRCount)
        }
    }
    @AppStorage("kingHanaRbLampGCount") var rbLampGCount = 0 {
        didSet {
            rbLampCountSum = countSum(rbLampBCount, rbLampYCount, rbLampGCount, rbLampRCount)
            rbLampKisuCountSum = countSum(rbLampBCount, rbLampGCount)
        }
    }
    @AppStorage("kingHanaRbLampRCount") var rbLampRCount = 0 {
        didSet {
            rbLampCountSum = countSum(rbLampBCount, rbLampYCount, rbLampGCount, rbLampRCount)
            rbLampGusuCountSum = countSum(rbLampYCount, rbLampRCount)
        }
    }
    @AppStorage("kingHanaCurrentGames") var currentGames = 0 {
        didSet {
            playGames = currentGames - startGameInput
        }
    }
    
    @AppStorage("kingHanaTotalBonus") var totalBonus = 0
    @AppStorage("kingHanaPlayGames") var playGames = 0
    @AppStorage("kingHanaBigPlayGames") var bigPlayGames = 0
    @AppStorage("kingHanaBbLampCountSum") var bbLampCountSum = 0
    @AppStorage("kingHanaRbLampCountSum") var rbLampCountSum = 0
    @AppStorage("kingHanaRbLampKisuCountSum") var rbLampKisuCountSum = 0
    @AppStorage("kingHanaRbLampGusuCountSum") var rbLampGusuCountSum = 0
    
    // ビッグ消化ゲーム数
    private func BigPlayGames(big:Int) -> Int {
        return big * 20
    }
    
    func hanaReset() {
        bellCount = 0
        bigCount = 0
        regCount = 0
        bbSuikaCount = 0
        bbLampBCount = 0
        bbLampYCount = 0
        bbLampGCount = 0
        bbLampRCount = 0
        rbLampBCount = 0
        rbLampYCount = 0
        rbLampGCount = 0
        rbLampRCount = 0
        currentGames = 0
        minusCheck = false
    }
    
    
    // ////////////////////////
    // 実戦 トータル結果
    // ////////////////////////
    @AppStorage("kingHanaTotalBigCount") var totalBigCount = 0 {
        didSet {
            totalBonusCountSum = countSum(totalBigCount, totalRegCount)
        }
    }
        @AppStorage("kingHanaTotalRegCount") var totalRegCount = 0 {
            didSet {
                totalBonusCountSum = countSum(totalBigCount, totalRegCount)
            }
        }
    @AppStorage("kingHanaTotalBellCount") var totalBellCount = 0
    @AppStorage("kingHanaTotalBonusCountSum") var totalBonusCountSum = 0
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("kingHanaMinusCheck") var minusCheck: Bool = false
    @AppStorage("kingHanaSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetKenDataInput()
        resetStartData()
        hanaReset()
    }
}


// //// メモリー1
class KingHanaMemory1: ObservableObject {
    @AppStorage("kingHanaKenBackCalculationEnableMemory1") var kenBackCalculationEnable: Bool = false
    @AppStorage("kingHanaKenGameIputMemory1") var kenGameIput: Int = 0
    @AppStorage("kingHanaKenBigCountInputMemory1") var kenBigCountInput: Int = 0
    @AppStorage("kingHanaKenRegCountInputMemory1") var kenRegCountInput: Int = 0
    @AppStorage("kingHanaKenCoinDifferenceInputMemory1") var kenCoinDifferenceInput: Int = 0
    @AppStorage("kingHanaKenBonusCountSumMemory1") var kenBonusCountSum: Int = 0
    @AppStorage("kingHanaKenBellBackCalculationCountMemory1") var kenBellBackCalculationCount: Int = 0
    @AppStorage("kingHanaStartBackCalculationEnableMemory1") var startBackCalculationEnable: Bool = false
    @AppStorage("kingHanaStartGamesMemory1") var startGameInput: Int = 0
    @AppStorage("kingHanaStartBigCountInputMemory1") var startBigCountInput: Int = 0
    @AppStorage("kingHanaStartRegCountInputMemory1") var startRegCountInput: Int = 0
    @AppStorage("kingHanaStartCoinDifferenceInputMemory1") var startCoinDifferenceInput: Int = 0
    @AppStorage("kingHanaStartBonusCountSumMemory1") var startBonusCountSum: Int = 0
    @AppStorage("kingHanaStartBellBackCalculationCountMemory1") var startBellBackCalculationCount: Int = 0
    @AppStorage("kingHanaBellCountMemory1") var bellCount = 0
    @AppStorage("kingHanaBigCountMemory1") var bigCount = 0
    @AppStorage("kingHanaRegCountMemory1") var regCount = 0
    @AppStorage("kingHanaBBSuikaCountMemory1") var bbSuikaCount = 0
    @AppStorage("kingHanaBBLampBCountMemory1") var bbLampBCount = 0
    @AppStorage("kingHanaBBLampYCountMemory1") var bbLampYCount = 0
    @AppStorage("kingHanaBBLampGCountMemory1") var bbLampGCount = 0
    @AppStorage("kingHanaBBLampRCountMemory1") var bbLampRCount = 0
    @AppStorage("kingHanaRbLampBCountMemory1") var rbLampBCount = 0
    @AppStorage("kingHanaRbLampYCountMemory1") var rbLampYCount = 0
    @AppStorage("kingHanaRbLampGCountMemory1") var rbLampGCount = 0
    @AppStorage("kingHanaRbLampRCountMemory1") var rbLampRCount = 0
    @AppStorage("kingHanaCurrentGamesMemory1") var currentGames = 0
    @AppStorage("kingHanaTotalBonusMemory1") var totalBonus = 0
    @AppStorage("kingHanaPlayGamesMemory1") var playGames = 0
    @AppStorage("kingHanaBigPlayGamesMemory1") var bigPlayGames = 0
    @AppStorage("kingHanaBbLampCountSumMemory1") var bbLampCountSum = 0
    @AppStorage("kingHanaRbLampCountSumMemory1") var rbLampCountSum = 0
    @AppStorage("kingHanaRbLampKisuCountSumMemory1") var rbLampKisuCountSum = 0
    @AppStorage("kingHanaRbLampGusuCountSumMemory1") var rbLampGusuCountSum = 0
    @AppStorage("kingHanaTotalBigCountMemory1") var totalBigCount = 0
    @AppStorage("kingHanaTotalRegCountMemory1") var totalRegCount = 0
    @AppStorage("kingHanaTotalBellCountMemory1") var totalBellCount = 0
    @AppStorage("kingHanaTotalBonusCountSumMemory1") var totalBonusCountSum = 0
    @AppStorage("kingHanaMemoMemory1") var memo = ""
    @AppStorage("kingHanaDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class KingHanaMemory2: ObservableObject {
    @AppStorage("kingHanaKenBackCalculationEnableMemory2") var kenBackCalculationEnable: Bool = false
    @AppStorage("kingHanaKenGameIputMemory2") var kenGameIput: Int = 0
    @AppStorage("kingHanaKenBigCountInputMemory2") var kenBigCountInput: Int = 0
    @AppStorage("kingHanaKenRegCountInputMemory2") var kenRegCountInput: Int = 0
    @AppStorage("kingHanaKenCoinDifferenceInputMemory2") var kenCoinDifferenceInput: Int = 0
    @AppStorage("kingHanaKenBonusCountSumMemory2") var kenBonusCountSum: Int = 0
    @AppStorage("kingHanaKenBellBackCalculationCountMemory2") var kenBellBackCalculationCount: Int = 0
    @AppStorage("kingHanaStartBackCalculationEnableMemory2") var startBackCalculationEnable: Bool = false
    @AppStorage("kingHanaStartGamesMemory2") var startGameInput: Int = 0
    @AppStorage("kingHanaStartBigCountInputMemory2") var startBigCountInput: Int = 0
    @AppStorage("kingHanaStartRegCountInputMemory2") var startRegCountInput: Int = 0
    @AppStorage("kingHanaStartCoinDifferenceInputMemory2") var startCoinDifferenceInput: Int = 0
    @AppStorage("kingHanaStartBonusCountSumMemory2") var startBonusCountSum: Int = 0
    @AppStorage("kingHanaStartBellBackCalculationCountMemory2") var startBellBackCalculationCount: Int = 0
    @AppStorage("kingHanaBellCountMemory2") var bellCount = 0
    @AppStorage("kingHanaBigCountMemory2") var bigCount = 0
    @AppStorage("kingHanaRegCountMemory2") var regCount = 0
    @AppStorage("kingHanaBBSuikaCountMemory2") var bbSuikaCount = 0
    @AppStorage("kingHanaBBLampBCountMemory2") var bbLampBCount = 0
    @AppStorage("kingHanaBBLampYCountMemory2") var bbLampYCount = 0
    @AppStorage("kingHanaBBLampGCountMemory2") var bbLampGCount = 0
    @AppStorage("kingHanaBBLampRCountMemory2") var bbLampRCount = 0
    @AppStorage("kingHanaRbLampBCountMemory2") var rbLampBCount = 0
    @AppStorage("kingHanaRbLampYCountMemory2") var rbLampYCount = 0
    @AppStorage("kingHanaRbLampGCountMemory2") var rbLampGCount = 0
    @AppStorage("kingHanaRbLampRCountMemory2") var rbLampRCount = 0
    @AppStorage("kingHanaCurrentGamesMemory2") var currentGames = 0
    @AppStorage("kingHanaTotalBonusMemory2") var totalBonus = 0
    @AppStorage("kingHanaPlayGamesMemory2") var playGames = 0
    @AppStorage("kingHanaBigPlayGamesMemory2") var bigPlayGames = 0
    @AppStorage("kingHanaBbLampCountSumMemory2") var bbLampCountSum = 0
    @AppStorage("kingHanaRbLampCountSumMemory2") var rbLampCountSum = 0
    @AppStorage("kingHanaRbLampKisuCountSumMemory2") var rbLampKisuCountSum = 0
    @AppStorage("kingHanaRbLampGusuCountSumMemory2") var rbLampGusuCountSum = 0
    @AppStorage("kingHanaTotalBigCountMemory2") var totalBigCount = 0
    @AppStorage("kingHanaTotalRegCountMemory2") var totalRegCount = 0
    @AppStorage("kingHanaTotalBellCountMemory2") var totalBellCount = 0
    @AppStorage("kingHanaTotalBonusCountSumMemory2") var totalBonusCountSum = 0
    @AppStorage("kingHanaMemoMemory2") var memo = ""
    @AppStorage("kingHanaDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class KingHanaMemory3: ObservableObject {
    @AppStorage("kingHanaKenBackCalculationEnableMemory3") var kenBackCalculationEnable: Bool = false
    @AppStorage("kingHanaKenGameIputMemory3") var kenGameIput: Int = 0
    @AppStorage("kingHanaKenBigCountInputMemory3") var kenBigCountInput: Int = 0
    @AppStorage("kingHanaKenRegCountInputMemory3") var kenRegCountInput: Int = 0
    @AppStorage("kingHanaKenCoinDifferenceInputMemory3") var kenCoinDifferenceInput: Int = 0
    @AppStorage("kingHanaKenBonusCountSumMemory3") var kenBonusCountSum: Int = 0
    @AppStorage("kingHanaKenBellBackCalculationCountMemory3") var kenBellBackCalculationCount: Int = 0
    @AppStorage("kingHanaStartBackCalculationEnableMemory3") var startBackCalculationEnable: Bool = false
    @AppStorage("kingHanaStartGamesMemory3") var startGameInput: Int = 0
    @AppStorage("kingHanaStartBigCountInputMemory3") var startBigCountInput: Int = 0
    @AppStorage("kingHanaStartRegCountInputMemory3") var startRegCountInput: Int = 0
    @AppStorage("kingHanaStartCoinDifferenceInputMemory3") var startCoinDifferenceInput: Int = 0
    @AppStorage("kingHanaStartBonusCountSumMemory3") var startBonusCountSum: Int = 0
    @AppStorage("kingHanaStartBellBackCalculationCountMemory3") var startBellBackCalculationCount: Int = 0
    @AppStorage("kingHanaBellCountMemory3") var bellCount = 0
    @AppStorage("kingHanaBigCountMemory3") var bigCount = 0
    @AppStorage("kingHanaRegCountMemory3") var regCount = 0
    @AppStorage("kingHanaBBSuikaCountMemory3") var bbSuikaCount = 0
    @AppStorage("kingHanaBBLampBCountMemory3") var bbLampBCount = 0
    @AppStorage("kingHanaBBLampYCountMemory3") var bbLampYCount = 0
    @AppStorage("kingHanaBBLampGCountMemory3") var bbLampGCount = 0
    @AppStorage("kingHanaBBLampRCountMemory3") var bbLampRCount = 0
    @AppStorage("kingHanaRbLampBCountMemory3") var rbLampBCount = 0
    @AppStorage("kingHanaRbLampYCountMemory3") var rbLampYCount = 0
    @AppStorage("kingHanaRbLampGCountMemory3") var rbLampGCount = 0
    @AppStorage("kingHanaRbLampRCountMemory3") var rbLampRCount = 0
    @AppStorage("kingHanaCurrentGamesMemory3") var currentGames = 0
    @AppStorage("kingHanaTotalBonusMemory3") var totalBonus = 0
    @AppStorage("kingHanaPlayGamesMemory3") var playGames = 0
    @AppStorage("kingHanaBigPlayGamesMemory3") var bigPlayGames = 0
    @AppStorage("kingHanaBbLampCountSumMemory3") var bbLampCountSum = 0
    @AppStorage("kingHanaRbLampCountSumMemory3") var rbLampCountSum = 0
    @AppStorage("kingHanaRbLampKisuCountSumMemory3") var rbLampKisuCountSum = 0
    @AppStorage("kingHanaRbLampGusuCountSumMemory3") var rbLampGusuCountSum = 0
    @AppStorage("kingHanaTotalBigCountMemory3") var totalBigCount = 0
    @AppStorage("kingHanaTotalRegCountMemory3") var totalRegCount = 0
    @AppStorage("kingHanaTotalBellCountMemory3") var totalBellCount = 0
    @AppStorage("kingHanaTotalBonusCountSumMemory3") var totalBonusCountSum = 0
    @AppStorage("kingHanaMemoMemory3") var memo = ""
    @AppStorage("kingHanaDateMemory3") var dateDouble = 0.0
}

struct kingHanaVer2ViewTop: View {
    @ObservedObject var ver391: Ver391
    @StateObject var kingHana = KingHana()
    @State var isShowAlert: Bool = false
    @StateObject var kingHanaMemory1 = KingHanaMemory1()
    @StateObject var kingHanaMemory2 = KingHanaMemory2()
    @StateObject var kingHanaMemory3 = KingHanaMemory3()
    @ObservedObject var bayes: Bayes
    @StateObject var viewModel: InterstitialViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    
                } header: {
                    unitLabelMachineTopTitle(machineName: "キングハナハナ")
                }
                
                // //// 見
                Section {
                    // データ入力
                    NavigationLink(destination: kingHanaVer2ViewKenDataInput(kingHana: kingHana)) {
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
                .popoverTip(tipUnitJugHanaCommonKenView())
                // //// 実戦
                Section {
                    // データ入力
                    NavigationLink(destination: kingHanaVer2ViewJissenStartData(kingHana: kingHana)) {
                        unitLabelMenu(
                            imageSystemName: "airplane.departure",
                            textBody: "打ち始めデータ"
                        )
                    }
                    // 実戦カウント
                    NavigationLink(destination: kingHanaVer2ViewJissenCount(
                        ver391: ver391,
                        kingHana: kingHana,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "arcade.stick.and.arrow.down",
                            textBody: "実戦カウント"
                        )
                    }
                    // トータル結果確認
                    NavigationLink(destination: kingHanaVer2ViewJissenTotalDataCheck(
                        ver391: ver391,
                        kingHana: kingHana,
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
                NavigationLink(destination: kingHanaVer2View95CiTotal(kingHana: kingHana)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 設定期待値計算
                NavigationLink(destination: kingHanaViewBayes(
                    ver391: ver391,
                    kingHana: kingHana,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: ver391.kingHanaMenuBayesBadge,
                    )
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4311")
//                    .popoverTip(tipVer220AddLink())
                
                // コピーライト
                unitSectionCopyright {
                    Text("©PIONEER")
                }
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "キングハナハナ",
                screenClass: screenClass
            )
        }
        // 画面ログイベントの収集
//        .onAppear {
//            // Viewが表示されたタイミングでログを送信します
//            Analytics.logEvent(AnalyticsEventScreenView, parameters: [
//                AnalyticsParameterScreenName: "キングハナハナ", // この画面の名前を識別できるように設定
//                AnalyticsParameterScreenClass: "kingHanaVer2ViewTop" // 通常はViewのクラス名（構造体名）を設定
//                // その他、この画面に関連するパラメータを追加できます
//            ])
//            print("Firebase Analytics: kingHanaVer2ViewTop appeared.") // デバッグ用にログ出力
//        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(kingHanaSubViewLoadMemory(
                        kingHana: kingHana,
                        kingHanaMemory1: kingHanaMemory1,
                        kingHanaMemory2: kingHanaMemory2,
                        kingHanaMemory3: kingHanaMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(kingHanaSubViewSaveMemory(
                        kingHana: kingHana,
                        kingHanaMemory1: kingHanaMemory1,
                        kingHanaMemory2: kingHanaMemory2,
                        kingHanaMemory3: kingHanaMemory3
                    )))
                }
//                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: kingHana.resetAll, message: "この機種のデータを全てリセットします")
//                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct kingHanaSubViewSaveMemory: View {
    @ObservedObject var kingHana: KingHana
    @ObservedObject var kingHanaMemory1: KingHanaMemory1
    @ObservedObject var kingHanaMemory2: KingHanaMemory2
    @ObservedObject var kingHanaMemory3: KingHanaMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "キングハナハナ",
            selectedMemory: $kingHana.selectedMemory,
            memoMemory1: $kingHanaMemory1.memo,
            dateDoubleMemory1: $kingHanaMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $kingHanaMemory2.memo,
            dateDoubleMemory2: $kingHanaMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $kingHanaMemory3.memo,
            dateDoubleMemory3: $kingHanaMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        kingHanaMemory1.kenBackCalculationEnable = kingHana.kenBackCalculationEnable
        kingHanaMemory1.kenGameIput = kingHana.kenGameIput
        kingHanaMemory1.kenBigCountInput = kingHana.kenBigCountInput
        kingHanaMemory1.kenRegCountInput = kingHana.kenRegCountInput
        kingHanaMemory1.kenCoinDifferenceInput = kingHana.kenCoinDifferenceInput
        kingHanaMemory1.kenBonusCountSum = kingHana.kenBonusCountSum
        kingHanaMemory1.kenBellBackCalculationCount = kingHana.kenBellBackCalculationCount
        kingHanaMemory1.startBackCalculationEnable = kingHana.startBackCalculationEnable
        kingHanaMemory1.startGameInput = kingHana.startGameInput
        kingHanaMemory1.startBigCountInput = kingHana.startBigCountInput
        kingHanaMemory1.startRegCountInput = kingHana.startRegCountInput
        kingHanaMemory1.startCoinDifferenceInput = kingHana.startCoinDifferenceInput
        kingHanaMemory1.startBonusCountSum = kingHana.startBonusCountSum
        kingHanaMemory1.startBellBackCalculationCount = kingHana.startBellBackCalculationCount
        kingHanaMemory1.bellCount = kingHana.bellCount
        kingHanaMemory1.bigCount = kingHana.bigCount
        kingHanaMemory1.regCount = kingHana.regCount
        kingHanaMemory1.bbSuikaCount = kingHana.bbSuikaCount
        kingHanaMemory1.bbLampBCount = kingHana.bbLampBCount
        kingHanaMemory1.bbLampYCount = kingHana.bbLampYCount
        kingHanaMemory1.bbLampGCount = kingHana.bbLampGCount
        kingHanaMemory1.bbLampRCount = kingHana.bbLampRCount
        kingHanaMemory1.rbLampBCount = kingHana.rbLampBCount
        kingHanaMemory1.rbLampYCount = kingHana.rbLampYCount
        kingHanaMemory1.rbLampGCount = kingHana.rbLampGCount
        kingHanaMemory1.rbLampRCount = kingHana.rbLampRCount
        kingHanaMemory1.currentGames = kingHana.currentGames
        kingHanaMemory1.totalBonus = kingHana.totalBonus
        kingHanaMemory1.playGames = kingHana.playGames
        kingHanaMemory1.bigPlayGames = kingHana.bigPlayGames
        kingHanaMemory1.bbLampCountSum = kingHana.bbLampCountSum
        kingHanaMemory1.rbLampCountSum = kingHana.rbLampCountSum
        kingHanaMemory1.rbLampKisuCountSum = kingHana.rbLampKisuCountSum
        kingHanaMemory1.rbLampGusuCountSum = kingHana.rbLampGusuCountSum
        kingHanaMemory1.totalBigCount = kingHana.totalBigCount
        kingHanaMemory1.totalRegCount = kingHana.totalRegCount
        kingHanaMemory1.totalBellCount = kingHana.totalBellCount
        kingHanaMemory1.totalBonusCountSum = kingHana.totalBonusCountSum
    }
    func saveMemory2() {
        kingHanaMemory2.kenBackCalculationEnable = kingHana.kenBackCalculationEnable
        kingHanaMemory2.kenGameIput = kingHana.kenGameIput
        kingHanaMemory2.kenBigCountInput = kingHana.kenBigCountInput
        kingHanaMemory2.kenRegCountInput = kingHana.kenRegCountInput
        kingHanaMemory2.kenCoinDifferenceInput = kingHana.kenCoinDifferenceInput
        kingHanaMemory2.kenBonusCountSum = kingHana.kenBonusCountSum
        kingHanaMemory2.kenBellBackCalculationCount = kingHana.kenBellBackCalculationCount
        kingHanaMemory2.startBackCalculationEnable = kingHana.startBackCalculationEnable
        kingHanaMemory2.startGameInput = kingHana.startGameInput
        kingHanaMemory2.startBigCountInput = kingHana.startBigCountInput
        kingHanaMemory2.startRegCountInput = kingHana.startRegCountInput
        kingHanaMemory2.startCoinDifferenceInput = kingHana.startCoinDifferenceInput
        kingHanaMemory2.startBonusCountSum = kingHana.startBonusCountSum
        kingHanaMemory2.startBellBackCalculationCount = kingHana.startBellBackCalculationCount
        kingHanaMemory2.bellCount = kingHana.bellCount
        kingHanaMemory2.bigCount = kingHana.bigCount
        kingHanaMemory2.regCount = kingHana.regCount
        kingHanaMemory2.bbSuikaCount = kingHana.bbSuikaCount
        kingHanaMemory2.bbLampBCount = kingHana.bbLampBCount
        kingHanaMemory2.bbLampYCount = kingHana.bbLampYCount
        kingHanaMemory2.bbLampGCount = kingHana.bbLampGCount
        kingHanaMemory2.bbLampRCount = kingHana.bbLampRCount
        kingHanaMemory2.rbLampBCount = kingHana.rbLampBCount
        kingHanaMemory2.rbLampYCount = kingHana.rbLampYCount
        kingHanaMemory2.rbLampGCount = kingHana.rbLampGCount
        kingHanaMemory2.rbLampRCount = kingHana.rbLampRCount
        kingHanaMemory2.currentGames = kingHana.currentGames
        kingHanaMemory2.totalBonus = kingHana.totalBonus
        kingHanaMemory2.playGames = kingHana.playGames
        kingHanaMemory2.bigPlayGames = kingHana.bigPlayGames
        kingHanaMemory2.bbLampCountSum = kingHana.bbLampCountSum
        kingHanaMemory2.rbLampCountSum = kingHana.rbLampCountSum
        kingHanaMemory2.rbLampKisuCountSum = kingHana.rbLampKisuCountSum
        kingHanaMemory2.rbLampGusuCountSum = kingHana.rbLampGusuCountSum
        kingHanaMemory2.totalBigCount = kingHana.totalBigCount
        kingHanaMemory2.totalRegCount = kingHana.totalRegCount
        kingHanaMemory2.totalBellCount = kingHana.totalBellCount
        kingHanaMemory2.totalBonusCountSum = kingHana.totalBonusCountSum
    }
    func saveMemory3() {
        kingHanaMemory3.kenBackCalculationEnable = kingHana.kenBackCalculationEnable
        kingHanaMemory3.kenGameIput = kingHana.kenGameIput
        kingHanaMemory3.kenBigCountInput = kingHana.kenBigCountInput
        kingHanaMemory3.kenRegCountInput = kingHana.kenRegCountInput
        kingHanaMemory3.kenCoinDifferenceInput = kingHana.kenCoinDifferenceInput
        kingHanaMemory3.kenBonusCountSum = kingHana.kenBonusCountSum
        kingHanaMemory3.kenBellBackCalculationCount = kingHana.kenBellBackCalculationCount
        kingHanaMemory3.startBackCalculationEnable = kingHana.startBackCalculationEnable
        kingHanaMemory3.startGameInput = kingHana.startGameInput
        kingHanaMemory3.startBigCountInput = kingHana.startBigCountInput
        kingHanaMemory3.startRegCountInput = kingHana.startRegCountInput
        kingHanaMemory3.startCoinDifferenceInput = kingHana.startCoinDifferenceInput
        kingHanaMemory3.startBonusCountSum = kingHana.startBonusCountSum
        kingHanaMemory3.startBellBackCalculationCount = kingHana.startBellBackCalculationCount
        kingHanaMemory3.bellCount = kingHana.bellCount
        kingHanaMemory3.bigCount = kingHana.bigCount
        kingHanaMemory3.regCount = kingHana.regCount
        kingHanaMemory3.bbSuikaCount = kingHana.bbSuikaCount
        kingHanaMemory3.bbLampBCount = kingHana.bbLampBCount
        kingHanaMemory3.bbLampYCount = kingHana.bbLampYCount
        kingHanaMemory3.bbLampGCount = kingHana.bbLampGCount
        kingHanaMemory3.bbLampRCount = kingHana.bbLampRCount
        kingHanaMemory3.rbLampBCount = kingHana.rbLampBCount
        kingHanaMemory3.rbLampYCount = kingHana.rbLampYCount
        kingHanaMemory3.rbLampGCount = kingHana.rbLampGCount
        kingHanaMemory3.rbLampRCount = kingHana.rbLampRCount
        kingHanaMemory3.currentGames = kingHana.currentGames
        kingHanaMemory3.totalBonus = kingHana.totalBonus
        kingHanaMemory3.playGames = kingHana.playGames
        kingHanaMemory3.bigPlayGames = kingHana.bigPlayGames
        kingHanaMemory3.bbLampCountSum = kingHana.bbLampCountSum
        kingHanaMemory3.rbLampCountSum = kingHana.rbLampCountSum
        kingHanaMemory3.rbLampKisuCountSum = kingHana.rbLampKisuCountSum
        kingHanaMemory3.rbLampGusuCountSum = kingHana.rbLampGusuCountSum
        kingHanaMemory3.totalBigCount = kingHana.totalBigCount
        kingHanaMemory3.totalRegCount = kingHana.totalRegCount
        kingHanaMemory3.totalBellCount = kingHana.totalBellCount
        kingHanaMemory3.totalBonusCountSum = kingHana.totalBonusCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct kingHanaSubViewLoadMemory: View {
    @ObservedObject var kingHana: KingHana
    @ObservedObject var kingHanaMemory1: KingHanaMemory1
    @ObservedObject var kingHanaMemory2: KingHanaMemory2
    @ObservedObject var kingHanaMemory3: KingHanaMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "キングハナハナ",
            selectedMemory: $kingHana.selectedMemory,
            memoMemory1: kingHanaMemory1.memo,
            dateDoubleMemory1: kingHanaMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: kingHanaMemory2.memo,
            dateDoubleMemory2: kingHanaMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: kingHanaMemory3.memo,
            dateDoubleMemory3: kingHanaMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        kingHana.kenBackCalculationEnable = kingHanaMemory1.kenBackCalculationEnable
        kingHana.kenGameIput = kingHanaMemory1.kenGameIput
        kingHana.kenBigCountInput = kingHanaMemory1.kenBigCountInput
        kingHana.kenRegCountInput = kingHanaMemory1.kenRegCountInput
        kingHana.kenCoinDifferenceInput = kingHanaMemory1.kenCoinDifferenceInput
        kingHana.kenBonusCountSum = kingHanaMemory1.kenBonusCountSum
        kingHana.kenBellBackCalculationCount = kingHanaMemory1.kenBellBackCalculationCount
        kingHana.startBackCalculationEnable = kingHanaMemory1.startBackCalculationEnable
        kingHana.startGameInput = kingHanaMemory1.startGameInput
        kingHana.startBigCountInput = kingHanaMemory1.startBigCountInput
        kingHana.startRegCountInput = kingHanaMemory1.startRegCountInput
        kingHana.startCoinDifferenceInput = kingHanaMemory1.startCoinDifferenceInput
        kingHana.startBonusCountSum = kingHanaMemory1.startBonusCountSum
        kingHana.startBellBackCalculationCount = kingHanaMemory1.startBellBackCalculationCount
        kingHana.bellCount = kingHanaMemory1.bellCount
        kingHana.bigCount = kingHanaMemory1.bigCount
        kingHana.regCount = kingHanaMemory1.regCount
        kingHana.bbSuikaCount = kingHanaMemory1.bbSuikaCount
        kingHana.bbLampBCount = kingHanaMemory1.bbLampBCount
        kingHana.bbLampYCount = kingHanaMemory1.bbLampYCount
        kingHana.bbLampGCount = kingHanaMemory1.bbLampGCount
        kingHana.bbLampRCount = kingHanaMemory1.bbLampRCount
        kingHana.rbLampBCount = kingHanaMemory1.rbLampBCount
        kingHana.rbLampYCount = kingHanaMemory1.rbLampYCount
        kingHana.rbLampGCount = kingHanaMemory1.rbLampGCount
        kingHana.rbLampRCount = kingHanaMemory1.rbLampRCount
        kingHana.currentGames = kingHanaMemory1.currentGames
        kingHana.totalBonus = kingHanaMemory1.totalBonus
        kingHana.playGames = kingHanaMemory1.playGames
        kingHana.bigPlayGames = kingHanaMemory1.bigPlayGames
        kingHana.bbLampCountSum = kingHanaMemory1.bbLampCountSum
        kingHana.rbLampCountSum = kingHanaMemory1.rbLampCountSum
        kingHana.rbLampKisuCountSum = kingHanaMemory1.rbLampKisuCountSum
        kingHana.rbLampGusuCountSum = kingHanaMemory1.rbLampGusuCountSum
        kingHana.totalBigCount = kingHanaMemory1.totalBigCount
        kingHana.totalRegCount = kingHanaMemory1.totalRegCount
        kingHana.totalBellCount = kingHanaMemory1.totalBellCount
        kingHana.totalBonusCountSum = kingHanaMemory1.totalBonusCountSum
    }
    func loadMemory2() {
        kingHana.kenBackCalculationEnable = kingHanaMemory2.kenBackCalculationEnable
        kingHana.kenGameIput = kingHanaMemory2.kenGameIput
        kingHana.kenBigCountInput = kingHanaMemory2.kenBigCountInput
        kingHana.kenRegCountInput = kingHanaMemory2.kenRegCountInput
        kingHana.kenCoinDifferenceInput = kingHanaMemory2.kenCoinDifferenceInput
        kingHana.kenBonusCountSum = kingHanaMemory2.kenBonusCountSum
        kingHana.kenBellBackCalculationCount = kingHanaMemory2.kenBellBackCalculationCount
        kingHana.startBackCalculationEnable = kingHanaMemory2.startBackCalculationEnable
        kingHana.startGameInput = kingHanaMemory2.startGameInput
        kingHana.startBigCountInput = kingHanaMemory2.startBigCountInput
        kingHana.startRegCountInput = kingHanaMemory2.startRegCountInput
        kingHana.startCoinDifferenceInput = kingHanaMemory2.startCoinDifferenceInput
        kingHana.startBonusCountSum = kingHanaMemory2.startBonusCountSum
        kingHana.startBellBackCalculationCount = kingHanaMemory2.startBellBackCalculationCount
        kingHana.bellCount = kingHanaMemory2.bellCount
        kingHana.bigCount = kingHanaMemory2.bigCount
        kingHana.regCount = kingHanaMemory2.regCount
        kingHana.bbSuikaCount = kingHanaMemory2.bbSuikaCount
        kingHana.bbLampBCount = kingHanaMemory2.bbLampBCount
        kingHana.bbLampYCount = kingHanaMemory2.bbLampYCount
        kingHana.bbLampGCount = kingHanaMemory2.bbLampGCount
        kingHana.bbLampRCount = kingHanaMemory2.bbLampRCount
        kingHana.rbLampBCount = kingHanaMemory2.rbLampBCount
        kingHana.rbLampYCount = kingHanaMemory2.rbLampYCount
        kingHana.rbLampGCount = kingHanaMemory2.rbLampGCount
        kingHana.rbLampRCount = kingHanaMemory2.rbLampRCount
        kingHana.currentGames = kingHanaMemory2.currentGames
        kingHana.totalBonus = kingHanaMemory2.totalBonus
        kingHana.playGames = kingHanaMemory2.playGames
        kingHana.bigPlayGames = kingHanaMemory2.bigPlayGames
        kingHana.bbLampCountSum = kingHanaMemory2.bbLampCountSum
        kingHana.rbLampCountSum = kingHanaMemory2.rbLampCountSum
        kingHana.rbLampKisuCountSum = kingHanaMemory2.rbLampKisuCountSum
        kingHana.rbLampGusuCountSum = kingHanaMemory2.rbLampGusuCountSum
        kingHana.totalBigCount = kingHanaMemory2.totalBigCount
        kingHana.totalRegCount = kingHanaMemory2.totalRegCount
        kingHana.totalBellCount = kingHanaMemory2.totalBellCount
        kingHana.totalBonusCountSum = kingHanaMemory2.totalBonusCountSum
    }
    func loadMemory3() {
        kingHana.kenBackCalculationEnable = kingHanaMemory3.kenBackCalculationEnable
        kingHana.kenGameIput = kingHanaMemory3.kenGameIput
        kingHana.kenBigCountInput = kingHanaMemory3.kenBigCountInput
        kingHana.kenRegCountInput = kingHanaMemory3.kenRegCountInput
        kingHana.kenCoinDifferenceInput = kingHanaMemory3.kenCoinDifferenceInput
        kingHana.kenBonusCountSum = kingHanaMemory3.kenBonusCountSum
        kingHana.kenBellBackCalculationCount = kingHanaMemory3.kenBellBackCalculationCount
        kingHana.startBackCalculationEnable = kingHanaMemory3.startBackCalculationEnable
        kingHana.startGameInput = kingHanaMemory3.startGameInput
        kingHana.startBigCountInput = kingHanaMemory3.startBigCountInput
        kingHana.startRegCountInput = kingHanaMemory3.startRegCountInput
        kingHana.startCoinDifferenceInput = kingHanaMemory3.startCoinDifferenceInput
        kingHana.startBonusCountSum = kingHanaMemory3.startBonusCountSum
        kingHana.startBellBackCalculationCount = kingHanaMemory3.startBellBackCalculationCount
        kingHana.bellCount = kingHanaMemory3.bellCount
        kingHana.bigCount = kingHanaMemory3.bigCount
        kingHana.regCount = kingHanaMemory3.regCount
        kingHana.bbSuikaCount = kingHanaMemory3.bbSuikaCount
        kingHana.bbLampBCount = kingHanaMemory3.bbLampBCount
        kingHana.bbLampYCount = kingHanaMemory3.bbLampYCount
        kingHana.bbLampGCount = kingHanaMemory3.bbLampGCount
        kingHana.bbLampRCount = kingHanaMemory3.bbLampRCount
        kingHana.rbLampBCount = kingHanaMemory3.rbLampBCount
        kingHana.rbLampYCount = kingHanaMemory3.rbLampYCount
        kingHana.rbLampGCount = kingHanaMemory3.rbLampGCount
        kingHana.rbLampRCount = kingHanaMemory3.rbLampRCount
        kingHana.currentGames = kingHanaMemory3.currentGames
        kingHana.totalBonus = kingHanaMemory3.totalBonus
        kingHana.playGames = kingHanaMemory3.playGames
        kingHana.bigPlayGames = kingHanaMemory3.bigPlayGames
        kingHana.bbLampCountSum = kingHanaMemory3.bbLampCountSum
        kingHana.rbLampCountSum = kingHanaMemory3.rbLampCountSum
        kingHana.rbLampKisuCountSum = kingHanaMemory3.rbLampKisuCountSum
        kingHana.rbLampGusuCountSum = kingHanaMemory3.rbLampGusuCountSum
        kingHana.totalBigCount = kingHanaMemory3.totalBigCount
        kingHana.totalRegCount = kingHanaMemory3.totalRegCount
        kingHana.totalBellCount = kingHanaMemory3.totalBellCount
        kingHana.totalBonusCountSum = kingHanaMemory3.totalBonusCountSum
    }
}

#Preview {
    kingHanaVer2ViewTop(
        ver391: Ver391(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
