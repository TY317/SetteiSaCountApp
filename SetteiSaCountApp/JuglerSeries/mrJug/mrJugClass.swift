//
//  mrJugClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/08.
//

import Foundation
import SwiftUI

// //////////////////
// 変数
// //////////////////
class MrJug: ObservableObject {
    // ////////////////////////
    // 確率値
    // ////////////////////////
    let denominateListBell: [Double] = [
        6.29,
        6.22,
        6.15,
        6.09,
        6.02,
        5.96
    ]
    
    let denominateListBigSum: [Double] = [
        268.6,
        267.5,
        260.1,
        249.2,
        240.9,
        237.4
    ]
    
    let denominateListRegSum: [Double] = [
        374.5,
        354.2,
        331.0,
        291.3,
        257.0,
        237.4
    ]
    
    let denominateListBonusSum: [Double] = [
        156.4,
        152.4,
        145.6,
        134.3,
        124.4,
        118.7
    ]
    
    let denominateListBigAlone: [Double] = [
        354.19,
        352.74,
        341.66,
        330.01,
        320.22,
        313.88,
    ]
    
    let denominateListBigCherry: [Double] = [
        1688.53,
        1681.62,
        1655.12,
        1508.25,
        1410.02,
        1385.39,
    ]
    
    let denominateListRegAlone: [Double] = [
        517.48,
        480.53,
        447.2,
        384.32,
        329.41,
        298.65,
    ]
    
    let denominateListRegCherry: [Double] = [
        1620.67,
        1599.82,
        1503.26,
        1411.79,
        1357.06,
        1331.13,
    ]
    
    // ////////////////////////
    // 見
    // ////////////////////////
    @AppStorage("mrJugKenBackCalculationEnable") var kenBackCalculationEnable: Bool = false {
        didSet {
            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
        }
    }
        @AppStorage("mrJugKenGameIput") var kenGameIput: Int = 0 {
            didSet {
                kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
            }
        }
            @AppStorage("mrJugKenBigCountInput") var kenBigCountInput: Int = 0 {
                didSet {
                    kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                    kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                }
            }
                @AppStorage("mrJugKenRegCountInput") var kenRegCountInput: Int = 0 {
                    didSet {
                        kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                    }
                }
                    @AppStorage("mrJugKenCoinDifferenceInput") var kenCoinDifferenceInput: Int = 0 {
                        didSet {
                            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        }
                    }
    @AppStorage("mrJugKenBonusCountSum") var kenBonusCountSum: Int = 0
    @AppStorage("mrJugKenBellBackCalculationCount") var kenBellBackCalculationCount: Int = 0
    
    func bellBackCalculate(game: Int, bigCount: Int, regCount: Int, coinDifference: Int) -> Int {
        // 各種確率の定義
        let replayDenominate = 7.298   // リプレイ確率
        let cherryDenominate: Double = 37.24   // チェリー確率
        let suikaDenominate: Double = 655.36   // ベル確率
        let pieroDenominate: Double = 420.1   // ピエロ確率
        let cherryGetRatio = 0.9   // チェリー奪取率
        let suikaGetRatio: Double = 0.75   // ベル奪取率、V2スロマガ情報より
        let pieroGetRatio: Double = 0.75   // ピエロ奪取率、V2スロマガ情報より
        let budonukiAverageGame = 1.31   // ぶどう抜き平均消化ゲーム数（1枚がけ）
        let budonukiAverageIn = 1.13   // ぶどう抜き平均IN枚数
        let budonukiAverageOut = 1.01   // ぶどう抜き平均OUT枚数
        let bigOut: Double = 240   // ビッグ獲得枚数
        let regOut: Double = 96   // REG獲得枚数
        let cherryOut: Double = 4   // チェリー払い出し枚数
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
    @AppStorage("mrJugStartBackCalculationEnable") var startBackCalculationEnable: Bool = false {
        didSet {
            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
        }
    }
        @AppStorage("mrJugStartGames") var startGameInput: Int = 0 {
            didSet {
                startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                playGame = currentGames - startGameInput
            }
        }
            @AppStorage("mrJugStartBigCountInput") var startBigCountInput: Int = 0 {
                didSet {
                    startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                    startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                    totalBigCount = countSum(startBigCountInput, personalBigCountSum)
                }
            }
                @AppStorage("mrJugStartRegCountInput") var startRegCountInput: Int = 0 {
                    didSet {
                        startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                        totalRegCount = countSum(startRegCountInput, personalRegCountSum)
                    }
                }
                    @AppStorage("mrJugStartCoinDifferenceInput") var startCoinDifferenceInput: Int = 0 {
                        didSet {
                            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        }
                    }
    @AppStorage("mrJugStartBonusCountSum") var startBonusCountSum: Int = 0
    @AppStorage("mrJugStartBellBackCalculationCount") var startBellBackCalculationCount: Int = 0 {
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
    @AppStorage("mrJugBellCount") var personalBellCount = 0 {
        didSet {
            totalBellCount = countSum(startBellBackCalculationCount, personalBellCount)
        }
    }
    @AppStorage("mrJugAloneBigCount") var personalAloneBigCount = 0 {
        didSet {
            personalBigCountSum = countSum(personalAloneBigCount, personalCherryBigCount)
        }
    }
    @AppStorage("mrJugCherryBigCount") var personalCherryBigCount = 0 {
        didSet {
            personalBigCountSum = countSum(personalAloneBigCount, personalCherryBigCount)
        }
    }
        @AppStorage("mrJugAloneRegCount") var personalAloneRegCount = 0 {
            didSet {
                personalRegCountSum = countSum(personalAloneRegCount, personalCherryRegCount)
            }
        }
            @AppStorage("mrJugCherryRegCount") var personalCherryRegCount = 0 {
                didSet {
                    personalRegCountSum = countSum(personalAloneRegCount, personalCherryRegCount)
                }
            }
    @AppStorage("mrJugCurrentGames") var currentGames = 0 {
        didSet {
            playGame = currentGames - startGameInput
        }
    }
    @AppStorage("mrJugBigCountSum") var personalBigCountSum = 0 {
        didSet {
            personalBonusCountSum = countSum(personalBigCountSum, personalRegCountSum)
            totalBigCount = countSum(startBigCountInput, personalBigCountSum)
        }
    }
    @AppStorage("mrJugRegCountSum") var personalRegCountSum = 0 {
        didSet {
            personalBonusCountSum = countSum(personalBigCountSum, personalRegCountSum)
            totalRegCount = countSum(startRegCountInput, personalRegCountSum)
        }
    }
    @AppStorage("mrJugBonusCountSum") var personalBonusCountSum = 0
    @AppStorage("mrJugPlayGame") var playGame = 0
    
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
    @AppStorage("mrJugTotalBigCount") var totalBigCount = 0 {
        didSet {
            totalBonusCountSum = countSum(totalBigCount, totalRegCount)
        }
    }
        @AppStorage("mrJugTotalRegCount") var totalRegCount = 0 {
            didSet {
                totalBonusCountSum = countSum(totalBigCount, totalRegCount)
            }
        }
    @AppStorage("mrJugTotalBellCount") var totalBellCount = 0
    @AppStorage("mrJugTotalBonusCountSum") var totalBonusCountSum = 0
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "ミスタージャグラー"
    @AppStorage("mrJugMinusCheck") var minusCheck: Bool = false
    @AppStorage("mrJugSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetKenDataInput()
        resetStartData()
        resetCountData()
    }
    
    // ////////
    // 島合算
    // ////////
    @AppStorage("mrJugShimaGames") var shimaGames: Int = 0
    @AppStorage("mrJugShimaBigs") var shimaBigs: Int = 0
    @AppStorage("mrJugShimaRegs") var shimaRegs: Int = 0
    @AppStorage("mrJugShimaBonusSum") var shimaBonusSum: Int = 0
}


// //// メモリー1
class MrJugMemory1: ObservableObject {
    @AppStorage("mrJugKenBackCalculationEnableMemory1") var kenBackCalculationEnable: Bool = false
    @AppStorage("mrJugKenGameIputMemory1") var kenGameIput: Int = 0
    @AppStorage("mrJugKenBigCountInputMemory1") var kenBigCountInput: Int = 0
    @AppStorage("mrJugKenRegCountInputMemory1") var kenRegCountInput: Int = 0
    @AppStorage("mrJugKenCoinDifferenceInputMemory1") var kenCoinDifferenceInput: Int = 0
    @AppStorage("mrJugKenBonusCountSumMemory1") var kenBonusCountSum: Int = 0
    @AppStorage("mrJugKenBellBackCalculationCountMemory1") var kenBellBackCalculationCount: Int = 0
    @AppStorage("mrJugStartBackCalculationEnableMemory1") var startBackCalculationEnable: Bool = false
    @AppStorage("mrJugStartGamesMemory1") var startGameInput: Int = 0
    @AppStorage("mrJugStartBigCountInputMemory1") var startBigCountInput: Int = 0
    @AppStorage("mrJugStartRegCountInputMemory1") var startRegCountInput: Int = 0
    @AppStorage("mrJugStartCoinDifferenceInputMemory1") var startCoinDifferenceInput: Int = 0
    @AppStorage("mrJugStartBonusCountSumMemory1") var startBonusCountSum: Int = 0
    @AppStorage("mrJugStartBellBackCalculationCountMemory1") var startBellBackCalculationCount: Int = 0
    @AppStorage("mrJugBellCountMemory1") var personalBellCount = 0
    @AppStorage("mrJugAloneBigCountMemory1") var personalAloneBigCount = 0
    @AppStorage("mrJugCherryBigCountMemory1") var personalCherryBigCount = 0
    @AppStorage("mrJugBigCountSumMemory1") var personalBigCountSum = 0
    @AppStorage("mrJugAloneRegCountMemory1") var personalAloneRegCount = 0
    @AppStorage("mrJugCherryRegCountMemory1") var personalCherryRegCount = 0
    @AppStorage("mrJugCurrentGamesMemory1") var currentGames = 0
    @AppStorage("mrJugRegCountSumMemory1") var personalRegCountSum = 0
    @AppStorage("mrJugBonusCountSumMemory1") var personalBonusCountSum = 0
    @AppStorage("mrJugPlayGameMemory1") var playGame = 0
    @AppStorage("mrJugTotalBigCountMemory1") var totalBigCount = 0
    @AppStorage("mrJugTotalRegCountMemory1") var totalRegCount = 0
    @AppStorage("mrJugTotalBellCountMemory1") var totalBellCount = 0
    @AppStorage("mrJugTotalBonusCountSumMemory1") var totalBonusCountSum = 0
    @AppStorage("mrJugMemoMemory1") var memo = ""
    @AppStorage("mrJugDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class MrJugMemory2: ObservableObject {
    @AppStorage("mrJugKenBackCalculationEnableMemory2") var kenBackCalculationEnable: Bool = false
    @AppStorage("mrJugKenGameIputMemory2") var kenGameIput: Int = 0
    @AppStorage("mrJugKenBigCountInputMemory2") var kenBigCountInput: Int = 0
    @AppStorage("mrJugKenRegCountInputMemory2") var kenRegCountInput: Int = 0
    @AppStorage("mrJugKenCoinDifferenceInputMemory2") var kenCoinDifferenceInput: Int = 0
    @AppStorage("mrJugKenBonusCountSumMemory2") var kenBonusCountSum: Int = 0
    @AppStorage("mrJugKenBellBackCalculationCountMemory2") var kenBellBackCalculationCount: Int = 0
    @AppStorage("mrJugStartBackCalculationEnableMemory2") var startBackCalculationEnable: Bool = false
    @AppStorage("mrJugStartGamesMemory2") var startGameInput: Int = 0
    @AppStorage("mrJugStartBigCountInputMemory2") var startBigCountInput: Int = 0
    @AppStorage("mrJugStartRegCountInputMemory2") var startRegCountInput: Int = 0
    @AppStorage("mrJugStartCoinDifferenceInputMemory2") var startCoinDifferenceInput: Int = 0
    @AppStorage("mrJugStartBonusCountSumMemory2") var startBonusCountSum: Int = 0
    @AppStorage("mrJugStartBellBackCalculationCountMemory2") var startBellBackCalculationCount: Int = 0
    @AppStorage("mrJugBellCountMemory2") var personalBellCount = 0
    @AppStorage("mrJugAloneBigCountMemory2") var personalAloneBigCount = 0
    @AppStorage("mrJugCherryBigCountMemory2") var personalCherryBigCount = 0
    @AppStorage("mrJugBigCountSumMemory2") var personalBigCountSum = 0
    @AppStorage("mrJugAloneRegCountMemory2") var personalAloneRegCount = 0
    @AppStorage("mrJugCherryRegCountMemory2") var personalCherryRegCount = 0
    @AppStorage("mrJugCurrentGamesMemory2") var currentGames = 0
    @AppStorage("mrJugRegCountSumMemory2") var personalRegCountSum = 0
    @AppStorage("mrJugBonusCountSumMemory2") var personalBonusCountSum = 0
    @AppStorage("mrJugPlayGameMemory2") var playGame = 0
    @AppStorage("mrJugTotalBigCountMemory2") var totalBigCount = 0
    @AppStorage("mrJugTotalRegCountMemory2") var totalRegCount = 0
    @AppStorage("mrJugTotalBellCountMemory2") var totalBellCount = 0
    @AppStorage("mrJugTotalBonusCountSumMemory2") var totalBonusCountSum = 0
    @AppStorage("mrJugMemoMemory2") var memo = ""
    @AppStorage("mrJugDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class MrJugMemory3: ObservableObject {
    @AppStorage("mrJugKenBackCalculationEnableMemory3") var kenBackCalculationEnable: Bool = false
    @AppStorage("mrJugKenGameIputMemory3") var kenGameIput: Int = 0
    @AppStorage("mrJugKenBigCountInputMemory3") var kenBigCountInput: Int = 0
    @AppStorage("mrJugKenRegCountInputMemory3") var kenRegCountInput: Int = 0
    @AppStorage("mrJugKenCoinDifferenceInputMemory3") var kenCoinDifferenceInput: Int = 0
    @AppStorage("mrJugKenBonusCountSumMemory3") var kenBonusCountSum: Int = 0
    @AppStorage("mrJugKenBellBackCalculationCountMemory3") var kenBellBackCalculationCount: Int = 0
    @AppStorage("mrJugStartBackCalculationEnableMemory3") var startBackCalculationEnable: Bool = false
    @AppStorage("mrJugStartGamesMemory3") var startGameInput: Int = 0
    @AppStorage("mrJugStartBigCountInputMemory3") var startBigCountInput: Int = 0
    @AppStorage("mrJugStartRegCountInputMemory3") var startRegCountInput: Int = 0
    @AppStorage("mrJugStartCoinDifferenceInputMemory3") var startCoinDifferenceInput: Int = 0
    @AppStorage("mrJugStartBonusCountSumMemory3") var startBonusCountSum: Int = 0
    @AppStorage("mrJugStartBellBackCalculationCountMemory3") var startBellBackCalculationCount: Int = 0
    @AppStorage("mrJugBellCountMemory3") var personalBellCount = 0
    @AppStorage("mrJugAloneBigCountMemory3") var personalAloneBigCount = 0
    @AppStorage("mrJugCherryBigCountMemory3") var personalCherryBigCount = 0
    @AppStorage("mrJugBigCountSumMemory3") var personalBigCountSum = 0
    @AppStorage("mrJugAloneRegCountMemory3") var personalAloneRegCount = 0
    @AppStorage("mrJugCherryRegCountMemory3") var personalCherryRegCount = 0
    @AppStorage("mrJugCurrentGamesMemory3") var currentGames = 0
    @AppStorage("mrJugRegCountSumMemory3") var personalRegCountSum = 0
    @AppStorage("mrJugBonusCountSumMemory3") var personalBonusCountSum = 0
    @AppStorage("mrJugPlayGameMemory3") var playGame = 0
    @AppStorage("mrJugTotalBigCountMemory3") var totalBigCount = 0
    @AppStorage("mrJugTotalRegCountMemory3") var totalRegCount = 0
    @AppStorage("mrJugTotalBellCountMemory3") var totalBellCount = 0
    @AppStorage("mrJugTotalBonusCountSumMemory3") var totalBonusCountSum = 0
    @AppStorage("mrJugMemoMemory3") var memo = ""
    @AppStorage("mrJugDateMemory3") var dateDouble = 0.0
}
