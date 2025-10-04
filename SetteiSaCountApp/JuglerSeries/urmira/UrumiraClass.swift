//
//  UrumiraClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/01.
//

import Foundation
import SwiftUI

// //////////////////
// 変数
// //////////////////
class Urmira: ObservableObject {
    // ////////////////////////
    // 確率値
    // ////////////////////////
    let denominateListCherry: [Double] = [
        35.1,
        35.0,
        34.8,
        34.7,
        33.5,
        33.0
    ]
    let denominateListBell: [Double] = [
        5.93,
        5.93,
        5.93,
        5.93,
        5.87,
        5.81
    ]
    
    let denominateListBigSum: [Double] = [
        267.5,
        261.1,
        256.0,
        242.7,
        233.2,
        216.3
    ]
    
    let denominateListRegSum: [Double] = [
        425.6,
        402.1,
        350.5,
        322.8,
        297.9,
        277.7,
    ]
    
    let denominateListBonusSum: [Double] = [
        164.2,
        158.3,
        147.9,
        138.6,
        130.8,
        121.6,
    ]
    
    let denominateListBigAlone: [Double] = [
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
    ]

    let denominateListBigCherry: [Double] = [
        -1,
        -1,
        -1,
        -1,
        -1,
        -1
    ]
    
    let denominateListRegAlone: [Double] = [
        -1,
        -1,
        -1,
        -1,
        -1,
        -1
    ]
    
    let denominateListRegCherry: [Double] = [
        -1,
        -1,
        -1,
        -1,
        -1,
        -1
    ]
    
    // ////////////////////////
    // 見
    // ////////////////////////
    @AppStorage("urmiraKenBackCalculationEnable") var kenBackCalculationEnable: Bool = false {
        didSet {
            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
        }
    }
        @AppStorage("urmiraKenGameIput") var kenGameIput: Int = 0 {
            didSet {
                kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
            }
        }
            @AppStorage("urmiraKenBigCountInput") var kenBigCountInput: Int = 0 {
                didSet {
                    kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                    kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                }
            }
                @AppStorage("urmiraKenRegCountInput") var kenRegCountInput: Int = 0 {
                    didSet {
                        kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                    }
                }
                    @AppStorage("urmiraKenCoinDifferenceInput") var kenCoinDifferenceInput: Int = 0 {
                        didSet {
                            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        }
                    }
    @AppStorage("urmiraKenBonusCountSum") var kenBonusCountSum: Int = 0
    @AppStorage("urmiraKenBellBackCalculationCount") var kenBellBackCalculationCount: Int = 0
    
    func bellBackCalculate(game: Int, bigCount: Int, regCount: Int, coinDifference: Int) -> Int {
        // 各種確率の定義
        let replayDenominate = 7.298   // リプレイ確率
        let cherryDenominate: Double = 35.0   // チェリー確率
        let suikaDenominate: Double = 1024.0   // ベル確率
        let pieroDenominate: Double = 1024.0   // ピエロ確率
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
    @AppStorage("urmiraStartBackCalculationEnable") var startBackCalculationEnable: Bool = false {
        didSet {
            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
        }
    }
        @AppStorage("urmiraStartGames") var startGameInput: Int = 0 {
            didSet {
                startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                playGame = currentGames - startGameInput
            }
        }
            @AppStorage("urmiraStartBigCountInput") var startBigCountInput: Int = 0 {
                didSet {
                    startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                    startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                    totalBigCount = countSum(startBigCountInput, personalBigCountSum)
                }
            }
                @AppStorage("urmiraStartRegCountInput") var startRegCountInput: Int = 0 {
                    didSet {
                        startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                        totalRegCount = countSum(startRegCountInput, personalRegCountSum)
                    }
                }
                    @AppStorage("urmiraStartCoinDifferenceInput") var startCoinDifferenceInput: Int = 0 {
                        didSet {
                            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        }
                    }
    @AppStorage("urmiraStartBonusCountSum") var startBonusCountSum: Int = 0
    @AppStorage("urmiraStartBellBackCalculationCount") var startBellBackCalculationCount: Int = 0 {
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
    @AppStorage("urmiraBellCount") var personalBellCount = 0 {
        didSet {
            totalBellCount = countSum(startBellBackCalculationCount, personalBellCount)
        }
    }
    @AppStorage("urmiraAloneBigCount") var personalAloneBigCount = 0 {
        didSet {
            personalBigCountSum = countSum(personalAloneBigCount, personalCherryBigCount)
        }
    }
    @AppStorage("urmiraCherryBigCount") var personalCherryBigCount = 0 {
        didSet {
            personalBigCountSum = countSum(personalAloneBigCount, personalCherryBigCount)
        }
    }
        @AppStorage("urmiraAloneRegCount") var personalAloneRegCount = 0 {
            didSet {
                personalRegCountSum = countSum(personalAloneRegCount, personalCherryRegCount)
            }
        }
            @AppStorage("urmiraCherryRegCount") var personalCherryRegCount = 0 {
                didSet {
                    personalRegCountSum = countSum(personalAloneRegCount, personalCherryRegCount)
                }
            }
    @AppStorage("urmiraCurrentGames") var currentGames = 0 {
        didSet {
            playGame = currentGames - startGameInput
        }
    }
    @AppStorage("urmiraBigCountSum") var personalBigCountSum = 0 {
        didSet {
            personalBonusCountSum = countSum(personalBigCountSum, personalRegCountSum)
            totalBigCount = countSum(startBigCountInput, personalBigCountSum)
        }
    }
    @AppStorage("urmiraRegCountSum") var personalRegCountSum = 0 {
        didSet {
            personalBonusCountSum = countSum(personalBigCountSum, personalRegCountSum)
            totalRegCount = countSum(startRegCountInput, personalRegCountSum)
        }
    }
    @AppStorage("urmiraBonusCountSum") var personalBonusCountSum = 0
    @AppStorage("urmiraPlayGame") var playGame = 0
    @AppStorage("urmiraPersonalCherryCount") var personalCherryCount: Int = 0
    
    func resetCountData() {
        personalBellCount = 0
        personalAloneBigCount = 0
        personalCherryBigCount = 0
        personalAloneRegCount = 0
        personalCherryRegCount = 0
        currentGames = 0
        minusCheck = false
        personalCherryCount = 0
    }
    
    // ////////////////////////
    // 実戦 トータル結果
    // ////////////////////////
    @AppStorage("urmiraTotalBigCount") var totalBigCount = 0 {
        didSet {
            totalBonusCountSum = countSum(totalBigCount, totalRegCount)
        }
    }
        @AppStorage("urmiraTotalRegCount") var totalRegCount = 0 {
            didSet {
                totalBonusCountSum = countSum(totalBigCount, totalRegCount)
            }
        }
    @AppStorage("urmiraTotalBellCount") var totalBellCount = 0
    @AppStorage("urmiraTotalBonusCountSum") var totalBonusCountSum = 0
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "ウルトラミラクルジャグラー"
    @AppStorage("urmiraMinusCheck") var minusCheck: Bool = false
    @AppStorage("urmiraSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetKenDataInput()
        resetStartData()
        resetCountData()
    }
}


// //// メモリー1
class UrmiraMemory1: ObservableObject {
    @AppStorage("urmiraKenBackCalculationEnableMemory1") var kenBackCalculationEnable: Bool = false
    @AppStorage("urmiraKenGameIputMemory1") var kenGameIput: Int = 0
    @AppStorage("urmiraKenBigCountInputMemory1") var kenBigCountInput: Int = 0
    @AppStorage("urmiraKenRegCountInputMemory1") var kenRegCountInput: Int = 0
    @AppStorage("urmiraKenCoinDifferenceInputMemory1") var kenCoinDifferenceInput: Int = 0
    @AppStorage("urmiraKenBonusCountSumMemory1") var kenBonusCountSum: Int = 0
    @AppStorage("urmiraKenBellBackCalculationCountMemory1") var kenBellBackCalculationCount: Int = 0
    @AppStorage("urmiraStartBackCalculationEnableMemory1") var startBackCalculationEnable: Bool = false
    @AppStorage("urmiraStartGamesMemory1") var startGameInput: Int = 0
    @AppStorage("urmiraStartBigCountInputMemory1") var startBigCountInput: Int = 0
    @AppStorage("urmiraStartRegCountInputMemory1") var startRegCountInput: Int = 0
    @AppStorage("urmiraStartCoinDifferenceInputMemory1") var startCoinDifferenceInput: Int = 0
    @AppStorage("urmiraStartBonusCountSumMemory1") var startBonusCountSum: Int = 0
    @AppStorage("urmiraStartBellBackCalculationCountMemory1") var startBellBackCalculationCount: Int = 0
    @AppStorage("urmiraBellCountMemory1") var personalBellCount = 0
    @AppStorage("urmiraAloneBigCountMemory1") var personalAloneBigCount = 0
    @AppStorage("urmiraCherryBigCountMemory1") var personalCherryBigCount = 0
    @AppStorage("urmiraBigCountSumMemory1") var personalBigCountSum = 0
    @AppStorage("urmiraAloneRegCountMemory1") var personalAloneRegCount = 0
    @AppStorage("urmiraCherryRegCountMemory1") var personalCherryRegCount = 0
    @AppStorage("urmiraCurrentGamesMemory1") var currentGames = 0
    @AppStorage("urmiraRegCountSumMemory1") var personalRegCountSum = 0
    @AppStorage("urmiraBonusCountSumMemory1") var personalBonusCountSum = 0
    @AppStorage("urmiraPlayGameMemory1") var playGame = 0
    @AppStorage("urmiraTotalBigCountMemory1") var totalBigCount = 0
    @AppStorage("urmiraTotalRegCountMemory1") var totalRegCount = 0
    @AppStorage("urmiraTotalBellCountMemory1") var totalBellCount = 0
    @AppStorage("urmiraTotalBonusCountSumMemory1") var totalBonusCountSum = 0
    @AppStorage("urmiraPersonalCherryCountMemory1") var personalCherryCount: Int = 0
    @AppStorage("urmiraMemoMemory1") var memo = ""
    @AppStorage("urmiraDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class UrmiraMemory2: ObservableObject {
    @AppStorage("urmiraKenBackCalculationEnableMemory2") var kenBackCalculationEnable: Bool = false
    @AppStorage("urmiraKenGameIputMemory2") var kenGameIput: Int = 0
    @AppStorage("urmiraKenBigCountInputMemory2") var kenBigCountInput: Int = 0
    @AppStorage("urmiraKenRegCountInputMemory2") var kenRegCountInput: Int = 0
    @AppStorage("urmiraKenCoinDifferenceInputMemory2") var kenCoinDifferenceInput: Int = 0
    @AppStorage("urmiraKenBonusCountSumMemory2") var kenBonusCountSum: Int = 0
    @AppStorage("urmiraKenBellBackCalculationCountMemory2") var kenBellBackCalculationCount: Int = 0
    @AppStorage("urmiraStartBackCalculationEnableMemory2") var startBackCalculationEnable: Bool = false
    @AppStorage("urmiraStartGamesMemory2") var startGameInput: Int = 0
    @AppStorage("urmiraStartBigCountInputMemory2") var startBigCountInput: Int = 0
    @AppStorage("urmiraStartRegCountInputMemory2") var startRegCountInput: Int = 0
    @AppStorage("urmiraStartCoinDifferenceInputMemory2") var startCoinDifferenceInput: Int = 0
    @AppStorage("urmiraStartBonusCountSumMemory2") var startBonusCountSum: Int = 0
    @AppStorage("urmiraStartBellBackCalculationCountMemory2") var startBellBackCalculationCount: Int = 0
    @AppStorage("urmiraBellCountMemory2") var personalBellCount = 0
    @AppStorage("urmiraAloneBigCountMemory2") var personalAloneBigCount = 0
    @AppStorage("urmiraCherryBigCountMemory2") var personalCherryBigCount = 0
    @AppStorage("urmiraBigCountSumMemory2") var personalBigCountSum = 0
    @AppStorage("urmiraAloneRegCountMemory2") var personalAloneRegCount = 0
    @AppStorage("urmiraCherryRegCountMemory2") var personalCherryRegCount = 0
    @AppStorage("urmiraCurrentGamesMemory2") var currentGames = 0
    @AppStorage("urmiraRegCountSumMemory2") var personalRegCountSum = 0
    @AppStorage("urmiraBonusCountSumMemory2") var personalBonusCountSum = 0
    @AppStorage("urmiraPlayGameMemory2") var playGame = 0
    @AppStorage("urmiraTotalBigCountMemory2") var totalBigCount = 0
    @AppStorage("urmiraTotalRegCountMemory2") var totalRegCount = 0
    @AppStorage("urmiraTotalBellCountMemory2") var totalBellCount = 0
    @AppStorage("urmiraTotalBonusCountSumMemory2") var totalBonusCountSum = 0
    @AppStorage("urmiraPersonalCherryCountMemory2") var personalCherryCount: Int = 0
    @AppStorage("urmiraMemoMemory2") var memo = ""
    @AppStorage("urmiraDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class UrmiraMemory3: ObservableObject {
    @AppStorage("urmiraKenBackCalculationEnableMemory3") var kenBackCalculationEnable: Bool = false
    @AppStorage("urmiraKenGameIputMemory3") var kenGameIput: Int = 0
    @AppStorage("urmiraKenBigCountInputMemory3") var kenBigCountInput: Int = 0
    @AppStorage("urmiraKenRegCountInputMemory3") var kenRegCountInput: Int = 0
    @AppStorage("urmiraKenCoinDifferenceInputMemory3") var kenCoinDifferenceInput: Int = 0
    @AppStorage("urmiraKenBonusCountSumMemory3") var kenBonusCountSum: Int = 0
    @AppStorage("urmiraKenBellBackCalculationCountMemory3") var kenBellBackCalculationCount: Int = 0
    @AppStorage("urmiraStartBackCalculationEnableMemory3") var startBackCalculationEnable: Bool = false
    @AppStorage("urmiraStartGamesMemory3") var startGameInput: Int = 0
    @AppStorage("urmiraStartBigCountInputMemory3") var startBigCountInput: Int = 0
    @AppStorage("urmiraStartRegCountInputMemory3") var startRegCountInput: Int = 0
    @AppStorage("urmiraStartCoinDifferenceInputMemory3") var startCoinDifferenceInput: Int = 0
    @AppStorage("urmiraStartBonusCountSumMemory3") var startBonusCountSum: Int = 0
    @AppStorage("urmiraStartBellBackCalculationCountMemory3") var startBellBackCalculationCount: Int = 0
    @AppStorage("urmiraBellCountMemory3") var personalBellCount = 0
    @AppStorage("urmiraAloneBigCountMemory3") var personalAloneBigCount = 0
    @AppStorage("urmiraCherryBigCountMemory3") var personalCherryBigCount = 0
    @AppStorage("urmiraBigCountSumMemory3") var personalBigCountSum = 0
    @AppStorage("urmiraAloneRegCountMemory3") var personalAloneRegCount = 0
    @AppStorage("urmiraCherryRegCountMemory3") var personalCherryRegCount = 0
    @AppStorage("urmiraCurrentGamesMemory3") var currentGames = 0
    @AppStorage("urmiraRegCountSumMemory3") var personalRegCountSum = 0
    @AppStorage("urmiraBonusCountSumMemory3") var personalBonusCountSum = 0
    @AppStorage("urmiraPlayGameMemory3") var playGame = 0
    @AppStorage("urmiraTotalBigCountMemory3") var totalBigCount = 0
    @AppStorage("urmiraTotalRegCountMemory3") var totalRegCount = 0
    @AppStorage("urmiraTotalBellCountMemory3") var totalBellCount = 0
    @AppStorage("urmiraTotalBonusCountSumMemory3") var totalBonusCountSum = 0
    @AppStorage("urmiraPersonalCherryCountMemory3") var personalCherryCount: Int = 0
    @AppStorage("urmiraMemoMemory3") var memo = ""
    @AppStorage("urmiraDateMemory3") var dateDouble = 0.0
}

