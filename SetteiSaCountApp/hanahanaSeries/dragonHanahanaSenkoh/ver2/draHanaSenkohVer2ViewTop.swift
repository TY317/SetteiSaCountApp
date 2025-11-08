//
//  draHanaSenkohVer2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/27.
//

import SwiftUI
import FirebaseAnalytics


// ///////////////////////
// 変数
// ///////////////////////
class DraHanaSenkoh: ObservableObject {
    // ////////////////////////
    // 確率値
    // ////////////////////////
    let denominateListBell: [Double] = [
        7.20,
        7.15,
        7.10,
        7.05,
        7.00,
        6.95
    ]
    let denominateListBig: [Double] = [
        256,
        246,
        235,
        224,
        212,
        199
    ]
    let denominateListReg: [Double] = [
        642,
        585,
        537,
        489,
        442,
        399
    ]
    let denominateListBonusSum: [Double] = [
        183,
        173,
        163,
        153,
        143,
        133
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
    @AppStorage("draHanaSenkohKenBackCalculationEnable") var kenBackCalculationEnable: Bool = false {
        didSet {
            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
        }
    }
        @AppStorage("draHanaSenkohKenGameIput") var kenGameIput: Int = 0 {
            didSet {
                kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
            }
        }
            @AppStorage("draHanaSenkohKenBigCountInput") var kenBigCountInput: Int = 0 {
                didSet {
                    kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                    kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                }
            }
                @AppStorage("draHanaSenkohKenRegCountInput") var kenRegCountInput: Int = 0 {
                    didSet {
                        kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                    }
                }
                    @AppStorage("draHanaSenkohKenCoinDifferenceInput") var kenCoinDifferenceInput: Int = 0 {
                        didSet {
                            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        }
                    }
    @AppStorage("draHanaSenkohKenBonusCountSum") var kenBonusCountSum: Int = 0
    @AppStorage("draHanaSenkohKenBellBackCalculationCount") var kenBellBackCalculationCount: Int = 0
    
    func bellBackCalculate(game: Int, bigCount: Int, regCount: Int, coinDifference: Int) -> Int {
        // 各種確率の定義
        let replayDenominate = 7.298   // リプレイ確率
        let cherryDenominate: Double = 48.0   // チェリー確率
        let suikaDenominate: Double = 160.0   // スイカ確率
        let cherryGetRatio = 0.9   // チェリー奪取率
        let suikaGetRatio: Double = 0.7   // ベル奪取率
        let bigOut: Double = 252   // ビッグ獲得枚数
        let regOut: Double = 96   // REG獲得枚数
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
    @AppStorage("draHanaSenkohStartBackCalculationEnable") var startBackCalculationEnable: Bool = false {
        didSet {
            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
        }
    }
        @AppStorage("draHanaSenkohStartGames") var startGameInput: Int = 0 {
            didSet {
                startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                playGames = currentGames - startGameInput
            }
        }
            @AppStorage("draHanaSenkohStartBigCountInput") var startBigCountInput: Int = 0 {
                didSet {
                    startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                    startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                    totalBigCount = countSum(startBigCountInput, bigCount)
                }
            }
                @AppStorage("draHanaSenkohStartRegCountInput") var startRegCountInput: Int = 0 {
                    didSet {
                        startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                        totalRegCount = countSum(startRegCountInput, regCount)
                    }
                }
                    @AppStorage("draHanaSenkohStartCoinDifferenceInput") var startCoinDifferenceInput: Int = 0 {
                        didSet {
                            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        }
                    }
    @AppStorage("draHanaSenkohStartBonusCountSum") var startBonusCountSum: Int = 0
    @AppStorage("draHanaSenkohStartBellBackCalculationCount") var startBellBackCalculationCount: Int = 0 {
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
    @AppStorage("draHanaSenkohBellCount") var bellCount = 0 {
        didSet {
            totalBellCount = countSum(startBellBackCalculationCount, bellCount)
        }
    }
    @AppStorage("draHanaSenkohBigCount") var bigCount = 0 {
        didSet {
            totalBonus = countSum(bigCount, regCount)
            bigPlayGames = BigPlayGames(big: bigCount)
            totalBigCount = countSum(startBigCountInput, bigCount)
        }
    }
    @AppStorage("draHanaSenkohRegCount") var regCount = 0 {
        didSet {
            totalBonus = countSum(bigCount, regCount)
            totalRegCount = countSum(startRegCountInput, regCount)
        }
    }
    @AppStorage("draHanaSenkohBBSuikaCount") var bbSuikaCount = 0
    @AppStorage("draHanaSenkohBBLampBCount") var bbLampBCount = 0 {
        didSet {
            bbLampCountSum = countSum(bbLampBCount, bbLampYCount, bbLampGCount, bbLampRCount)
        }
    }
    @AppStorage("draHanaSenkohBBLampYCount") var bbLampYCount = 0 {
        didSet {
            bbLampCountSum = countSum(bbLampBCount, bbLampYCount, bbLampGCount, bbLampRCount)
        }
    }
    @AppStorage("draHanaSenkohBBLampGCount") var bbLampGCount = 0 {
        didSet {
            bbLampCountSum = countSum(bbLampBCount, bbLampYCount, bbLampGCount, bbLampRCount)
        }
    }
    @AppStorage("draHanaSenkohBBLampRCount") var bbLampRCount = 0 {
        didSet {
            bbLampCountSum = countSum(bbLampBCount, bbLampYCount, bbLampGCount, bbLampRCount)
        }
    }
    @AppStorage("draHanaSenkohRbLampBCount") var rbLampBCount = 0 {
        didSet {
            rbLampCountSum = countSum(rbLampBCount, rbLampYCount, rbLampGCount, rbLampRCount)
            rbLampKisuCountSum = countSum(rbLampBCount, rbLampGCount)
        }
    }
    @AppStorage("draHanaSenkohRbLampYCount") var rbLampYCount = 0 {
        didSet {
            rbLampCountSum = countSum(rbLampBCount, rbLampYCount, rbLampGCount, rbLampRCount)
            rbLampGusuCountSum = countSum(rbLampYCount, rbLampRCount)
        }
    }
    @AppStorage("draHanaSenkohRbLampGCount") var rbLampGCount = 0 {
        didSet {
            rbLampCountSum = countSum(rbLampBCount, rbLampYCount, rbLampGCount, rbLampRCount)
            rbLampKisuCountSum = countSum(rbLampBCount, rbLampGCount)
        }
    }
    @AppStorage("draHanaSenkohRbLampRCount") var rbLampRCount = 0 {
        didSet {
            rbLampCountSum = countSum(rbLampBCount, rbLampYCount, rbLampGCount, rbLampRCount)
            rbLampGusuCountSum = countSum(rbLampYCount, rbLampRCount)
        }
    }
    @AppStorage("draHanaSenkohCurrentGames") var currentGames = 0 {
        didSet {
            playGames = currentGames - startGameInput
        }
    }
    
    @AppStorage("draHanaSenkohTotalBonus") var totalBonus = 0
    @AppStorage("draHanaSenkohPlayGames") var playGames = 0
    @AppStorage("draHanaSenkohBigPlayGames") var bigPlayGames = 0
    @AppStorage("draHanaSenkohBbLampCountSum") var bbLampCountSum = 0
    @AppStorage("draHanaSenkohRbLampCountSum") var rbLampCountSum = 0
    @AppStorage("draHanaSenkohRbLampKisuCountSum") var rbLampKisuCountSum = 0
    @AppStorage("draHanaSenkohRbLampGusuCountSum") var rbLampGusuCountSum = 0
    
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
    @AppStorage("draHanaSenkohTotalBigCount") var totalBigCount = 0 {
        didSet {
            totalBonusCountSum = countSum(totalBigCount, totalRegCount)
        }
    }
        @AppStorage("draHanaSenkohTotalRegCount") var totalRegCount = 0 {
            didSet {
                totalBonusCountSum = countSum(totalBigCount, totalRegCount)
            }
        }
    @AppStorage("draHanaSenkohTotalBellCount") var totalBellCount = 0
    @AppStorage("draHanaSenkohTotalBonusCountSum") var totalBonusCountSum = 0
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "ドラゴンハナハナ閃光"
    @AppStorage("draHanaSenkohMinusCheck") var minusCheck: Bool = false
    @AppStorage("draHanaSenkohSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetKenDataInput()
        resetStartData()
        hanaReset()
    }
    
    // ////////
    // 島合算
    // ////////
    @AppStorage("draHanaSenkohShimaGames") var shimaGames: Int = 0
    @AppStorage("draHanaSenkohShimaBigs") var shimaBigs: Int = 0
    @AppStorage("draHanaSenkohShimaRegs") var shimaRegs: Int = 0
    @AppStorage("draHanaSenkohShimaBonusSum") var shimaBonusSum: Int = 0
}


// //// メモリー1
class DraHanaSenkohMemory1: ObservableObject {
    @AppStorage("draHanaSenkohKenBackCalculationEnableMemory1") var kenBackCalculationEnable: Bool = false
    @AppStorage("draHanaSenkohKenGameIputMemory1") var kenGameIput: Int = 0
    @AppStorage("draHanaSenkohKenBigCountInputMemory1") var kenBigCountInput: Int = 0
    @AppStorage("draHanaSenkohKenRegCountInputMemory1") var kenRegCountInput: Int = 0
    @AppStorage("draHanaSenkohKenCoinDifferenceInputMemory1") var kenCoinDifferenceInput: Int = 0
    @AppStorage("draHanaSenkohKenBonusCountSumMemory1") var kenBonusCountSum: Int = 0
    @AppStorage("draHanaSenkohKenBellBackCalculationCountMemory1") var kenBellBackCalculationCount: Int = 0
    @AppStorage("draHanaSenkohStartBackCalculationEnableMemory1") var startBackCalculationEnable: Bool = false
    @AppStorage("draHanaSenkohStartGamesMemory1") var startGameInput: Int = 0
    @AppStorage("draHanaSenkohStartBigCountInputMemory1") var startBigCountInput: Int = 0
    @AppStorage("draHanaSenkohStartRegCountInputMemory1") var startRegCountInput: Int = 0
    @AppStorage("draHanaSenkohStartCoinDifferenceInputMemory1") var startCoinDifferenceInput: Int = 0
    @AppStorage("draHanaSenkohStartBonusCountSumMemory1") var startBonusCountSum: Int = 0
    @AppStorage("draHanaSenkohStartBellBackCalculationCountMemory1") var startBellBackCalculationCount: Int = 0
    @AppStorage("draHanaSenkohBellCountMemory1") var bellCount = 0
    @AppStorage("draHanaSenkohBigCountMemory1") var bigCount = 0
    @AppStorage("draHanaSenkohRegCountMemory1") var regCount = 0
    @AppStorage("draHanaSenkohBBSuikaCountMemory1") var bbSuikaCount = 0
    @AppStorage("draHanaSenkohBBLampBCountMemory1") var bbLampBCount = 0
    @AppStorage("draHanaSenkohBBLampYCountMemory1") var bbLampYCount = 0
    @AppStorage("draHanaSenkohBBLampGCountMemory1") var bbLampGCount = 0
    @AppStorage("draHanaSenkohBBLampRCountMemory1") var bbLampRCount = 0
    @AppStorage("draHanaSenkohRbLampBCountMemory1") var rbLampBCount = 0
    @AppStorage("draHanaSenkohRbLampYCountMemory1") var rbLampYCount = 0
    @AppStorage("draHanaSenkohRbLampGCountMemory1") var rbLampGCount = 0
    @AppStorage("draHanaSenkohRbLampRCountMemory1") var rbLampRCount = 0
    @AppStorage("draHanaSenkohCurrentGamesMemory1") var currentGames = 0
    @AppStorage("draHanaSenkohTotalBonusMemory1") var totalBonus = 0
    @AppStorage("draHanaSenkohPlayGamesMemory1") var playGames = 0
    @AppStorage("draHanaSenkohBigPlayGamesMemory1") var bigPlayGames = 0
    @AppStorage("draHanaSenkohBbLampCountSumMemory1") var bbLampCountSum = 0
    @AppStorage("draHanaSenkohRbLampCountSumMemory1") var rbLampCountSum = 0
    @AppStorage("draHanaSenkohRbLampKisuCountSumMemory1") var rbLampKisuCountSum = 0
    @AppStorage("draHanaSenkohRbLampGusuCountSumMemory1") var rbLampGusuCountSum = 0
    @AppStorage("draHanaSenkohTotalBigCountMemory1") var totalBigCount = 0
    @AppStorage("draHanaSenkohTotalRegCountMemory1") var totalRegCount = 0
    @AppStorage("draHanaSenkohTotalBellCountMemory1") var totalBellCount = 0
    @AppStorage("draHanaSenkohTotalBonusCountSumMemory1") var totalBonusCountSum = 0
    @AppStorage("draHanaSenkohMemoMemory1") var memo = ""
    @AppStorage("draHanaSenkohDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class DraHanaSenkohMemory2: ObservableObject {
    @AppStorage("draHanaSenkohKenBackCalculationEnableMemory2") var kenBackCalculationEnable: Bool = false
    @AppStorage("draHanaSenkohKenGameIputMemory2") var kenGameIput: Int = 0
    @AppStorage("draHanaSenkohKenBigCountInputMemory2") var kenBigCountInput: Int = 0
    @AppStorage("draHanaSenkohKenRegCountInputMemory2") var kenRegCountInput: Int = 0
    @AppStorage("draHanaSenkohKenCoinDifferenceInputMemory2") var kenCoinDifferenceInput: Int = 0
    @AppStorage("draHanaSenkohKenBonusCountSumMemory2") var kenBonusCountSum: Int = 0
    @AppStorage("draHanaSenkohKenBellBackCalculationCountMemory2") var kenBellBackCalculationCount: Int = 0
    @AppStorage("draHanaSenkohStartBackCalculationEnableMemory2") var startBackCalculationEnable: Bool = false
    @AppStorage("draHanaSenkohStartGamesMemory2") var startGameInput: Int = 0
    @AppStorage("draHanaSenkohStartBigCountInputMemory2") var startBigCountInput: Int = 0
    @AppStorage("draHanaSenkohStartRegCountInputMemory2") var startRegCountInput: Int = 0
    @AppStorage("draHanaSenkohStartCoinDifferenceInputMemory2") var startCoinDifferenceInput: Int = 0
    @AppStorage("draHanaSenkohStartBonusCountSumMemory2") var startBonusCountSum: Int = 0
    @AppStorage("draHanaSenkohStartBellBackCalculationCountMemory2") var startBellBackCalculationCount: Int = 0
    @AppStorage("draHanaSenkohBellCountMemory2") var bellCount = 0
    @AppStorage("draHanaSenkohBigCountMemory2") var bigCount = 0
    @AppStorage("draHanaSenkohRegCountMemory2") var regCount = 0
    @AppStorage("draHanaSenkohBBSuikaCountMemory2") var bbSuikaCount = 0
    @AppStorage("draHanaSenkohBBLampBCountMemory2") var bbLampBCount = 0
    @AppStorage("draHanaSenkohBBLampYCountMemory2") var bbLampYCount = 0
    @AppStorage("draHanaSenkohBBLampGCountMemory2") var bbLampGCount = 0
    @AppStorage("draHanaSenkohBBLampRCountMemory2") var bbLampRCount = 0
    @AppStorage("draHanaSenkohRbLampBCountMemory2") var rbLampBCount = 0
    @AppStorage("draHanaSenkohRbLampYCountMemory2") var rbLampYCount = 0
    @AppStorage("draHanaSenkohRbLampGCountMemory2") var rbLampGCount = 0
    @AppStorage("draHanaSenkohRbLampRCountMemory2") var rbLampRCount = 0
    @AppStorage("draHanaSenkohCurrentGamesMemory2") var currentGames = 0
    @AppStorage("draHanaSenkohTotalBonusMemory2") var totalBonus = 0
    @AppStorage("draHanaSenkohPlayGamesMemory2") var playGames = 0
    @AppStorage("draHanaSenkohBigPlayGamesMemory2") var bigPlayGames = 0
    @AppStorage("draHanaSenkohBbLampCountSumMemory2") var bbLampCountSum = 0
    @AppStorage("draHanaSenkohRbLampCountSumMemory2") var rbLampCountSum = 0
    @AppStorage("draHanaSenkohRbLampKisuCountSumMemory2") var rbLampKisuCountSum = 0
    @AppStorage("draHanaSenkohRbLampGusuCountSumMemory2") var rbLampGusuCountSum = 0
    @AppStorage("draHanaSenkohTotalBigCountMemory2") var totalBigCount = 0
    @AppStorage("draHanaSenkohTotalRegCountMemory2") var totalRegCount = 0
    @AppStorage("draHanaSenkohTotalBellCountMemory2") var totalBellCount = 0
    @AppStorage("draHanaSenkohTotalBonusCountSumMemory2") var totalBonusCountSum = 0
    @AppStorage("draHanaSenkohMemoMemory2") var memo = ""
    @AppStorage("draHanaSenkohDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class DraHanaSenkohMemory3: ObservableObject {
    @AppStorage("draHanaSenkohKenBackCalculationEnableMemory3") var kenBackCalculationEnable: Bool = false
    @AppStorage("draHanaSenkohKenGameIputMemory3") var kenGameIput: Int = 0
    @AppStorage("draHanaSenkohKenBigCountInputMemory3") var kenBigCountInput: Int = 0
    @AppStorage("draHanaSenkohKenRegCountInputMemory3") var kenRegCountInput: Int = 0
    @AppStorage("draHanaSenkohKenCoinDifferenceInputMemory3") var kenCoinDifferenceInput: Int = 0
    @AppStorage("draHanaSenkohKenBonusCountSumMemory3") var kenBonusCountSum: Int = 0
    @AppStorage("draHanaSenkohKenBellBackCalculationCountMemory3") var kenBellBackCalculationCount: Int = 0
    @AppStorage("draHanaSenkohStartBackCalculationEnableMemory3") var startBackCalculationEnable: Bool = false
    @AppStorage("draHanaSenkohStartGamesMemory3") var startGameInput: Int = 0
    @AppStorage("draHanaSenkohStartBigCountInputMemory3") var startBigCountInput: Int = 0
    @AppStorage("draHanaSenkohStartRegCountInputMemory3") var startRegCountInput: Int = 0
    @AppStorage("draHanaSenkohStartCoinDifferenceInputMemory3") var startCoinDifferenceInput: Int = 0
    @AppStorage("draHanaSenkohStartBonusCountSumMemory3") var startBonusCountSum: Int = 0
    @AppStorage("draHanaSenkohStartBellBackCalculationCountMemory3") var startBellBackCalculationCount: Int = 0
    @AppStorage("draHanaSenkohBellCountMemory3") var bellCount = 0
    @AppStorage("draHanaSenkohBigCountMemory3") var bigCount = 0
    @AppStorage("draHanaSenkohRegCountMemory3") var regCount = 0
    @AppStorage("draHanaSenkohBBSuikaCountMemory3") var bbSuikaCount = 0
    @AppStorage("draHanaSenkohBBLampBCountMemory3") var bbLampBCount = 0
    @AppStorage("draHanaSenkohBBLampYCountMemory3") var bbLampYCount = 0
    @AppStorage("draHanaSenkohBBLampGCountMemory3") var bbLampGCount = 0
    @AppStorage("draHanaSenkohBBLampRCountMemory3") var bbLampRCount = 0
    @AppStorage("draHanaSenkohRbLampBCountMemory3") var rbLampBCount = 0
    @AppStorage("draHanaSenkohRbLampYCountMemory3") var rbLampYCount = 0
    @AppStorage("draHanaSenkohRbLampGCountMemory3") var rbLampGCount = 0
    @AppStorage("draHanaSenkohRbLampRCountMemory3") var rbLampRCount = 0
    @AppStorage("draHanaSenkohCurrentGamesMemory3") var currentGames = 0
    @AppStorage("draHanaSenkohTotalBonusMemory3") var totalBonus = 0
    @AppStorage("draHanaSenkohPlayGamesMemory3") var playGames = 0
    @AppStorage("draHanaSenkohBigPlayGamesMemory3") var bigPlayGames = 0
    @AppStorage("draHanaSenkohBbLampCountSumMemory3") var bbLampCountSum = 0
    @AppStorage("draHanaSenkohRbLampCountSumMemory3") var rbLampCountSum = 0
    @AppStorage("draHanaSenkohRbLampKisuCountSumMemory3") var rbLampKisuCountSum = 0
    @AppStorage("draHanaSenkohRbLampGusuCountSumMemory3") var rbLampGusuCountSum = 0
    @AppStorage("draHanaSenkohTotalBigCountMemory3") var totalBigCount = 0
    @AppStorage("draHanaSenkohTotalRegCountMemory3") var totalRegCount = 0
    @AppStorage("draHanaSenkohTotalBellCountMemory3") var totalBellCount = 0
    @AppStorage("draHanaSenkohTotalBonusCountSumMemory3") var totalBonusCountSum = 0
    @AppStorage("draHanaSenkohMemoMemory3") var memo = ""
    @AppStorage("draHanaSenkohDateMemory3") var dateDouble = 0.0
}

struct draHanaSenkohVer2ViewTop: View {
    @EnvironmentObject var common: commonVar
    @StateObject var draHanaSenkoh = DraHanaSenkoh()
    @State var isShowAlert: Bool = false
    @StateObject var draHanaSenkohMemory1 = DraHanaSenkohMemory1()
    @StateObject var draHanaSenkohMemory2 = DraHanaSenkohMemory2()
    @StateObject var draHanaSenkohMemory3 = DraHanaSenkohMemory3()
    @ObservedObject var bayes: Bayes
    @StateObject var viewModel: InterstitialViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    
                } header: {
                    unitLabelMachineTopTitle(machineName: "ドラゴンハナハナ閃光")
                }
                
                // //// 見
                Section {
                    // データ入力
                    NavigationLink(destination: draHanaSenkohVer2ViewKenDataInput(draHanaSenkoh: draHanaSenkoh)) {
                        unitLabelMenu(
                            imageSystemName: "magnifyingglass",
                            textBody: "データ確認"
                        )
                    }
                    // 島データ
                    NavigationLink(destination: draHanaSenkohViewShimaData(
                        draHanaSenkoh: draHanaSenkoh,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "waveform.path.ecg.magnifyingglass",
                            textBody: "島データ確認",
                            badgeStatus: common.draHanaSenkohMenuShimaBadge,
                        )
                    }
                } header: {
                    HStack {
                        Text("見")
                            .fontWeight(.bold)
                            .font(.headline)
                        unitToolbarButtonQuestion {
                            unitExView5body2image(
                                title: "見",
                                textBody1: "・空き台のデータ確認にご利用下さい",
                                textBody2: "・データ確認：ぶどう・ベル逆算値はこちらで確認。そのまま打ち始めデータとして登録も可能です",
                                textBody3: "・島データ確認：複数台の合算値はこちらで確認",
                            )
                        }
                    }
                }
//                .popoverTip(tipUnitJugHanaCommonKenView())
                // //// 実戦
                Section {
                    // データ入力
                    NavigationLink(destination: draHanaSenkohVer2ViewJissenStartData(draHanaSenkoh: draHanaSenkoh)) {
                        unitLabelMenu(
                            imageSystemName: "airplane.departure",
                            textBody: "打ち始めデータ"
                        )
                    }
                    // 実戦カウント
                    NavigationLink(destination: draHanaSenkohVer2ViewJissenCount(
//                        ver391: ver391,
                        draHanaSenkoh: draHanaSenkoh,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "arcade.stick.and.arrow.down",
                            textBody: "実戦カウント"
                        )
                    }
                    // トータル結果確認
                    NavigationLink(destination: draHanaSenkohVer2ViewJissenTotalDataCheck(
//                        ver391: ver391,
                        draHanaSenkoh: draHanaSenkoh,
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
                NavigationLink(destination: draHanaSenkohVer2View95CiTotal(draHanaSenkoh: draHanaSenkoh)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 設定期待値計算
                NavigationLink(destination: draHanaSenkohViewBayes(
//                    ver391: ver391,
                    draHanaSenkoh: draHanaSenkoh,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
//                        badgeStatus: ver391.draHanaSenkohMenuBayesBadge,
                    )
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4453")
//                    .popoverTip(tipVer220AddLink())
                
                // コピーライト
                unitSectionCopyright {
                    Text("©PIONEER")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.draHanaSenkohMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ドラゴンハナハナ閃光",
                screenClass: screenClass
            )
        }
        // 画面ログイベントの収集
//        .onAppear {
//            // Viewが表示されたタイミングでログを送信します
//            Analytics.logEvent(AnalyticsEventScreenView, parameters: [
//                AnalyticsParameterScreenName: "ドラゴンハナハナ閃光", // この画面の名前を識別できるように設定
//                AnalyticsParameterScreenClass: "draHanaSenkohVer2ViewTop" // 通常はViewのクラス名（構造体名）を設定
//                // その他、この画面に関連するパラメータを追加できます
//            ])
//            print("Firebase Analytics: draHanaSenkohVer2ViewTop appeared.") // デバッグ用にログ出力
//        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(draHanaSenkohSubViewLoadMemory(
                        draHanaSenkoh: draHanaSenkoh,
                        draHanaSenkohMemory1: draHanaSenkohMemory1,
                        draHanaSenkohMemory2: draHanaSenkohMemory2,
                        draHanaSenkohMemory3: draHanaSenkohMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(draHanaSenkohSubViewSaveMemory(
                        draHanaSenkoh: draHanaSenkoh,
                        draHanaSenkohMemory1: draHanaSenkohMemory1,
                        draHanaSenkohMemory2: draHanaSenkohMemory2,
                        draHanaSenkohMemory3: draHanaSenkohMemory3
                    )))
                }
//                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: draHanaSenkoh.resetAll, message: "この機種のデータを全てリセットします")
//                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct draHanaSenkohSubViewSaveMemory: View {
    @ObservedObject var draHanaSenkoh: DraHanaSenkoh
    @ObservedObject var draHanaSenkohMemory1: DraHanaSenkohMemory1
    @ObservedObject var draHanaSenkohMemory2: DraHanaSenkohMemory2
    @ObservedObject var draHanaSenkohMemory3: DraHanaSenkohMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "ドラゴンハナハナ閃光",
            selectedMemory: $draHanaSenkoh.selectedMemory,
            memoMemory1: $draHanaSenkohMemory1.memo,
            dateDoubleMemory1: $draHanaSenkohMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $draHanaSenkohMemory2.memo,
            dateDoubleMemory2: $draHanaSenkohMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $draHanaSenkohMemory3.memo,
            dateDoubleMemory3: $draHanaSenkohMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        draHanaSenkohMemory1.kenBackCalculationEnable = draHanaSenkoh.kenBackCalculationEnable
        draHanaSenkohMemory1.kenGameIput = draHanaSenkoh.kenGameIput
        draHanaSenkohMemory1.kenBigCountInput = draHanaSenkoh.kenBigCountInput
        draHanaSenkohMemory1.kenRegCountInput = draHanaSenkoh.kenRegCountInput
        draHanaSenkohMemory1.kenCoinDifferenceInput = draHanaSenkoh.kenCoinDifferenceInput
        draHanaSenkohMemory1.kenBonusCountSum = draHanaSenkoh.kenBonusCountSum
        draHanaSenkohMemory1.kenBellBackCalculationCount = draHanaSenkoh.kenBellBackCalculationCount
        draHanaSenkohMemory1.startBackCalculationEnable = draHanaSenkoh.startBackCalculationEnable
        draHanaSenkohMemory1.startGameInput = draHanaSenkoh.startGameInput
        draHanaSenkohMemory1.startBigCountInput = draHanaSenkoh.startBigCountInput
        draHanaSenkohMemory1.startRegCountInput = draHanaSenkoh.startRegCountInput
        draHanaSenkohMemory1.startCoinDifferenceInput = draHanaSenkoh.startCoinDifferenceInput
        draHanaSenkohMemory1.startBonusCountSum = draHanaSenkoh.startBonusCountSum
        draHanaSenkohMemory1.startBellBackCalculationCount = draHanaSenkoh.startBellBackCalculationCount
        draHanaSenkohMemory1.bellCount = draHanaSenkoh.bellCount
        draHanaSenkohMemory1.bigCount = draHanaSenkoh.bigCount
        draHanaSenkohMemory1.regCount = draHanaSenkoh.regCount
        draHanaSenkohMemory1.bbSuikaCount = draHanaSenkoh.bbSuikaCount
        draHanaSenkohMemory1.bbLampBCount = draHanaSenkoh.bbLampBCount
        draHanaSenkohMemory1.bbLampYCount = draHanaSenkoh.bbLampYCount
        draHanaSenkohMemory1.bbLampGCount = draHanaSenkoh.bbLampGCount
        draHanaSenkohMemory1.bbLampRCount = draHanaSenkoh.bbLampRCount
        draHanaSenkohMemory1.rbLampBCount = draHanaSenkoh.rbLampBCount
        draHanaSenkohMemory1.rbLampYCount = draHanaSenkoh.rbLampYCount
        draHanaSenkohMemory1.rbLampGCount = draHanaSenkoh.rbLampGCount
        draHanaSenkohMemory1.rbLampRCount = draHanaSenkoh.rbLampRCount
        draHanaSenkohMemory1.currentGames = draHanaSenkoh.currentGames
        draHanaSenkohMemory1.totalBonus = draHanaSenkoh.totalBonus
        draHanaSenkohMemory1.playGames = draHanaSenkoh.playGames
        draHanaSenkohMemory1.bigPlayGames = draHanaSenkoh.bigPlayGames
        draHanaSenkohMemory1.bbLampCountSum = draHanaSenkoh.bbLampCountSum
        draHanaSenkohMemory1.rbLampCountSum = draHanaSenkoh.rbLampCountSum
        draHanaSenkohMemory1.rbLampKisuCountSum = draHanaSenkoh.rbLampKisuCountSum
        draHanaSenkohMemory1.rbLampGusuCountSum = draHanaSenkoh.rbLampGusuCountSum
        draHanaSenkohMemory1.totalBigCount = draHanaSenkoh.totalBigCount
        draHanaSenkohMemory1.totalRegCount = draHanaSenkoh.totalRegCount
        draHanaSenkohMemory1.totalBellCount = draHanaSenkoh.totalBellCount
        draHanaSenkohMemory1.totalBonusCountSum = draHanaSenkoh.totalBonusCountSum
    }
    func saveMemory2() {
        draHanaSenkohMemory2.kenBackCalculationEnable = draHanaSenkoh.kenBackCalculationEnable
        draHanaSenkohMemory2.kenGameIput = draHanaSenkoh.kenGameIput
        draHanaSenkohMemory2.kenBigCountInput = draHanaSenkoh.kenBigCountInput
        draHanaSenkohMemory2.kenRegCountInput = draHanaSenkoh.kenRegCountInput
        draHanaSenkohMemory2.kenCoinDifferenceInput = draHanaSenkoh.kenCoinDifferenceInput
        draHanaSenkohMemory2.kenBonusCountSum = draHanaSenkoh.kenBonusCountSum
        draHanaSenkohMemory2.kenBellBackCalculationCount = draHanaSenkoh.kenBellBackCalculationCount
        draHanaSenkohMemory2.startBackCalculationEnable = draHanaSenkoh.startBackCalculationEnable
        draHanaSenkohMemory2.startGameInput = draHanaSenkoh.startGameInput
        draHanaSenkohMemory2.startBigCountInput = draHanaSenkoh.startBigCountInput
        draHanaSenkohMemory2.startRegCountInput = draHanaSenkoh.startRegCountInput
        draHanaSenkohMemory2.startCoinDifferenceInput = draHanaSenkoh.startCoinDifferenceInput
        draHanaSenkohMemory2.startBonusCountSum = draHanaSenkoh.startBonusCountSum
        draHanaSenkohMemory2.startBellBackCalculationCount = draHanaSenkoh.startBellBackCalculationCount
        draHanaSenkohMemory2.bellCount = draHanaSenkoh.bellCount
        draHanaSenkohMemory2.bigCount = draHanaSenkoh.bigCount
        draHanaSenkohMemory2.regCount = draHanaSenkoh.regCount
        draHanaSenkohMemory2.bbSuikaCount = draHanaSenkoh.bbSuikaCount
        draHanaSenkohMemory2.bbLampBCount = draHanaSenkoh.bbLampBCount
        draHanaSenkohMemory2.bbLampYCount = draHanaSenkoh.bbLampYCount
        draHanaSenkohMemory2.bbLampGCount = draHanaSenkoh.bbLampGCount
        draHanaSenkohMemory2.bbLampRCount = draHanaSenkoh.bbLampRCount
        draHanaSenkohMemory2.rbLampBCount = draHanaSenkoh.rbLampBCount
        draHanaSenkohMemory2.rbLampYCount = draHanaSenkoh.rbLampYCount
        draHanaSenkohMemory2.rbLampGCount = draHanaSenkoh.rbLampGCount
        draHanaSenkohMemory2.rbLampRCount = draHanaSenkoh.rbLampRCount
        draHanaSenkohMemory2.currentGames = draHanaSenkoh.currentGames
        draHanaSenkohMemory2.totalBonus = draHanaSenkoh.totalBonus
        draHanaSenkohMemory2.playGames = draHanaSenkoh.playGames
        draHanaSenkohMemory2.bigPlayGames = draHanaSenkoh.bigPlayGames
        draHanaSenkohMemory2.bbLampCountSum = draHanaSenkoh.bbLampCountSum
        draHanaSenkohMemory2.rbLampCountSum = draHanaSenkoh.rbLampCountSum
        draHanaSenkohMemory2.rbLampKisuCountSum = draHanaSenkoh.rbLampKisuCountSum
        draHanaSenkohMemory2.rbLampGusuCountSum = draHanaSenkoh.rbLampGusuCountSum
        draHanaSenkohMemory2.totalBigCount = draHanaSenkoh.totalBigCount
        draHanaSenkohMemory2.totalRegCount = draHanaSenkoh.totalRegCount
        draHanaSenkohMemory2.totalBellCount = draHanaSenkoh.totalBellCount
        draHanaSenkohMemory2.totalBonusCountSum = draHanaSenkoh.totalBonusCountSum
    }
    func saveMemory3() {
        draHanaSenkohMemory3.kenBackCalculationEnable = draHanaSenkoh.kenBackCalculationEnable
        draHanaSenkohMemory3.kenGameIput = draHanaSenkoh.kenGameIput
        draHanaSenkohMemory3.kenBigCountInput = draHanaSenkoh.kenBigCountInput
        draHanaSenkohMemory3.kenRegCountInput = draHanaSenkoh.kenRegCountInput
        draHanaSenkohMemory3.kenCoinDifferenceInput = draHanaSenkoh.kenCoinDifferenceInput
        draHanaSenkohMemory3.kenBonusCountSum = draHanaSenkoh.kenBonusCountSum
        draHanaSenkohMemory3.kenBellBackCalculationCount = draHanaSenkoh.kenBellBackCalculationCount
        draHanaSenkohMemory3.startBackCalculationEnable = draHanaSenkoh.startBackCalculationEnable
        draHanaSenkohMemory3.startGameInput = draHanaSenkoh.startGameInput
        draHanaSenkohMemory3.startBigCountInput = draHanaSenkoh.startBigCountInput
        draHanaSenkohMemory3.startRegCountInput = draHanaSenkoh.startRegCountInput
        draHanaSenkohMemory3.startCoinDifferenceInput = draHanaSenkoh.startCoinDifferenceInput
        draHanaSenkohMemory3.startBonusCountSum = draHanaSenkoh.startBonusCountSum
        draHanaSenkohMemory3.startBellBackCalculationCount = draHanaSenkoh.startBellBackCalculationCount
        draHanaSenkohMemory3.bellCount = draHanaSenkoh.bellCount
        draHanaSenkohMemory3.bigCount = draHanaSenkoh.bigCount
        draHanaSenkohMemory3.regCount = draHanaSenkoh.regCount
        draHanaSenkohMemory3.bbSuikaCount = draHanaSenkoh.bbSuikaCount
        draHanaSenkohMemory3.bbLampBCount = draHanaSenkoh.bbLampBCount
        draHanaSenkohMemory3.bbLampYCount = draHanaSenkoh.bbLampYCount
        draHanaSenkohMemory3.bbLampGCount = draHanaSenkoh.bbLampGCount
        draHanaSenkohMemory3.bbLampRCount = draHanaSenkoh.bbLampRCount
        draHanaSenkohMemory3.rbLampBCount = draHanaSenkoh.rbLampBCount
        draHanaSenkohMemory3.rbLampYCount = draHanaSenkoh.rbLampYCount
        draHanaSenkohMemory3.rbLampGCount = draHanaSenkoh.rbLampGCount
        draHanaSenkohMemory3.rbLampRCount = draHanaSenkoh.rbLampRCount
        draHanaSenkohMemory3.currentGames = draHanaSenkoh.currentGames
        draHanaSenkohMemory3.totalBonus = draHanaSenkoh.totalBonus
        draHanaSenkohMemory3.playGames = draHanaSenkoh.playGames
        draHanaSenkohMemory3.bigPlayGames = draHanaSenkoh.bigPlayGames
        draHanaSenkohMemory3.bbLampCountSum = draHanaSenkoh.bbLampCountSum
        draHanaSenkohMemory3.rbLampCountSum = draHanaSenkoh.rbLampCountSum
        draHanaSenkohMemory3.rbLampKisuCountSum = draHanaSenkoh.rbLampKisuCountSum
        draHanaSenkohMemory3.rbLampGusuCountSum = draHanaSenkoh.rbLampGusuCountSum
        draHanaSenkohMemory3.totalBigCount = draHanaSenkoh.totalBigCount
        draHanaSenkohMemory3.totalRegCount = draHanaSenkoh.totalRegCount
        draHanaSenkohMemory3.totalBellCount = draHanaSenkoh.totalBellCount
        draHanaSenkohMemory3.totalBonusCountSum = draHanaSenkoh.totalBonusCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct draHanaSenkohSubViewLoadMemory: View {
    @ObservedObject var draHanaSenkoh: DraHanaSenkoh
    @ObservedObject var draHanaSenkohMemory1: DraHanaSenkohMemory1
    @ObservedObject var draHanaSenkohMemory2: DraHanaSenkohMemory2
    @ObservedObject var draHanaSenkohMemory3: DraHanaSenkohMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "ドラゴンハナハナ閃光",
            selectedMemory: $draHanaSenkoh.selectedMemory,
            memoMemory1: draHanaSenkohMemory1.memo,
            dateDoubleMemory1: draHanaSenkohMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: draHanaSenkohMemory2.memo,
            dateDoubleMemory2: draHanaSenkohMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: draHanaSenkohMemory3.memo,
            dateDoubleMemory3: draHanaSenkohMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        draHanaSenkoh.kenBackCalculationEnable = draHanaSenkohMemory1.kenBackCalculationEnable
        draHanaSenkoh.kenGameIput = draHanaSenkohMemory1.kenGameIput
        draHanaSenkoh.kenBigCountInput = draHanaSenkohMemory1.kenBigCountInput
        draHanaSenkoh.kenRegCountInput = draHanaSenkohMemory1.kenRegCountInput
        draHanaSenkoh.kenCoinDifferenceInput = draHanaSenkohMemory1.kenCoinDifferenceInput
        draHanaSenkoh.kenBonusCountSum = draHanaSenkohMemory1.kenBonusCountSum
        draHanaSenkoh.kenBellBackCalculationCount = draHanaSenkohMemory1.kenBellBackCalculationCount
        draHanaSenkoh.startBackCalculationEnable = draHanaSenkohMemory1.startBackCalculationEnable
        draHanaSenkoh.startGameInput = draHanaSenkohMemory1.startGameInput
        draHanaSenkoh.startBigCountInput = draHanaSenkohMemory1.startBigCountInput
        draHanaSenkoh.startRegCountInput = draHanaSenkohMemory1.startRegCountInput
        draHanaSenkoh.startCoinDifferenceInput = draHanaSenkohMemory1.startCoinDifferenceInput
        draHanaSenkoh.startBonusCountSum = draHanaSenkohMemory1.startBonusCountSum
        draHanaSenkoh.startBellBackCalculationCount = draHanaSenkohMemory1.startBellBackCalculationCount
        draHanaSenkoh.bellCount = draHanaSenkohMemory1.bellCount
        draHanaSenkoh.bigCount = draHanaSenkohMemory1.bigCount
        draHanaSenkoh.regCount = draHanaSenkohMemory1.regCount
        draHanaSenkoh.bbSuikaCount = draHanaSenkohMemory1.bbSuikaCount
        draHanaSenkoh.bbLampBCount = draHanaSenkohMemory1.bbLampBCount
        draHanaSenkoh.bbLampYCount = draHanaSenkohMemory1.bbLampYCount
        draHanaSenkoh.bbLampGCount = draHanaSenkohMemory1.bbLampGCount
        draHanaSenkoh.bbLampRCount = draHanaSenkohMemory1.bbLampRCount
        draHanaSenkoh.rbLampBCount = draHanaSenkohMemory1.rbLampBCount
        draHanaSenkoh.rbLampYCount = draHanaSenkohMemory1.rbLampYCount
        draHanaSenkoh.rbLampGCount = draHanaSenkohMemory1.rbLampGCount
        draHanaSenkoh.rbLampRCount = draHanaSenkohMemory1.rbLampRCount
        draHanaSenkoh.currentGames = draHanaSenkohMemory1.currentGames
        draHanaSenkoh.totalBonus = draHanaSenkohMemory1.totalBonus
        draHanaSenkoh.playGames = draHanaSenkohMemory1.playGames
        draHanaSenkoh.bigPlayGames = draHanaSenkohMemory1.bigPlayGames
        draHanaSenkoh.bbLampCountSum = draHanaSenkohMemory1.bbLampCountSum
        draHanaSenkoh.rbLampCountSum = draHanaSenkohMemory1.rbLampCountSum
        draHanaSenkoh.rbLampKisuCountSum = draHanaSenkohMemory1.rbLampKisuCountSum
        draHanaSenkoh.rbLampGusuCountSum = draHanaSenkohMemory1.rbLampGusuCountSum
        draHanaSenkoh.totalBigCount = draHanaSenkohMemory1.totalBigCount
        draHanaSenkoh.totalRegCount = draHanaSenkohMemory1.totalRegCount
        draHanaSenkoh.totalBellCount = draHanaSenkohMemory1.totalBellCount
        draHanaSenkoh.totalBonusCountSum = draHanaSenkohMemory1.totalBonusCountSum
    }
    func loadMemory2() {
        draHanaSenkoh.kenBackCalculationEnable = draHanaSenkohMemory2.kenBackCalculationEnable
        draHanaSenkoh.kenGameIput = draHanaSenkohMemory2.kenGameIput
        draHanaSenkoh.kenBigCountInput = draHanaSenkohMemory2.kenBigCountInput
        draHanaSenkoh.kenRegCountInput = draHanaSenkohMemory2.kenRegCountInput
        draHanaSenkoh.kenCoinDifferenceInput = draHanaSenkohMemory2.kenCoinDifferenceInput
        draHanaSenkoh.kenBonusCountSum = draHanaSenkohMemory2.kenBonusCountSum
        draHanaSenkoh.kenBellBackCalculationCount = draHanaSenkohMemory2.kenBellBackCalculationCount
        draHanaSenkoh.startBackCalculationEnable = draHanaSenkohMemory2.startBackCalculationEnable
        draHanaSenkoh.startGameInput = draHanaSenkohMemory2.startGameInput
        draHanaSenkoh.startBigCountInput = draHanaSenkohMemory2.startBigCountInput
        draHanaSenkoh.startRegCountInput = draHanaSenkohMemory2.startRegCountInput
        draHanaSenkoh.startCoinDifferenceInput = draHanaSenkohMemory2.startCoinDifferenceInput
        draHanaSenkoh.startBonusCountSum = draHanaSenkohMemory2.startBonusCountSum
        draHanaSenkoh.startBellBackCalculationCount = draHanaSenkohMemory2.startBellBackCalculationCount
        draHanaSenkoh.bellCount = draHanaSenkohMemory2.bellCount
        draHanaSenkoh.bigCount = draHanaSenkohMemory2.bigCount
        draHanaSenkoh.regCount = draHanaSenkohMemory2.regCount
        draHanaSenkoh.bbSuikaCount = draHanaSenkohMemory2.bbSuikaCount
        draHanaSenkoh.bbLampBCount = draHanaSenkohMemory2.bbLampBCount
        draHanaSenkoh.bbLampYCount = draHanaSenkohMemory2.bbLampYCount
        draHanaSenkoh.bbLampGCount = draHanaSenkohMemory2.bbLampGCount
        draHanaSenkoh.bbLampRCount = draHanaSenkohMemory2.bbLampRCount
        draHanaSenkoh.rbLampBCount = draHanaSenkohMemory2.rbLampBCount
        draHanaSenkoh.rbLampYCount = draHanaSenkohMemory2.rbLampYCount
        draHanaSenkoh.rbLampGCount = draHanaSenkohMemory2.rbLampGCount
        draHanaSenkoh.rbLampRCount = draHanaSenkohMemory2.rbLampRCount
        draHanaSenkoh.currentGames = draHanaSenkohMemory2.currentGames
        draHanaSenkoh.totalBonus = draHanaSenkohMemory2.totalBonus
        draHanaSenkoh.playGames = draHanaSenkohMemory2.playGames
        draHanaSenkoh.bigPlayGames = draHanaSenkohMemory2.bigPlayGames
        draHanaSenkoh.bbLampCountSum = draHanaSenkohMemory2.bbLampCountSum
        draHanaSenkoh.rbLampCountSum = draHanaSenkohMemory2.rbLampCountSum
        draHanaSenkoh.rbLampKisuCountSum = draHanaSenkohMemory2.rbLampKisuCountSum
        draHanaSenkoh.rbLampGusuCountSum = draHanaSenkohMemory2.rbLampGusuCountSum
        draHanaSenkoh.totalBigCount = draHanaSenkohMemory2.totalBigCount
        draHanaSenkoh.totalRegCount = draHanaSenkohMemory2.totalRegCount
        draHanaSenkoh.totalBellCount = draHanaSenkohMemory2.totalBellCount
        draHanaSenkoh.totalBonusCountSum = draHanaSenkohMemory2.totalBonusCountSum
    }
    func loadMemory3() {
        draHanaSenkoh.kenBackCalculationEnable = draHanaSenkohMemory3.kenBackCalculationEnable
        draHanaSenkoh.kenGameIput = draHanaSenkohMemory3.kenGameIput
        draHanaSenkoh.kenBigCountInput = draHanaSenkohMemory3.kenBigCountInput
        draHanaSenkoh.kenRegCountInput = draHanaSenkohMemory3.kenRegCountInput
        draHanaSenkoh.kenCoinDifferenceInput = draHanaSenkohMemory3.kenCoinDifferenceInput
        draHanaSenkoh.kenBonusCountSum = draHanaSenkohMemory3.kenBonusCountSum
        draHanaSenkoh.kenBellBackCalculationCount = draHanaSenkohMemory3.kenBellBackCalculationCount
        draHanaSenkoh.startBackCalculationEnable = draHanaSenkohMemory3.startBackCalculationEnable
        draHanaSenkoh.startGameInput = draHanaSenkohMemory3.startGameInput
        draHanaSenkoh.startBigCountInput = draHanaSenkohMemory3.startBigCountInput
        draHanaSenkoh.startRegCountInput = draHanaSenkohMemory3.startRegCountInput
        draHanaSenkoh.startCoinDifferenceInput = draHanaSenkohMemory3.startCoinDifferenceInput
        draHanaSenkoh.startBonusCountSum = draHanaSenkohMemory3.startBonusCountSum
        draHanaSenkoh.startBellBackCalculationCount = draHanaSenkohMemory3.startBellBackCalculationCount
        draHanaSenkoh.bellCount = draHanaSenkohMemory3.bellCount
        draHanaSenkoh.bigCount = draHanaSenkohMemory3.bigCount
        draHanaSenkoh.regCount = draHanaSenkohMemory3.regCount
        draHanaSenkoh.bbSuikaCount = draHanaSenkohMemory3.bbSuikaCount
        draHanaSenkoh.bbLampBCount = draHanaSenkohMemory3.bbLampBCount
        draHanaSenkoh.bbLampYCount = draHanaSenkohMemory3.bbLampYCount
        draHanaSenkoh.bbLampGCount = draHanaSenkohMemory3.bbLampGCount
        draHanaSenkoh.bbLampRCount = draHanaSenkohMemory3.bbLampRCount
        draHanaSenkoh.rbLampBCount = draHanaSenkohMemory3.rbLampBCount
        draHanaSenkoh.rbLampYCount = draHanaSenkohMemory3.rbLampYCount
        draHanaSenkoh.rbLampGCount = draHanaSenkohMemory3.rbLampGCount
        draHanaSenkoh.rbLampRCount = draHanaSenkohMemory3.rbLampRCount
        draHanaSenkoh.currentGames = draHanaSenkohMemory3.currentGames
        draHanaSenkoh.totalBonus = draHanaSenkohMemory3.totalBonus
        draHanaSenkoh.playGames = draHanaSenkohMemory3.playGames
        draHanaSenkoh.bigPlayGames = draHanaSenkohMemory3.bigPlayGames
        draHanaSenkoh.bbLampCountSum = draHanaSenkohMemory3.bbLampCountSum
        draHanaSenkoh.rbLampCountSum = draHanaSenkohMemory3.rbLampCountSum
        draHanaSenkoh.rbLampKisuCountSum = draHanaSenkohMemory3.rbLampKisuCountSum
        draHanaSenkoh.rbLampGusuCountSum = draHanaSenkohMemory3.rbLampGusuCountSum
        draHanaSenkoh.totalBigCount = draHanaSenkohMemory3.totalBigCount
        draHanaSenkoh.totalRegCount = draHanaSenkohMemory3.totalRegCount
        draHanaSenkoh.totalBellCount = draHanaSenkohMemory3.totalBellCount
        draHanaSenkoh.totalBonusCountSum = draHanaSenkohMemory3.totalBonusCountSum
    }
}

#Preview {
    draHanaSenkohVer2ViewTop(
//        ver391: Ver391(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
