//
//  newKingHanaClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/16.
//

import Foundation
import SwiftUI
import Combine

class NewKingHana: ObservableObject {
    // -------
    // 確率値
    // -------
    let ratioBell: [Double] = [7.41,7.39,7.35,7.31,7.25]
    let ratioFirstHitBig: [Double] = [299,291,281,268,253]
    let ratioFirstHitReg: [Double] = [496,471,442,409,372]
    let ratioFirstHitSum: [Double] = [186,180,172,162,150]
    let ratioBigSuika: [Double] = [48,44,42,40,32]
    let ratioSideLampBlue: [Double] = [36,23,33,22,25]
    let ratioSideLampYellow: [Double] = [24,35,22,32,25]
    let ratioSideLampGreen: [Double] = [24,17,27,18,25]
    let ratioSideLampRed: [Double] = [16,25,18,28,25]
    let ratioSideLampRainbow: [Double] = [0.05,0.06,0.08,0.20,0.80]
    let ratioSideLampKisu: [Double] = [60,40,60,40,50]
    let ratioBigTopLampBlue: [Double] = [3.6,4.1,4.3,4.9,5.8]
    let ratioBigTopLampYellow: [Double] = [2.9,3.0,3.5,3.9,4.6]
    let ratioBigTopLampGreen: [Double] = [1.9,2.1,2.3,2.5,3.1]
    let ratioBigTopLampPurple: [Double] = [1.3,1.4,1.5,1.6,1.9]
    let ratioBigTopLampRainbow: [Double] = [0.01,0.04,0.07,0.07,0.4]
    let ratioBigTopLampSum: [Double] = [9.7,10.6,11.7,13,15.8]
    let ratioRegSuika: [Double] = [-1,-1,-1,-1,-1,]
    
    // ------
    // ぶどう逆算
    // ------
    func bellBackCalculate(game: Int, bigCount: Int, regCount: Int, coinDifference: Int) -> Int {
        // 各種確率の定義
        let replayDenominate = 7.298   // リプレイ確率
        let cherryDenominate: Double = 48.0   // チェリー確率
        let suikaDenominate: Double = 160.0   // スイカ確率
        let cherryGetRatio = 0.8   // チェリー奪取率
        let suikaGetRatio: Double = 0.6   // スイカ奪取率
        let bigFirstHalfGame: Double = 14   // BIG前半のゲーム数
        let bigFirstHalfNeedMedal: Double = 1.0   // BIG前半 何枚がけか？
        let btGame: Double = 1.14   // BT中の平均ゲーム数
        let btNeedMedal: Double = 2.0   // BT中 何枚がけか？
        let duringBtBellDeno: Double = 8.0   // BT中 ベルの成立確率分母
        let bigSecondHalfGame: Double = 11   // BIG後半のゲーム数
        let bigSecondHalfNeedMedal: Double = 2.0   // BIG後半 何枚がけか？
        let regGame: Double = 10   // REGのゲーム数
        let regNeedMedal: Double = 1.0   // REG 何枚がけか？
        let cherryOut: Double = 4   // チェリー払い出し枚数
        let bellOut: Double = 8   // ぶどう・ベル払い出し枚数
        let suikaOut: Double = 10   // スイカ払い出し枚数
        let bonusOut: Double = 14   // ボーナス中の１ゲームあたりの払い出し枚数
        
        // ---- ゲーム数の内訳算出
        let replayGame = Double(game) / replayDenominate
        let normalGame = Double(game) - replayGame
        
        // ---- IN枚数の計算
        let normalGameIn = normalGame * 3   // 通常ゲームでのIN
        let bigFirstHalfIn = Double(bigCount) * bigFirstHalfGame * bigFirstHalfNeedMedal   // BIG前半でのIN
        let btIn = Double(bigCount) * btGame * btNeedMedal   // BTでのIN
        let bigSecondHalfIn = Double(bigCount) * bigSecondHalfGame * bigSecondHalfNeedMedal   // BIG後半でのIN
        let regIn = Double(regCount) * regGame * regNeedMedal   // REGでのIN
        let totalIn = normalGameIn + bigFirstHalfIn + btIn + bigSecondHalfIn + regIn
        
        // ---- OUT枚数の計算
        let bigFirstHalfOut = Double(bigCount) * bigFirstHalfGame * bonusOut   // BIG前半でのOUT
        let btOut = Double(bigCount) * btGame / duringBtBellDeno * bonusOut   // BTでのOUT
        let bigSecondHalfOut = Double(bigCount) * bigSecondHalfGame * bonusOut   // BIG後半でのOUT
        let regOut = Double(regCount) * regGame * bonusOut   // REGでのOUT
        let cherryOutTotal = Double(game) / cherryDenominate * cherryOut * cherryGetRatio   // 通常時チェリーでのOUt
        let suikaOutTotal = Double(game) / suikaDenominate * suikaOut * suikaGetRatio   // 通常時スイカでのOUT
        let outTotalWithoutBell = cherryOutTotal + suikaOutTotal + bigFirstHalfOut + btOut + bigSecondHalfOut + regOut   // OUTトータル
        
        // ---- ベル回数の算出
        let bellOutTotal = Double(coinDifference) - outTotalWithoutBell + totalIn   // ベルでのOUT
        let bellBackCalculateCount = Int(bellOutTotal / bellOut)   // ベル回数逆算値
        
        return bellBackCalculateCount
    }
    
    // -----
    // 見 データ入力
    // -----
    @AppStorage("newKingHanaKenBackCalculationEnable") var kenBackCalculationEnable: Bool = false
    @AppStorage("newKingHanaKenGameIput") var kenGameIput: Int = 0
    @AppStorage("newKingHanaKenBigCountInput") var kenBigCountInput: Int = 0
    @AppStorage("newKingHanaKenRegCountInput") var kenRegCountInput: Int = 0
    @AppStorage("newKingHanaKenCoinDifferenceInput") var kenCoinDifferenceInput: Int = 0
    @AppStorage("newKingHanaKenBonusCountSum") var kenBonusCountSum: Int = 0
    @AppStorage("newKingHanaKenBellBackCalculationCount") var kenBellBackCalculationCount: Int = 0
    
    func kenBonusSumFunc() {
        kenBonusCountSum = kenBigCountInput + kenRegCountInput
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
        kenBonusCountSum = 0
        kenBellBackCalculationCount = 0
        minusCheck = false
    }
    
    // --------
    // 実戦 打ち始めデータ
    // --------
    @AppStorage("newKingHanaStartBackCalculationEnable") var startBackCalculationEnable: Bool = false
    @AppStorage("newKingHanaStartGames") var startGameInput: Int = 0
    @AppStorage("newKingHanaStartBigCountInput") var startBigCountInput: Int = 0
    @AppStorage("newKingHanaStartRegCountInput") var startRegCountInput: Int = 0
    @AppStorage("newKingHanaStartCoinDifferenceInput") var startCoinDifferenceInput: Int = 0
    @AppStorage("newKingHanaStartBonusCountSum") var startBonusCountSum: Int = 0
    @AppStorage("newKingHanaStartBellBackCalculationCount") var startBellBackCalculationCount: Int = 0
    
    func startBonusSumFunc() {
        startBonusCountSum = startBigCountInput + startRegCountInput
    }
    
    func resetStartData() {
        startGameInput = 0
        startBigCountInput = 0
        startRegCountInput = 0
        startCoinDifferenceInput = 0
        startBonusCountSum = 0
        startBellBackCalculationCount = 0
        minusCheck = false
    }
    
    // --------
    // 実戦
    // --------
    @AppStorage("newKingHanaBellCount") var bellCount: Int = 0
    @AppStorage("newKingHanaBigCount") var bigCount: Int = 0
    @AppStorage("newKingHanaRegCount") var regCount: Int = 0
    @AppStorage("newKingHanaCurrentGames") var currentGames: Int = 0
    @AppStorage("newKingHanaBonusSum") var bonusSum: Int = 0
    @AppStorage("newKingHanaPlayGames") var playGames: Int = 0
    
    // BIG
    @AppStorage("newKingHanaBBSuikaCount") var bbSuikaCount = 0
    @AppStorage("newKingHanaBigPlayGames") var bigPlayGames = 0
    @AppStorage("newKingHanaSideLampCountBlue") var sideLampCountBlue: Int = 0
    @AppStorage("newKingHanaSideLampCountYellow") var sideLampCountYellow: Int = 0
    @AppStorage("newKingHanaSideLampCountGreen") var sideLampCountGreen: Int = 0
    @AppStorage("newKingHanaSideLampCountRed") var sideLampCountRed: Int = 0
    @AppStorage("newKingHanaSideLampCountSum") var sideLampCountSum: Int = 0
    @AppStorage("newKingHanaSideLampCountKisu") var sideLampCountKisu: Int = 0
    @AppStorage("newKingHanaSideLampCountGusu") var sideLampCountGusu: Int = 0
    @AppStorage("newKingHanaBigTopLampCountBlue") var bigTopLampCountBlue: Int = 0
    @AppStorage("newKingHanaBigTopLampCountYellow") var bigTopLampCountYellow: Int = 0
    @AppStorage("newKingHanaBigTopLampCountGreen") var bigTopLampCountGreen: Int = 0
    @AppStorage("newKingHanaBigTopLampCountPurple") var bigTopLampCountPurple: Int = 0
    @AppStorage("newKingHanaBigTopLampCountSum") var bigTopLampCountSum: Int = 0
    
    // REG
    @AppStorage("newKingHanaRegSuikaCount") var regSuikaCount: Int = 0
    @AppStorage("newKingHanaRegPlayGames") var regPlayGames: Int = 0
    
    func bonusSumFunc() {
        bonusSum = bigCount + regCount
    }
    
    func playGameCalFunc() {
        playGames = currentGames - startGameInput
    }
    
    func bigPlayGameCalFunc() {
        bigPlayGames = bigCount * 14
    }
    
    func sideLampCountSumFunc() {
        sideLampCountSum = countSum(
            sideLampCountBlue,
            sideLampCountYellow,
            sideLampCountGreen,
            sideLampCountRed,
        )
        sideLampCountKisu = sideLampCountBlue + sideLampCountGreen
        sideLampCountGusu = sideLampCountYellow + sideLampCountRed
    }
    
    func bigTopLampSumFunc() {
        bigTopLampCountSum = countSum(
            bigTopLampCountBlue,
            bigTopLampCountYellow,
            bigTopLampCountGreen,
            bigTopLampCountPurple,
        )
    }
    
    func regPlayGameCalFunc() {
        regPlayGames = regCount * 10
    }
    
    func hanaReset() {
        bellCount = 0
        bigCount = 0
        regCount = 0
        currentGames = 0
        bonusSum = 0
        playGames = 0
        bbSuikaCount = 0
        bigPlayGames = 0
        sideLampCountBlue = 0
        sideLampCountYellow = 0
        sideLampCountGreen = 0
        sideLampCountRed = 0
        sideLampCountSum = 0
        sideLampCountKisu = 0
        sideLampCountGusu = 0
        bigTopLampCountBlue = 0
        bigTopLampCountYellow = 0
        bigTopLampCountGreen = 0
        bigTopLampCountPurple = 0
        bigTopLampCountSum = 0
        regSuikaCount = 0
        regPlayGames = 0
        minusCheck = false
    }
    
    // --------
    // 実戦 トータル結果
    // --------
    @AppStorage("newKingHanaTotalBigCount") var totalBigCount = 0
    @AppStorage("newKingHanaTotalRegCount") var totalRegCount = 0
    @AppStorage("newKingHanaTotalBellCount") var totalBellCount = 0
    @AppStorage("newKingHanaTotalBonusCountSum") var totalBonusCountSum = 0
    
    func totalBonusSumFunc() {
        totalBigCount = startBigCountInput + bigCount
        totalRegCount = startRegCountInput + regCount
        totalBonusCountSum = totalBigCount + totalRegCount
    }
    
    func totalBellSumFunc() {
        totalBellCount = startBellBackCalculationCount + bellCount
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "ニューキングハナハナ"
    @AppStorage("newKingHanaMinusCheck") var minusCheck: Bool = false
    @AppStorage("newKingHanaSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetKenDataInput()
        resetStartData()
        hanaReset()
    }
    
    // ////////
    // 島合算
    // ////////
    @AppStorage("newKingHanaShimaGames") var shimaGames: Int = 0
    @AppStorage("newKingHanaShimaBigs") var shimaBigs: Int = 0
    @AppStorage("newKingHanaShimaRegs") var shimaRegs: Int = 0
    @AppStorage("newKingHanaShimaBonusSum") var shimaBonusSum: Int = 0
}


class NewKingHanaMemory1: ObservableObject {
    @AppStorage("newKingHanaKenBackCalculationEnableMemory1") var kenBackCalculationEnable: Bool = false
    @AppStorage("newKingHanaKenGameIputMemory1") var kenGameIput: Int = 0
    @AppStorage("newKingHanaKenBigCountInputMemory1") var kenBigCountInput: Int = 0
    @AppStorage("newKingHanaKenRegCountInputMemory1") var kenRegCountInput: Int = 0
    @AppStorage("newKingHanaKenCoinDifferenceInputMemory1") var kenCoinDifferenceInput: Int = 0
    @AppStorage("newKingHanaKenBonusCountSumMemory1") var kenBonusCountSum: Int = 0
    @AppStorage("newKingHanaKenBellBackCalculationCountMemory1") var kenBellBackCalculationCount: Int = 0
    @AppStorage("newKingHanaStartBackCalculationEnableMemory1") var startBackCalculationEnable: Bool = false
    @AppStorage("newKingHanaStartGamesMemory1") var startGameInput: Int = 0
    @AppStorage("newKingHanaStartBigCountInputMemory1") var startBigCountInput: Int = 0
    @AppStorage("newKingHanaStartRegCountInputMemory1") var startRegCountInput: Int = 0
    @AppStorage("newKingHanaStartCoinDifferenceInputMemory1") var startCoinDifferenceInput: Int = 0
    @AppStorage("newKingHanaStartBonusCountSumMemory1") var startBonusCountSum: Int = 0
    @AppStorage("newKingHanaStartBellBackCalculationCountMemory1") var startBellBackCalculationCount: Int = 0
    @AppStorage("newKingHanaBellCountMemory1") var bellCount = 0
    @AppStorage("newKingHanaBigCountMemory1") var bigCount = 0
    @AppStorage("newKingHanaRegCountMemory1") var regCount = 0
    @AppStorage("newKingHanaCurrentGamesMemory1") var currentGames = 0
    @AppStorage("newKingHanaBonusSumMemory1") var bonusSum = 0
    @AppStorage("newKingHanaPlayGamesMemory1") var playGames = 0
    @AppStorage("newKingHanaBBSuikaCountMemory1") var bbSuikaCount = 0
    @AppStorage("newKingHanaBigPlayGamesMemory1") var bigPlayGames = 0
    @AppStorage("newKingHanaSideLampCountBlueMemory1") var sideLampCountBlue: Int = 0
    @AppStorage("newKingHanaSideLampCountYellowMemory1") var sideLampCountYellow: Int = 0
    @AppStorage("newKingHanaSideLampCountGreenMemory1") var sideLampCountGreen: Int = 0
    @AppStorage("newKingHanaSideLampCountRedMemory1") var sideLampCountRed: Int = 0
    @AppStorage("newKingHanaSideLampCountSumMemory1") var sideLampCountSum: Int = 0
    @AppStorage("newKingHanaSideLampCountKisuMemory1") var sideLampCountKisu: Int = 0
    @AppStorage("newKingHanaSideLampCountGusuMemory1") var sideLampCountGusu: Int = 0
    @AppStorage("newKingHanaBigTopLampCountBlueMemory1") var bigTopLampCountBlue: Int = 0
    @AppStorage("newKingHanaBigTopLampCountYellowMemory1") var bigTopLampCountYellow: Int = 0
    @AppStorage("newKingHanaBigTopLampCountGreenMemory1") var bigTopLampCountGreen: Int = 0
    @AppStorage("newKingHanaBigTopLampCountPurpleMemory1") var bigTopLampCountPurple: Int = 0
    @AppStorage("newKingHanaBigTopLampCountSumMemory1") var bigTopLampCountSum: Int = 0
    @AppStorage("newKingHanaRegSuikaCountMemory1") var regSuikaCount = 0
    @AppStorage("newKingHanaRegPlayGamesMemory1") var regPlayGames = 0
    @AppStorage("newKingHanaTotalBigCountMemory1") var totalBigCount = 0
    @AppStorage("newKingHanaTotalRegCountMemory1") var totalRegCount = 0
    @AppStorage("newKingHanaTotalBellCountMemory1") var totalBellCount = 0
    @AppStorage("newKingHanaTotalBonusCountSumMemory1") var totalBonusCountSum = 0
    @AppStorage("newKingHanaShimaGamesMemory1") var shimaGames: Int = 0
    @AppStorage("newKingHanaShimaBigsMemory1") var shimaBigs: Int = 0
    @AppStorage("newKingHanaShimaRegsMemory1") var shimaRegs: Int = 0
    @AppStorage("newKingHanaShimaBonusSumMemory1") var shimaBonusSum: Int = 0
    @AppStorage("newKingHanaMemoMemory1") var memo = ""
    @AppStorage("newKingHanaDateMemory1") var dateDouble = 0.0
}


class NewKingHanaMemory2: ObservableObject {
    @AppStorage("newKingHanaKenBackCalculationEnableMemory2") var kenBackCalculationEnable: Bool = false
    @AppStorage("newKingHanaKenGameIputMemory2") var kenGameIput: Int = 0
    @AppStorage("newKingHanaKenBigCountInputMemory2") var kenBigCountInput: Int = 0
    @AppStorage("newKingHanaKenRegCountInputMemory2") var kenRegCountInput: Int = 0
    @AppStorage("newKingHanaKenCoinDifferenceInputMemory2") var kenCoinDifferenceInput: Int = 0
    @AppStorage("newKingHanaKenBonusCountSumMemory2") var kenBonusCountSum: Int = 0
    @AppStorage("newKingHanaKenBellBackCalculationCountMemory2") var kenBellBackCalculationCount: Int = 0
    @AppStorage("newKingHanaStartBackCalculationEnableMemory2") var startBackCalculationEnable: Bool = false
    @AppStorage("newKingHanaStartGamesMemory2") var startGameInput: Int = 0
    @AppStorage("newKingHanaStartBigCountInputMemory2") var startBigCountInput: Int = 0
    @AppStorage("newKingHanaStartRegCountInputMemory2") var startRegCountInput: Int = 0
    @AppStorage("newKingHanaStartCoinDifferenceInputMemory2") var startCoinDifferenceInput: Int = 0
    @AppStorage("newKingHanaStartBonusCountSumMemory2") var startBonusCountSum: Int = 0
    @AppStorage("newKingHanaStartBellBackCalculationCountMemory2") var startBellBackCalculationCount: Int = 0
    @AppStorage("newKingHanaBellCountMemory2") var bellCount = 0
    @AppStorage("newKingHanaBigCountMemory2") var bigCount = 0
    @AppStorage("newKingHanaRegCountMemory2") var regCount = 0
    @AppStorage("newKingHanaCurrentGamesMemory2") var currentGames = 0
    @AppStorage("newKingHanaBonusSumMemory2") var bonusSum = 0
    @AppStorage("newKingHanaPlayGamesMemory2") var playGames = 0
    @AppStorage("newKingHanaBBSuikaCountMemory2") var bbSuikaCount = 0
    @AppStorage("newKingHanaBigPlayGamesMemory2") var bigPlayGames = 0
    @AppStorage("newKingHanaSideLampCountBlueMemory2") var sideLampCountBlue: Int = 0
    @AppStorage("newKingHanaSideLampCountYellowMemory2") var sideLampCountYellow: Int = 0
    @AppStorage("newKingHanaSideLampCountGreenMemory2") var sideLampCountGreen: Int = 0
    @AppStorage("newKingHanaSideLampCountRedMemory2") var sideLampCountRed: Int = 0
    @AppStorage("newKingHanaSideLampCountSumMemory2") var sideLampCountSum: Int = 0
    @AppStorage("newKingHanaSideLampCountKisuMemory2") var sideLampCountKisu: Int = 0
    @AppStorage("newKingHanaSideLampCountGusuMemory2") var sideLampCountGusu: Int = 0
    @AppStorage("newKingHanaBigTopLampCountBlueMemory2") var bigTopLampCountBlue: Int = 0
    @AppStorage("newKingHanaBigTopLampCountYellowMemory2") var bigTopLampCountYellow: Int = 0
    @AppStorage("newKingHanaBigTopLampCountGreenMemory2") var bigTopLampCountGreen: Int = 0
    @AppStorage("newKingHanaBigTopLampCountPurpleMemory2") var bigTopLampCountPurple: Int = 0
    @AppStorage("newKingHanaBigTopLampCountSumMemory2") var bigTopLampCountSum: Int = 0
    @AppStorage("newKingHanaRegSuikaCountMemory2") var regSuikaCount = 0
    @AppStorage("newKingHanaRegPlayGamesMemory2") var regPlayGames = 0
    @AppStorage("newKingHanaTotalBigCountMemory2") var totalBigCount = 0
    @AppStorage("newKingHanaTotalRegCountMemory2") var totalRegCount = 0
    @AppStorage("newKingHanaTotalBellCountMemory2") var totalBellCount = 0
    @AppStorage("newKingHanaTotalBonusCountSumMemory2") var totalBonusCountSum = 0
    @AppStorage("newKingHanaShimaGamesMemory2") var shimaGames: Int = 0
    @AppStorage("newKingHanaShimaBigsMemory2") var shimaBigs: Int = 0
    @AppStorage("newKingHanaShimaRegsMemory2") var shimaRegs: Int = 0
    @AppStorage("newKingHanaShimaBonusSumMemory2") var shimaBonusSum: Int = 0
    @AppStorage("newKingHanaMemoMemory2") var memo = ""
    @AppStorage("newKingHanaDateMemory2") var dateDouble = 0.0
}


class NewKingHanaMemory3: ObservableObject {
    @AppStorage("newKingHanaKenBackCalculationEnableMemory3") var kenBackCalculationEnable: Bool = false
    @AppStorage("newKingHanaKenGameIputMemory3") var kenGameIput: Int = 0
    @AppStorage("newKingHanaKenBigCountInputMemory3") var kenBigCountInput: Int = 0
    @AppStorage("newKingHanaKenRegCountInputMemory3") var kenRegCountInput: Int = 0
    @AppStorage("newKingHanaKenCoinDifferenceInputMemory3") var kenCoinDifferenceInput: Int = 0
    @AppStorage("newKingHanaKenBonusCountSumMemory3") var kenBonusCountSum: Int = 0
    @AppStorage("newKingHanaKenBellBackCalculationCountMemory3") var kenBellBackCalculationCount: Int = 0
    @AppStorage("newKingHanaStartBackCalculationEnableMemory3") var startBackCalculationEnable: Bool = false
    @AppStorage("newKingHanaStartGamesMemory3") var startGameInput: Int = 0
    @AppStorage("newKingHanaStartBigCountInputMemory3") var startBigCountInput: Int = 0
    @AppStorage("newKingHanaStartRegCountInputMemory3") var startRegCountInput: Int = 0
    @AppStorage("newKingHanaStartCoinDifferenceInputMemory3") var startCoinDifferenceInput: Int = 0
    @AppStorage("newKingHanaStartBonusCountSumMemory3") var startBonusCountSum: Int = 0
    @AppStorage("newKingHanaStartBellBackCalculationCountMemory3") var startBellBackCalculationCount: Int = 0
    @AppStorage("newKingHanaBellCountMemory3") var bellCount = 0
    @AppStorage("newKingHanaBigCountMemory3") var bigCount = 0
    @AppStorage("newKingHanaRegCountMemory3") var regCount = 0
    @AppStorage("newKingHanaCurrentGamesMemory3") var currentGames = 0
    @AppStorage("newKingHanaBonusSumMemory3") var bonusSum = 0
    @AppStorage("newKingHanaPlayGamesMemory3") var playGames = 0
    @AppStorage("newKingHanaBBSuikaCountMemory3") var bbSuikaCount = 0
    @AppStorage("newKingHanaBigPlayGamesMemory3") var bigPlayGames = 0
    @AppStorage("newKingHanaSideLampCountBlueMemory3") var sideLampCountBlue: Int = 0
    @AppStorage("newKingHanaSideLampCountYellowMemory3") var sideLampCountYellow: Int = 0
    @AppStorage("newKingHanaSideLampCountGreenMemory3") var sideLampCountGreen: Int = 0
    @AppStorage("newKingHanaSideLampCountRedMemory3") var sideLampCountRed: Int = 0
    @AppStorage("newKingHanaSideLampCountSumMemory3") var sideLampCountSum: Int = 0
    @AppStorage("newKingHanaSideLampCountKisuMemory3") var sideLampCountKisu: Int = 0
    @AppStorage("newKingHanaSideLampCountGusuMemory3") var sideLampCountGusu: Int = 0
    @AppStorage("newKingHanaBigTopLampCountBlueMemory3") var bigTopLampCountBlue: Int = 0
    @AppStorage("newKingHanaBigTopLampCountYellowMemory3") var bigTopLampCountYellow: Int = 0
    @AppStorage("newKingHanaBigTopLampCountGreenMemory3") var bigTopLampCountGreen: Int = 0
    @AppStorage("newKingHanaBigTopLampCountPurpleMemory3") var bigTopLampCountPurple: Int = 0
    @AppStorage("newKingHanaBigTopLampCountSumMemory3") var bigTopLampCountSum: Int = 0
    @AppStorage("newKingHanaRegSuikaCountMemory3") var regSuikaCount = 0
    @AppStorage("newKingHanaRegPlayGamesMemory3") var regPlayGames = 0
    @AppStorage("newKingHanaTotalBigCountMemory3") var totalBigCount = 0
    @AppStorage("newKingHanaTotalRegCountMemory3") var totalRegCount = 0
    @AppStorage("newKingHanaTotalBellCountMemory3") var totalBellCount = 0
    @AppStorage("newKingHanaTotalBonusCountSumMemory3") var totalBonusCountSum = 0
    @AppStorage("newKingHanaShimaGamesMemory3") var shimaGames: Int = 0
    @AppStorage("newKingHanaShimaBigsMemory3") var shimaBigs: Int = 0
    @AppStorage("newKingHanaShimaRegsMemory3") var shimaRegs: Int = 0
    @AppStorage("newKingHanaShimaBonusSumMemory3") var shimaBonusSum: Int = 0
    @AppStorage("newKingHanaMemoMemory3") var memo = ""
    @AppStorage("newKingHanaDateMemory3") var dateDouble = 0.0
}
