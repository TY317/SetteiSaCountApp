//
//  hihodenClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/13.
//

import Foundation
import SwiftUI
import Combine

class Hihoden: ObservableObject {
    // ----------
    // 通常時
    // ----------
    let ratioKoyakuCherry: [Double] = [54.7,52.9,51.1,49.5,48,46.5]
    @AppStorage("hihodenTotalGame") var totalGame: Int = 0
    @AppStorage("hihodenKoyakuCountCherry") var koyakuCountCherry: Int = 0
    
    let ratioChanceKokaku: [Double] = [50,-1,-1,-1,-1,-1,]
    @AppStorage("hihodenKoyakuCountChance") var koyakuCountChance: Int = 0
    @AppStorage("hihodenChanceKokakuCount") var chanceKokakuCount: Int = 0
    
    func resetNormal() {
        totalGame = 0
        koyakuCountCherry = 0
        koyakuCountChance = 0
        chanceKokakuCount = 0
        minusCheck = false
    }
    
    // ---------------
    // 初当り
    // ---------------
    let ratioFirstHit: [Double] = [292.5,271.4,283.6,257.5,264,246]
    @AppStorage("hihodenNormalGame") var normalGame: Int = 0
    @AppStorage("hihodenFirstHitCount") var firstHitCount: Int = 0
    
    func resetFirstHit() {
        normalGame = 0
        firstHitCount = 0
        minusCheck = false
    }
    
    // --------------
    // ボーナス中
    // --------------
    let ratioBonusHazure: [Double] = [40.1,37.8,35.5,33.4,31.6,29.9]
    @AppStorage("hihodenBonusGame") var bonusGame: Int = 0
    @AppStorage("hihodenbonusHazureCount") var bonusHazureCount: Int = 0
    func resetDuringBonus() {
        bonusGame = 0
        bonusHazureCount = 0
        minusCheck = false
    }
    
    // --------------
    // 伝説
    // --------------
    let ratioLegendAfterBig: [Double] = [50,-1,-1,-1,-1,-1,]
    let ratioLegendAfterReg: [Double] = [30,-1,-1,-1,-1,-1,]
    
    @AppStorage("hihodenLegendCountBigNone") var legendCountBigNone: Int = 0
    @AppStorage("hihodenLegendCountBigHit") var legendCountBigHit: Int = 0
    @AppStorage("hihodenLegendCountBigSum") var legendCountBigSum: Int = 0
    @AppStorage("hihodenLegendCountRegNone") var legendCountRegNone: Int = 0
    @AppStorage("hihodenLegendCountRegHit") var legendCountRegHit: Int = 0
    @AppStorage("hihodenLegendCountRegSum") var legendCountRegSum: Int = 0
    
    func legendSumFunc() {
        legendCountBigSum = legendCountBigNone + legendCountBigHit
        legendCountRegSum = legendCountRegNone + legendCountRegHit
    }
    
    func resetLegend() {
        legendCountBigNone = 0
        legendCountBigHit = 0
        legendCountBigSum = 0
        legendCountRegNone = 0
        legendCountRegHit = 0
        legendCountRegSum = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "秘宝伝"
    @AppStorage("hihodenMinusCheck") var minusCheck: Bool = false
    @AppStorage("hihodenSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetDuringBonus()
        resetLegend()
    }
}


class HihodenMemory1: ObservableObject {
    @AppStorage("hihodenTotalGameMemory1") var totalGame: Int = 0
    @AppStorage("hihodenKoyakuCountCherryMemory1") var koyakuCountCherry: Int = 0
    @AppStorage("hihodenKoyakuCountChanceMemory1") var koyakuCountChance: Int = 0
    @AppStorage("hihodenChanceKokakuCountMemory1") var chanceKokakuCount: Int = 0
    @AppStorage("hihodenNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("hihodenFirstHitCountMemory1") var firstHitCount: Int = 0
    @AppStorage("hihodenBonusGameMemory1") var bonusGame: Int = 0
    @AppStorage("hihodenbonusHazureCountMemory1") var bonusHazureCount: Int = 0
    @AppStorage("hihodenLegendCountBigNoneMemory1") var legendCountBigNone: Int = 0
    @AppStorage("hihodenLegendCountBigHitMemory1") var legendCountBigHit: Int = 0
    @AppStorage("hihodenLegendCountBigSumMemory1") var legendCountBigSum: Int = 0
    @AppStorage("hihodenLegendCountRegNoneMemory1") var legendCountRegNone: Int = 0
    @AppStorage("hihodenLegendCountRegHitMemory1") var legendCountRegHit: Int = 0
    @AppStorage("hihodenLegendCountRegSumMemory1") var legendCountRegSum: Int = 0
    @AppStorage("hihodenMemoMemory1") var memo = ""
    @AppStorage("hihodenDateMemory1") var dateDouble = 0.0
}


class HihodenMemory2: ObservableObject {
    @AppStorage("hihodenTotalGameMemory2") var totalGame: Int = 0
    @AppStorage("hihodenKoyakuCountCherryMemory2") var koyakuCountCherry: Int = 0
    @AppStorage("hihodenKoyakuCountChanceMemory2") var koyakuCountChance: Int = 0
    @AppStorage("hihodenChanceKokakuCountMemory2") var chanceKokakuCount: Int = 0
    @AppStorage("hihodenNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("hihodenFirstHitCountMemory2") var firstHitCount: Int = 0
    @AppStorage("hihodenBonusGameMemory2") var bonusGame: Int = 0
    @AppStorage("hihodenbonusHazureCountMemory2") var bonusHazureCount: Int = 0
    @AppStorage("hihodenLegendCountBigNoneMemory2") var legendCountBigNone: Int = 0
    @AppStorage("hihodenLegendCountBigHitMemory2") var legendCountBigHit: Int = 0
    @AppStorage("hihodenLegendCountBigSumMemory2") var legendCountBigSum: Int = 0
    @AppStorage("hihodenLegendCountRegNoneMemory2") var legendCountRegNone: Int = 0
    @AppStorage("hihodenLegendCountRegHitMemory2") var legendCountRegHit: Int = 0
    @AppStorage("hihodenLegendCountRegSumMemory2") var legendCountRegSum: Int = 0
    @AppStorage("hihodenMemoMemory2") var memo = ""
    @AppStorage("hihodenDateMemory2") var dateDouble = 0.0
}


class HihodenMemory3: ObservableObject {
    @AppStorage("hihodenTotalGameMemory3") var totalGame: Int = 0
    @AppStorage("hihodenKoyakuCountCherryMemory3") var koyakuCountCherry: Int = 0
    @AppStorage("hihodenKoyakuCountChanceMemory3") var koyakuCountChance: Int = 0
    @AppStorage("hihodenChanceKokakuCountMemory3") var chanceKokakuCount: Int = 0
    @AppStorage("hihodenNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("hihodenFirstHitCountMemory3") var firstHitCount: Int = 0
    @AppStorage("hihodenBonusGameMemory3") var bonusGame: Int = 0
    @AppStorage("hihodenbonusHazureCountMemory3") var bonusHazureCount: Int = 0
    @AppStorage("hihodenLegendCountBigNoneMemory3") var legendCountBigNone: Int = 0
    @AppStorage("hihodenLegendCountBigHitMemory3") var legendCountBigHit: Int = 0
    @AppStorage("hihodenLegendCountBigSumMemory3") var legendCountBigSum: Int = 0
    @AppStorage("hihodenLegendCountRegNoneMemory3") var legendCountRegNone: Int = 0
    @AppStorage("hihodenLegendCountRegHitMemory3") var legendCountRegHit: Int = 0
    @AppStorage("hihodenLegendCountRegSumMemory3") var legendCountRegSum: Int = 0
    @AppStorage("hihodenMemoMemory3") var memo = ""
    @AppStorage("hihodenDateMemory3") var dateDouble = 0.0
}
