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
    
    let ratioChanceKokaku: [Double] = [50,55.3,51.2,57.6,54,60.2,]
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
        
        charaCountHighJaku = 0
        charaCountHighKyo = 0
        charaCountNegate2 = 0
        charaCountNegate3 = 0
        charaCountNegate4 = 0
        charaCountChange = 0
        charaCountOver2 = 0
        charaCountOver4 = 0
        charaCountOver5 = 0
        charaCountOver6 = 0
        charaCountSum = 0
    }
    
    // --------------
    // 伝説
    // --------------
    let ratioLegendAfterBig: [Double] = [50,55,52.4,56.8,54.6,57.8]
    let ratioLegendAfterReg: [Double] = [30,40.3,31.9,44.3,35.4,50]
    
    @AppStorage("hihodenLegendCountBigNone") var legendCountBigNone: Int = 0
    @AppStorage("hihodenLegendCountBigHit") var legendCountBigHit: Int = 0
    @AppStorage("hihodenLegendCountBigSum") var legendCountBigSum: Int = 0
    @AppStorage("hihodenLegendCountRegNone") var legendCountRegNone: Int = 0
    @AppStorage("hihodenLegendCountRegHit") var legendCountRegHit: Int = 0
    @AppStorage("hihodenLegendCountRegSum") var legendCountRegSum: Int = 0
    
    func legendSumFunc() {
        legendCountBigSum = legendCountBigNone + legendCountBigHit
        legendCountRegSum = legendCountRegNone + legendCountRegHit
        legendCountKokakuMissSum = legendCountKokakuMissNone + legendCountKokakuMissHit
    }
    
    func resetLegend() {
        legendCountBigNone = 0
        legendCountBigHit = 0
        legendCountBigSum = 0
        legendCountRegNone = 0
        legendCountRegHit = 0
        legendCountRegSum = 0
        minusCheck = false
        
        legendCountKokakuMissNone = 0
        legendCountKokakuMissHit = 0
        legendCountKokakuMissSum = 0
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
    
    // -------
    // ver3.21.1
    // -------
    //REG中キャラ
    @AppStorage("hihodenCharaCountHighJaku") var charaCountHighJaku: Int = 0
    @AppStorage("hihodenCharaCountHighKyo") var charaCountHighKyo: Int = 0
    @AppStorage("hihodenCharaCountNegate2") var charaCountNegate2: Int = 0
    @AppStorage("hihodenCharaCountNegate3") var charaCountNegate3: Int = 0
    @AppStorage("hihodenCharaCountNegate4") var charaCountNegate4: Int = 0
    @AppStorage("hihodenCharaCountChange") var charaCountChange: Int = 0
    @AppStorage("hihodenCharaCountOver2") var charaCountOver2: Int = 0
    @AppStorage("hihodenCharaCountOver4") var charaCountOver4: Int = 0
    @AppStorage("hihodenCharaCountOver5") var charaCountOver5: Int = 0
    @AppStorage("hihodenCharaCountOver6") var charaCountOver6: Int = 0
    @AppStorage("hihodenCharaCountSum") var charaCountSum: Int = 0
    
    func charaSumFunc() {
        charaCountSum = countSum(
            charaCountHighJaku,
            charaCountHighKyo,
            charaCountNegate2,
            charaCountNegate3,
            charaCountNegate4,
            charaCountChange,
            charaCountOver2,
            charaCountOver4,
            charaCountOver5,
            charaCountOver6,
        )
    }
    
    // 高確失敗時の伝説モード移行
    let ratioLegendAfterChanceMiss: [Double] = [1.2,3.5,1.6,4.7,3.1,5.9]
    @AppStorage("hihodenLegendCountKokakuMissNone") var legendCountKokakuMissNone: Int = 0
    @AppStorage("hihodenLegendCountKokakuMissHit") var legendCountKokakuMissHit: Int = 0
    @AppStorage("hihodenLegendCountKokakuMissSum") var legendCountKokakuMissSum: Int = 0
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
    
    // -------
    // ver3.21.1
    // -------
    @AppStorage("hihodenCharaCountHighJakuMemory1") var charaCountHighJaku: Int = 0
    @AppStorage("hihodenCharaCountHighKyoMemory1") var charaCountHighKyo: Int = 0
    @AppStorage("hihodenCharaCountNegate2Memory1") var charaCountNegate2: Int = 0
    @AppStorage("hihodenCharaCountNegate3Memory1") var charaCountNegate3: Int = 0
    @AppStorage("hihodenCharaCountNegate4Memory1") var charaCountNegate4: Int = 0
    @AppStorage("hihodenCharaCountChangeMemory1") var charaCountChange: Int = 0
    @AppStorage("hihodenCharaCountOver2Memory1") var charaCountOver2: Int = 0
    @AppStorage("hihodenCharaCountOver4Memory1") var charaCountOver4: Int = 0
    @AppStorage("hihodenCharaCountOver5Memory1") var charaCountOver5: Int = 0
    @AppStorage("hihodenCharaCountOver6Memory1") var charaCountOver6: Int = 0
    @AppStorage("hihodenCharaCountSumMemory1") var charaCountSum: Int = 0
    @AppStorage("hihodenLegendCountKokakuMissNoneMemory1") var legendCountKokakuMissNone: Int = 0
    @AppStorage("hihodenLegendCountKokakuMissHitMemory1") var legendCountKokakuMissHit: Int = 0
    @AppStorage("hihodenLegendCountKokakuMissSumMemory1") var legendCountKokakuMissSum: Int = 0
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
    
    // -------
    // ver3.21.1
    // -------
    @AppStorage("hihodenCharaCountHighJakuMemory2") var charaCountHighJaku: Int = 0
    @AppStorage("hihodenCharaCountHighKyoMemory2") var charaCountHighKyo: Int = 0
    @AppStorage("hihodenCharaCountNegate2Memory2") var charaCountNegate2: Int = 0
    @AppStorage("hihodenCharaCountNegate3Memory2") var charaCountNegate3: Int = 0
    @AppStorage("hihodenCharaCountNegate4Memory2") var charaCountNegate4: Int = 0
    @AppStorage("hihodenCharaCountChangeMemory2") var charaCountChange: Int = 0
    @AppStorage("hihodenCharaCountOver2Memory2") var charaCountOver2: Int = 0
    @AppStorage("hihodenCharaCountOver4Memory2") var charaCountOver4: Int = 0
    @AppStorage("hihodenCharaCountOver5Memory2") var charaCountOver5: Int = 0
    @AppStorage("hihodenCharaCountOver6Memory2") var charaCountOver6: Int = 0
    @AppStorage("hihodenCharaCountSumMemory2") var charaCountSum: Int = 0
    @AppStorage("hihodenLegendCountKokakuMissNoneMemory2") var legendCountKokakuMissNone: Int = 0
    @AppStorage("hihodenLegendCountKokakuMissHitMemory2") var legendCountKokakuMissHit: Int = 0
    @AppStorage("hihodenLegendCountKokakuMissSumMemory2") var legendCountKokakuMissSum: Int = 0
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
    
    // -------
    // ver3.21.1
    // -------
    @AppStorage("hihodenCharaCountHighJakuMemory3") var charaCountHighJaku: Int = 0
    @AppStorage("hihodenCharaCountHighKyoMemory3") var charaCountHighKyo: Int = 0
    @AppStorage("hihodenCharaCountNegate2Memory3") var charaCountNegate2: Int = 0
    @AppStorage("hihodenCharaCountNegate3Memory3") var charaCountNegate3: Int = 0
    @AppStorage("hihodenCharaCountNegate4Memory3") var charaCountNegate4: Int = 0
    @AppStorage("hihodenCharaCountChangeMemory3") var charaCountChange: Int = 0
    @AppStorage("hihodenCharaCountOver2Memory3") var charaCountOver2: Int = 0
    @AppStorage("hihodenCharaCountOver4Memory3") var charaCountOver4: Int = 0
    @AppStorage("hihodenCharaCountOver5Memory3") var charaCountOver5: Int = 0
    @AppStorage("hihodenCharaCountOver6Memory3") var charaCountOver6: Int = 0
    @AppStorage("hihodenCharaCountSumMemory3") var charaCountSum: Int = 0
    @AppStorage("hihodenLegendCountKokakuMissNoneMemory3") var legendCountKokakuMissNone: Int = 0
    @AppStorage("hihodenLegendCountKokakuMissHitMemory3") var legendCountKokakuMissHit: Int = 0
    @AppStorage("hihodenLegendCountKokakuMissSumMemory3") var legendCountKokakuMissSum: Int = 0
}
