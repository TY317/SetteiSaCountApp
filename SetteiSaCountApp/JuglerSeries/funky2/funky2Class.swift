//
//  funky2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/09.
//

import Foundation
import SwiftUI

// //////////////////
// 変数
// //////////////////
class Funky2: ObservableObject {
    // ////////////////////////
    // 確率値
    // ////////////////////////
    let denominateListBell: [Double] = [
        5.94,
        5.92,
        5.88,
        5.83,
        5.76,
        5.67
    ]
    
    let denominateListBigSum: [Double] = [
        266.4,
        259.0,
        256.0,
        249.2,
        240.1,
        219.9
    ]
    
    let denominateListRegSum: [Double] = [
        439.8,
        407.1,
        366.1,
        322.8,
        299.3,
        262.1
    ]
    
    let denominateListBonusSum: [Double] = [
        165.9,
        158.3,
        150.7,
        140.6,
        133.2,
        119.6
    ]
    
    let denominateListBigAlone: [Double] = [
        402.06,
        397.19,
        397.19,
        385.51,
        378.82,
        339.56
    ]
    
    let denominateListBigCherry: [Double] = [
        1456.36,
        1365.33,
        1337.47,
        1337.47,
        1260.31,
        1191.56
    ]
    
    let denominateListRegAlone: [Double] = [
        636.27,
        574.88,
        512.00,
        448.88,
        409.60,
        356.17
    ]
    
    let denominateListRegCherry: [Double] = [
        1424.70,
        1394.38,
        1285.02,
        1149.75,
        1110.78,
        992.97
    ]
    
    // ////////////////////////
    // 見
    // ////////////////////////
    @AppStorage("funky2KenBackCalculationEnable") var kenBackCalculationEnable: Bool = false {
        didSet {
            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
        }
    }
        @AppStorage("funky2KenGameIput") var kenGameIput: Int = 0 {
            didSet {
                kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
            }
        }
            @AppStorage("funky2KenBigCountInput") var kenBigCountInput: Int = 0 {
                didSet {
                    kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                    kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                }
            }
                @AppStorage("funky2KenRegCountInput") var kenRegCountInput: Int = 0 {
                    didSet {
                        kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                    }
                }
                    @AppStorage("funky2KenCoinDifferenceInput") var kenCoinDifferenceInput: Int = 0 {
                        didSet {
                            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        }
                    }
    @AppStorage("funky2KenBonusCountSum") var kenBonusCountSum: Int = 0
    @AppStorage("funky2KenBellBackCalculationCount") var kenBellBackCalculationCount: Int = 0
    
    func bellBackCalculate(game: Int, bigCount: Int, regCount: Int, coinDifference: Int) -> Int {
        // 各種確率の定義
        let replayDenominate = 7.298   // リプレイ確率
        let cherryDenominate: Double = 35.62   // チェリー確率
        let suikaDenominate: Double = 1092.27   // ベル確率
        let pieroDenominate: Double = 1092.27   // ピエロ確率
        let cherryGetRatio = 0.9   // チェリー奪取率
        let suikaGetRatio: Double = 0.11   // ベル奪取率、V2スロマガ情報より
        let pieroGetRatio: Double = 0.16   // ピエロ奪取率、V2スロマガ情報より
        let budonukiAverageGame = 1.31   // ぶどう抜き平均消化ゲーム数（1枚がけ）
        let budonukiAverageIn = 1.13   // ぶどう抜き平均IN枚数
        let budonukiAverageOut = 1.01   // ぶどう抜き平均OUT枚数
        let bigOut: Double = 240   // ビッグ獲得枚数
        let regOut: Double = 96   // REG獲得枚数
        let cherryOut: Double = 2   // チェリー払い出し枚数
        let bellOut: Double = 8   // ぶどう・ベル払い出し枚数
        let suikaOut: Double = 14   // ベル払い出し枚数
        let pieroOut: Double = 10   // ピエロ払い出し枚数
        
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
        let suikaOutTotal = (Double(game) - budonukiGame) / suikaDenominate * suikaOut * suikaGetRatio
        let pieroOutTotal = (Double(game) - budonukiGame) / pieroDenominate * pieroOut * pieroGetRatio
        let outTotalWithoutBell = budonukiOut + bigOutTotal + regOutTotal + cherryOutTotal + suikaOutTotal + pieroOutTotal
        
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
    @AppStorage("funky2StartBackCalculationEnable") var startBackCalculationEnable: Bool = false {
        didSet {
            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
        }
    }
        @AppStorage("funky2StartGames") var startGameInput: Int = 0 {
            didSet {
                startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                playGame = currentGames - startGameInput
            }
        }
            @AppStorage("funky2StartBigCountInput") var startBigCountInput: Int = 0 {
                didSet {
                    startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                    startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                    totalBigCount = countSum(startBigCountInput, personalBigCountSum)
                }
            }
                @AppStorage("funky2StartRegCountInput") var startRegCountInput: Int = 0 {
                    didSet {
                        startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                        totalRegCount = countSum(startRegCountInput, personalRegCountSum)
                    }
                }
                    @AppStorage("funky2StartCoinDifferenceInput") var startCoinDifferenceInput: Int = 0 {
                        didSet {
                            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        }
                    }
    @AppStorage("funky2StartBonusCountSum") var startBonusCountSum: Int = 0
    @AppStorage("funky2StartBellBackCalculationCount") var startBellBackCalculationCount: Int = 0 {
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
    @AppStorage("funky2BellCount") var personalBellCount = 0 {
        didSet {
            totalBellCount = countSum(startBellBackCalculationCount, personalBellCount)
        }
    }
    @AppStorage("funky2AloneBigCount") var personalAloneBigCount = 0 {
        didSet {
            personalBigCountSum = countSum(personalAloneBigCount, personalCherryBigCount)
        }
    }
    @AppStorage("funky2CherryBigCount") var personalCherryBigCount = 0 {
        didSet {
            personalBigCountSum = countSum(personalAloneBigCount, personalCherryBigCount)
        }
    }
        @AppStorage("funky2AloneRegCount") var personalAloneRegCount = 0 {
            didSet {
                personalRegCountSum = countSum(personalAloneRegCount, personalCherryRegCount)
            }
        }
            @AppStorage("funky2CherryRegCount") var personalCherryRegCount = 0 {
                didSet {
                    personalRegCountSum = countSum(personalAloneRegCount, personalCherryRegCount)
                }
            }
    @AppStorage("funky2CurrentGames") var currentGames = 0 {
        didSet {
            playGame = currentGames - startGameInput
        }
    }
    @AppStorage("funky2BigCountSum") var personalBigCountSum = 0 {
        didSet {
            personalBonusCountSum = countSum(personalBigCountSum, personalRegCountSum)
            totalBigCount = countSum(startBigCountInput, personalBigCountSum)
        }
    }
    @AppStorage("funky2RegCountSum") var personalRegCountSum = 0 {
        didSet {
            personalBonusCountSum = countSum(personalBigCountSum, personalRegCountSum)
            totalRegCount = countSum(startRegCountInput, personalRegCountSum)
        }
    }
    @AppStorage("funky2BonusCountSum") var personalBonusCountSum = 0
    @AppStorage("funky2PlayGame") var playGame = 0
    
    func resetCountData() {
        personalBellCount = 0
        personalAloneBigCount = 0
        personalCherryBigCount = 0
        personalAloneRegCount = 0
        personalCherryRegCount = 0
        currentGames = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 実戦 トータル結果
    // ////////////////////////
    @AppStorage("funky2TotalBigCount") var totalBigCount = 0 {
        didSet {
            totalBonusCountSum = countSum(totalBigCount, totalRegCount)
        }
    }
        @AppStorage("funky2TotalRegCount") var totalRegCount = 0 {
            didSet {
                totalBonusCountSum = countSum(totalBigCount, totalRegCount)
            }
        }
    @AppStorage("funky2TotalBellCount") var totalBellCount = 0
    @AppStorage("funky2TotalBonusCountSum") var totalBonusCountSum = 0
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "ファンキージャグラー2"
    @AppStorage("funky2MinusCheck") var minusCheck: Bool = false
    @AppStorage("funky2SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetKenDataInput()
        resetStartData()
        resetCountData()
    }
    
    // ////////
    // 島合算
    // ////////
    @AppStorage("funky2ShimaGames") var shimaGames: Int = 0
    @AppStorage("funky2ShimaBigs") var shimaBigs: Int = 0
    @AppStorage("funky2ShimaRegs") var shimaRegs: Int = 0
    @AppStorage("funky2ShimaBonusSum") var shimaBonusSum: Int = 0
}


// //// メモリー1
class Funky2Memory1: ObservableObject {
    @AppStorage("funky2KenBackCalculationEnableMemory1") var kenBackCalculationEnable: Bool = false
    @AppStorage("funky2KenGameIputMemory1") var kenGameIput: Int = 0
    @AppStorage("funky2KenBigCountInputMemory1") var kenBigCountInput: Int = 0
    @AppStorage("funky2KenRegCountInputMemory1") var kenRegCountInput: Int = 0
    @AppStorage("funky2KenCoinDifferenceInputMemory1") var kenCoinDifferenceInput: Int = 0
    @AppStorage("funky2KenBonusCountSumMemory1") var kenBonusCountSum: Int = 0
    @AppStorage("funky2KenBellBackCalculationCountMemory1") var kenBellBackCalculationCount: Int = 0
    @AppStorage("funky2StartBackCalculationEnableMemory1") var startBackCalculationEnable: Bool = false
    @AppStorage("funky2StartGamesMemory1") var startGameInput: Int = 0
    @AppStorage("funky2StartBigCountInputMemory1") var startBigCountInput: Int = 0
    @AppStorage("funky2StartRegCountInputMemory1") var startRegCountInput: Int = 0
    @AppStorage("funky2StartCoinDifferenceInputMemory1") var startCoinDifferenceInput: Int = 0
    @AppStorage("funky2StartBonusCountSumMemory1") var startBonusCountSum: Int = 0
    @AppStorage("funky2StartBellBackCalculationCountMemory1") var startBellBackCalculationCount: Int = 0
    @AppStorage("funky2BellCountMemory1") var personalBellCount = 0
    @AppStorage("funky2AloneBigCountMemory1") var personalAloneBigCount = 0
    @AppStorage("funky2CherryBigCountMemory1") var personalCherryBigCount = 0
    @AppStorage("funky2BigCountSumMemory1") var personalBigCountSum = 0
    @AppStorage("funky2AloneRegCountMemory1") var personalAloneRegCount = 0
    @AppStorage("funky2CherryRegCountMemory1") var personalCherryRegCount = 0
    @AppStorage("funky2CurrentGamesMemory1") var currentGames = 0
    @AppStorage("funky2RegCountSumMemory1") var personalRegCountSum = 0
    @AppStorage("funky2BonusCountSumMemory1") var personalBonusCountSum = 0
    @AppStorage("funky2PlayGameMemory1") var playGame = 0
    @AppStorage("funky2TotalBigCountMemory1") var totalBigCount = 0
    @AppStorage("funky2TotalRegCountMemory1") var totalRegCount = 0
    @AppStorage("funky2TotalBellCountMemory1") var totalBellCount = 0
    @AppStorage("funky2TotalBonusCountSumMemory1") var totalBonusCountSum = 0
    @AppStorage("funky2MemoMemory1") var memo = ""
    @AppStorage("funky2DateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class Funky2Memory2: ObservableObject {
    @AppStorage("funky2KenBackCalculationEnableMemory2") var kenBackCalculationEnable: Bool = false
    @AppStorage("funky2KenGameIputMemory2") var kenGameIput: Int = 0
    @AppStorage("funky2KenBigCountInputMemory2") var kenBigCountInput: Int = 0
    @AppStorage("funky2KenRegCountInputMemory2") var kenRegCountInput: Int = 0
    @AppStorage("funky2KenCoinDifferenceInputMemory2") var kenCoinDifferenceInput: Int = 0
    @AppStorage("funky2KenBonusCountSumMemory2") var kenBonusCountSum: Int = 0
    @AppStorage("funky2KenBellBackCalculationCountMemory2") var kenBellBackCalculationCount: Int = 0
    @AppStorage("funky2StartBackCalculationEnableMemory2") var startBackCalculationEnable: Bool = false
    @AppStorage("funky2StartGamesMemory2") var startGameInput: Int = 0
    @AppStorage("funky2StartBigCountInputMemory2") var startBigCountInput: Int = 0
    @AppStorage("funky2StartRegCountInputMemory2") var startRegCountInput: Int = 0
    @AppStorage("funky2StartCoinDifferenceInputMemory2") var startCoinDifferenceInput: Int = 0
    @AppStorage("funky2StartBonusCountSumMemory2") var startBonusCountSum: Int = 0
    @AppStorage("funky2StartBellBackCalculationCountMemory2") var startBellBackCalculationCount: Int = 0
    @AppStorage("funky2BellCountMemory2") var personalBellCount = 0
    @AppStorage("funky2AloneBigCountMemory2") var personalAloneBigCount = 0
    @AppStorage("funky2CherryBigCountMemory2") var personalCherryBigCount = 0
    @AppStorage("funky2BigCountSumMemory2") var personalBigCountSum = 0
    @AppStorage("funky2AloneRegCountMemory2") var personalAloneRegCount = 0
    @AppStorage("funky2CherryRegCountMemory2") var personalCherryRegCount = 0
    @AppStorage("funky2CurrentGamesMemory2") var currentGames = 0
    @AppStorage("funky2RegCountSumMemory2") var personalRegCountSum = 0
    @AppStorage("funky2BonusCountSumMemory2") var personalBonusCountSum = 0
    @AppStorage("funky2PlayGameMemory2") var playGame = 0
    @AppStorage("funky2TotalBigCountMemory2") var totalBigCount = 0
    @AppStorage("funky2TotalRegCountMemory2") var totalRegCount = 0
    @AppStorage("funky2TotalBellCountMemory2") var totalBellCount = 0
    @AppStorage("funky2TotalBonusCountSumMemory2") var totalBonusCountSum = 0
    @AppStorage("funky2MemoMemory2") var memo = ""
    @AppStorage("funky2DateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class Funky2Memory3: ObservableObject {
    @AppStorage("funky2KenBackCalculationEnableMemory3") var kenBackCalculationEnable: Bool = false
    @AppStorage("funky2KenGameIputMemory3") var kenGameIput: Int = 0
    @AppStorage("funky2KenBigCountInputMemory3") var kenBigCountInput: Int = 0
    @AppStorage("funky2KenRegCountInputMemory3") var kenRegCountInput: Int = 0
    @AppStorage("funky2KenCoinDifferenceInputMemory3") var kenCoinDifferenceInput: Int = 0
    @AppStorage("funky2KenBonusCountSumMemory3") var kenBonusCountSum: Int = 0
    @AppStorage("funky2KenBellBackCalculationCountMemory3") var kenBellBackCalculationCount: Int = 0
    @AppStorage("funky2StartBackCalculationEnableMemory3") var startBackCalculationEnable: Bool = false
    @AppStorage("funky2StartGamesMemory3") var startGameInput: Int = 0
    @AppStorage("funky2StartBigCountInputMemory3") var startBigCountInput: Int = 0
    @AppStorage("funky2StartRegCountInputMemory3") var startRegCountInput: Int = 0
    @AppStorage("funky2StartCoinDifferenceInputMemory3") var startCoinDifferenceInput: Int = 0
    @AppStorage("funky2StartBonusCountSumMemory3") var startBonusCountSum: Int = 0
    @AppStorage("funky2StartBellBackCalculationCountMemory3") var startBellBackCalculationCount: Int = 0
    @AppStorage("funky2BellCountMemory3") var personalBellCount = 0
    @AppStorage("funky2AloneBigCountMemory3") var personalAloneBigCount = 0
    @AppStorage("funky2CherryBigCountMemory3") var personalCherryBigCount = 0
    @AppStorage("funky2BigCountSumMemory3") var personalBigCountSum = 0
    @AppStorage("funky2AloneRegCountMemory3") var personalAloneRegCount = 0
    @AppStorage("funky2CherryRegCountMemory3") var personalCherryRegCount = 0
    @AppStorage("funky2CurrentGamesMemory3") var currentGames = 0
    @AppStorage("funky2RegCountSumMemory3") var personalRegCountSum = 0
    @AppStorage("funky2BonusCountSumMemory3") var personalBonusCountSum = 0
    @AppStorage("funky2PlayGameMemory3") var playGame = 0
    @AppStorage("funky2TotalBigCountMemory3") var totalBigCount = 0
    @AppStorage("funky2TotalRegCountMemory3") var totalRegCount = 0
    @AppStorage("funky2TotalBellCountMemory3") var totalBellCount = 0
    @AppStorage("funky2TotalBonusCountSumMemory3") var totalBonusCountSum = 0
    @AppStorage("funky2MemoMemory3") var memo = ""
    @AppStorage("funky2DateMemory3") var dateDouble = 0.0
}
