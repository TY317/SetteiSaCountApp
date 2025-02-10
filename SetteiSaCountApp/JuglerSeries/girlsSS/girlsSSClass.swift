//
//  girlsSSClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/09.
//

import Foundation
import SwiftUI

// //////////////////
// 変数
// //////////////////
class GirlsSS: ObservableObject {
    // ////////////////////////
    // 確率値
    // ////////////////////////
    let denominateListBell: [Double] = [
        5.98,
        5.98,
        5.98,
        5.98,
        5.88,
        5.83
    ]
    
    let denominateListBigSum: [Double] = [
        273.1,
        270.8,
        260.1,
        250.1,
        243.6,
        226.0
    ]
    
    let denominateListRegSum: [Double] = [
        381.0,
        350.5,
        316.6,
        281.3,
        270.8,
        252.1
    ]
    
    let denominateListBonusSum: [Double] = [
        159.1,
        152.8,
        142.8,
        132.4,
        128.3,
        119.2
    ]
    
//    let denominateListBigAlone: [Double] = [
//        437,
//        431,
//        412,
//        415,
//        377,
//        345
//    ]
//    
//    let denominateListBigCherry: [Double] = [
//        1489,
//        1489,
//        1489,
//        1214,
//        1214,
//        1214
//    ]
    
    let denominateListRegAlone: [Double] = [
        523.87,
        485.31,
        440.10,
        399.26,
        385.18,
        358.87
    ]
    
    let denominateListRegCherry: [Double] = [
        1397.01,
        1261.81,
        1128.25,
        952.10,
        911.95,
        847.33
    ]
    
    // ////////////////////////
    // 見
    // ////////////////////////
    @AppStorage("girlsSSKenBackCalculationEnable") var kenBackCalculationEnable: Bool = false {
        didSet {
            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
        }
    }
        @AppStorage("girlsSSKenGameIput") var kenGameIput: Int = 0 {
            didSet {
                kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
            }
        }
            @AppStorage("girlsSSKenBigCountInput") var kenBigCountInput: Int = 0 {
                didSet {
                    kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                    kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                }
            }
                @AppStorage("girlsSSKenRegCountInput") var kenRegCountInput: Int = 0 {
                    didSet {
                        kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                    }
                }
                    @AppStorage("girlsSSKenCoinDifferenceInput") var kenCoinDifferenceInput: Int = 0 {
                        didSet {
                            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        }
                    }
    @AppStorage("girlsSSKenBonusCountSum") var kenBonusCountSum: Int = 0
    @AppStorage("girlsSSKenBellBackCalculationCount") var kenBellBackCalculationCount: Int = 0
    
    func bellBackCalculate(game: Int, bigCount: Int, regCount: Int, coinDifference: Int) -> Int {
        // 各種確率の定義
        let replayDenominate = 7.298   // リプレイ確率
        let cherryDenominate: Double = 33.2   // チェリー確率
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
    @AppStorage("girlsSSStartBackCalculationEnable") var startBackCalculationEnable: Bool = false {
        didSet {
            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
        }
    }
        @AppStorage("girlsSSStartGames") var startGameInput: Int = 0 {
            didSet {
                startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                playGame = currentGames - startGameInput
            }
        }
            @AppStorage("girlsSSStartBigCountInput") var startBigCountInput: Int = 0 {
                didSet {
                    startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                    startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                    totalBigCount = countSum(startBigCountInput, personalBigCountSum)
                }
            }
                @AppStorage("girlsSSStartRegCountInput") var startRegCountInput: Int = 0 {
                    didSet {
                        startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                        totalRegCount = countSum(startRegCountInput, personalRegCountSum)
                    }
                }
                    @AppStorage("girlsSSStartCoinDifferenceInput") var startCoinDifferenceInput: Int = 0 {
                        didSet {
                            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        }
                    }
    @AppStorage("girlsSSStartBonusCountSum") var startBonusCountSum: Int = 0
    @AppStorage("girlsSSStartBellBackCalculationCount") var startBellBackCalculationCount: Int = 0 {
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
    @AppStorage("girlsSSBellCount") var personalBellCount = 0 {
        didSet {
            totalBellCount = countSum(startBellBackCalculationCount, personalBellCount)
        }
    }
    @AppStorage("girlsSSAloneBigCount") var personalAloneBigCount = 0 {
        didSet {
            personalBigCountSum = countSum(personalAloneBigCount, personalCherryBigCount)
        }
    }
    @AppStorage("girlsSSCherryBigCount") var personalCherryBigCount = 0 {
        didSet {
            personalBigCountSum = countSum(personalAloneBigCount, personalCherryBigCount)
        }
    }
        @AppStorage("girlsSSAloneRegCount") var personalAloneRegCount = 0 {
            didSet {
                personalRegCountSum = countSum(personalAloneRegCount, personalCherryRegCount)
            }
        }
            @AppStorage("girlsSSCherryRegCount") var personalCherryRegCount = 0 {
                didSet {
                    personalRegCountSum = countSum(personalAloneRegCount, personalCherryRegCount)
                }
            }
    @AppStorage("girlsSSCurrentGames") var currentGames = 0 {
        didSet {
            playGame = currentGames - startGameInput
        }
    }
    @AppStorage("girlsSSBigCountSum") var personalBigCountSum = 0 {
        didSet {
            personalBonusCountSum = countSum(personalBigCountSum, personalRegCountSum)
            totalBigCount = countSum(startBigCountInput, personalBigCountSum)
        }
    }
    @AppStorage("girlsSSRegCountSum") var personalRegCountSum = 0 {
        didSet {
            personalBonusCountSum = countSum(personalBigCountSum, personalRegCountSum)
            totalRegCount = countSum(startRegCountInput, personalRegCountSum)
        }
    }
    @AppStorage("girlsSSBonusCountSum") var personalBonusCountSum = 0
    @AppStorage("girlsSSPlayGame") var playGame = 0
    
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
    @AppStorage("girlsSSTotalBigCount") var totalBigCount = 0 {
        didSet {
            totalBonusCountSum = countSum(totalBigCount, totalRegCount)
        }
    }
        @AppStorage("girlsSSTotalRegCount") var totalRegCount = 0 {
            didSet {
                totalBonusCountSum = countSum(totalBigCount, totalRegCount)
            }
        }
    @AppStorage("girlsSSTotalBellCount") var totalBellCount = 0
    @AppStorage("girlsSSTotalBonusCountSum") var totalBonusCountSum = 0
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("girlsSSMinusCheck") var minusCheck: Bool = false
    @AppStorage("girlsSSSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetKenDataInput()
        resetStartData()
        resetCountData()
    }
}


// //// メモリー1
class GirlsSSMemory1: ObservableObject {
    @AppStorage("girlsSSKenBackCalculationEnableMemory1") var kenBackCalculationEnable: Bool = false
    @AppStorage("girlsSSKenGameIputMemory1") var kenGameIput: Int = 0
    @AppStorage("girlsSSKenBigCountInputMemory1") var kenBigCountInput: Int = 0
    @AppStorage("girlsSSKenRegCountInputMemory1") var kenRegCountInput: Int = 0
    @AppStorage("girlsSSKenCoinDifferenceInputMemory1") var kenCoinDifferenceInput: Int = 0
    @AppStorage("girlsSSKenBonusCountSumMemory1") var kenBonusCountSum: Int = 0
    @AppStorage("girlsSSKenBellBackCalculationCountMemory1") var kenBellBackCalculationCount: Int = 0
    @AppStorage("girlsSSStartBackCalculationEnableMemory1") var startBackCalculationEnable: Bool = false
    @AppStorage("girlsSSStartGamesMemory1") var startGameInput: Int = 0
    @AppStorage("girlsSSStartBigCountInputMemory1") var startBigCountInput: Int = 0
    @AppStorage("girlsSSStartRegCountInputMemory1") var startRegCountInput: Int = 0
    @AppStorage("girlsSSStartCoinDifferenceInputMemory1") var startCoinDifferenceInput: Int = 0
    @AppStorage("girlsSSStartBonusCountSumMemory1") var startBonusCountSum: Int = 0
    @AppStorage("girlsSSStartBellBackCalculationCountMemory1") var startBellBackCalculationCount: Int = 0
    @AppStorage("girlsSSBellCountMemory1") var personalBellCount = 0
    @AppStorage("girlsSSAloneBigCountMemory1") var personalAloneBigCount = 0
    @AppStorage("girlsSSCherryBigCountMemory1") var personalCherryBigCount = 0
    @AppStorage("girlsSSBigCountSumMemory1") var personalBigCountSum = 0
    @AppStorage("girlsSSAloneRegCountMemory1") var personalAloneRegCount = 0
    @AppStorage("girlsSSCherryRegCountMemory1") var personalCherryRegCount = 0
    @AppStorage("girlsSSCurrentGamesMemory1") var currentGames = 0
    @AppStorage("girlsSSRegCountSumMemory1") var personalRegCountSum = 0
    @AppStorage("girlsSSBonusCountSumMemory1") var personalBonusCountSum = 0
    @AppStorage("girlsSSPlayGameMemory1") var playGame = 0
    @AppStorage("girlsSSTotalBigCountMemory1") var totalBigCount = 0
    @AppStorage("girlsSSTotalRegCountMemory1") var totalRegCount = 0
    @AppStorage("girlsSSTotalBellCountMemory1") var totalBellCount = 0
    @AppStorage("girlsSSTotalBonusCountSumMemory1") var totalBonusCountSum = 0
    @AppStorage("girlsSSMemoMemory1") var memo = ""
    @AppStorage("girlsSSDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class GirlsSSMemory2: ObservableObject {
    @AppStorage("girlsSSKenBackCalculationEnableMemory2") var kenBackCalculationEnable: Bool = false
    @AppStorage("girlsSSKenGameIputMemory2") var kenGameIput: Int = 0
    @AppStorage("girlsSSKenBigCountInputMemory2") var kenBigCountInput: Int = 0
    @AppStorage("girlsSSKenRegCountInputMemory2") var kenRegCountInput: Int = 0
    @AppStorage("girlsSSKenCoinDifferenceInputMemory2") var kenCoinDifferenceInput: Int = 0
    @AppStorage("girlsSSKenBonusCountSumMemory2") var kenBonusCountSum: Int = 0
    @AppStorage("girlsSSKenBellBackCalculationCountMemory2") var kenBellBackCalculationCount: Int = 0
    @AppStorage("girlsSSStartBackCalculationEnableMemory2") var startBackCalculationEnable: Bool = false
    @AppStorage("girlsSSStartGamesMemory2") var startGameInput: Int = 0
    @AppStorage("girlsSSStartBigCountInputMemory2") var startBigCountInput: Int = 0
    @AppStorage("girlsSSStartRegCountInputMemory2") var startRegCountInput: Int = 0
    @AppStorage("girlsSSStartCoinDifferenceInputMemory2") var startCoinDifferenceInput: Int = 0
    @AppStorage("girlsSSStartBonusCountSumMemory2") var startBonusCountSum: Int = 0
    @AppStorage("girlsSSStartBellBackCalculationCountMemory2") var startBellBackCalculationCount: Int = 0
    @AppStorage("girlsSSBellCountMemory2") var personalBellCount = 0
    @AppStorage("girlsSSAloneBigCountMemory2") var personalAloneBigCount = 0
    @AppStorage("girlsSSCherryBigCountMemory2") var personalCherryBigCount = 0
    @AppStorage("girlsSSBigCountSumMemory2") var personalBigCountSum = 0
    @AppStorage("girlsSSAloneRegCountMemory2") var personalAloneRegCount = 0
    @AppStorage("girlsSSCherryRegCountMemory2") var personalCherryRegCount = 0
    @AppStorage("girlsSSCurrentGamesMemory2") var currentGames = 0
    @AppStorage("girlsSSRegCountSumMemory2") var personalRegCountSum = 0
    @AppStorage("girlsSSBonusCountSumMemory2") var personalBonusCountSum = 0
    @AppStorage("girlsSSPlayGameMemory2") var playGame = 0
    @AppStorage("girlsSSTotalBigCountMemory2") var totalBigCount = 0
    @AppStorage("girlsSSTotalRegCountMemory2") var totalRegCount = 0
    @AppStorage("girlsSSTotalBellCountMemory2") var totalBellCount = 0
    @AppStorage("girlsSSTotalBonusCountSumMemory2") var totalBonusCountSum = 0
    @AppStorage("girlsSSMemoMemory2") var memo = ""
    @AppStorage("girlsSSDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class GirlsSSMemory3: ObservableObject {
    @AppStorage("girlsSSKenBackCalculationEnableMemory3") var kenBackCalculationEnable: Bool = false
    @AppStorage("girlsSSKenGameIputMemory3") var kenGameIput: Int = 0
    @AppStorage("girlsSSKenBigCountInputMemory3") var kenBigCountInput: Int = 0
    @AppStorage("girlsSSKenRegCountInputMemory3") var kenRegCountInput: Int = 0
    @AppStorage("girlsSSKenCoinDifferenceInputMemory3") var kenCoinDifferenceInput: Int = 0
    @AppStorage("girlsSSKenBonusCountSumMemory3") var kenBonusCountSum: Int = 0
    @AppStorage("girlsSSKenBellBackCalculationCountMemory3") var kenBellBackCalculationCount: Int = 0
    @AppStorage("girlsSSStartBackCalculationEnableMemory3") var startBackCalculationEnable: Bool = false
    @AppStorage("girlsSSStartGamesMemory3") var startGameInput: Int = 0
    @AppStorage("girlsSSStartBigCountInputMemory3") var startBigCountInput: Int = 0
    @AppStorage("girlsSSStartRegCountInputMemory3") var startRegCountInput: Int = 0
    @AppStorage("girlsSSStartCoinDifferenceInputMemory3") var startCoinDifferenceInput: Int = 0
    @AppStorage("girlsSSStartBonusCountSumMemory3") var startBonusCountSum: Int = 0
    @AppStorage("girlsSSStartBellBackCalculationCountMemory3") var startBellBackCalculationCount: Int = 0
    @AppStorage("girlsSSBellCountMemory3") var personalBellCount = 0
    @AppStorage("girlsSSAloneBigCountMemory3") var personalAloneBigCount = 0
    @AppStorage("girlsSSCherryBigCountMemory3") var personalCherryBigCount = 0
    @AppStorage("girlsSSBigCountSumMemory3") var personalBigCountSum = 0
    @AppStorage("girlsSSAloneRegCountMemory3") var personalAloneRegCount = 0
    @AppStorage("girlsSSCherryRegCountMemory3") var personalCherryRegCount = 0
    @AppStorage("girlsSSCurrentGamesMemory3") var currentGames = 0
    @AppStorage("girlsSSRegCountSumMemory3") var personalRegCountSum = 0
    @AppStorage("girlsSSBonusCountSumMemory3") var personalBonusCountSum = 0
    @AppStorage("girlsSSPlayGameMemory3") var playGame = 0
    @AppStorage("girlsSSTotalBigCountMemory3") var totalBigCount = 0
    @AppStorage("girlsSSTotalRegCountMemory3") var totalRegCount = 0
    @AppStorage("girlsSSTotalBellCountMemory3") var totalBellCount = 0
    @AppStorage("girlsSSTotalBonusCountSumMemory3") var totalBonusCountSum = 0
    @AppStorage("girlsSSMemoMemory3") var memo = ""
    @AppStorage("girlsSSDateMemory3") var dateDouble = 0.0
}
