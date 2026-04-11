//
//  jormungandClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/04.
//

import Foundation
import SwiftUI
import Combine

class Jormungand: ObservableObject {
    // ---------
    // 通常時
    // ---------
    // レア役からのCZ
    let ratioRareCzNormalChance: [Double] = [10.16,11.33,14.06,16.02,16.41,16.80]
    let ratioRareCzNormalKyoCherry: [Double] = [25,26.95,32.03,34.38,34.77,35.16]
    let ratioRareCzHighChance: [Double] = [33.59,36.72,46.09,50,50,50]
    let ratioRareCzHighKyoCherry: [Double] = [66.80,68.36,75,80.08,80.08,80.08,]
    @AppStorage("jormungandRareCzCountChance") var rareCzCountChance: Int = 0
    @AppStorage("jormungandRareCzCountChanceHit") var rareCzCountChanceHit: Int = 0
    @AppStorage("jormungandRareCzCountKyoCherry") var rareCzCountKyoCherry: Int = 0
    @AppStorage("jormungandRareCzCountKyoCherryHit") var rareCzCountKyoCherryHit: Int = 0
    
    // 天井短縮
    let ratioTenjoCut: [Double] = [33.59,40.23,45.31,49.22,49.61,50]
    @AppStorage("jormungandTenjoCountMiss") var tenjoCountMiss: Int = 0
    @AppStorage("jormungandTenjoCountHit") var tenjoCountHit: Int = 0
    @AppStorage("jormungandTenjoCountSum") var tenjoCountSum: Int = 0
    
    func tenjoSumFunc() {
        tenjoCountSum = tenjoCountMiss + tenjoCountHit
    }
    
    // 示唆カード
    @AppStorage("jormungandCardCountDefault") var cardCountDefault: Int = 0
    @AppStorage("jormungandCardCountKisu") var cardCountKisu: Int = 0
    @AppStorage("jormungandCardCountGusu") var cardCountGusu: Int = 0
    @AppStorage("jormungandCardCountHighJaku") var cardCountHighJaku: Int = 0
    @AppStorage("jormungandCardCountModeCJaku") var cardCountModeCJaku: Int = 0
    @AppStorage("jormungandCardCountHighKyo") var cardCountHighKyo: Int = 0
    @AppStorage("jormungandCardCountModeCKyo") var cardCountModeCKyo: Int = 0
    @AppStorage("jormungandCardCountGusuFix") var cardCountGusuFix: Int = 0
    @AppStorage("jormungandCardCountModeD") var cardCountModeD: Int = 0
    @AppStorage("jormungandCardCountHorobi") var cardCountHorobi: Int = 0
    @AppStorage("jormungandCardCountSum") var cardCountSum: Int = 0
    
    func cardSumFunc() {
        cardCountSum = countSum(
            cardCountDefault,
            cardCountKisu,
            cardCountGusu,
            cardCountHighJaku,
//            cardCountModeCJaku,
            cardCountHighKyo,
//            cardCountModeCKyo,
            cardCountGusuFix,
//            cardCountModeD,
//            cardCountHorobi,
        )
    }
    
    func resetNormal() {
        rareCzCountChance = 0
        rareCzCountChanceHit = 0
        rareCzCountKyoCherry = 0
        rareCzCountKyoCherryHit = 0
        tenjoCountMiss = 0
        tenjoCountHit = 0
        tenjoCountSum = 0
        cardCountDefault = 0
        cardCountKisu = 0
        cardCountGusu = 0
        cardCountHighJaku = 0
        cardCountModeCJaku = 0
        cardCountHighKyo = 0
        cardCountModeCKyo = 0
        cardCountGusuFix = 0
        cardCountModeD = 0
        cardCountHorobi = 0
        cardCountSum = 0
        minusCheck = false
    }
    
    // ----------
    // CZ
    // ----------
    let ratioFirstHitCz: [Double] = [194.2,188.6,175.7,169.4,167.8,167.2]
    @AppStorage("jormungandNormalGame") var normalGame: Int = 0
    @AppStorage("jormungandFirstHitCountCz") var firstHitCountCz: Int = 0
    
    func resetCz() {
        normalGame = 0
        firstHitCountCz = 0
        minusCheck = false
    }
    
    // -----------
    // 初当り
    // -----------
    let ratioFirstHitAt: [Double] = [333.8,323.3,305.4,291.6,291.1,290.1]
    @AppStorage("jormungandFirstHitCountAt") var firstHitCountAt: Int = 0
    func resetFirstHit() {
        normalGame = 0
        firstHitCountCz = 0
        firstHitCountAt = 0
        minusCheck = false
    }
    
    // -------
    // 終了画面
    // -------
    @AppStorage("jormungandScreenCountDefault") var screenCountDefault: Int = 0
    @AppStorage("jormungandScreenCountHigh") var screenCountHigh: Int = 0
    @AppStorage("jormungandScreenCountKisu") var screenCountKisu: Int = 0
    @AppStorage("jormungandScreenCountGusu") var screenCountGusu: Int = 0
    @AppStorage("jormungandScreenCountNegate2") var screenCountNegate2: Int = 0
    @AppStorage("jormungandScreenCountGusuFix") var screenCountGusuFix: Int = 0
    @AppStorage("jormungandScreenCountOver4") var screenCountOver4: Int = 0
    @AppStorage("jormungandScreenCountOver6") var screenCountOver6: Int = 0
    @AppStorage("jormungandScreenCountSum") var screenCountSum: Int = 0
    
    func screenSumFunc() {
        screenCountSum = countSum(
            screenCountDefault,
            screenCountHigh,
            screenCountKisu,
            screenCountGusu,
            screenCountNegate2,
            screenCountGusuFix,
            screenCountOver4,
            screenCountOver6,
        )
    }
    
    func resetScreen() {
        screenCountDefault = 0
        screenCountHigh = 0
        screenCountKisu = 0
        screenCountGusu = 0
        screenCountNegate2 = 0
        screenCountGusuFix = 0
        screenCountOver4 = 0
        screenCountOver6 = 0
        screenCountSum = 0
        minusCheck = false
    }
    
    // ---------
    // REG
    // ---------
    @AppStorage("jormungandCharaCountKisu") var charaCountKisu: Int = 0
    @AppStorage("jormungandCharaCountGusu") var charaCountGusu: Int = 0
    @AppStorage("jormungandCharaCountHigh") var charaCountHigh: Int = 0
    @AppStorage("jormungandCharaCountOver2") var charaCountOver2: Int = 0
    @AppStorage("jormungandCharaCountOver4") var charaCountOver4: Int = 0
    @AppStorage("jormungandCharaCountOver6") var charaCountOver6: Int = 0
    @AppStorage("jormungandCharaCountSum") var charaCountSum: Int = 0
    
    func charaSumFunc() {
        charaCountSum = countSum(
            charaCountKisu,
            charaCountGusu,
            charaCountHigh,
            charaCountOver2,
            charaCountOver4,
            charaCountOver6,
        )
    }
    
    func resetReg() {
        charaCountKisu = 0
        charaCountGusu = 0
        charaCountHigh = 0
        charaCountOver2 = 0
        charaCountOver4 = 0
        charaCountOver6 = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "ヨルムンガンド"
    @AppStorage("jormungandMinusCheck") var minusCheck: Bool = false
    @AppStorage("jormungandSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetCz()
        resetFirstHit()
        resetNormal()
        resetScreen()
        resetReg()
    }
}


class JormungandMemory1: ObservableObject {
    @AppStorage("jormungandNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("jormungandFirstHitCountCzMemory1") var firstHitCountCz: Int = 0
    @AppStorage("jormungandFirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("jormungandMemoMemory1") var memo = ""
    @AppStorage("jormungandDateMemory1") var dateDouble = 0.0
}


class JormungandMemory2: ObservableObject {
    @AppStorage("jormungandNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("jormungandFirstHitCountCzMemory2") var firstHitCountCz: Int = 0
    @AppStorage("jormungandFirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("jormungandMemoMemory2") var memo = ""
    @AppStorage("jormungandDateMemory2") var dateDouble = 0.0
}


class JormungandMemory3: ObservableObject {
    @AppStorage("jormungandNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("jormungandFirstHitCountCzMemory3") var firstHitCountCz: Int = 0
    @AppStorage("jormungandFirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("jormungandMemoMemory3") var memo = ""
    @AppStorage("jormungandDateMemory3") var dateDouble = 0.0
}
