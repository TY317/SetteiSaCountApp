//
//  starHanaClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/15.
//

import Foundation
import SwiftUI

class StarHana: ObservableObject {
    // ////////////////////////
    // 確率値
    // ////////////////////////
    let denominateListBell: [Double] = [
        6.31,
        6.31,
        6.28,
        6.28,
        6.27,
        6.23
    ]
    let denominateListBig: [Double] = [
        270,
        262,
        252,
        240,
        229,
        218
    ]
    let denominateListReg: [Double] = [
        387,
        354,
        322,
        293,
        267,
        242
    ]
    let denominateListBonusSum: [Double] = [
        159,
        150,
        141,
        132,
        123,
        114
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
    @AppStorage("starHanaKenBackCalculationEnable") var kenBackCalculationEnable: Bool = false {
        didSet {
            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
        }
    }
        @AppStorage("starHanaKenGameIput") var kenGameIput: Int = 0 {
            didSet {
                kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
            }
        }
            @AppStorage("starHanaKenBigCountInput") var kenBigCountInput: Int = 0 {
                didSet {
                    kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                    kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                }
            }
                @AppStorage("starHanaKenRegCountInput") var kenRegCountInput: Int = 0 {
                    didSet {
                        kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                    }
                }
                    @AppStorage("starHanaKenCoinDifferenceInput") var kenCoinDifferenceInput: Int = 0 {
                        didSet {
                            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        }
                    }
    @AppStorage("starHanaKenBonusCountSum") var kenBonusCountSum: Int = 0
    @AppStorage("starHanaKenBellBackCalculationCount") var kenBellBackCalculationCount: Int = 0
    
    func bellBackCalculate(game: Int, bigCount: Int, regCount: Int, coinDifference: Int) -> Int {
        // 各種確率の定義
        let replayDenominate = 7.298   // リプレイ確率
        let cherryDenominate: Double = 48.0   // チェリー確率
        let suikaDenominate: Double = 160.0   // スイカ確率
        let cherryGetRatio = 0.9   // チェリー奪取率
        let suikaGetRatio: Double = 0.7   // ベル奪取率
        let bigOut: Double = 240   // ビッグ獲得枚数
        let regOut: Double = 96   // REG獲得枚数
        let cherryOut: Double = 4   // チェリー払い出し枚数
        let bellOut: Double = 8   // ぶどう・ベル払い出し枚数
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
    @AppStorage("starHanaStartBackCalculationEnable") var startBackCalculationEnable: Bool = false {
        didSet {
            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
        }
    }
        @AppStorage("starHanaStartGames") var startGameInput: Int = 0 {
            didSet {
                startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                playGames = currentGames - startGameInput
            }
        }
            @AppStorage("starHanaStartBigCountInput") var startBigCountInput: Int = 0 {
                didSet {
                    startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                    startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                    totalBigCount = countSum(startBigCountInput, bigCount)
                }
            }
                @AppStorage("starHanaStartRegCountInput") var startRegCountInput: Int = 0 {
                    didSet {
                        startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                        totalRegCount = countSum(startRegCountInput, regCount)
                    }
                }
                    @AppStorage("starHanaStartCoinDifferenceInput") var startCoinDifferenceInput: Int = 0 {
                        didSet {
                            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        }
                    }
    @AppStorage("starHanaStartBonusCountSum") var startBonusCountSum: Int = 0
    @AppStorage("starHanaStartBellBackCalculationCount") var startBellBackCalculationCount: Int = 0 {
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
    @AppStorage("starHanaBellCount") var bellCount = 0 {
        didSet {
            totalBellCount = countSum(startBellBackCalculationCount, bellCount)
        }
    }
    @AppStorage("starHanaBigCount") var bigCount = 0 {
        didSet {
            totalBonus = countSum(bigCount, regCount)
            bigPlayGames = BigPlayGames(big: bigCount)
            totalBigCount = countSum(startBigCountInput, bigCount)
        }
    }
    @AppStorage("starHanaRegCount") var regCount = 0 {
        didSet {
            totalBonus = countSum(bigCount, regCount)
            totalRegCount = countSum(startRegCountInput, regCount)
        }
    }
    @AppStorage("starHanaBBSuikaCount") var bbSuikaCount = 0
    @AppStorage("starHanaBBLampBCount") var bbLampBCount = 0 {
        didSet {
            bbLampCountSum = countSum(bbLampBCount, bbLampYCount, bbLampGCount, bbLampRCount)
        }
    }
    @AppStorage("starHanaBBLampYCount") var bbLampYCount = 0 {
        didSet {
            bbLampCountSum = countSum(bbLampBCount, bbLampYCount, bbLampGCount, bbLampRCount)
        }
    }
    @AppStorage("starHanaBBLampGCount") var bbLampGCount = 0 {
        didSet {
            bbLampCountSum = countSum(bbLampBCount, bbLampYCount, bbLampGCount, bbLampRCount)
        }
    }
    @AppStorage("starHanaBBLampRCount") var bbLampRCount = 0 {
        didSet {
            bbLampCountSum = countSum(bbLampBCount, bbLampYCount, bbLampGCount, bbLampRCount)
        }
    }
    @AppStorage("starHanaRbLampBCount") var rbLampBCount = 0 {
        didSet {
            rbLampCountSum = countSum(rbLampBCount, rbLampYCount, rbLampGCount, rbLampRCount)
            rbLampKisuCountSum = countSum(rbLampBCount, rbLampGCount)
        }
    }
    @AppStorage("starHanaRbLampYCount") var rbLampYCount = 0 {
        didSet {
            rbLampCountSum = countSum(rbLampBCount, rbLampYCount, rbLampGCount, rbLampRCount)
            rbLampGusuCountSum = countSum(rbLampYCount, rbLampRCount)
        }
    }
    @AppStorage("starHanaRbLampGCount") var rbLampGCount = 0 {
        didSet {
            rbLampCountSum = countSum(rbLampBCount, rbLampYCount, rbLampGCount, rbLampRCount)
            rbLampKisuCountSum = countSum(rbLampBCount, rbLampGCount)
        }
    }
    @AppStorage("starHanaRbLampRCount") var rbLampRCount = 0 {
        didSet {
            rbLampCountSum = countSum(rbLampBCount, rbLampYCount, rbLampGCount, rbLampRCount)
            rbLampGusuCountSum = countSum(rbLampYCount, rbLampRCount)
        }
    }
    @AppStorage("starHanaCurrentGames") var currentGames = 0 {
        didSet {
            playGames = currentGames - startGameInput
        }
    }
    
    @AppStorage("starHanaTotalBonus") var totalBonus = 0
    @AppStorage("starHanaPlayGames") var playGames = 0
    @AppStorage("starHanaBigPlayGames") var bigPlayGames = 0
    @AppStorage("starHanaBbLampCountSum") var bbLampCountSum = 0
    @AppStorage("starHanaRbLampCountSum") var rbLampCountSum = 0
    @AppStorage("starHanaRbLampKisuCountSum") var rbLampKisuCountSum = 0
    @AppStorage("starHanaRbLampGusuCountSum") var rbLampGusuCountSum = 0
    
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
    @AppStorage("starHanaTotalBigCount") var totalBigCount = 0 {
        didSet {
            totalBonusCountSum = countSum(totalBigCount, totalRegCount)
        }
    }
        @AppStorage("starHanaTotalRegCount") var totalRegCount = 0 {
            didSet {
                totalBonusCountSum = countSum(totalBigCount, totalRegCount)
            }
        }
    @AppStorage("starHanaTotalBellCount") var totalBellCount = 0
    @AppStorage("starHanaTotalBonusCountSum") var totalBonusCountSum = 0
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "スターハナハナ"
    @AppStorage("starHanaMinusCheck") var minusCheck: Bool = false
    @AppStorage("starHanaSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetKenDataInput()
        resetStartData()
        hanaReset()
    }
    
    // ////////
    // 島合算
    // ////////
    @AppStorage("starHanaShimaGames") var shimaGames: Int = 0
    @AppStorage("starHanaShimaBigs") var shimaBigs: Int = 0
    @AppStorage("starHanaShimaRegs") var shimaRegs: Int = 0
    @AppStorage("starHanaShimaBonusSum") var shimaBonusSum: Int = 0
}


// //// メモリー1
class StarHanaMemory1: ObservableObject {
    @AppStorage("starHanaKenBackCalculationEnableMemory1") var kenBackCalculationEnable: Bool = false
    @AppStorage("starHanaKenGameIputMemory1") var kenGameIput: Int = 0
    @AppStorage("starHanaKenBigCountInputMemory1") var kenBigCountInput: Int = 0
    @AppStorage("starHanaKenRegCountInputMemory1") var kenRegCountInput: Int = 0
    @AppStorage("starHanaKenCoinDifferenceInputMemory1") var kenCoinDifferenceInput: Int = 0
    @AppStorage("starHanaKenBonusCountSumMemory1") var kenBonusCountSum: Int = 0
    @AppStorage("starHanaKenBellBackCalculationCountMemory1") var kenBellBackCalculationCount: Int = 0
    @AppStorage("starHanaStartBackCalculationEnableMemory1") var startBackCalculationEnable: Bool = false
    @AppStorage("starHanaStartGamesMemory1") var startGameInput: Int = 0
    @AppStorage("starHanaStartBigCountInputMemory1") var startBigCountInput: Int = 0
    @AppStorage("starHanaStartRegCountInputMemory1") var startRegCountInput: Int = 0
    @AppStorage("starHanaStartCoinDifferenceInputMemory1") var startCoinDifferenceInput: Int = 0
    @AppStorage("starHanaStartBonusCountSumMemory1") var startBonusCountSum: Int = 0
    @AppStorage("starHanaStartBellBackCalculationCountMemory1") var startBellBackCalculationCount: Int = 0
    @AppStorage("starHanaBellCountMemory1") var bellCount = 0
    @AppStorage("starHanaBigCountMemory1") var bigCount = 0
    @AppStorage("starHanaRegCountMemory1") var regCount = 0
    @AppStorage("starHanaBBSuikaCountMemory1") var bbSuikaCount = 0
    @AppStorage("starHanaBBLampBCountMemory1") var bbLampBCount = 0
    @AppStorage("starHanaBBLampYCountMemory1") var bbLampYCount = 0
    @AppStorage("starHanaBBLampGCountMemory1") var bbLampGCount = 0
    @AppStorage("starHanaBBLampRCountMemory1") var bbLampRCount = 0
    @AppStorage("starHanaRbLampBCountMemory1") var rbLampBCount = 0
    @AppStorage("starHanaRbLampYCountMemory1") var rbLampYCount = 0
    @AppStorage("starHanaRbLampGCountMemory1") var rbLampGCount = 0
    @AppStorage("starHanaRbLampRCountMemory1") var rbLampRCount = 0
    @AppStorage("starHanaCurrentGamesMemory1") var currentGames = 0
    @AppStorage("starHanaTotalBonusMemory1") var totalBonus = 0
    @AppStorage("starHanaPlayGamesMemory1") var playGames = 0
    @AppStorage("starHanaBigPlayGamesMemory1") var bigPlayGames = 0
    @AppStorage("starHanaBbLampCountSumMemory1") var bbLampCountSum = 0
    @AppStorage("starHanaRbLampCountSumMemory1") var rbLampCountSum = 0
    @AppStorage("starHanaRbLampKisuCountSumMemory1") var rbLampKisuCountSum = 0
    @AppStorage("starHanaRbLampGusuCountSumMemory1") var rbLampGusuCountSum = 0
    @AppStorage("starHanaTotalBigCountMemory1") var totalBigCount = 0
    @AppStorage("starHanaTotalRegCountMemory1") var totalRegCount = 0
    @AppStorage("starHanaTotalBellCountMemory1") var totalBellCount = 0
    @AppStorage("starHanaTotalBonusCountSumMemory1") var totalBonusCountSum = 0
    @AppStorage("starHanaMemoMemory1") var memo = ""
    @AppStorage("starHanaDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class StarHanaMemory2: ObservableObject {
    @AppStorage("starHanaKenBackCalculationEnableMemory2") var kenBackCalculationEnable: Bool = false
    @AppStorage("starHanaKenGameIputMemory2") var kenGameIput: Int = 0
    @AppStorage("starHanaKenBigCountInputMemory2") var kenBigCountInput: Int = 0
    @AppStorage("starHanaKenRegCountInputMemory2") var kenRegCountInput: Int = 0
    @AppStorage("starHanaKenCoinDifferenceInputMemory2") var kenCoinDifferenceInput: Int = 0
    @AppStorage("starHanaKenBonusCountSumMemory2") var kenBonusCountSum: Int = 0
    @AppStorage("starHanaKenBellBackCalculationCountMemory2") var kenBellBackCalculationCount: Int = 0
    @AppStorage("starHanaStartBackCalculationEnableMemory2") var startBackCalculationEnable: Bool = false
    @AppStorage("starHanaStartGamesMemory2") var startGameInput: Int = 0
    @AppStorage("starHanaStartBigCountInputMemory2") var startBigCountInput: Int = 0
    @AppStorage("starHanaStartRegCountInputMemory2") var startRegCountInput: Int = 0
    @AppStorage("starHanaStartCoinDifferenceInputMemory2") var startCoinDifferenceInput: Int = 0
    @AppStorage("starHanaStartBonusCountSumMemory2") var startBonusCountSum: Int = 0
    @AppStorage("starHanaStartBellBackCalculationCountMemory2") var startBellBackCalculationCount: Int = 0
    @AppStorage("starHanaBellCountMemory2") var bellCount = 0
    @AppStorage("starHanaBigCountMemory2") var bigCount = 0
    @AppStorage("starHanaRegCountMemory2") var regCount = 0
    @AppStorage("starHanaBBSuikaCountMemory2") var bbSuikaCount = 0
    @AppStorage("starHanaBBLampBCountMemory2") var bbLampBCount = 0
    @AppStorage("starHanaBBLampYCountMemory2") var bbLampYCount = 0
    @AppStorage("starHanaBBLampGCountMemory2") var bbLampGCount = 0
    @AppStorage("starHanaBBLampRCountMemory2") var bbLampRCount = 0
    @AppStorage("starHanaRbLampBCountMemory2") var rbLampBCount = 0
    @AppStorage("starHanaRbLampYCountMemory2") var rbLampYCount = 0
    @AppStorage("starHanaRbLampGCountMemory2") var rbLampGCount = 0
    @AppStorage("starHanaRbLampRCountMemory2") var rbLampRCount = 0
    @AppStorage("starHanaCurrentGamesMemory2") var currentGames = 0
    @AppStorage("starHanaTotalBonusMemory2") var totalBonus = 0
    @AppStorage("starHanaPlayGamesMemory2") var playGames = 0
    @AppStorage("starHanaBigPlayGamesMemory2") var bigPlayGames = 0
    @AppStorage("starHanaBbLampCountSumMemory2") var bbLampCountSum = 0
    @AppStorage("starHanaRbLampCountSumMemory2") var rbLampCountSum = 0
    @AppStorage("starHanaRbLampKisuCountSumMemory2") var rbLampKisuCountSum = 0
    @AppStorage("starHanaRbLampGusuCountSumMemory2") var rbLampGusuCountSum = 0
    @AppStorage("starHanaTotalBigCountMemory2") var totalBigCount = 0
    @AppStorage("starHanaTotalRegCountMemory2") var totalRegCount = 0
    @AppStorage("starHanaTotalBellCountMemory2") var totalBellCount = 0
    @AppStorage("starHanaTotalBonusCountSumMemory2") var totalBonusCountSum = 0
    @AppStorage("starHanaMemoMemory2") var memo = ""
    @AppStorage("starHanaDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class StarHanaMemory3: ObservableObject {
    @AppStorage("starHanaKenBackCalculationEnableMemory3") var kenBackCalculationEnable: Bool = false
    @AppStorage("starHanaKenGameIputMemory3") var kenGameIput: Int = 0
    @AppStorage("starHanaKenBigCountInputMemory3") var kenBigCountInput: Int = 0
    @AppStorage("starHanaKenRegCountInputMemory3") var kenRegCountInput: Int = 0
    @AppStorage("starHanaKenCoinDifferenceInputMemory3") var kenCoinDifferenceInput: Int = 0
    @AppStorage("starHanaKenBonusCountSumMemory3") var kenBonusCountSum: Int = 0
    @AppStorage("starHanaKenBellBackCalculationCountMemory3") var kenBellBackCalculationCount: Int = 0
    @AppStorage("starHanaStartBackCalculationEnableMemory3") var startBackCalculationEnable: Bool = false
    @AppStorage("starHanaStartGamesMemory3") var startGameInput: Int = 0
    @AppStorage("starHanaStartBigCountInputMemory3") var startBigCountInput: Int = 0
    @AppStorage("starHanaStartRegCountInputMemory3") var startRegCountInput: Int = 0
    @AppStorage("starHanaStartCoinDifferenceInputMemory3") var startCoinDifferenceInput: Int = 0
    @AppStorage("starHanaStartBonusCountSumMemory3") var startBonusCountSum: Int = 0
    @AppStorage("starHanaStartBellBackCalculationCountMemory3") var startBellBackCalculationCount: Int = 0
    @AppStorage("starHanaBellCountMemory3") var bellCount = 0
    @AppStorage("starHanaBigCountMemory3") var bigCount = 0
    @AppStorage("starHanaRegCountMemory3") var regCount = 0
    @AppStorage("starHanaBBSuikaCountMemory3") var bbSuikaCount = 0
    @AppStorage("starHanaBBLampBCountMemory3") var bbLampBCount = 0
    @AppStorage("starHanaBBLampYCountMemory3") var bbLampYCount = 0
    @AppStorage("starHanaBBLampGCountMemory3") var bbLampGCount = 0
    @AppStorage("starHanaBBLampRCountMemory3") var bbLampRCount = 0
    @AppStorage("starHanaRbLampBCountMemory3") var rbLampBCount = 0
    @AppStorage("starHanaRbLampYCountMemory3") var rbLampYCount = 0
    @AppStorage("starHanaRbLampGCountMemory3") var rbLampGCount = 0
    @AppStorage("starHanaRbLampRCountMemory3") var rbLampRCount = 0
    @AppStorage("starHanaCurrentGamesMemory3") var currentGames = 0
    @AppStorage("starHanaTotalBonusMemory3") var totalBonus = 0
    @AppStorage("starHanaPlayGamesMemory3") var playGames = 0
    @AppStorage("starHanaBigPlayGamesMemory3") var bigPlayGames = 0
    @AppStorage("starHanaBbLampCountSumMemory3") var bbLampCountSum = 0
    @AppStorage("starHanaRbLampCountSumMemory3") var rbLampCountSum = 0
    @AppStorage("starHanaRbLampKisuCountSumMemory3") var rbLampKisuCountSum = 0
    @AppStorage("starHanaRbLampGusuCountSumMemory3") var rbLampGusuCountSum = 0
    @AppStorage("starHanaTotalBigCountMemory3") var totalBigCount = 0
    @AppStorage("starHanaTotalRegCountMemory3") var totalRegCount = 0
    @AppStorage("starHanaTotalBellCountMemory3") var totalBellCount = 0
    @AppStorage("starHanaTotalBonusCountSumMemory3") var totalBonusCountSum = 0
    @AppStorage("starHanaMemoMemory3") var memo = ""
    @AppStorage("starHanaDateMemory3") var dateDouble = 0.0
}
