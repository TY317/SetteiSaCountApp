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
        minusCheck = false
    }
    
    // --------
    // 実戦
    // --------
    @AppStorage("newKingHanaBellCount") var bellCount = 0
    @AppStorage("newKingHanaBigCount") var bigCount = 0
    @AppStorage("newKingHanaRegCount") var regCount = 0
    @AppStorage("newKingHanaCurrentGames") var currentGames = 0
    @AppStorage("newKingHanaBonusSum") var bonusSum = 0
    @AppStorage("newKingHanaPlayGames") var playGames = 0
    
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
    @AppStorage("newKingHanaRegSuikaCount") var regSuikaCount = 0
    @AppStorage("newKingHanaRegPlayGames") var regPlayGames = 0
    
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
        
    }
    
    // ////////
    // 島合算
    // ////////
    @AppStorage("newKingHanaShimaGames") var shimaGames: Int = 0
    @AppStorage("newKingHanaShimaBigs") var shimaBigs: Int = 0
    @AppStorage("newKingHanaShimaRegs") var shimaRegs: Int = 0
    @AppStorage("newKingHanaShimaBonusSum") var shimaBonusSum: Int = 0
}
