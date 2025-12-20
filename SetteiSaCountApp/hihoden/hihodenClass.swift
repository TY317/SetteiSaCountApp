//
//  hihodenClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/13.
//

import Foundation
import SwiftUI

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
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "秘宝伝"
    @AppStorage("hihodenMinusCheck") var minusCheck: Bool = false
    @AppStorage("hihodenSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
    }
}
